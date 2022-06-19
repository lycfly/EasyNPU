// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vpe_flow_ctrl.h for the primary calling header

#include "Vpe_flow_ctrl.h"
#include "Vpe_flow_ctrl__Syms.h"

//==========

VL_CTOR_IMP(Vpe_flow_ctrl) {
    Vpe_flow_ctrl__Syms* __restrict vlSymsp = __VlSymsp = new Vpe_flow_ctrl__Syms(this, name());
    Vpe_flow_ctrl* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Reset internal values
    
    // Reset structure values
    _ctor_var_reset();
}

void Vpe_flow_ctrl::__Vconfigure(Vpe_flow_ctrl__Syms* vlSymsp, bool first) {
    if (false && first) {}  // Prevent unused
    this->__VlSymsp = vlSymsp;
    if (false && this->__VlSymsp) {}  // Prevent unused
    Verilated::timeunit(-9);
    Verilated::timeprecision(-12);
}

Vpe_flow_ctrl::~Vpe_flow_ctrl() {
    VL_DO_CLEAR(delete __VlSymsp, __VlSymsp = nullptr);
}

void Vpe_flow_ctrl::_settle__TOP__4(Vpe_flow_ctrl__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpe_flow_ctrl::_settle__TOP__4\n"); );
    Vpe_flow_ctrl* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->pe_flow_ctrl__DOT__oyi_reach_th = ((IData)(vlTOPp->pe_flow_ctrl__DOT__oyi__DOT__cnt_rg) 
                                               == (IData)(vlTOPp->rg_para_yhat));
    vlTOPp->pe_flow_ctrl__DOT__oxi_reach_th = ((IData)(vlTOPp->pe_flow_ctrl__DOT__oxi__DOT__cnt_rg) 
                                               == (IData)(vlTOPp->rg_para_xhat));
    vlTOPp->pe_flow_ctrl__DOT__kz_reach_th = ((IData)(vlTOPp->pe_flow_ctrl__DOT__kz__DOT__cnt_rg) 
                                              == (IData)(vlTOPp->rg_para_Ci));
    vlTOPp->pe_flow_ctrl__DOT__hki_reach_th = ((IData)(vlTOPp->pe_flow_ctrl__DOT__hki__DOT__cnt_rg) 
                                               == (IData)(vlTOPp->rg_para_Hk));
    vlTOPp->pe_flow_ctrl__DOT__wki_reach_th = ((IData)(vlTOPp->pe_flow_ctrl__DOT__wki__DOT__cnt_rg) 
                                               == (IData)(vlTOPp->rg_para_Wk));
    vlTOPp->pe_ctrl_ps_back_en = vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_back_en;
    vlTOPp->pe_ctrl_ps_waddr = vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_waddr;
    vlTOPp->pe_ctrl_ps_raddr = vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_raddr;
    vlTOPp->pe_ctrl_ps_wr = vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_wr;
    vlTOPp->pe_ctrl_ps_rd = vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_rd;
    vlTOPp->pe_ctrl_ps_allow_rd = vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_allow_rd;
    vlTOPp->pe_ctrl_ps_pinA_bias_en = vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_pinA_bias_en;
    vlTOPp->pe_ctrl_ps_pinB_bias_en = vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_pinB_bias_en;
    vlTOPp->pe_ctrl_byp_mul_en = vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_byp_mul_en;
    vlTOPp->pe_ctrl_maxpool_en = vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_maxpool_en;
    vlTOPp->pe_ctrl_bias_mul_en = vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_bias_mul_en;
    vlTOPp->pe_ctrl_ps_scale_en = vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_scale_en;
    vlTOPp->ifscp_ctrl_if_rd = vlTOPp->pe_flow_ctrl__DOT__ifscp_ctrl_rgs_if_rd;
    vlTOPp->ifscp_ctrl_hw_addr = vlTOPp->pe_flow_ctrl__DOT__ifscp_ctrl_rgs_hw_addr;
    vlTOPp->ifscp_ctrl_ich_addr = vlTOPp->pe_flow_ctrl__DOT__ifscp_ctrl_rgs_ich_addr;
    vlTOPp->ifscp_ctrl_cast_mode = vlTOPp->pe_flow_ctrl__DOT__ifscp_ctrl_rgs_cast_mode;
    vlTOPp->wescp_ctrl_we_rd = vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_we_rd;
    vlTOPp->wescp_ctrl_bs_wr = vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_bs_wr;
    vlTOPp->wescp_ctrl_bs_rd = vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_bs_rd;
    vlTOPp->wescp_ctrl_sc_rd = vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_sc_rd;
    vlTOPp->wescp_ctrl_bs_byte_cnt = vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_bs_byte_cnt;
    vlTOPp->wescp_ctrl_och_gcnt = vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_och_gcnt;
    vlTOPp->pe_flow_ctrl__DOT__ps_raddr_ov = ((IData)(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_raddr) 
                                              == (IData)(vlTOPp->rg_para_xyzs));
    vlTOPp->pe_flow_ctrl__DOT__ps_waddr_ov = ((IData)(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_waddr) 
                                              == (IData)(vlTOPp->rg_para_xyzs));
    vlTOPp->pe_flow_ctrl__DOT__kzi_reach_th = ((IData)(vlTOPp->pe_flow_ctrl__DOT__kzi__DOT__cnt_rg) 
                                               == (IData)(vlTOPp->rg_para_k));
    vlTOPp->pe_flow_ctrl__DOT__ozi_reach_th = ((IData)(vlTOPp->pe_flow_ctrl__DOT__ozi__DOT__cnt_rg) 
                                               == (IData)(vlTOPp->rg_para_zs));
    vlTOPp->pe_flow_ctrl__DOT__ozi_this_ov = ((IData)(vlTOPp->pe_flow_ctrl__DOT__ozi_reach_th) 
                                              & (IData)(vlTOPp->pe_flow_ctrl__DOT__dofetch));
    vlTOPp->pe_flow_ctrl__DOT__oxi_this_ov = ((IData)(vlTOPp->pe_flow_ctrl__DOT__oxi_reach_th) 
                                              & (IData)(vlTOPp->pe_flow_ctrl__DOT__ozi_this_ov));
    vlTOPp->pe_flow_ctrl__DOT__oyi_this_ov = ((IData)(vlTOPp->pe_flow_ctrl__DOT__oyi_reach_th) 
                                              & (IData)(vlTOPp->pe_flow_ctrl__DOT__oxi_this_ov));
    vlTOPp->pe_flow_ctrl__DOT__wki_this_ov = ((IData)(vlTOPp->pe_flow_ctrl__DOT__wki_reach_th) 
                                              & (IData)(vlTOPp->pe_flow_ctrl__DOT__oyi_this_ov));
    vlTOPp->pe_flow_ctrl__DOT__hki_this_ov = ((IData)(vlTOPp->pe_flow_ctrl__DOT__hki_reach_th) 
                                              & (IData)(vlTOPp->pe_flow_ctrl__DOT__wki_this_ov));
    vlTOPp->pe_flow_ctrl__DOT__kzi_this_ov = ((IData)(vlTOPp->pe_flow_ctrl__DOT__kzi_reach_th) 
                                              & (IData)(vlTOPp->pe_flow_ctrl__DOT__hki_this_ov));
    vlTOPp->subconv_finish = (((IData)(vlTOPp->pe_flow_ctrl__DOT__kz_reach_th) 
                               & (IData)(vlTOPp->pe_flow_ctrl__DOT__kzi_this_ov)) 
                              & (IData)(vlTOPp->rg_ctrl_tensor_op_en));
    vlTOPp->pe_flow_ctrl__DOT__fsm_next_state = vlTOPp->pe_flow_ctrl__DOT__fsm_curr_state;
    if ((1U == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_curr_state))) {
        if (vlTOPp->subconv_finish) {
            vlTOPp->pe_flow_ctrl__DOT__fsm_next_state = 2U;
        }
    } else {
        if ((2U != (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_curr_state))) {
            if (vlTOPp->start_conv) {
                vlTOPp->pe_flow_ctrl__DOT__fsm_next_state = 1U;
            }
        }
    }
}

