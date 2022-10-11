
import spinal.core._
import spinal.core.sim._
import spinal.lib.fsm._
import spinal.lib._
import scala.collection.mutable.ArrayBuffer

class Wescp_ctrl (cfg: NPUConfig) extends Bundle{
  val we_rd   =  Bool
  val bs_wr   =  Bool
  val bs_rd   =  Bool
  val sc_rd   =  Bool
  val bs_byte_cnt  =  UInt(log2Up(cfg.BIAS_BYTE_NUM+1) bits)
  val och_gcnt =  UInt(cfg.SUBOCH_WD bits)
}

case class Wescp_ctrl_bus (cfg: NPUConfig) extends Wescp_ctrl(cfg) with IMasterSlave{
  override def asMaster(): Unit = out(this)
}

class We_scratch_pad (cfg: NPUConfig) extends Component{
    val io = new Bundle {
    val wescp_wbus = slave(RF_wbus(cfg.WESCP_ADDRWD, cfg.WESCP_BUS_WD, 1))
    val wescp_ctrl = slave(Wescp_ctrl_bus(cfg))
    val we_pe_bus  = out Vec(Bits(cfg.PE_WEIGHT_WD bits), cfg.ARRAY_COL_NUM)
    val bias_pe_bus  = out Vec(Bits(cfg.PE_BIAS_WD bits), cfg.ARRAY_COL_NUM)
    val scale_pe_bus  = out Vec(Bits(cfg.PE_SCALE_WD bits), cfg.ARRAY_COL_NUM)

  }
  noIoPrefix()
  val We_rf = ArrayBuffer.fill(cfg.ARRAY_COL_NUM)(regfile(DATAWD = cfg.PE_WEIGHT_WD, SIZE = cfg.WESCP_SIZE,1,1))
  val Bs_rf = ArrayBuffer.fill(cfg.ARRAY_COL_NUM, cfg.BIAS_BYTE_NUM + 1)(regfile(DATAWD = cfg.PE_WEIGHT_WD,  SIZE = cfg.SCALE_SIZE, 1, 1))
  
  
  val wewdata = io.wescp_wbus.wdata(0).subdivideIn(cfg.ARRAY_COL_NUM slices)
  for(i <- 0 until cfg.ARRAY_COL_NUM){
      We_rf(i).io.wbus.wr(0) := io.wescp_wbus.wr(0)
      We_rf(i).io.wbus.waddr(0) := io.wescp_wbus.waddr(0)
      We_rf(i).io.wbus.wdata(0) := wewdata(i)

      We_rf(i).io.rbus.raddr(0) := io.wescp_ctrl.och_gcnt
      We_rf(i).io.rbus.rd(0) := io.wescp_ctrl.we_rd
      io.we_pe_bus(i) := We_rf(i).io.rbus.rdata(0)
  }

  // val bias_byte_cnt = Reg(UInt(log2Up(cfg.BIAS_BYTE_NUM) bits))
  // val bias_byte_cnt_ov = Bool()
  // bias_byte_cnt_ov := bias_byte_cnt === (cfg.BIAS_BYTE_NUM-1)
  // when(io.wescp_ctrl.bias_wr){
  //   when(bias_byte_cnt_ov){
  //     bias_byte_cnt := 0
  //   }.otherwise{
  //     bias_byte_cnt := bias_byte_cnt + 1
  //   }
  // }
  val bs_wr_byte_sel =  ArrayBuffer.fill(cfg.BIAS_BYTE_NUM + 1)(Bool())

  for(j <- 0 until (cfg.BIAS_BYTE_NUM+1)){
      when(io.wescp_ctrl.bs_byte_cnt === j){
        bs_wr_byte_sel(j) := False
      }.otherwise{
        bs_wr_byte_sel(j) := io.wescp_ctrl.bs_wr
      }
  }
  for(i <- 0 until cfg.ARRAY_COL_NUM){
    for(j <- 0 until (cfg.BIAS_BYTE_NUM+1)){
      Bs_rf(i)(j).io.wbus.wr(0) :=  bs_wr_byte_sel(j) & io.wescp_wbus.wr(0)
      Bs_rf(i)(j).io.wbus.waddr(0) := io.wescp_wbus.waddr(0)
      Bs_rf(i)(j).io.wbus.wdata(0) := wewdata(i)

      Bs_rf(i)(j).io.rbus.raddr(0) := io.wescp_ctrl.och_gcnt

      if(j < cfg.BIAS_BYTE_NUM){
        Bs_rf(i)(j).io.rbus.rd(0) := io.wescp_ctrl.bs_rd
        io.bias_pe_bus(i)((j+1)*cfg.PE_WEIGHT_WD-1 downto j*cfg.PE_WEIGHT_WD) := Bs_rf(i)(j).io.rbus.rdata(0)
      }
      else{
        Bs_rf(i)(j).io.rbus.rd(0) := io.wescp_ctrl.sc_rd
      }
  }
  io.scale_pe_bus(i) := Bs_rf(i)(cfg.BIAS_BYTE_NUM).io.rbus.rdata(0)


}


}

object wescp_gen {
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
      .generate(new We_scratch_pad(cfg=NPUConfig()))
    }.printPruned()
}
