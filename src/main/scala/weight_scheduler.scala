import spinal.core._
import spinal.core.sim._
import spinal.lib.fsm._
import spinal.lib._

case class DTCM_rbus (ADDRWD: Int , DATAWD: Int) extends Bundle with IMasterSlave{
  val rd    =  Bool
  val raddr =  UInt(ADDRWD bits)
  val rdata =  Bits(DATAWD bits)
  override def asMaster(): Unit = {
  out(rd)
  out(raddr)
  in(rdata)
 }
}
class weight_scheduler (cfg: NPUConfig) extends Component{
  val io = new Bundle {
    val layer_start = in Bool()
    val start_addr_bs = in UInt(cfg.WDTCM_ADDRWD bits)
    val start_addr_w = in UInt(cfg.WDTCM_ADDRWD bits)
    val prefetch_one = in Bool()
    //val oz_cnt = in UInt(cfg.CHANNEL_WD bits)
    
   // val wdtcm_rbus = slave(DTCM_rbus(cfg.WDTCM_ADDRWD, cfg.WDTCM_WD))
   // val wescp_wbus = master(RF_wbus(cfg.WESCP_ADDRWD, cfg.WESCP_BUS_WD))
    val wescp_ctrl = slave(Wescp_ctrl_bus(cfg))
    val rg_para = slave(Para_reg_interface(cfg))

  }
  noIoPrefix()
  // weight load cnts
  val weight_fetch_work = Bool()
  val oz_sigs = count_sigs()
  val kz_sigs = count_sigs()
  val hki_sigs = count_sigs()
  val wki_sigs = count_sigs()
  val ozi_sigs = count_sigs()
  oz_sigs.inc  := kz_sigs.this_ov
  kz_sigs.inc  := hki_sigs.this_ov
  hki_sigs.inc := wki_sigs.this_ov
  wki_sigs.inc := ozi_sigs.this_ov
  ozi_sigs.inc := weight_fetch_work
  val oz =  counter.build(cfg.CHANNEL_WD  ,false, io.rg_para.Co, 
                                                  (io.rg_para.z + 1).resize(cfg.CHANNEL_WD+1),  oz_sigs)
  val kz =  counter.build(cfg.CHANNEL_WD  ,false, io.rg_para.Ci,   1 , kz_sigs)
  val hki = counter.build(cfg.KERNEL_H_WD ,false, io.rg_para.Hk,   1 , hki_sigs)
  val wki = counter.build(cfg.KERNEL_W_WD ,false, io.rg_para.Wk,   1 , wki_sigs)
  val ozi = counter.build(cfg.SUBOCH_WD   ,false, io.rg_para.zs,   1 , ozi_sigs)

  val isfirst = Reg(Bool()) init(True)
  val first_end = Bool()
  val subconv_end = Bool()
  val oz_inc_flag = Bool()
  val layer_end = Bool()
  first_end := ozi.io.this_ov & wki.io.isInitial & hki.io.isInitial & kz.io.isInitial 
  subconv_end := kz.io.this_ov
  oz_inc_flag := kz.io.this_ov & ~(oz.io.nxt_cnt === (io.rg_para.Co + 1).resize(cfg.CHANNEL_WD+1)) 
  layer_end := oz.io.this_ov
  // bias scale load cnt
  val BS_CNT_WD = log2Up(cfg.BIAS_BYTE_NUM + 1) + cfg.SUBOCH_WD 
  val bs_cnt_th = UInt(BS_CNT_WD bits)
  val bias_scale_fetch_work = Reg(Bool()) init(False)
 
  val bs_ozi_sigs = count_sigs()
  bs_ozi_sigs.inc := bias_scale_fetch_work
  val zs_ext = (io.rg_para.zs + 1).resize(BS_CNT_WD)
  bs_cnt_th := zs_ext + (zs_ext |<< log2Up(cfg.BIAS_BYTE_NUM)) - 1 
  val bs_cnt = counter.build(BS_CNT_WD  ,false, bs_cnt_th,   1 , bs_ozi_sigs)

  val bs_load_end = Bool()
  bs_load_end := bs_cnt.io.this_ov
  val fsm = new MyStateMachine{
    val IDLE = makeInstantEntry() setName("IDLE")
    val LOAD_BS = new State
    val FIRST_FETCH = new State
    val PRE_FETCH = new State

    IDLE
      .whenIsActive {
        isfirst.set()
        when(io.layer_start){
          goto(LOAD_BS)
        }
       bias_scale_fetch_work.clear()
      }
    LOAD_BS
      .whenIsActive {
        when(bs_load_end & isfirst){
          bias_scale_fetch_work.set()
          goto(FIRST_FETCH)
        }.elsewhen(bs_load_end & ~isfirst){
          goto(PRE_FETCH)
        }.otherwise{
          bias_scale_fetch_work.set()
        }
      }
    FIRST_FETCH
      .whenIsActive {
        isfirst.clear()
        when(first_end){
          goto(PRE_FETCH)  
          weight_fetch_work.clear()
        }.otherwise{
          weight_fetch_work.set()
        }
      }
    PRE_FETCH
      .whenIsActive {
          when(io.prefetch_one){
            weight_fetch_work.set()
          }.otherwise{
            weight_fetch_work.clear()
          }

          when(subconv_end & oz_inc_flag){
            goto(LOAD_BS)  
          }.elsewhen(subconv_end & layer_end){
            goto(LOAD_BS)  
          }
      }
  }


}

object w_schedule_ctrl_gen {
  def main(args: Array[String]): Unit = {
    SpinalConfig(
      defaultConfigForClockDomains = ClockDomainConfig(resetKind = ASYNC,
        clockEdge = RISING,
        resetActiveLevel = LOW),
      mode=Verilog,
      enumPrefixEnable = false,
      //removePruned = true,
      anonymSignalPrefix="tmp",
      targetDirectory = "rtl"
      )
    //  .withoutEnumString()
      .generate(new weight_scheduler(cfg=NPUConfig()))
    }.printPruned()
}
