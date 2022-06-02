
import spinal.core._
import spinal.core.sim._
import spinal.lib.fsm._
import spinal.lib._
import spire.algebra.Sign

class PeControls (cfg: NPUConfig) extends Bundle with IMasterSlave{
  override def asMaster(): Unit = out(this)
  override def asSlave() : Unit  = in(this)
  
  val ps_back_en = Bool
  val ps_waddr = UInt(log2Up(cfg.PE_PSUM_NUM) bits)
  val ps_raddr = UInt(log2Up(cfg.PE_PSUM_NUM) bits)
  val ps_wr   = Bool
  val ps_rd   = Bool
  val ps_allow_rd = Bool
  val ps_pinA_bias_en = Bool  
  val ps_pinB_bias_en = Bool
  val byp_mul_en = Bool
  val maxpool_en = Bool
  val bias_mul_en = Bool
  val ps_scale_en = Bool

}

class PeFlags () extends Bundle with IMasterSlave{
  override def asMaster(): Unit = out(this)
  override def asSlave() : Unit  = in(this)
  
  val ps_rd_ready = Bool
  val ps_wr_ready = Bool
}

class adder_unit (cfg: NPUConfig) extends Component {
  val io = new Bundle {
   val pinA = in SInt(cfg.PE_PSUM_WD bits)
   val pinB = in SInt(cfg.PE_PSUM_WD bits)
   val maxpool_en = in Bool()
   val result = out SInt(cfg.PE_PSUM_WD bits)
  }
  noIoPrefix()

  val adder_pinA = SInt(cfg.PE_PSUM_WD bits)
  val adder_pinB = SInt(cfg.PE_PSUM_WD bits)
  val adder_sum  = SInt(cfg.PE_PSUM_WD bits)
  
  adder_pinA := Mux(io.maxpool_en, S(0), io.pinA)
  adder_pinB := Mux(io.maxpool_en, S(0), io.pinB)
  adder_sum := adder_pinA + adder_pinB

  val comp_pinA = SInt(cfg.PE_PSUM_WD bits)
  val comp_pinB = SInt(cfg.PE_PSUM_WD bits)
  val comp_res  = SInt(cfg.PE_PSUM_WD bits)
  val AgtB = Bool()
  AgtB := comp_pinA > comp_pinB
  comp_pinA := Mux(io.maxpool_en, io.pinA, S(0))
  comp_pinB := Mux(io.maxpool_en, io.pinB, S(0))
  comp_res := Mux(AgtB, comp_pinA, comp_pinB)
  
  io.result :=  Mux(io.maxpool_en, comp_res, adder_sum)
}

class RoundToInf_unit (DATAWD: Int, SIGNED: Boolean) extends Component {
  val RND_WD = log2Up(DATAWD)
  val io = new Bundle {
   val indata = in Bits(DATAWD bits)
   val roundbits = in UInt(RND_WD bits)
   val outdata = out  Bits(DATAWD bits)
  }
  noIoPrefix()
  val isZero = io.roundbits === 0
  val decide_bit = B(0,DATAWD-1 bits) ## io.indata(io.roundbits-1)
  if(SIGNED){
    io.outdata := Mux(isZero, io.indata, ((io.indata.asSInt >> io.roundbits) + decide_bit.asSInt).asBits)
  }
  else{
    io.outdata := Mux(isZero, io.indata, ((io.indata.asUInt >> io.roundbits) + decide_bit.asUInt).asBits)
  }
}

class QNT_unit (DIn_WD: Int, DOut_WD: Int, DSc_WD: Int) extends Component {
  val io = new Bundle {
   val enable = in Bool()
   val indata = in SInt(DIn_WD bits)
   val shift_scale = in SInt(DSc_WD bits)
   val quant_data = out  SInt(DOut_WD bits)
  }
  noIoPrefix()
  val isSign = io.shift_scale.sign
  val scale_abs = io.shift_scale.abs
  val indata_after_shift = SInt(DIn_WD bits)
  val indata_after_round = SInt(DIn_WD bits)
  indata_after_shift := Mux(isSign, io.indata, io.indata |<< scale_abs)

  val roundtoinf = new RoundToInf_unit(DATAWD = DIn_WD, SIGNED= true)
  roundtoinf.io.indata := indata_after_shift.asBits
  roundtoinf.io.roundbits := Mux(isSign, scale_abs, U(0))
  indata_after_round := Mux(io.enable, roundtoinf.io.outdata.asSInt, io.indata)

  io.quant_data := indata_after_round.sat(DIn_WD-DOut_WD)

}

class pe_unit (cfg: NPUConfig) extends Component {
  val io = new Bundle {
   val pe_weight_in = slave Flow(SInt(cfg.PE_WEIGHT_WD bits))
   val pe_ifmap_in = slave Flow(SInt(cfg.PE_FMAP_WD bits))
   val pe_bias_in = slave Flow(SInt(cfg.PE_BIAS_WD bits))
   val pe_shift_scale = slave Flow(SInt(cfg.PE_SCALE_WD bits))
   val pe_ofmap_out = master Flow(SInt(cfg.PE_FMAP_WD bits))
   val pe_ctrl = slave(new PeControls(cfg=cfg))
   val pe_flags = master(new PeFlags())
  }
  noIoPrefix()
  val PROD_WD = cfg.PE_FMAP_WD+cfg.PE_WEIGHT_WD 
  assert(PROD_WD <= cfg.PE_PSUM_WD)

