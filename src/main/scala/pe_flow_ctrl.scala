import spinal.core._
import spinal.core.sim._
import spinal.lib.fsm._
import spinal.lib._
import spire.algebra.Sign
class MyStateMachine extends StateMachine{
   disableAutoStart()
   override def build(): Unit = {
    builded = true
    inGeneration = true
    childStateMachines.foreach(_.build())
    if(autoStart) {
      stateBoot.whenIsActive {
        startFsm()
      }
    }
    stateReg  = Reg(enumDef())
    stateNext = enumDef().allowOverride
    /* Only synthesize, if conditional state machine */
    if (transitionCond != null)
      stateNextCand = enumDef().allowOverride

    OwnableRef.proposal(stateBoot, this)
    OwnableRef.proposal(stateReg, this)
    OwnableRef.proposal(stateNext, this)

    stateReg.setPartialName("curr_state")
    stateNext.setPartialName("next_state")
    if (transitionCond != null)
      stateNextCand.setPartialName("stateNextCand")

    for(state <- states){
      checkState(state)
      val enumElement = enumDef.newElement(if(state.isNamed) state.getPartialName else null)
      stateToEnumElement += (state -> enumElement)
    }

    stateReg init(enumOf(this.stateBoot))
    stateReg := stateNext

    val stateRegOneHotMap  = states.map(state => (state -> (stateReg === enumOf(state)))).toMap
    val stateNextOneHotMap = states.map(state => (state -> (stateNext === enumOf(state)))).toMap
    if(transitionCond == null) {
      stateNext := stateReg
    } else {
      stateNextCand := stateReg
      stateNext := transitionCond ? stateNextCand | stateReg
    }

    switch(stateReg){
      for(state <- states){
        if(state == stateBoot) default {
          state.whenActiveTasks.sortBy(_.priority).foreach(_.body())
        } else is(enumOf(state)) {
          state.whenActiveTasks.sortBy(_.priority).foreach(_.body())
        }
      }
    }

    for(state <- states){
      when(!stateRegOneHotMap(state)){
        state.whenInactiveTasks.foreach(_())
      }
      when(stateRegOneHotMap(state) && !stateNextOneHotMap(state)){
        state.onExitTasks.foreach(_())
      }
    }

    switch(stateNext){
      for(state <- states){
        if(state == stateBoot) default {
          state.whenIsNextTasks.foreach(_())
        } else is(enumOf(state)) {
          state.whenIsNextTasks.foreach(_())
        }
      }
    }

    for(state <- states){
      when(!stateRegOneHotMap(state) && stateNextOneHotMap(state)){
        state.onEntryTasks.foreach(_())
      }
    }

    alwaysTasks.foreach(_())
    postBuildTasks.foreach(_())

    // when(wantStart){
    //   if(entryState == null)
    //     globalData.pendingErrors += (() => (s"$this as no entry point set. val yourState : State = new State with EntryPoint{...}   should solve the situation at \n${getScalaLocationLong}"))
    //   else if(entryState != stateBoot)
    //     forceGoto(entryState)
    // }
    // when(wantKill){
    //   forceGoto(stateBoot)
    // }

    if(corruptedState != null){
      switch(stateReg, coverUnreachable = true){
        for(e <- states) is(enumOf(e)){
          corruptedState := False
        }
        default{
          corruptedState := True
        }
      }
      for(state <- states){
        when(!stateRegOneHotMap(state) && stateNextOneHotMap(state)){
          state.onEntryTasks.foreach(_())
        }
      }
    }
  }
}



