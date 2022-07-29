
import spinal.core._
import spinal.core.sim._
import spinal.lib.fsm._
import spinal.lib._


case class count_sigs () extends Bundle{
  val inc = Bool()
  val this_ov = Bool()
  val reach_th = Bool()
  val isInitial = Bool()
}

object counter {
  def build(DW: Int, Th_dec: Boolean, thre: UInt, step: UInt, sigs: count_sigs): counter = {
    val count = counter(DW, Th_dec)
    count.io.step := step
    count.io.inc_en := sigs.inc
    count.io.threshold := thre
    sigs.this_ov := count.io.this_ov
    sigs.reach_th := count.io.reach_th
    sigs.isInitial := count.io.isInitial
    count
  }
}


case class counter (DW: Int, Th_dec: Boolean) extends Component{
  val io = new Bundle {
    val step      = in UInt(DW+1 bits)
    val threshold = in UInt(DW bits)
    val inc_en    = in Bool()
    val cnt   = out UInt(DW bits)
    val nxt_cnt   = out UInt(DW+1 bits)
    val this_ov   = out Bool()
    val reach_th  = out Bool()
    val isInitial = out Bool()

  }
  noIoPrefix()
  val cnt_rg = Reg(UInt(DW+1 bits)) init(0)
  val true_threshold = UInt(DW bits)
  true_threshold := io.threshold.resize(DW)
  io.nxt_cnt := cnt_rg + io.step

  if (Th_dec){
    io.reach_th := (io.nxt_cnt >= (true_threshold - 1))
  }else {
    io.reach_th := (io.nxt_cnt >= true_threshold)
  }

  when(io.inc_en){
    when(io.reach_th){
      cnt_rg := 0
    }.otherwise{
      cnt_rg := io.nxt_cnt
    }
  }
  io.cnt := cnt_rg.resized
  io.this_ov := io.reach_th & io.inc_en
  io.isInitial := io.cnt(DW-1 downto 0) === 0
}



object PortToRegWithInit {
  def apply[T <: Data](dataType: HardType[T]): T = {
    val regOut = cloneOf(dataType)
    for ( e <- regOut.flatten) {
      e.setAsReg()
      e.init(
        e.getZero
      )
    }
    regOut
  }
}

object SigsClearAll {  
  //Clear all signals in a Bundle
  def apply(dataType: Data): Unit = {
    for ( e <- dataType.flatten) {
      e := e.getZero
    }
  }
}