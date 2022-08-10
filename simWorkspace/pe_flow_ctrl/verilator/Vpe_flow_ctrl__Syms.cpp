// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table implementation internals

#include "Vpe_flow_ctrl__Syms.h"
#include "Vpe_flow_ctrl.h"
#include "Vpe_flow_ctrl___024root.h"

// FUNCTIONS
Vpe_flow_ctrl__Syms::~Vpe_flow_ctrl__Syms()
{
}

Vpe_flow_ctrl__Syms::Vpe_flow_ctrl__Syms(VerilatedContext* contextp, const char* namep,Vpe_flow_ctrl* modelp)
    : VerilatedSyms{contextp}
    // Setup internal state of the Syms class
    , __Vm_modelp{modelp}
    // Setup module instances
    , TOP{this, namep}
{
    // Configure time unit / time precision
    _vm_contextp__->timeunit(-9);
    _vm_contextp__->timeprecision(-12);
    // Setup each module's pointers to their submodules
    // Setup each module's pointer back to symbol table (for public functions)
    TOP.__Vconfigure(true);
}
