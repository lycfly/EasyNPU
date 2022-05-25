

import spinal.core._
import spinal.core.sim._
import scala.language.postfixOps

class booth4 (SIZEINA: Int, SIZEINB:Int) extends Component {
  val io = new Bundle {
    val din_vld = in Bool()
    val dinA = in SInt (SIZEINA bits)
    val dinB = in SInt (SIZEINB bits)

    val dout_vld = out Bool()
    val cal_finish = out Bool()
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
  io.cal_finish := cal_cnt_ov_flag & cal_en

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

object booth4_test{
  import scala.math._
  def main(args: Array[String]): Unit = {
    val A = 8
    val B = 8
    val testcase_coverage = 0.05
    SpinalConfig(
      defaultConfigForClockDomains = ClockDomainConfig(resetKind = ASYNC,
        clockEdge = RISING,
        resetActiveLevel = LOW),
        mode=Verilog,
        targetDirectory="rtl"
      ).generate(new booth4(SIZEINA = A, SIZEINB = B))
  var start_time = 0.0
  var end_time = 0.0
  val compiled = SimConfig.withWave.allOptimisation.compile(
  //val compiled = SimConfig.allOptimisation.compile(
    rtl = new booth4(SIZEINA = A, SIZEINB = B))
  compiled.doSim { dut =>
    dut.clockDomain.forkStimulus(2)
    dut.io.din_vld #= false

    sleep(100)
    println("test")
    start_time = (simTime()/1000.0).toFloat
    var a,b,c,d = 0

    val A_bound = pow(2,A-1).toInt
    val B_bound = pow(2,B-1).toInt

    dut.clockDomain.waitSampling()
    val driver_thread = fork{
      for (a <- (-A_bound) to (A_bound-1)){
        for (b <- (-B_bound) to (B_bound-1)) {
          dut.io.din_vld #= true
          dut.io.dinA #= a
          dut.io.dinB #= b
          dut.clockDomain.waitSampling()
          dut.io.din_vld #= false
          dut.clockDomain.waitSamplingWhere(dut.io.cal_finish.toBoolean)
        }
      }
    }
    val monitor_thread = fork{
       for (c <- (-A_bound) to (A_bound-1)){
        for (d <- (-B_bound) to (B_bound-1)) {
          dut.clockDomain.waitSamplingWhere(dut.io.dout_vld.toBoolean)
          assert((d*c)==dut.io.dout.toInt,"data Mismathc")
          println(s"PASSED! Input A = ${c}, B = ${d}. DUT Result = ${dut.io.dout.toInt}; Expect Result = ${c*d}")

        }}
    }
    monitor_thread.join()
    sleep(10)
    end_time = (simTime()*testcase_coverage/1000.0).toFloat
    println(start_time)
    println(end_time)
    simSuccess()

  }
  // import sys.process._
  // "gtkwave -o ./simWorkspace/booth4_v2/test.vcd"!


  //  import DesignCompiler._
  //  val dc_config = DesignCompiler_config(process = 28, freq = 100)
  //  val dc = new DesignCompilerFlow(
  //                                    design = new booth4(SIZEINA = A, SIZEINB = B),
  //                                    topModuleName = "booth4",
  //                                    workspacePath = "/mnt/data/projects/kws/Easonlib/syn/booth4",
  //                                    DCConfig = dc_config,
  //                                    designPath = ""
  //  ).doit()
  
  // import PTPX._
  //  val PTPXconfig = PTPX_config(process = 28, freq = 100)
  //  val ptpx = new PTPX_flow(
  //                                 topModuleName = "booth4",
  //                                 workspacePath = "/mnt/data/projects/kws/Easonlib/ptpx/booth4",
  //                                 PTPXConfig =  PTPXconfig,
  //                                 Date_mode = false,
  //                                 designPath = "/mnt/data/projects/kws/Easonlib",
  //                                 start_time = start_time.toFloat,
  //                                 end_time = end_time.toFloat
  //  ).doit()
    } 
}