void Vpe_flow_ctrl::_eval_initial(Vpe_flow_ctrl__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpe_flow_ctrl::_eval_initial\n"); );
    Vpe_flow_ctrl* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->__Vclklast__TOP__clk = (1U & (~ (IData)(vlTOPp->clk)));
    vlTOPp->__Vclklast__TOP__reset = (1U & (~ (IData)(vlTOPp->reset)));
}

void Vpe_flow_ctrl::final() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpe_flow_ctrl::final\n"); );
    // Variables
    Vpe_flow_ctrl__Syms* __restrict vlSymsp = this->__VlSymsp;
    Vpe_flow_ctrl* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

void Vpe_flow_ctrl::_eval_settle(Vpe_flow_ctrl__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpe_flow_ctrl::_eval_settle\n"); );
    Vpe_flow_ctrl* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->_settle__TOP__4(vlSymsp);
    vlTOPp->__Vm_traceActivity[2U] = 1U;
    vlTOPp->__Vm_traceActivity[1U] = 1U;
    vlTOPp->__Vm_traceActivity[0U] = 1U;
}

void Vpe_flow_ctrl::_ctor_var_reset() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpe_flow_ctrl::_ctor_var_reset\n"); );
    // Body
    start_conv = VL_RAND_RESET_I(1);
    rg_para_yhat = VL_RAND_RESET_I(6);
    rg_para_xhat = VL_RAND_RESET_I(6);
    rg_para_y = VL_RAND_RESET_I(6);
    rg_para_x = VL_RAND_RESET_I(6);
    rg_para_Hk = VL_RAND_RESET_I(8);
    rg_para_Wk = VL_RAND_RESET_I(8);
    rg_para_Ho = VL_RAND_RESET_I(8);
    rg_para_Wo = VL_RAND_RESET_I(8);
    rg_para_Hi = VL_RAND_RESET_I(8);
    rg_para_Wi = VL_RAND_RESET_I(8);
    rg_para_Co = VL_RAND_RESET_I(8);
    rg_para_Ci = VL_RAND_RESET_I(8);
    rg_para_sh = VL_RAND_RESET_I(4);
    rg_para_sw = VL_RAND_RESET_I(4);
    rg_para_ph = VL_RAND_RESET_I(4);
    rg_para_pw = VL_RAND_RESET_I(4);
    rg_para_dh = VL_RAND_RESET_I(4);
    rg_para_dw = VL_RAND_RESET_I(4);
    rg_para_zs = VL_RAND_RESET_I(4);
    rg_para_zp = VL_RAND_RESET_I(4);
    rg_para_k = VL_RAND_RESET_I(4);
    rg_para_shxhat = VL_RAND_RESET_I(6);
    rg_para_xyzs = VL_RAND_RESET_I(7);
    rg_ctrl_bias_en = VL_RAND_RESET_I(1);
    rg_ctrl_scale_en = VL_RAND_RESET_I(1);
    rg_ctrl_tensor_op_en = VL_RAND_RESET_I(1);
    pe_ctrl_ps_back_en = VL_RAND_RESET_I(1);
    pe_ctrl_ps_waddr = VL_RAND_RESET_I(7);
    pe_ctrl_ps_raddr = VL_RAND_RESET_I(7);
    pe_ctrl_ps_wr = VL_RAND_RESET_I(1);
    pe_ctrl_ps_rd = VL_RAND_RESET_I(1);
    pe_ctrl_ps_allow_rd = VL_RAND_RESET_I(1);
    pe_ctrl_ps_pinA_bias_en = VL_RAND_RESET_I(1);
    pe_ctrl_ps_pinB_bias_en = VL_RAND_RESET_I(1);
    pe_ctrl_byp_mul_en = VL_RAND_RESET_I(1);
    pe_ctrl_maxpool_en = VL_RAND_RESET_I(1);
    pe_ctrl_bias_mul_en = VL_RAND_RESET_I(1);
    pe_ctrl_ps_scale_en = VL_RAND_RESET_I(1);
    ifscp_ctrl_if_rd = VL_RAND_RESET_I(1);
    ifscp_ctrl_hw_addr = VL_RAND_RESET_I(6);
    ifscp_ctrl_ich_addr = VL_RAND_RESET_I(4);
    ifscp_ctrl_cast_mode = VL_RAND_RESET_I(1);
    wescp_ctrl_we_rd = VL_RAND_RESET_I(1);
    wescp_ctrl_bs_wr = VL_RAND_RESET_I(1);
    wescp_ctrl_bs_rd = VL_RAND_RESET_I(1);
    wescp_ctrl_sc_rd = VL_RAND_RESET_I(1);
    wescp_ctrl_bs_byte_cnt = VL_RAND_RESET_I(3);
    wescp_ctrl_och_gcnt = VL_RAND_RESET_I(4);
    pe_flags_ps_rd_ready = VL_RAND_RESET_I(1);
    pe_flags_ps_wr_ready = VL_RAND_RESET_I(1);
    subconv_finish = VL_RAND_RESET_I(1);
    clk = 0;
    reset = 0;
    pe_flow_ctrl__DOT__kz_reach_th = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__kzi_this_ov = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__kzi_reach_th = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__hki_this_ov = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__hki_reach_th = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__wki_this_ov = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__wki_reach_th = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__ozi_this_ov = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__ozi_reach_th = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__oyi_this_ov = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__oyi_reach_th = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__oxi_this_ov = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__oxi_reach_th = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__dofetch = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_back_en = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_waddr = VL_RAND_RESET_I(7);
    pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_raddr = VL_RAND_RESET_I(7);
    pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_wr = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_rd = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_allow_rd = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_pinA_bias_en = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_pinB_bias_en = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__pe_ctrl_rgs_byp_mul_en = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__pe_ctrl_rgs_maxpool_en = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__pe_ctrl_rgs_bias_mul_en = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_scale_en = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__ifscp_ctrl_rgs_if_rd = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__ifscp_ctrl_rgs_hw_addr = VL_RAND_RESET_I(6);
    pe_flow_ctrl__DOT__ifscp_ctrl_rgs_ich_addr = VL_RAND_RESET_I(4);
    pe_flow_ctrl__DOT__ifscp_ctrl_rgs_cast_mode = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__wescp_ctrl_rgs_we_rd = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__wescp_ctrl_rgs_bs_wr = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__wescp_ctrl_rgs_bs_rd = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__wescp_ctrl_rgs_sc_rd = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__wescp_ctrl_rgs_bs_byte_cnt = VL_RAND_RESET_I(3);
    pe_flow_ctrl__DOT__wescp_ctrl_rgs_och_gcnt = VL_RAND_RESET_I(4);
    pe_flow_ctrl__DOT__ps_raddr_ov = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__ps_waddr_ov = VL_RAND_RESET_I(1);
    pe_flow_ctrl__DOT__fsm_curr_state = VL_RAND_RESET_I(2);
    pe_flow_ctrl__DOT__fsm_next_state = VL_RAND_RESET_I(2);
    pe_flow_ctrl__DOT__kz__DOT__cnt_rg = VL_RAND_RESET_I(8);
    pe_flow_ctrl__DOT__kzi__DOT__cnt_rg = VL_RAND_RESET_I(4);
    pe_flow_ctrl__DOT__hki__DOT__cnt_rg = VL_RAND_RESET_I(8);
    pe_flow_ctrl__DOT__wki__DOT__cnt_rg = VL_RAND_RESET_I(8);
    pe_flow_ctrl__DOT__ozi__DOT__cnt_rg = VL_RAND_RESET_I(4);
    pe_flow_ctrl__DOT__oyi__DOT__cnt_rg = VL_RAND_RESET_I(6);
    pe_flow_ctrl__DOT__oxi__DOT__cnt_rg = VL_RAND_RESET_I(6);
    __Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_waddr = VL_RAND_RESET_I(7);
    __Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_raddr = VL_RAND_RESET_I(7);
    __Vdly__pe_flow_ctrl__DOT__kzi__DOT__cnt_rg = VL_RAND_RESET_I(4);
    __Vdly__pe_flow_ctrl__DOT__ozi__DOT__cnt_rg = VL_RAND_RESET_I(4);
    for (int __Vi0=0; __Vi0<3; ++__Vi0) {
        __Vm_traceActivity[__Vi0] = VL_RAND_RESET_I(1);
    }
}
