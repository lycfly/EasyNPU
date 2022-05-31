import spinal.core._
import spinal.core.sim._
import spinal.lib.fsm._
import spinal.lib._
import spire.algebra.Sign

case class Flow_reg_interface (cfg: NPUConfig) extends Bundle with IMasterSlave{
  val subHo = UInt(cfg.SUBH_WD bits)
  val subHi = UInt(cfg.SUBH_WD bits)
  val subWo = UInt(cfg.SUBW_WD bits)
  val subWi = UInt(cfg.SUBW_WD bits)
  val Hk    = UInt(cfg.KERNEL_H_WD bits)
  val Wk    = UInt(cfg.KERNEL_W_WD bits)
  val Ho    = UInt(cfg.HEIGHT_WD bits)
  val Wo    = UInt(cfg.WIDTH_WD bits)
  val Hi    = UInt(cfg.HEIGHT_WD bits)
  val Wi    = UInt(cfg.WIDTH_WD bits)
  val Co    = UInt(cfg.CHANNEL_WD bits)
  val Ci    = UInt(cfg.CHANNEL_WD bits)
  val sh    = UInt(cfg.STRIDE_WD bits)
  val sw    = UInt(cfg.STRIDE_WD bits)
  val ph    = UInt(cfg.PADDING_WD bits)
  val pw    = UInt(cfg.PADDING_WD bits)
  val dh    = UInt(cfg.DILATION_WD bits)
  val dw    = UInt(cfg.DILATION_WD bits)
  val zs    = UInt(cfg.SUBOCH_WD bits)
  val k     = UInt(cfg.SUBOCH_WD bits)

  override def asMaster(): Unit = out(this)
}

case class Flow_reg_interface (cfg: NPUConfig) extends Bundle with IMasterSlave{



case class counter (DW: Int, Th_dec: Boolean) extends Component{
  val io = new Bundle {
    val threshold = in UInt(DW bits)
    val inc_en    = in Bool()
    val this_ov   = out Bool()
  }
  val cnt = Reg(UInt(DW bits)) init(0)
  val overflow = Bool()
  if (Th_dec){
    overflow := (cnt === (io.threshold - 1))
  }else {
    overflow := (cnt === io.threshold)
  }
  when(inc_en){
    when(overflow){
      cnt := 0
    }.otherwise{
      cnt := cnt + 1
    }
  }
  io.this_ov := overflow
}

class pe_flow_ctrl (cfg: NPUConfig) extends Component{
  val io = new Bundle {
    val rg = slave(Flow_reg_interface(cfg))
    val pe_ctrl = master(new PeControls(cfg))
    val ifscp_ctrl = master(Ifscp_ctrl(cfg))
    val wescp_ctrl = master(Wescp_ctrl(cfg))
    val pe_flags = slave(new PeFlags())

  }
  noIoPrefix()
  val kzi = counter(cfg.SUBOCH_WD , true)
  val hzi = counter(cfg.SUBOCH_WD , true)


}

object flow_ctrl_gen {
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
      .generate(new pe_flow_ctrl(cfg=NPUConfig()))
    }.printPruned()
}
