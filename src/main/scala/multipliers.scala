

import spinal.core._
import spinal.core.sim._

case class MulConfig(
                   SIZEINA: Int ,
                   SIZEINB: Int ,
                   Vender: Mulvendor
)

trait Mulvendor {
  def build(wrap: multiplier_wrap, MC: MulConfig): Component = new SimpleSignedMul(wrap ,MC).Build()
}
case object SimpleMulVendor extends Mulvendor

case object Booth4Vendor extends Mulvendor{
  override def build(wrap: multiplier_wrap, MC: MulConfig): Component = new Booth4Mul(wrap ,MC).Build()
}
case object MultiplierIPVendor extends Mulvendor{
  override def build(wrap: multiplier_wrap, MC: MulConfig): BlackBox = new MultiplierIP(wrap ,MC).Build()
}


class MultiplierIP(wrap: multiplier_wrap, MC: MulConfig) extends BlackBox{
  this.setDefinitionName(s"multiplier_ip")
  val io = new Bundle { 
    val dinA = in SInt (MC.SIZEINA bits)
    val dinB = in SInt (MC.SIZEINB bits)
    val din_vld = in Bool()
    val dout = out SInt (MC.SIZEINA + MC.SIZEINB bits)
    val dout_vld = out Bool()
  }
    def Build(): BlackBox={
      io.dinA    := wrap.io.dinA
      io.dinB    := wrap.io.dinB
      io.din_vld := wrap.io.din_vld
      wrap.io.dout    := io.dout
      wrap.io.dout_vld:= io.dout_vld
      wrap.io.finish:= io.din_vld   // finish = din vld ?? This should be checked

      this
    }
  noIoPrefix()
  

}
class SimpleSignedMul(wrap: multiplier_wrap, MC: MulConfig) extends Component{
  val io = new Bundle { 
    val dinA = in SInt (MC.SIZEINA bits)
    val dinB = in SInt (MC.SIZEINB bits)
    val din_vld = in Bool()
    val dout = out SInt (MC.SIZEINA + MC.SIZEINB bits)
    val dout_vld = out Bool()
  }
    val mul = new SignMultiplier(MC.SIZEINA ,MC.SIZEINB)
    mul.io.dinA := io.dinA
    mul.io.dinB := io.dinB
    mul.io.din_vld := io.din_vld
    io.dout    := mul.io.dout
    io.dout_vld:= mul.io.dout_vld

    def Build(): Component={
      io.dinA    := wrap.io.dinA
      io.dinB    := wrap.io.dinB
      io.din_vld := wrap.io.din_vld
      wrap.io.dout    := io.dout
      wrap.io.dout_vld:= io.dout_vld
      wrap.io.finish:= io.din_vld   // finish = din vld

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
    val finish = out Bool()
    val dout_vld = out Bool()
  }
    val mul = new booth4(MC.SIZEINA ,MC.SIZEINB)
    mul.io.dinA := io.dinA
    mul.io.dinB := io.dinB
    mul.io.din_vld := io.din_vld
    io.dout    := mul.io.dout
    io.dout_vld:= mul.io.dout_vld
    io.finish := mul.io.finish
    def Build(): Component={
      io.dinA    := wrap.io.dinA
      io.dinB    := wrap.io.dinB
      io.din_vld := wrap.io.din_vld
      wrap.io.dout    := io.dout
      wrap.io.dout_vld:= io.dout_vld
      wrap.io.dout_vld:= io.finish
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
    val finish = out Bool()
    val dout_vld = out Bool()

  }
  noIoPrefix()
  val mul = MC.Vender.build(this,MC)


}

// class MulPorts (SIZEINA: Int, SIZEINB:Int) extends Bundle {
//   val io = new Bundle {
//     val din_vld = in Bool()
//     val dinA = in SInt (SIZEINA bits)
//     val dinB = in SInt (SIZEINB bits)

//     val dout_vld = out Bool()
//     val cal_finish = out Bool()
//     val dout = out SInt (SIZEINA + SIZEINB bits)
//   }
// }


class booth4 (SIZEINA: Int, SIZEINB:Int) extends Component{
    val io = new Bundle {
    val din_vld = in Bool()
    val dinA = in SInt (SIZEINA bits)
    val dinB = in SInt (SIZEINB bits)

    val dout_vld = out Bool()
    val finish = out Bool()
    val dout = out SInt (SIZEINA + SIZEINB bits)
  }
 // val dinAReg = Reg(SInt (SIZEINA bits)) init(0)
 // val dinBReg = Reg(SInt (SIZEINA bits)) init(0)
  val MAX_NUM = SIZEINA/2 - 1
  val MAX_DW = log2Up(SIZEINA/2)
  val SHIFT_SIZE = SIZEINA + SIZEINB + 1 + 2
  val Breg = Reg(SInt(SIZEINB bits)) init(0)
  val shiftReg = Reg(Bits(SHIFT_SIZE bits)) init(0)
  val flag_bits = Bits(3 bits)
  val NegativeB = SInt(SIZEINB + 2 bits)
  val Negative2B = SInt(SIZEINB + 2 bits)
  val PositiveB = SInt(SIZEINB + 2 bits)
  val Positive2B = SInt(SIZEINB + 2 bits)
  val AddB = SInt(SIZEINB + 2 bits)
  val Add2B = SInt(SIZEINB + 2 bits)
  val MinusB = SInt(SIZEINB + 2 bits)
  val Minus2B = SInt(SIZEINB + 2 bits)

