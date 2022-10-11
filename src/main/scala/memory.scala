import spinal.core._
import spinal.core.sim._
import spinal.lib._

case class MemConfig(
                   DATAWD: Int ,
                   SIZE: Int ,
                   RD_NUM: Int,
                   WR_NUM: Int,
                   MemVender: MEMVender

){
  val ADDRWD: Int = log2Up(SIZE)

}

case class MemoryWritePort(mc: MemConfig) extends Bundle {
  val address = UInt(mc.ADDRWD bits)
  val data    = Bits(mc.DATAWD bits)
}

case class MemoryReadPort(mc: MemConfig) extends Bundle {
  val address = UInt(mc.ADDRWD bits)
}

case class Ram1rw(mc: MemConfig, memName: String = "") extends Component{
  val io = new Bundle{

    val rd, wr = in Bool()
    val addr   = in UInt(mc.ADDRWD bits)
    val wdata  = in Bits(mc.DATAWD bits)
    val rdata  = out Bits(mc.DATAWD bits)
  }
   noIoPrefix()
  val ram = mc.MemVender.build(this, mc)
}

case class Ram1r1w(mc: MemConfig, memName: String = "") extends Component{
  val io = new Bundle{

    val rd, wr = in Bool()
    val waddr   = in UInt(mc.ADDRWD bits)
    val raddr   = in UInt(mc.ADDRWD bits)
    val wdata  = in Bits(mc.DATAWD bits)
    val rdata  = out Bits(mc.DATAWD bits)
  }
   noIoPrefix()
  val ram = mc.MemVender.build(this, mc)
}

case class RamNrNw(mc: MemConfig, memName: String = "") extends Component{
  val io = new Bundle{

    val wr     = in Vec(Bool(), mc.WR_NUM)
    val rd     = in Vec(Bool(), mc.RD_NUM)
    val waddr  = in Vec(UInt(mc.ADDRWD bits), mc.WR_NUM)
    val wdata  = in Vec(Bits(mc.DATAWD bits), mc.WR_NUM)
    val raddr  = in Vec(UInt(mc.ADDRWD bits), mc.RD_NUM)
    val rdata  = out Vec(Bits(mc.DATAWD bits), mc.RD_NUM)
  }
   noIoPrefix()
  val ram = mc.MemVender.build(this, mc)
}
// case class Ram2rw(mc: MemConfig, memName: String = "") extends Component with MemWrap{
//   val io = new Bundle{
//     val Aclk  = in Bool()
//     val Awr, Acs  = in Bool()
//     val Aaddr = in UInt()
//     val Awdata = in Bits()
//     val Ardata = out Bits()

//     val Bclk  = in Bool()
//     val Bwr, Bcs = in Bool()
//     val Baddr = in UInt()
//     val Bwdata = in Bits()
//     val Brdata = out Bits()
//   }

//   noIoPrefix()
//   val ram = mc.vendor.build(this)
// }

trait MEMVender {
  def build(mw: Ram1rw, mc :MemConfig): Component = new regMem1rw(mw, mc).Build()
  def build(mw: Ram1r1w, mc :MemConfig): Component = new regMem1r1w(mw, mc).Build()
  def build(mw: RamNrNw, mc :MemConfig): Component = new regMemNrNw(mw, mc).Build()

}
case object REGMEM extends MEMVender
case object IPMEM extends MEMVender{
  override def build(mw: Ram1rw, mc :MemConfig): BlackBox = new ipMem1rw(mw,mc).Build()
  override def build(mw: Ram1r1w, mc :MemConfig): BlackBox = new ipMem1r1w(mw,mc).Build()
}

class regMem1rw(wrap: Ram1rw, mc :MemConfig) extends Component{ //1rw
  val io = new Bundle { 
    val writeValid, readValid = in Bool()
    val address   = in UInt(mc.ADDRWD bits)
    val writeData  = in Bits(mc.DATAWD bits)
    val readData  = out Bits(mc.DATAWD bits)
  }
  val mem = Mem(Bits(mc.DATAWD bits), wordCount = mc.SIZE)
  mem.write(
    enable  = io.writeValid,
    address = io.address,
    data    = io.writeData
  )

  io.readData := mem.readSync(
    enable  = io.readValid,
    address = io.address
  )
  
  def Build(): Component = {
    this.io.writeValid   := wrap.io.wr
    this.io.readValid    := wrap.io.rd
    this.io.address      := wrap.io.addr
    this.io.writeData    := wrap.io.wdata
    wrap.io.rdata        := this.io.readData
    this
  }
  noIoPrefix()
}

class regMem1r1w(wrap: Ram1r1w, mc :MemConfig) extends Component{  //1r1w
  val io = new Bundle { 
    val writeValid, readValid = in Bool()
    val waddress   = in UInt(mc.ADDRWD bits)
    val raddress   = in UInt(mc.ADDRWD bits)
    val writeData  = in Bits(mc.DATAWD bits)
    val readData  = out Bits(mc.DATAWD bits)
  }
  val mem = Mem(Bits(mc.DATAWD bits), wordCount = mc.SIZE)
  mem.write(
    enable  = io.writeValid,
    address = io.waddress,
    data    = io.writeData
  )

