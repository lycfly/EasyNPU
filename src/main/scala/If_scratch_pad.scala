
import spinal.core._
import spinal.core.sim._
import spinal.lib.fsm._
import spinal.lib._
import scala.collection.mutable.ArrayBuffer

case class RF_wbus (ADDRWD: Int , DATAWD: Int) extends Bundle with IMasterSlave{
  val wr    =  Bool
  val waddr =  UInt(ADDRWD bits)
  val wdata =  Bits(DATAWD bits)
  override def asMaster(): Unit = {
  out(wr)
  out(waddr)
  out(wdata)
 }
}
case class RF_rbus (ADDRWD: Int , DATAWD: Int) extends Bundle with IMasterSlave{
  val rd    =  Bool
  val raddr =  UInt(ADDRWD bits)
  val rdata =  Bits(DATAWD bits)
  override def asMaster(): Unit = {
  out(rd)
  out(raddr)
  in(rdata)
 }
}
case class regfile(DATAWD: Int , SIZE: Int ) extends Component{
  val io = new Bundle{
    val wbus = slave(RF_wbus(log2Up(SIZE), DATAWD))
    val rbus = slave(RF_rbus(log2Up(SIZE), DATAWD))
  }
  noIoPrefix()
  val rf = new Ram1r1w(MemConfig(
                         DATAWD = DATAWD, 
                         SIZE = SIZE, 
                         MemVender = REGMEM))
  rf.io.waddr := io.wbus.waddr
  rf.io.wdata := io.wbus.wdata
  rf.io.wr := io.wbus.wr
  rf.io.raddr := io.rbus.raddr
  rf.io.rd := io.rbus.rd
  io.rbus.rdata := rf.io.rdata
}

class Ifscp_ctrl (cfg: NPUConfig) extends Bundle{
  val if_rd   =  Bool
  val hw_addr =  UInt(cfg.IFSCP_ADDRWD bits)
  val ich_addr =  UInt(log2Up(cfg.ARRAY_COL_NUM) bits)
  val cast_mode = Bool
}

case class Ifscp_ctrl_bus (cfg: NPUConfig) extends Ifscp_ctrl(cfg) with IMasterSlave{
  override def asMaster(): Unit = out(this)
}


class If_scratch_pad (cfg: NPUConfig) extends Component{
  val io = new Bundle {
    val ifscp_wbus = slave(RF_wbus(cfg.IFSCP_ADDRWD, cfg.IFSCP_BUS_WD))
    val ifscp_ctrl = slave(Ifscp_ctrl_bus(cfg))
    val if_pe_bus  = out Vec(Bits(cfg.PE_FMAP_WD bits), cfg.ARRAY_COL_NUM)
  }
  noIoPrefix()

  val If_rf = ArrayBuffer.fill(cfg.ARRAY_COL_NUM)(regfile(DATAWD = cfg.PE_FMAP_WD, SIZE = cfg.IFSCP_SIZE))
  
  val ifwdata = io.ifscp_wbus.wdata.subdivideIn(cfg.ARRAY_COL_NUM slices)
  val ifrdata = Vec(Bits(cfg.PE_FMAP_WD bits), cfg.ARRAY_COL_NUM)

  for(i <- 0 until cfg.ARRAY_COL_NUM){
      If_rf(i).io.wbus.wr := io.ifscp_wbus.wr
      If_rf(i).io.wbus.waddr := io.ifscp_wbus.waddr
      If_rf(i).io.wbus.wdata := ifwdata(i)

      If_rf(i).io.rbus.raddr := io.ifscp_ctrl.hw_addr
      If_rf(i).io.rbus.rd := io.ifscp_ctrl.if_rd
      ifrdata(i) := If_rf(i).io.rbus.rdata
  }
  
  val if_broadcast_out = Bits(cfg.PE_FMAP_WD bits)
  if_broadcast_out := ifrdata(io.ifscp_ctrl.ich_addr)
  for(i <- 0 until cfg.ARRAY_COL_NUM){
    io.if_pe_bus(i) := Mux(io.ifscp_ctrl.cast_mode, if_broadcast_out , ifrdata(i))
  }


}



object ifscp_gen {
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
      .generate(new If_scratch_pad(cfg=NPUConfig()))
    }.printPruned()
}