  val Multiplier =  multiplier_wrap(
       MulConfig(SIZEINA = cfg.PE_WEIGHT_WD, SIZEINB = cfg.PE_FMAP_WD, cfg.PE_MUL_Vender))
  
  // Multiplier
  val Mula = Reg(SInt(cfg.PE_FMAP_WD bits)) init(0)
  val Mulb = Reg(SInt(cfg.PE_WEIGHT_WD bits)) init(0)
  val MA_AfterMux = Flow(SInt(cfg.PE_FMAP_WD bits))
  val MB_AfterMux = Flow(SInt(cfg.PE_WEIGHT_WD bits))
  val bias_Mul = Flow(SInt(cfg.PE_WEIGHT_WD bits))
  val Mul_out = Flow(SInt(PROD_WD bits))
  val Mul_finish = Bool()
  bias_Mul.valid := io.pe_bias_in.valid
  bias_Mul.payload:= io.pe_bias_in.payload(cfg.PE_WEIGHT_WD-1 downto 0)
  MA_AfterMux := Mux(io.pe_ctrl.ps_back_en, io.pe_ofmap_out, io.pe_ifmap_in)
  MB_AfterMux := Mux(io.pe_ctrl.bias_mul_en, bias_Mul, io.pe_weight_in )

  when(MA_AfterMux.valid){
      Mula := MA_AfterMux.payload
  }
  when(MB_AfterMux.valid){
      Mulb := MB_AfterMux.payload
  }

  io.pe_flags.ps_rd_ready := MA_AfterMux.valid
  
  Multiplier.io.dinA := Mula
  Multiplier.io.dinB := Mulb
  Multiplier.io.din_vld := RegNext(MA_AfterMux.valid) init(false) // can be modified
  Mul_finish := Multiplier.io.finish 
  Mul_out.payload := Multiplier.io.dout
  Mul_out.valid := Multiplier.io.dout_vld
  io.pe_flags.ps_wr_ready := Mul_finish

  // Adder
  val Adder = new adder_unit(cfg)
  val adder_out = Flow(SInt(cfg.PE_PSUM_WD bits))
  val mul_out_ext = Mul_out.payload.resize(cfg.PE_PSUM_WD)
  val adder_pinB = SInt(cfg.PE_PSUM_WD bits)
  val adder_pinA = SInt(cfg.PE_PSUM_WD bits)
  Adder.io.pinA := adder_pinA
  Adder.io.pinB := adder_pinB
  Adder.io.maxpool_en := io.pe_ctrl.maxpool_en
  adder_out.payload := Adder.io.result
  adder_out.valid := Mul_out.valid
  adder_pinA :=  Mux(io.pe_ctrl.ps_pinA_bias_en, io.pe_bias_in.payload, mul_out_ext)

  // Quant
  val qnt = new QNT_unit(DIn_WD = cfg.PE_PSUM_WD, DOut_WD = cfg.PE_PSUM_WD, DSc_WD = cfg.PE_SCALE_WD)
  qnt.io.indata := adder_out.payload
  qnt.io.shift_scale :=  io.pe_shift_scale.payload
  qnt.io.enable := io.pe_ctrl.ps_scale_en

  // Psum 
  val Ps_rgfile = new Ram1r1w(MemConfig(DATAWD = cfg.PE_PSUM_WD,SIZE = cfg.PE_PSUM_NUM,MemVender = REGMEM))
  val ps_rf_rdata = Flow(SInt(cfg.PE_PSUM_WD bits))
  val ps_true_rd_en = Bool()
  ps_true_rd_en := io.pe_ctrl.ps_rd & io.pe_ctrl.ps_allow_rd
  Ps_rgfile.io.waddr := io.pe_ctrl.ps_waddr
  Ps_rgfile.io.raddr := io.pe_ctrl.ps_raddr
  Ps_rgfile.io.wr := io.pe_ctrl.ps_wr
  Ps_rgfile.io.rd := ps_true_rd_en
  Ps_rgfile.io.wdata := qnt.io.quant_data.asBits
  ps_rf_rdata.payload := Mux(ps_true_rd_en, Ps_rgfile.io.rdata.asSInt, S(0))
  ps_rf_rdata.valid := RegNext(ps_true_rd_en) init(false)
  adder_pinB :=  Mux(io.pe_ctrl.ps_pinB_bias_en, io.pe_bias_in.payload, ps_rf_rdata.payload)


  io.pe_ofmap_out.valid := ps_rf_rdata.valid
  io.pe_ofmap_out.payload := ps_rf_rdata.payload(cfg.PE_FMAP_WD-1 downto 0)

}


object pe_gen {
  def main(args: Array[String]): Unit = {
    SpinalConfig(
      defaultConfigForClockDomains = ClockDomainConfig(resetKind = ASYNC,
        clockEdge = RISING,
        resetActiveLevel = LOW),
      mode=Verilog,
      enumPrefixEnable = false,
      anonymSignalPrefix="tmp",
      targetDirectory = "rtl"
      )
    //  .withoutEnumString()
      .generate(new pe_unit(cfg=NPUConfig()))
    }.printPruned()
}