case class Para_reg_interface (cfg: NPUConfig) extends Bundle with IMasterSlave{
  val yhat  = UInt(cfg.SUBH_WD bits)
  val xhat  = UInt(cfg.SUBH_WD bits)
  val y     = UInt(cfg.SUBW_WD bits)
  val x     = UInt(cfg.SUBW_WD bits)
  val z     = UInt(cfg.CHANNEL_WD bits)
  val Hk    = UInt(cfg.KERNEL_H_WD bits)
  val Wk    = UInt(cfg.KERNEL_W_WD bits)
  val Ho    = UInt(cfg.HEIGHT_WD bits)
  val Wo    = UInt(cfg.WIDTH_WD bits)
  val Hi    = UInt(cfg.HEIGHT_WD bits)
  val Wi    = UInt(cfg.WIDTH_WD bits)
  val Co    = UInt(cfg.CHANNEL_WD bits)
  val Ci    = UInt(cfg.CHANNEL_WD bits)
  val sh    = UInt(cfg.STRIDE_WD bits)  // not -1
  val sw    = UInt(cfg.STRIDE_WD bits)  // not -1
  val ph    = UInt(cfg.PADDING_WD bits) // not -1
  val pw    = UInt(cfg.PADDING_WD bits) // not -1
  val dh    = UInt(cfg.DILATION_WD bits) // not -1
  val dw    = UInt(cfg.DILATION_WD bits) // not -1
  val zs    = UInt(cfg.SUBOCH_WD bits)
  val zp    = UInt(cfg.SUBOCH_WD bits)   // z/zs
  val k     = UInt(cfg.SUBICH_WD bits)
  val shxhat= UInt(cfg.SUBH_WD bits)   // sh * xhat - 1 
  val xyzs  = UInt(cfg.PE_PSUM_ADDRWD bits)   // x * y * zs - 1

  override def asMaster(): Unit = out(this)
}

case class FlowCtrl_reg_interface (cfg: NPUConfig) extends Bundle with IMasterSlave{
  val bias_en  = Bool()
  val scale_en  = Bool()
  val tensor_op_en = Bool()

  override def asMaster(): Unit = out(this)
}

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
    val cnt   = out UInt(DW+1 bits)
    val nxt_cnt   = out UInt(DW+1 bits)
    val this_ov   = out Bool()
    val reach_th  = out Bool()
    val isInitial = out Bool()

  }
  noIoPrefix()
  val cnt_rg = Reg(UInt(DW+1 bits)) init(0)
  val true_threshold = UInt(DW+1 bits)
  true_threshold := io.threshold.resize(DW+1)
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
  io.cnt := cnt_rg
  io.this_ov := io.reach_th & io.inc_en
  io.isInitial := io.cnt(DW downto 0) === 0
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

class pe_flow_ctrl (cfg: NPUConfig) extends Component{
  val io = new Bundle {
    val start_conv = in Bool()
    val rg_para = slave(Para_reg_interface(cfg))
    val rg_ctrl = slave(FlowCtrl_reg_interface(cfg))

    val pe_ctrl = master(new PeControls(cfg))
    val ifscp_ctrl = master(Ifscp_ctrl_bus(cfg))
    val wescp_ctrl = master(Wescp_ctrl_bus(cfg))
    val pe_flags = slave(new PeFlags())

    val subconv_finish = out Bool()

  }
  noIoPrefix()

  val dofetch = Reg(Bool()) init(False)
  val kz_sigs = count_sigs()
  val hki_sigs = count_sigs()
  val wki_sigs = count_sigs()
  val kzi_sigs = count_sigs()

  val ozi_sigs = count_sigs()
  val oyi_sigs = count_sigs()
  val oxi_sigs = count_sigs()
  kz_sigs.inc  := kzi_sigs.this_ov
  kzi_sigs.inc := hki_sigs.this_ov
  hki_sigs.inc := wki_sigs.this_ov
  wki_sigs.inc := oyi_sigs.this_ov
  oyi_sigs.inc := oxi_sigs.this_ov
  oxi_sigs.inc := ozi_sigs.this_ov
  ozi_sigs.inc := dofetch
  val kz  = counter.build(cfg.CHANNEL_WD  ,false, io.rg_para.Ci, 
                                                 (io.rg_para.k + 1).resize(cfg.CHANNEL_WD+1) ,  kz_sigs)
  val kzi = counter.build(cfg.SUBICH_WD   ,false, io.rg_para.k,    1 , kzi_sigs)
  val hki = counter.build(cfg.KERNEL_H_WD ,false, io.rg_para.Hk,   1 , hki_sigs)
  val wki = counter.build(cfg.KERNEL_W_WD ,false, io.rg_para.Wk,   1 , wki_sigs)
  val ozi = counter.build(cfg.SUBOCH_WD   ,false, io.rg_para.zs,   1 , ozi_sigs)
  val oyi = counter.build(cfg.SUBH_WD     ,false, io.rg_para.yhat, 1 , oyi_sigs)
  val oxi = counter.build(cfg.SUBW_WD     ,false, io.rg_para.xhat, 1 , oxi_sigs)
  
