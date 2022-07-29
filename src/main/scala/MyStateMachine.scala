import spinal.core._
import spinal.core.sim._
import spinal.lib.fsm._
import spinal.lib._

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
