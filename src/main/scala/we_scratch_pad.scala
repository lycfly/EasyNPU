
import spinal.core._
import spinal.core.sim._
import spinal.lib.fsm._
import spinal.lib._
import scala.collection.mutable.ArrayBuffer

case class Wescp_ctrl (cfg: NPUConfig) extends Bundle with IMasterSlave{
  val we_rd   =  Bool
  val och_gcnt =  UInt(log2Up(cfg.ARRAY_COL_NUM) bits)
  
  override def asMaster(): Unit = out(this)
}

class We_scratch_pad (cfg: NPUConfig) extends Component{
    val io = new Bundle {
    val wescp_wbus = slave(RF_wbus(cfg.WESCP_ADDRWD, cfg.WESCP_BUS_WD))
    val wescp_ctrl = slave(Wescp_ctrl(cfg))
    val we_pe_bus  = out Vec(Bits(cfg.PE_WEIGHT_WD bits), cfg.ARRAY_COL_NUM)
  }
  noIoPrefix()
  val We_rf = ArrayBuffer.fill(cfg.ARRAY_COL_NUM)(regfile(DATAWD = cfg.PE_WEIGHT_WD, SIZE = cfg.WESCP_SIZE))
  
  val wewdata = io.wescp_wbus.wdata.subdivideIn(cfg.ARRAY_COL_NUM slices)
  for(i <- 0 until cfg.ARRAY_COL_NUM){
      We_rf(i).io.wbus.wr := io.wescp_wbus.wr
      We_rf(i).io.wbus.waddr := io.wescp_wbus.waddr
      We_rf(i).io.wbus.wdata := wewdata(i)

      We_rf(i).io.rbus.raddr := io.wescp_ctrl.och_gcnt
      We_rf(i).io.rbus.rd := io.wescp_ctrl.we_rd
      io.we_pe_bus(i) := We_rf(i).io.rbus.rdata
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