  val pe_ctrl_rgs = PortToRegWithInit(new PeControls(cfg)) 
  io.pe_ctrl <> pe_ctrl_rgs
  val ifscp_ctrl_rgs = PortToRegWithInit(new Ifscp_ctrl_bus(cfg)) 
  io.ifscp_ctrl <> ifscp_ctrl_rgs
  val wescp_ctrl_rgs = PortToRegWithInit(new Wescp_ctrl_bus(cfg)) 
  io.wescp_ctrl <> wescp_ctrl_rgs

  val ps_raddr_ov = Bool()
  ps_raddr_ov := pe_ctrl_rgs.ps_raddr === io.rg_para.xyzs
  val ps_waddr_ov = Bool()
  ps_waddr_ov := pe_ctrl_rgs.ps_waddr === io.rg_para.xyzs

  val ofmap_out_ready_flag = Bool()
  ofmap_out_ready_flag := kzi.io.reach_th & kz.io.reach_th & hki.io.reach_th & wki.io.reach_th

  io.subconv_finish := kz_sigs.this_ov & io.rg_ctrl.tensor_op_en

  val fsm = new MyStateMachine{
    val IDLE = makeInstantEntry() setName("IDLE")
    val SUBCONV = new State
    val TENSOR_OP = new State
    IDLE
      .whenIsActive {
        when(io.start_conv){
          goto(SUBCONV)
        }
        SigsClearAll(ifscp_ctrl_rgs)
        SigsClearAll(wescp_ctrl_rgs)
        SigsClearAll(pe_ctrl_rgs)

        dofetch.clear()
      }
  
    SUBCONV
      .whenIsActive {
        dofetch.set()
        ifscp_ctrl_rgs.cast_mode.clear()  // common conv mode
        // ifmap and weight addr 
        when(oxi_sigs.this_ov){
          ifscp_ctrl_rgs.hw_addr := ifscp_ctrl_rgs.hw_addr + (io.rg_para.shxhat + 1)
        }.elsewhen(oyi_sigs.this_ov){
          ifscp_ctrl_rgs.hw_addr.clearAll()
        }.otherwise{
          ifscp_ctrl_rgs.hw_addr := ifscp_ctrl_rgs.hw_addr + (io.rg_para.sw.resize(cfg.IFSCP_ADDRWD))
        }
        ifscp_ctrl_rgs.ich_addr := kzi.io.cnt
        wescp_ctrl_rgs.och_gcnt := ozi.io.cnt
        // ifmap and weight rd
        ifscp_ctrl_rgs.if_rd.set()
        wescp_ctrl_rgs.we_rd.set()
        // psum ctrl
        pe_ctrl_rgs.ps_wr    :=  io.pe_flags.ps_wr_ready
        pe_ctrl_rgs.ps_rd    :=  io.pe_flags.ps_rd_ready
        when(ps_raddr_ov){  //first subconv round should not read ps regfile (to save power)
          pe_ctrl_rgs.ps_allow_rd.set()
        }
      
        when(pe_ctrl_rgs.ps_rd){
          when(ps_raddr_ov){
            pe_ctrl_rgs.ps_raddr.clearAll()
          }.otherwise{
            pe_ctrl_rgs.ps_raddr := pe_ctrl_rgs.ps_raddr + 1
          }
        }
        when(pe_ctrl_rgs.ps_wr){
          when(ps_waddr_ov){
            pe_ctrl_rgs.ps_waddr.clearAll()
          }.otherwise{
            pe_ctrl_rgs.ps_waddr := pe_ctrl_rgs.ps_waddr + 1
          }
        }
        // bias and scale
        when(io.rg_ctrl.bias_en){
          when(ps_raddr_ov){
            wescp_ctrl_rgs.bs_rd.clear()
            pe_ctrl_rgs.ps_pinB_bias_en.clear()
          }.otherwise{
            wescp_ctrl_rgs.bs_rd.set()
            pe_ctrl_rgs.ps_pinB_bias_en.set()
          }
        }
        when(io.rg_ctrl.scale_en){
          when(ofmap_out_ready_flag){
            pe_ctrl_rgs.ps_scale_en.set()
          }.otherwise{
            pe_ctrl_rgs.ps_scale_en.clear()
          }
        }
        // exit subconv
        when(io.subconv_finish){
          goto(TENSOR_OP)
          dofetch.clear()
        }
      }
    TENSOR_OP
      .whenIsActive {
      }
  }

}

