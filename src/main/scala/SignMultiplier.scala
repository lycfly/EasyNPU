
import spinal.core._

import scala.language.postfixOps

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

  //  import DesignCompiler._
  //  val dc_config = DesignCompiler_config(process = 28, freq = 100)
  //  val dc = new DesignCompilerFlow(
  //                                    design = new SignMultiplier(SIZEINA = 16, SIZEINB = 16),
  //                                    topModuleName = "SignMultiplier",
  //                                    workspacePath = "/mnt/data/projects/kws/Easonlib/syn/SignMultiplier",
  //                                    DCConfig = dc_config,
  //                                    designPath = ""
  //  ).doit()
}