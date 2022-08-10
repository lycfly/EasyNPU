// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VPE_FLOW_CTRL__SYMS_H_
#define VERILATED_VPE_FLOW_CTRL__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vpe_flow_ctrl.h"

// INCLUDE MODULE CLASSES
#include "Vpe_flow_ctrl___024root.h"

// SYMS CLASS (contains all model state)
class Vpe_flow_ctrl__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vpe_flow_ctrl* const __Vm_modelp;
    bool __Vm_activity = false;  ///< Used by trace routines to determine change occurred
    uint32_t __Vm_baseCode = 0;  ///< Used by trace routines when tracing multiple models
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vpe_flow_ctrl___024root        TOP;

    // CONSTRUCTORS
    Vpe_flow_ctrl__Syms(VerilatedContext* contextp, const char* namep, Vpe_flow_ctrl* modelp);
    ~Vpe_flow_ctrl__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

#endif  // guard
