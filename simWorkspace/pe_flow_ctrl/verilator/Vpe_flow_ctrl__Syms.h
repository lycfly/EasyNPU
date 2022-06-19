// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef _VPE_FLOW_CTRL__SYMS_H_
#define _VPE_FLOW_CTRL__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODULE CLASSES
#include "Vpe_flow_ctrl.h"

// SYMS CLASS
class Vpe_flow_ctrl__Syms : public VerilatedSyms {
  public:
    
    // LOCAL STATE
    const char* __Vm_namep;
    bool __Vm_activity;  ///< Used by trace routines to determine change occurred
    uint32_t __Vm_baseCode;  ///< Used by trace routines when tracing multiple models
    bool __Vm_didInit;
    
    // SUBCELL STATE
    Vpe_flow_ctrl*                 TOPp;
    
    // CREATORS
    Vpe_flow_ctrl__Syms(Vpe_flow_ctrl* topp, const char* namep);
    ~Vpe_flow_ctrl__Syms() = default;
    
    // METHODS
    inline const char* name() { return __Vm_namep; }
    
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

#endif  // guard
