// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Primary design header
//
// This header should be included by all source files instantiating the design.
// The class here is then constructed to instantiate the design.
// See the Verilator manual for examples.

#ifndef _VPE_FLOW_CTRL_H_
#define _VPE_FLOW_CTRL_H_  // guard

#include "verilated.h"

//==========

class Vpe_flow_ctrl__Syms;
class Vpe_flow_ctrl_VerilatedVcd;


//----------

VL_MODULE(Vpe_flow_ctrl) {
  public:
    
    // PORTS
    // The application code writes and reads these signals to
    // propagate new values into/out from the Verilated model.
    VL_IN8(clk,0,0);
    VL_IN8(reset,0,0);
    VL_IN8(start_conv,0,0);
    VL_IN8(rg_para_yhat,5,0);
    VL_IN8(rg_para_xhat,5,0);
    VL_IN8(rg_para_y,5,0);
    VL_IN8(rg_para_x,5,0);
    VL_IN8(rg_para_Hk,7,0);
    VL_IN8(rg_para_Wk,7,0);
    VL_IN8(rg_para_Ho,7,0);
    VL_IN8(rg_para_Wo,7,0);
    VL_IN8(rg_para_Hi,7,0);
    VL_IN8(rg_para_Wi,7,0);
    VL_IN8(rg_para_Co,7,0);
    VL_IN8(rg_para_Ci,7,0);
    VL_IN8(rg_para_sh,3,0);
    VL_IN8(rg_para_sw,3,0);
    VL_IN8(rg_para_ph,3,0);
    VL_IN8(rg_para_pw,3,0);
    VL_IN8(rg_para_dh,3,0);
    VL_IN8(rg_para_dw,3,0);
    VL_IN8(rg_para_zs,3,0);
    VL_IN8(rg_para_zp,3,0);
    VL_IN8(rg_para_k,3,0);
    VL_IN8(rg_para_shxhat,5,0);
    VL_IN8(rg_para_xyzs,6,0);
    VL_IN8(rg_ctrl_bias_en,0,0);
    VL_IN8(rg_ctrl_scale_en,0,0);
    VL_IN8(rg_ctrl_tensor_op_en,0,0);
    VL_OUT8(pe_ctrl_ps_back_en,0,0);
    VL_OUT8(pe_ctrl_ps_waddr,6,0);
    VL_OUT8(pe_ctrl_ps_raddr,6,0);
    VL_OUT8(pe_ctrl_ps_wr,0,0);
    VL_OUT8(pe_ctrl_ps_rd,0,0);
    VL_OUT8(pe_ctrl_ps_allow_rd,0,0);
    VL_OUT8(pe_ctrl_ps_pinA_bias_en,0,0);
    VL_OUT8(pe_ctrl_ps_pinB_bias_en,0,0);
    VL_OUT8(pe_ctrl_byp_mul_en,0,0);
    VL_OUT8(pe_ctrl_maxpool_en,0,0);
    VL_OUT8(pe_ctrl_bias_mul_en,0,0);
    VL_OUT8(pe_ctrl_ps_scale_en,0,0);
    VL_OUT8(ifscp_ctrl_if_rd,0,0);
    VL_OUT8(ifscp_ctrl_hw_addr,5,0);
    VL_OUT8(ifscp_ctrl_ich_addr,3,0);
    VL_OUT8(ifscp_ctrl_cast_mode,0,0);
    VL_OUT8(wescp_ctrl_we_rd,0,0);
    VL_OUT8(wescp_ctrl_bs_wr,0,0);
    VL_OUT8(wescp_ctrl_bs_rd,0,0);
    VL_OUT8(wescp_ctrl_sc_rd,0,0);
    VL_OUT8(wescp_ctrl_bs_byte_cnt,2,0);
    VL_OUT8(wescp_ctrl_och_gcnt,3,0);
    VL_IN8(pe_flags_ps_rd_ready,0,0);
    VL_IN8(pe_flags_ps_wr_ready,0,0);
    VL_OUT8(subconv_finish,0,0);
    
    // LOCAL SIGNALS
    // Internals; generally not touched by application code
    CData/*0:0*/ pe_flow_ctrl__DOT__kz_reach_th;
    CData/*0:0*/ pe_flow_ctrl__DOT__kzi_this_ov;
    CData/*0:0*/ pe_flow_ctrl__DOT__kzi_reach_th;
    CData/*0:0*/ pe_flow_ctrl__DOT__hki_this_ov;
    CData/*0:0*/ pe_flow_ctrl__DOT__hki_reach_th;
    CData/*0:0*/ pe_flow_ctrl__DOT__wki_this_ov;
    CData/*0:0*/ pe_flow_ctrl__DOT__wki_reach_th;
    CData/*0:0*/ pe_flow_ctrl__DOT__ozi_this_ov;
    CData/*0:0*/ pe_flow_ctrl__DOT__ozi_reach_th;
    CData/*0:0*/ pe_flow_ctrl__DOT__oyi_this_ov;
    CData/*0:0*/ pe_flow_ctrl__DOT__oyi_reach_th;
    CData/*0:0*/ pe_flow_ctrl__DOT__oxi_this_ov;
    CData/*0:0*/ pe_flow_ctrl__DOT__oxi_reach_th;
    CData/*0:0*/ pe_flow_ctrl__DOT__dofetch;
    CData/*0:0*/ pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_back_en;
    CData/*6:0*/ pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_waddr;
    CData/*6:0*/ pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_raddr;
    CData/*0:0*/ pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_wr;
    CData/*0:0*/ pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_rd;
    CData/*0:0*/ pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_allow_rd;
    CData/*0:0*/ pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_pinA_bias_en;
    CData/*0:0*/ pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_pinB_bias_en;
    CData/*0:0*/ pe_flow_ctrl__DOT__pe_ctrl_rgs_byp_mul_en;
    CData/*0:0*/ pe_flow_ctrl__DOT__pe_ctrl_rgs_maxpool_en;
    CData/*0:0*/ pe_flow_ctrl__DOT__pe_ctrl_rgs_bias_mul_en;
    CData/*0:0*/ pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_scale_en;
    CData/*0:0*/ pe_flow_ctrl__DOT__ifscp_ctrl_rgs_if_rd;
    CData/*5:0*/ pe_flow_ctrl__DOT__ifscp_ctrl_rgs_hw_addr;
    CData/*3:0*/ pe_flow_ctrl__DOT__ifscp_ctrl_rgs_ich_addr;
    CData/*0:0*/ pe_flow_ctrl__DOT__ifscp_ctrl_rgs_cast_mode;
    CData/*0:0*/ pe_flow_ctrl__DOT__wescp_ctrl_rgs_we_rd;
    CData/*0:0*/ pe_flow_ctrl__DOT__wescp_ctrl_rgs_bs_wr;
    CData/*0:0*/ pe_flow_ctrl__DOT__wescp_ctrl_rgs_bs_rd;
    CData/*0:0*/ pe_flow_ctrl__DOT__wescp_ctrl_rgs_sc_rd;
    CData/*2:0*/ pe_flow_ctrl__DOT__wescp_ctrl_rgs_bs_byte_cnt;
    CData/*3:0*/ pe_flow_ctrl__DOT__wescp_ctrl_rgs_och_gcnt;
    CData/*0:0*/ pe_flow_ctrl__DOT__ps_raddr_ov;
    CData/*0:0*/ pe_flow_ctrl__DOT__ps_waddr_ov;
    CData/*1:0*/ pe_flow_ctrl__DOT__fsm_curr_state;
    CData/*1:0*/ pe_flow_ctrl__DOT__fsm_next_state;
    CData/*7:0*/ pe_flow_ctrl__DOT__kz__DOT__cnt_rg;
    CData/*3:0*/ pe_flow_ctrl__DOT__kzi__DOT__cnt_rg;
    CData/*7:0*/ pe_flow_ctrl__DOT__hki__DOT__cnt_rg;
    CData/*7:0*/ pe_flow_ctrl__DOT__wki__DOT__cnt_rg;
    CData/*3:0*/ pe_flow_ctrl__DOT__ozi__DOT__cnt_rg;
    CData/*5:0*/ pe_flow_ctrl__DOT__oyi__DOT__cnt_rg;
    CData/*5:0*/ pe_flow_ctrl__DOT__oxi__DOT__cnt_rg;
    
    // LOCAL VARIABLES
    // Internals; generally not touched by application code
    CData/*6:0*/ __Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_waddr;
    CData/*6:0*/ __Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_raddr;
    CData/*3:0*/ __Vdly__pe_flow_ctrl__DOT__kzi__DOT__cnt_rg;
    CData/*3:0*/ __Vdly__pe_flow_ctrl__DOT__ozi__DOT__cnt_rg;
    CData/*0:0*/ __Vclklast__TOP__clk;
    CData/*0:0*/ __Vclklast__TOP__reset;
    CData/*0:0*/ __Vm_traceActivity[3];
    
    // INTERNAL VARIABLES
    // Internals; generally not touched by application code
    Vpe_flow_ctrl__Syms* __VlSymsp;  // Symbol table
    
    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(Vpe_flow_ctrl);  ///< Copying not allowed
  public:
    /// Construct the model; called by application code
    /// The special name  may be used to make a wrapper with a
    /// single model invisible with respect to DPI scope names.
    Vpe_flow_ctrl(const char* name = "TOP");
    /// Destroy the model; called (often implicitly) by application code
    ~Vpe_flow_ctrl();
    /// Trace signals in the model; called by application code
    void trace(VerilatedVcdC* tfp, int levels, int options = 0);
    
    // API METHODS
    /// Evaluate the model.  Application must call when inputs change.
    void eval() { eval_step(); }
    /// Evaluate when calling multiple units/models per time step.
    void eval_step();
    /// Evaluate at end of a timestep for tracing, when using eval_step().
    /// Application must call after all eval() and before time changes.
    void eval_end_step() {}
    /// Simulation complete, run final blocks.  Application must call on completion.
    void final();
    
    // INTERNAL METHODS
    static void _eval_initial_loop(Vpe_flow_ctrl__Syms* __restrict vlSymsp);
    void __Vconfigure(Vpe_flow_ctrl__Syms* symsp, bool first);
  private:
    static QData _change_request(Vpe_flow_ctrl__Syms* __restrict vlSymsp);
    static QData _change_request_1(Vpe_flow_ctrl__Syms* __restrict vlSymsp);
  public:
    static void _combo__TOP__5(Vpe_flow_ctrl__Syms* __restrict vlSymsp);
  private:
    void _ctor_var_reset() VL_ATTR_COLD;
  public:
    static void _eval(Vpe_flow_ctrl__Syms* __restrict vlSymsp);
  private:
#ifdef VL_DEBUG
    void _eval_debug_assertions();
#endif  // VL_DEBUG
  public:
    static void _eval_initial(Vpe_flow_ctrl__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void _eval_settle(Vpe_flow_ctrl__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void _sequent__TOP__2(Vpe_flow_ctrl__Syms* __restrict vlSymsp);
    static void _sequent__TOP__3(Vpe_flow_ctrl__Syms* __restrict vlSymsp);
    static void _settle__TOP__4(Vpe_flow_ctrl__Syms* __restrict vlSymsp) VL_ATTR_COLD;
  private:
    static void traceChgSub0(void* userp, VerilatedVcd* tracep);
    static void traceChgTop0(void* userp, VerilatedVcd* tracep);
    static void traceCleanup(void* userp, VerilatedVcd* /*unused*/);
    static void traceFullSub0(void* userp, VerilatedVcd* tracep) VL_ATTR_COLD;
    static void traceFullTop0(void* userp, VerilatedVcd* tracep) VL_ATTR_COLD;
    static void traceInitSub0(void* userp, VerilatedVcd* tracep) VL_ATTR_COLD;
    static void traceInitTop(void* userp, VerilatedVcd* tracep) VL_ATTR_COLD;
    void traceRegister(VerilatedVcd* tracep) VL_ATTR_COLD;
    static void traceInit(void* userp, VerilatedVcd* tracep, uint32_t code) VL_ATTR_COLD;
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

//----------


#endif  // guard
