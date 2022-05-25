
import spinal.core._
import spinal.core.sim._
import spinal.lib.fsm._
import spinal.lib._
case class MulConfig(
                   SIZEINA: Int ,
                   SIZEINB: Int ,
                   Vender: Mulvendor
)

trait Mulvendor {
  def build(mulwrap: multiplier_wrap, MC: MulConfig): Component = new SimpleSignedMul(mulwrap,MC).Build()
}

case object Booth4Vendor extends Mulvendor{
  override def build(mulwrap: multiplier_wrap, MC: MulConfig): Component = new Booth4Mul(mulwrap,MC).Build()
}
case object SimpleMulVendor extends Mulvendor{
  override def build(mulwrap: multiplier_wrap, MC: MulConfig): Component = new SimpleSignedMul(mulwrap,MC).Build()
}

class SimpleSignedMul(wrap: multiplier_wrap, MC: MulConfig) extends BlackBox{
  val io = new Bundle { 
    val dinA = in SInt (MC.SIZEINA bits)
    val dinB = in SInt (MC.SIZEINB bits)
    val din_vld = in Bool()
    val dout = out SInt (MC.SIZEINA + MC.SIZEINB bits)
    val dout_vld = out Bool()
  }
  def Build(): Component = {
    this.io.dinA    := wrap.io.dinA
    this.io.dinB    := wrap.io.dinB
    this.io.din_vld := wrap.io.din_vld
    wrap.io.dout    := this.io.dout
    wrap.io.dout_vld:= this.io.dout_vld
    this
  }
  noIoPrefix()
}

class Booth4Mul(wrap: multiplier_wrap, MC: MulConfig) extends Component{
  val io = new Bundle { 
    val dinA = in SInt (MC.SIZEINA bits)
    val dinB = in SInt (MC.SIZEINB bits)
    val din_vld = in Bool()
    val dout = out SInt (MC.SIZEINA + MC.SIZEINB bits)
    val dout_vld = out Bool()
  }
  def Build(): Component = {
    this.io.dinA    := wrap.io.dinA
    this.io.dinB    := wrap.io.dinB
    this.io.din_vld := wrap.io.din_vld
    wrap.io.dout    := this.io.dout
    wrap.io.dout_vld:= this.io.dout_vld
    this
  }
  noIoPrefix()
}

case class multiplier_wrap(MC: MulConfig) extends Component{
  val io = new Bundle {
    val dinA = in SInt (MC.SIZEINA bits)
    val dinB = in SInt (MC.SIZEINB bits)
    val din_vld = in Bool()
    val dout = out SInt (MC.SIZEINA + MC.SIZEINB bits)
    val dout_vld = out Bool()

  }
   noIoPrefix()
  val mul = MC.Vender.build(this, MC)
}
