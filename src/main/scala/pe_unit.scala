
import spinal.core._
import spinal.core.sim._
import spinal.lib.fsm._
import spinal.lib._
import spire.algebra.Sign

class PeControls (cfg: NPUConfig) extends Bundle with IMasterSlave{
  override def asMaster(): Unit = out(this)
  override def asSlave() : Unit  = in(this)
  
  val ps_back_en = Bool
  val ps_addr = UInt(log2Up(cfg.PE_PSUM_NUM) bits)
  val ps_outer_en = Bool
  val byp_mul_en = Bool
  val maxpool_en = Bool
  val bias_mul_en = Bool
  val shift_scale = UInt(cfg.PE_SCALE_WD bits)
}

class pe_unit (cfg: NPUConfig) extends Component {
  val io = new Bundle {
 //  val pe_weight_in = slave Flow(SInt(cfg.PE_WEIGHT_WD bits))
   val pe_ifmap_in = slave Flow(SInt(cfg.PE_FMAP_WD bits))
 //  val pe_bias_in = slave Flow(SInt(cfg.PE_BIAS_WD bits))
   val pe_ofmap_out = master Flow(SInt(cfg.PE_FMAP_WD bits))
   val pe_ctrl = slave(new PeControls(cfg=cfg))
  }
  noIoPrefix()
   
  val Multiplier = multiplier_wrap(
      MulConfig(SIZEINA = cfg.PE_WEIGHT_WD, SIZEINB = cfg.PE_FMAP_WD, Vender = cfg.PE_MUL_Vender))
  

  val Mula = Reg(SInt(cfg.PE_WEIGHT_WD bits)) init(0)
  val Mulb = Reg(SInt(cfg.PE_WEIGHT_WD bits)) init(0)
  val MulaAfterMux = Flow(SInt(cfg.PE_FMAP_WD bits))
  MulaAfterMux := Mux(io.pe_ctrl.ps_back_en, io.pe_ofmap_out, io.pe_ifmap_in)
  when(MulaAfterMux.valid){
      Mula := MulaAfterMux.payload
  }
  Multiplier.io.dinA := Mula
  Multiplier.io.dinB := Mula
  Multiplier.io.din_vld := RegNext(MulaAfterMux.valid) init(False)

  io.pe_ofmap_out.valid := Bool(false)
  io.pe_ofmap_out.payload := 0


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
