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



case class Flow_reg_interface (cfg: NPUConfig) extends Bundle with IMasterSlave{
  val yhat  = UInt(cfg.SUBH_WD bits)
  val xhat  = UInt(cfg.SUBH_WD bits)
  val y     = UInt(cfg.SUBW_WD bits)
  val x     = UInt(cfg.SUBW_WD bits)
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
  val zp    = UInt(cfg.SUBOCH_WD bits) 
  val k     = UInt(cfg.SUBICH_WD bits)
  val shxhat= UInt(cfg.SUBH_WD bits)   // sh * xhat - 1 
  val xyzs  = UInt(cfg.PE_PSUM_ADDRWD bits)   // x * y * zs - 1

  override def asMaster(): Unit = out(this)
}

case class count_sigs () extends Bundle{
  val inc = Bool()
  val this_ov = Bool()
}

object counter {
  def build(DW: Int, Th_dec: Boolean, thre: UInt, sigs: count_sigs): counter = {
    val count = counter(DW, Th_dec)
    count.io.inc_en := sigs.inc
    count.io.threshold := thre
    sigs.this_ov := count.io.this_ov
    count
  }
}

case class counter (DW: Int, Th_dec: Boolean) extends Component{
  val io = new Bundle {
    val threshold = in UInt(DW bits)
    val inc_en    = in Bool()
    val cnt       = out UInt(DW bits)
    val this_ov   = out Bool()
  }
  noIoPrefix()
  val cnt_rg = Reg(UInt(DW bits)) init(0)
  val overflow = Bool()
  if (Th_dec){
    overflow := (cnt_rg === (io.threshold - 1))
  }else {
    overflow := (cnt_rg === io.threshold)
  }
  when(io.inc_en){
    when(overflow){
      cnt_rg := 0
    }.otherwise{
      cnt_rg := cnt_rg + 1
    }
  }
  io.cnt := cnt_rg
  io.this_ov := overflow & io.inc_en
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
    val rg = slave(Flow_reg_interface(cfg))
    val pe_ctrl = master(new PeControls(cfg))
    val ifscp_ctrl = master(Ifscp_ctrl_bus(cfg))
    val wescp_ctrl = master(Wescp_ctrl_bus(cfg))
    val pe_flags = slave(new PeFlags())

  }
  noIoPrefix()

  val dofetch = Reg(Bool()) init(False)

  val hki_sigs = count_sigs()
  val wki_sigs = count_sigs()
  val kzi_sigs = count_sigs()

  val ozi_sigs = count_sigs()
  val oyi_sigs = count_sigs()
  val oxi_sigs = count_sigs()
  hki_sigs.inc := wki_sigs.this_ov
  wki_sigs.inc := kzi_sigs.this_ov
  kzi_sigs.inc := ozi_sigs.this_ov
  ozi_sigs.inc := oyi_sigs.this_ov
  oyi_sigs.inc := oxi_sigs.this_ov
  oxi_sigs.inc := dofetch
  val kzi = counter.build(cfg.SUBICH_WD   ,false, io.rg.k,     kzi_sigs)
  val hki = counter.build(cfg.KERNEL_H_WD ,false, io.rg.Hk,    hki_sigs)
  val wki = counter.build(cfg.KERNEL_W_WD ,false, io.rg.Wk,    wki_sigs)
  val ozi = counter.build(cfg.SUBOCH_WD   ,false, io.rg.zs,    ozi_sigs)
  val oyi = counter.build(cfg.SUBH_WD     ,false, io.rg.yhat,  oyi_sigs)
  val oxi = counter.build(cfg.SUBW_WD     ,false, io.rg.xhat,  oxi_sigs)
  
  val pe_ctrl_rgs = PortToRegWithInit(new PeControls(cfg)) 
  io.pe_ctrl <> pe_ctrl_rgs
  val ifscp_ctrl_rgs = PortToRegWithInit(new Ifscp_ctrl_bus(cfg)) 
  io.ifscp_ctrl <> ifscp_ctrl_rgs
  val wescp_ctrl_rgs = PortToRegWithInit(new Wescp_ctrl_bus(cfg)) 
  io.wescp_ctrl <> wescp_ctrl_rgs

  val ps_raddr_ov = Bool()
  ps_raddr_ov := pe_ctrl_rgs.ps_raddr === io.rg.xyzs
  val ps_waddr_ov = Bool()
  ps_waddr_ov := pe_ctrl_rgs.ps_waddr === io.rg.xyzs

  val fsm = new MyStateMachine{
    val IDLE = makeInstantEntry() setName("IDLE")
    val SUBCONV = new State
    val QUANT = new State
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
          ifscp_ctrl_rgs.hw_addr := ifscp_ctrl_rgs.hw_addr + (io.rg.shxhat + 1)
        }.elsewhen(oyi_sigs.this_ov){
          ifscp_ctrl_rgs.hw_addr.clearAll()
        }.otherwise{
          ifscp_ctrl_rgs.hw_addr := ifscp_ctrl_rgs.hw_addr + (io.rg.sw.resize(cfg.IFSCP_ADDRWD))
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

        // exit subconv
        when(hki_sigs.this_ov){
          goto(QUANT)
          dofetch.clear()
        }
      }
    QUANT
      .whenIsActive {
        pe_ctrl_rgs.ps_pinA_bias_en.set()
        pe_ctrl_rgs.ps_scale_en.set()
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