  io.readData := mem.readSync(
    enable  = io.readValid,
    address = io.raddress
  )
  
  def Build(): Component = {
    this.io.writeValid   := wrap.io.wr
    this.io.readValid    := wrap.io.rd
    this.io.waddress      := wrap.io.waddr 
    this.io.raddress      := wrap.io.raddr
    this.io.writeData    := wrap.io.wdata
    wrap.io.rdata        := this.io.readData
    this
  }
  noIoPrefix()
}
class regMemNrNw(wrap: RamNrNw, mc :MemConfig) extends Component{  //1r1w
  val io = new Bundle { 
    val writeValid = in Vec(Bool(), mc.WR_NUM)
    val readValid  = in Vec(Bool(), mc.RD_NUM)
    val waddress   = in Vec(UInt(mc.ADDRWD bits), mc.WR_NUM)
    val writeData  = in Vec(Bits(mc.DATAWD bits), mc.WR_NUM)
    val raddress   = in Vec(UInt(mc.ADDRWD bits), mc.RD_NUM)
    val readData   = out Vec(Bits(mc.DATAWD bits), mc.RD_NUM)
  }
  val mem = Mem(Bits(mc.DATAWD bits), wordCount = mc.SIZE)

  for(i <- 0 to mc.RD_NUM-1){
    mem.write(
    enable  = io.writeValid(i),
    address = io.waddress(i),
    data    = io.writeData(i)
    )
    io.readData(i) := mem.readSync(
      enable  = io.readValid(i),
      address = io.raddress(i)
    )
  }

  
  def Build(): Component = {
    this.io.writeValid   := wrap.io.wr
    this.io.readValid    := wrap.io.rd
    this.io.waddress     := wrap.io.waddr 
    this.io.raddress     := wrap.io.raddr
    this.io.writeData    := wrap.io.wdata
    wrap.io.rdata        := this.io.readData
    this
  }
  noIoPrefix()
}

class ipMem1rw(wrap: Ram1rw, mc :MemConfig) extends BlackBox{    //1rw
  this.setDefinitionName(s"Mwrapper_rfsp${mc.SIZE}x${mc.DATAWD}m2b1w1")
  val io = new Bundle { iobd =>
    val CLK    = in Bool()
    val A      = in UInt(mc.ADDRWD bits)
    val D      = in Bits(mc.DATAWD bits)
    val CEN    = in Bool()
    val WEN    = in Bool()
    val Q      = out Bits(mc.DATAWD bits)
  }

  val cd  = ClockDomain(io.CLK)

  def Build(): BlackBox = {
    wrap.clockDomain.setSyncWith(cd)
    this.io.CLK  := wrap.clockDomain.readClockWire
    this.io.A    := wrap.io.addr
    this.io.CEN  := ~(wrap.io.rd | wrap.io.wr)
    this.io.WEN  := ~wrap.io.wr
    this.io.D    := wrap.io.wdata
    wrap.io.rdata  := this.io.Q

    // if(mc.withBist) {wrap.io.bist >> io.bist}
    // if(mc.withScan) {wrap.io.scan >> io.scan}
    this
  }
  noIoPrefix()
}

class ipMem1r1w(wrap: Ram1r1w, mc :MemConfig) extends BlackBox{    //1r1w
  this.setDefinitionName(s"Mwrapper_rfsp${mc.SIZE}x${mc.DATAWD}m2b1w1")
  val io = new Bundle { iobd =>
    val CLK    = in Bool()
    val WA      = in UInt(mc.ADDRWD bits)
    val RA      = in UInt(mc.ADDRWD bits)
    val D      = in Bits(mc.DATAWD bits)
    val CEN    = in Bool()
    val WEN    = in Bool()
    val Q      = out Bits(mc.DATAWD bits)
  }

  val cd  = ClockDomain(io.CLK)

  def Build(): BlackBox = {
    wrap.clockDomain.setSyncWith(cd)
    this.io.CLK  := wrap.clockDomain.readClockWire
    this.io.WA   := wrap.io.waddr
    this.io.RA   := wrap.io.raddr
    this.io.CEN  := ~(wrap.io.rd | wrap.io.wr)
    this.io.WEN  := ~wrap.io.wr
    this.io.D    := wrap.io.wdata
    wrap.io.rdata  := this.io.Q

    // if(mc.withBist) {wrap.io.bist >> io.bist}
    // if(mc.withScan) {wrap.io.scan >> io.scan}
    this
  }
  noIoPrefix()
}


object mem_gen_test {
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
      .generate(new RamNrNw(MemConfig( 
                   DATAWD = 32,
                   SIZE = 128 ,
                   RD_NUM = 2,
                   WR_NUM = 2,
                   MemVender = IPMEM)))
    }.printPruned()
}
