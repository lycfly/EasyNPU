
import spinal.core._
import spinal.core.sim._
import spinal.lib.fsm._
import spinal.lib._
import scala.collection.mutable.ArrayBuffer

case class RF_wbus (ADDRWD: Int , DATAWD: Int, PORT_NUM: Int) extends Bundle with IMasterSlave{
  val wr    =  Vec(Bool, PORT_NUM)
  val waddr =  Vec(UInt(ADDRWD bits), PORT_NUM)
  val wdata =  Vec(Bits(DATAWD bits), PORT_NUM)
  override def asMaster(): Unit = {
  out(wr)
  out(waddr)
  out(wdata)
 }
}
case class RF_rbus (ADDRWD: Int , DATAWD: Int, PORT_NUM: Int) extends Bundle with IMasterSlave{
  val rd    =  Vec(Bool, PORT_NUM)
  val raddr =  Vec(UInt(ADDRWD bits), PORT_NUM)
  val rdata =  Vec(Bits(DATAWD bits), PORT_NUM)
  override def asMaster(): Unit = {
  out(rd)
  out(raddr)
  in(rdata)
 }
}
case class regfile(DATAWD: Int , SIZE: Int , RDPORT_NUM: Int, WRPORT_NUM: Int) extends Component{
  val io = new Bundle{
    val wbus = slave(RF_wbus(log2Up(SIZE), DATAWD, WRPORT_NUM))
    val rbus = slave(RF_rbus(log2Up(SIZE), DATAWD, RDPORT_NUM))
  }
  noIoPrefix()
  val rf = new RamNrNw(MemConfig(
                        DATAWD = DATAWD, 
                        SIZE = SIZE, 
                        RD_NUM = RDPORT_NUM,
                        WR_NUM = WRPORT_NUM,
                        MemVender = REGMEM))
  rf.io.waddr := io.wbus.waddr
  rf.io.wdata := io.wbus.wdata
  rf.io.wr := io.wbus.wr
  rf.io.raddr := io.rbus.raddr
  rf.io.rd := io.rbus.rd
  io.rbus.rdata := rf.io.rdata
}

class Ifscp_ctrl (cfg: NPUConfig) extends Bundle{
  val if_rd   =  Vec(Bool, cfg.CLUSTER_LINE_NUM)
  val hw_addr =  Vec(UInt(cfg.IFSCP_ADDRWD bits), cfg.CLUSTER_LINE_NUM)
  val ich_addr =  UInt(log2Up(cfg.ARRAY_COL_NUM) bits)
  val cast_mode = Bool
}

case class Ifscp_ctrl_bus (cfg: NPUConfig) extends Ifscp_ctrl(cfg) with IMasterSlave{
  override def asMaster(): Unit = out(this)
}


class If_scratch_pad (cfg: NPUConfig) extends Component{
  val io = new Bundle {
    val ifscp_wbus = slave(RF_wbus(cfg.IFSCP_ADDRWD, cfg.IFSCP_BUS_WD, 1))
    val ifscp_ctrl = slave(Ifscp_ctrl_bus(cfg))
    val if_pe_bus  = out Vec(Vec(Bits(cfg.PE_FMAP_WD bits), cfg.CLUSTER_LINE_NUM), cfg.ARRAY_COL_NUM)
  }
  noIoPrefix()

  val If_rf = ArrayBuffer.fill(cfg.ARRAY_COL_NUM)(regfile(DATAWD = cfg.PE_FMAP_WD, SIZE = cfg.IFSCP_SIZE, RDPORT_NUM = cfg.CLUSTER_LINE_NUM, WRPORT_NUM = 1))
  
  val ifwdata = io.ifscp_wbus.wdata(0).subdivideIn(cfg.ARRAY_COL_NUM slices)
  val ifrdata = Vec(Vec(Bits(cfg.PE_FMAP_WD bits), cfg.CLUSTER_LINE_NUM),cfg.ARRAY_COL_NUM)

  for(i <- 0 until cfg.ARRAY_COL_NUM){
      If_rf(i).io.wbus.wr(0) := io.ifscp_wbus.wr(0)
      If_rf(i).io.wbus.waddr(0) := io.ifscp_wbus.waddr(0)
      If_rf(i).io.wbus.wdata(0) := ifwdata(i)

      for(j <- 0 until cfg.CLUSTER_LINE_NUM){
        If_rf(i).io.rbus.raddr(j) := io.ifscp_ctrl.hw_addr(j)
        If_rf(i).io.rbus.rd(j) := io.ifscp_ctrl.if_rd(j)
        ifrdata(i)(j) := If_rf(i).io.rbus.rdata(j)
      }
  }

  val if_broadcast_out = Vec(Bits(cfg.PE_FMAP_WD bits), cfg.CLUSTER_LINE_NUM)

  for(j <- 0 until cfg.CLUSTER_LINE_NUM){
    if_broadcast_out(j) := ifrdata(io.ifscp_ctrl.ich_addr)(j)
  }
  for(i <- 0 until cfg.ARRAY_COL_NUM){
    for(j <- 0 until cfg.CLUSTER_LINE_NUM){
      io.if_pe_bus(i)(j) := Mux(io.ifscp_ctrl.cast_mode, if_broadcast_out(j) , ifrdata(i)(j))
    }
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