  val cal_cnt = Reg(UInt(MAX_DW bits)) init(0)
  val cal_en = Reg(Bool()) init(false)
  flag_bits := shiftReg(2 downto 0)
  NegativeB := - PositiveB
  PositiveB := Breg.resized
  Negative2B := NegativeB |<< 1
  Positive2B := PositiveB |<< 1

  val shiftReg_low = SInt()
  val shiftReg_high = SInt()
  shiftReg_low := shiftReg(SIZEINA downto 0).asSInt
  shiftReg_high := shiftReg(SIZEINA+SIZEINB+2 downto SIZEINA+1).asSInt

  AddB := (shiftReg_high + PositiveB)
  Add2B := (shiftReg_high + Positive2B)
  MinusB := (shiftReg_high + NegativeB)
  Minus2B := (shiftReg_high + Negative2B)

  val cal_cnt_ov_flag = cal_cnt === MAX_NUM
  io.finish := cal_cnt_ov_flag & cal_en

  when(io.din_vld){
    cal_en := Bool(true)
  }.elsewhen(cal_cnt_ov_flag){
    cal_en := Bool(false)
  }
  when(cal_en){
    cal_cnt := cal_cnt + 1
  }.elsewhen(io.din_vld){
    cal_cnt := 0
  }
  val beforeshift = Bits()
  val aftershift = Bits()
  switch(flag_bits) {
    is(0,7){
      beforeshift := shiftReg_high.asBits
    }
    is(1,2){
      beforeshift  :=  AddB.asBits   //shift and add
    }
    is(5,6){
      beforeshift  :=  MinusB.asBits   //shift and add
    }
    is(3){
      beforeshift  :=  Add2B.asBits  //shift and add
    }
    is(4){
      beforeshift  :=  Minus2B.asBits  //shift and add
    }
  }
  aftershift := ((beforeshift ## shiftReg_low.asBits).asSInt |>> 2).asBits
  
  //val affterAdd = Bits(SIZEINA+SIZEINB + 3 bits)
  //affterAdd :=  (beforeshift ## shiftReg_low.asBits)
  //aftershift := affterAdd.msb ## affterAdd.msb ## affterAdd( SIZEINA+SIZEINB+2 downto 2)

  when(io.din_vld){
    shiftReg := U(0, SHIFT_SIZE - SIZEINA - 1 bits).asBits ## io.dinA.asBits ## U(0, 1 bits).asBits
    Breg     := io.dinB
  }.elsewhen(cal_en){
    shiftReg := aftershift
  }

  io.dout_vld := cal_en.fall
  io.dout := shiftReg(SIZEINA+SIZEINB downto 1).asSInt

  //  io.dout := io.dinA * io.dinB
}

class SignMultiplier (SIZEINA: Int, SIZEINB:Int) extends Component {
  val io = new Bundle {
    val dinA = in SInt (SIZEINA bits)
    val dinB = in SInt (SIZEINB bits)
    val din_vld = in Bool()

    val dout = out SInt (SIZEINA + SIZEINB bits)
    val dout_vld = out Bool()

  }
  val Result = Reg(SInt(SIZEINB+ SIZEINA bits)) init(0)
  val dout_vld_reg = RegNext(io.din_vld) init(false)
  when(io.din_vld){
    Result :=   io.dinA * io.dinB
  }
  io.dout := Result
  io.dout_vld := dout_vld_reg
}


object SignMultiplierInst {
  def main(args: Array[String]): Unit = {
    SpinalConfig(
      defaultConfigForClockDomains = ClockDomainConfig(resetKind = ASYNC,
        clockEdge = RISING,
        resetActiveLevel = LOW),
      mode=Verilog).generate(new SignMultiplier(SIZEINA = 8, SIZEINB = 8))


  }
}
object booth4_inst {
  def main(args: Array[String]): Unit = {
    SpinalConfig(
      defaultConfigForClockDomains = ClockDomainConfig(resetKind = ASYNC,
        clockEdge = RISING,
        resetActiveLevel = LOW),
      mode=Verilog,
      targetDirectory="rtl"
      ).generate(new booth4(SIZEINA = 8, SIZEINB = 8))


  }
}