object flow_ctrl_gen {
  def main(args: Array[String]): Unit = {
    SpinalConfig(
      defaultConfigForClockDomains = ClockDomainConfig(resetKind = ASYNC,
        clockEdge = RISING,
        resetActiveLevel = LOW),
      mode=Verilog,
      enumPrefixEnable = false,
      removePruned = true,
      anonymSignalPrefix="tmp",
      targetDirectory = "rtl"
      )
    //  .withoutEnumString()
      .generate(new pe_flow_ctrl(cfg=NPUConfig()))
    }.printPruned()
}

object flow_ctrl_simple_sym{
  def main(args: Array[String]): Unit = {

    val compiled = SimConfig.withWave.allOptimisation.compile(
      rtl = new pe_flow_ctrl(cfg=NPUConfig()))
    compiled.doSim { dut =>
      dut.clockDomain.forkStimulus(2)
      dut.io.start_conv #= false
      dut.io.pe_flags.ps_wr_ready #= false
      dut.io.pe_flags.ps_rd_ready #= false

      dut.io.rg_para.yhat #= 10-1
      dut.io.rg_para.xhat #= 6-1
      dut.io.rg_para.y #= 10-1
      dut.io.rg_para.x #= 6-1
      dut.io.rg_para.Hk #= 3-1
      dut.io.rg_para.Wk #= 3-1
      dut.io.rg_para.Ho #= 40-1
      dut.io.rg_para.Wo #= 60-1
      dut.io.rg_para.Hi #= 40-1
      dut.io.rg_para.Wi #= 60-1
      dut.io.rg_para.Ci #= 16-1
      dut.io.rg_para.Co #= 16-1
      dut.io.rg_para.sh #= 1
      dut.io.rg_para.sw #= 1
      dut.io.rg_para.ph #= 1
      dut.io.rg_para.pw #= 1
      dut.io.rg_para.dh #= 1
      dut.io.rg_para.dw #= 1
      dut.io.rg_para.zs #= 1-1
      dut.io.rg_para.zp #= 16-1
      dut.io.rg_para.k #= 16-1
      dut.io.rg_para.shxhat #= 6-1
      dut.io.rg_para.xyzs #= 60-1
      sleep(10)

      println("test")
      dut.clockDomain.waitSampling()
      dut.io.start_conv #= true
      dut.clockDomain.waitSampling()
      dut.io.pe_flags.ps_rd_ready #= true
      dut.clockDomain.waitSampling()
      dut.io.pe_flags.ps_wr_ready #= true

      //dut.clockDomain.waitSamplingWhere(dut.io.subconv_finish.toBoolean)
        
      sleep(1000)


    }
    // import sys.process._
    // "gtkwave -o ./simWorkspace/booth4_v2/test.vcd"!



  }
}