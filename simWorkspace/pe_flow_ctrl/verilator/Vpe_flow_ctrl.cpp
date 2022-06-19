// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vpe_flow_ctrl.h for the primary calling header

#include "Vpe_flow_ctrl.h"
#include "Vpe_flow_ctrl__Syms.h"

//==========

void Vpe_flow_ctrl::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vpe_flow_ctrl::eval\n"); );
    Vpe_flow_ctrl__Syms* __restrict vlSymsp = this->__VlSymsp;  // Setup global symbol table
    Vpe_flow_ctrl* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
#ifdef VL_DEBUG
    // Debug assertions
    _eval_debug_assertions();
#endif  // VL_DEBUG
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Clock loop\n"););
        vlSymsp->__Vm_activity = true;
        _eval(vlSymsp);
        if (VL_UNLIKELY(++__VclockLoop > 100)) {
            // About to fail, so enable debug to see what's not settling.
            // Note you must run make with OPT=-DVL_DEBUG for debug prints.
            int __Vsaved_debug = Verilated::debug();
            Verilated::debug(1);
            __Vchange = _change_request(vlSymsp);
            Verilated::debug(__Vsaved_debug);
            VL_FATAL_MT("/mnt/data/projects/npu/EasyNPU/tmp/job_1/pe_flow_ctrl.v", 7, "",
                "Verilated model didn't converge\n"
                "- See DIDNOTCONVERGE in the Verilator manual");
        } else {
            __Vchange = _change_request(vlSymsp);
        }
    } while (VL_UNLIKELY(__Vchange));
}

void Vpe_flow_ctrl::_eval_initial_loop(Vpe_flow_ctrl__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    _eval_initial(vlSymsp);
    vlSymsp->__Vm_activity = true;
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    do {
        _eval_settle(vlSymsp);
        _eval(vlSymsp);
        if (VL_UNLIKELY(++__VclockLoop > 100)) {
            // About to fail, so enable debug to see what's not settling.
            // Note you must run make with OPT=-DVL_DEBUG for debug prints.
            int __Vsaved_debug = Verilated::debug();
            Verilated::debug(1);
            __Vchange = _change_request(vlSymsp);
            Verilated::debug(__Vsaved_debug);
            VL_FATAL_MT("/mnt/data/projects/npu/EasyNPU/tmp/job_1/pe_flow_ctrl.v", 7, "",
                "Verilated model didn't DC converge\n"
                "- See DIDNOTCONVERGE in the Verilator manual");
        } else {
            __Vchange = _change_request(vlSymsp);
        }
    } while (VL_UNLIKELY(__Vchange));
}

VL_INLINE_OPT void Vpe_flow_ctrl::_sequent__TOP__2(Vpe_flow_ctrl__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpe_flow_ctrl::_sequent__TOP__2\n"); );
    Vpe_flow_ctrl* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Variables
    CData/*0:0*/ __Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_wr;
    CData/*0:0*/ __Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_rd;
    CData/*5:0*/ __Vdly__pe_flow_ctrl__DOT__ifscp_ctrl_rgs_hw_addr;
    CData/*7:0*/ __Vdly__pe_flow_ctrl__DOT__kz__DOT__cnt_rg;
    CData/*7:0*/ __Vdly__pe_flow_ctrl__DOT__hki__DOT__cnt_rg;
    CData/*7:0*/ __Vdly__pe_flow_ctrl__DOT__wki__DOT__cnt_rg;
    CData/*5:0*/ __Vdly__pe_flow_ctrl__DOT__oyi__DOT__cnt_rg;
    CData/*5:0*/ __Vdly__pe_flow_ctrl__DOT__oxi__DOT__cnt_rg;
    // Body
    __Vdly__pe_flow_ctrl__DOT__kz__DOT__cnt_rg = vlTOPp->pe_flow_ctrl__DOT__kz__DOT__cnt_rg;
    vlTOPp->__Vdly__pe_flow_ctrl__DOT__kzi__DOT__cnt_rg 
        = vlTOPp->pe_flow_ctrl__DOT__kzi__DOT__cnt_rg;
    __Vdly__pe_flow_ctrl__DOT__hki__DOT__cnt_rg = vlTOPp->pe_flow_ctrl__DOT__hki__DOT__cnt_rg;
    __Vdly__pe_flow_ctrl__DOT__wki__DOT__cnt_rg = vlTOPp->pe_flow_ctrl__DOT__wki__DOT__cnt_rg;
    __Vdly__pe_flow_ctrl__DOT__oyi__DOT__cnt_rg = vlTOPp->pe_flow_ctrl__DOT__oyi__DOT__cnt_rg;
    __Vdly__pe_flow_ctrl__DOT__ifscp_ctrl_rgs_hw_addr 
        = vlTOPp->pe_flow_ctrl__DOT__ifscp_ctrl_rgs_hw_addr;
    __Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_rd = vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_rd;
    __Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_wr = vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_wr;
    vlTOPp->__Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_raddr 
        = vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_raddr;
    vlTOPp->__Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_waddr 
        = vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_waddr;
    __Vdly__pe_flow_ctrl__DOT__oxi__DOT__cnt_rg = vlTOPp->pe_flow_ctrl__DOT__oxi__DOT__cnt_rg;
    vlTOPp->__Vdly__pe_flow_ctrl__DOT__ozi__DOT__cnt_rg 
        = vlTOPp->pe_flow_ctrl__DOT__ozi__DOT__cnt_rg;
    if (vlTOPp->reset) {
        __Vdly__pe_flow_ctrl__DOT__kz__DOT__cnt_rg = 0U;
    } else {
        if (vlTOPp->pe_flow_ctrl__DOT__kzi_this_ov) {
            __Vdly__pe_flow_ctrl__DOT__kz__DOT__cnt_rg 
                = ((IData)(vlTOPp->pe_flow_ctrl__DOT__kz_reach_th)
                    ? 0U : (0xffU & ((IData)(vlTOPp->pe_flow_ctrl__DOT__kz__DOT__cnt_rg) 
                                     + (IData)(vlTOPp->rg_para_k))));
        }
    }
    if (vlTOPp->reset) {
        vlTOPp->__Vdly__pe_flow_ctrl__DOT__kzi__DOT__cnt_rg = 0U;
    } else {
        if (vlTOPp->pe_flow_ctrl__DOT__hki_this_ov) {
            vlTOPp->__Vdly__pe_flow_ctrl__DOT__kzi__DOT__cnt_rg 
                = ((IData)(vlTOPp->pe_flow_ctrl__DOT__kzi_reach_th)
                    ? 0U : (0xfU & ((IData)(1U) + (IData)(vlTOPp->pe_flow_ctrl__DOT__kzi__DOT__cnt_rg))));
        }
    }
    if (vlTOPp->reset) {
        __Vdly__pe_flow_ctrl__DOT__hki__DOT__cnt_rg = 0U;
    } else {
        if (vlTOPp->pe_flow_ctrl__DOT__wki_this_ov) {
            __Vdly__pe_flow_ctrl__DOT__hki__DOT__cnt_rg 
                = ((IData)(vlTOPp->pe_flow_ctrl__DOT__hki_reach_th)
                    ? 0U : (0xffU & ((IData)(1U) + (IData)(vlTOPp->pe_flow_ctrl__DOT__hki__DOT__cnt_rg))));
        }
    }
    if (vlTOPp->reset) {
        __Vdly__pe_flow_ctrl__DOT__wki__DOT__cnt_rg = 0U;
    } else {
        if (vlTOPp->pe_flow_ctrl__DOT__oyi_this_ov) {
            __Vdly__pe_flow_ctrl__DOT__wki__DOT__cnt_rg 
                = ((IData)(vlTOPp->pe_flow_ctrl__DOT__wki_reach_th)
                    ? 0U : (0xffU & ((IData)(1U) + (IData)(vlTOPp->pe_flow_ctrl__DOT__wki__DOT__cnt_rg))));
        }
    }
    if (vlTOPp->reset) {
        __Vdly__pe_flow_ctrl__DOT__oyi__DOT__cnt_rg = 0U;
    } else {
        if (vlTOPp->pe_flow_ctrl__DOT__oxi_this_ov) {
            __Vdly__pe_flow_ctrl__DOT__oyi__DOT__cnt_rg 
                = ((IData)(vlTOPp->pe_flow_ctrl__DOT__oyi_reach_th)
                    ? 0U : (0x3fU & ((IData)(1U) + (IData)(vlTOPp->pe_flow_ctrl__DOT__oyi__DOT__cnt_rg))));
        }
    }
    if (vlTOPp->reset) {
        __Vdly__pe_flow_ctrl__DOT__oxi__DOT__cnt_rg = 0U;
    } else {
        if (vlTOPp->pe_flow_ctrl__DOT__ozi_this_ov) {
            __Vdly__pe_flow_ctrl__DOT__oxi__DOT__cnt_rg 
                = ((IData)(vlTOPp->pe_flow_ctrl__DOT__oxi_reach_th)
                    ? 0U : (0x3fU & ((IData)(1U) + (IData)(vlTOPp->pe_flow_ctrl__DOT__oxi__DOT__cnt_rg))));
        }
    }
    if (vlTOPp->reset) {
        vlTOPp->__Vdly__pe_flow_ctrl__DOT__ozi__DOT__cnt_rg = 0U;
    } else {
        if (vlTOPp->pe_flow_ctrl__DOT__dofetch) {
            vlTOPp->__Vdly__pe_flow_ctrl__DOT__ozi__DOT__cnt_rg 
                = ((IData)(vlTOPp->pe_flow_ctrl__DOT__ozi_reach_th)
                    ? 0U : (0xfU & ((IData)(1U) + (IData)(vlTOPp->pe_flow_ctrl__DOT__ozi__DOT__cnt_rg))));
        }
    }
    vlTOPp->pe_flow_ctrl__DOT__kz__DOT__cnt_rg = __Vdly__pe_flow_ctrl__DOT__kz__DOT__cnt_rg;
    vlTOPp->pe_flow_ctrl__DOT__hki__DOT__cnt_rg = __Vdly__pe_flow_ctrl__DOT__hki__DOT__cnt_rg;
    vlTOPp->pe_flow_ctrl__DOT__wki__DOT__cnt_rg = __Vdly__pe_flow_ctrl__DOT__wki__DOT__cnt_rg;
    vlTOPp->pe_flow_ctrl__DOT__oyi__DOT__cnt_rg = __Vdly__pe_flow_ctrl__DOT__oyi__DOT__cnt_rg;
    vlTOPp->pe_flow_ctrl__DOT__oxi__DOT__cnt_rg = __Vdly__pe_flow_ctrl__DOT__oxi__DOT__cnt_rg;
    if (vlTOPp->reset) {
        vlTOPp->pe_flow_ctrl__DOT__dofetch = 0U;
        vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_back_en = 0U;
        vlTOPp->__Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_waddr = 0U;
        vlTOPp->__Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_raddr = 0U;
        __Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_wr = 0U;
        __Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_rd = 0U;
        vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_allow_rd = 0U;
        vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_pinA_bias_en = 0U;
        vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_pinB_bias_en = 0U;
        vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_byp_mul_en = 0U;
        vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_maxpool_en = 0U;
        vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_bias_mul_en = 0U;
        vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_scale_en = 0U;
        vlTOPp->pe_flow_ctrl__DOT__ifscp_ctrl_rgs_if_rd = 0U;
        __Vdly__pe_flow_ctrl__DOT__ifscp_ctrl_rgs_hw_addr = 0U;
        vlTOPp->pe_flow_ctrl__DOT__ifscp_ctrl_rgs_ich_addr = 0U;
        vlTOPp->pe_flow_ctrl__DOT__ifscp_ctrl_rgs_cast_mode = 0U;
        vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_we_rd = 0U;
        vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_bs_wr = 0U;
        vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_bs_rd = 0U;
        vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_sc_rd = 0U;
        vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_bs_byte_cnt = 0U;
        vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_och_gcnt = 0U;
    } else {
        if ((1U == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_curr_state))) {
            __Vdly__pe_flow_ctrl__DOT__ifscp_ctrl_rgs_hw_addr 
                = (0x3fU & ((IData)(vlTOPp->pe_flow_ctrl__DOT__oxi_this_ov)
                             ? ((IData)(1U) + ((IData)(vlTOPp->pe_flow_ctrl__DOT__ifscp_ctrl_rgs_hw_addr) 
                                               + (IData)(vlTOPp->rg_para_shxhat)))
                             : ((IData)(vlTOPp->pe_flow_ctrl__DOT__oyi_this_ov)
                                 ? 0U : ((IData)(vlTOPp->pe_flow_ctrl__DOT__ifscp_ctrl_rgs_hw_addr) 
                                         + (IData)(vlTOPp->rg_para_sw)))));
            if (vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_rd) {
                vlTOPp->__Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_raddr 
                    = ((IData)(vlTOPp->pe_flow_ctrl__DOT__ps_raddr_ov)
                        ? 0U : (0x7fU & ((IData)(1U) 
                                         + (IData)(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_raddr))));
            }
            if (vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_wr) {
                vlTOPp->__Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_waddr 
                    = ((IData)(vlTOPp->pe_flow_ctrl__DOT__ps_waddr_ov)
                        ? 0U : (0x7fU & ((IData)(1U) 
                                         + (IData)(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_waddr))));
            }
            vlTOPp->pe_flow_ctrl__DOT__dofetch = 1U;
            vlTOPp->pe_flow_ctrl__DOT__ifscp_ctrl_rgs_cast_mode = 0U;
            vlTOPp->pe_flow_ctrl__DOT__ifscp_ctrl_rgs_ich_addr 
                = vlTOPp->pe_flow_ctrl__DOT__kzi__DOT__cnt_rg;
            vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_och_gcnt 
                = vlTOPp->pe_flow_ctrl__DOT__ozi__DOT__cnt_rg;
            vlTOPp->pe_flow_ctrl__DOT__ifscp_ctrl_rgs_if_rd = 1U;
            vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_we_rd = 1U;
            if (vlTOPp->pe_flow_ctrl__DOT__ps_raddr_ov) {
                vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_allow_rd = 1U;
            }
            if (vlTOPp->rg_ctrl_bias_en) {
                if (vlTOPp->pe_flow_ctrl__DOT__ps_raddr_ov) {
                    vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_bs_rd = 0U;
                    vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_pinB_bias_en = 0U;
                } else {
                    vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_bs_rd = 1U;
                    vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_pinB_bias_en = 1U;
                }
            }
            if (vlTOPp->rg_ctrl_scale_en) {
                vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_scale_en 
                    = ((((IData)(vlTOPp->pe_flow_ctrl__DOT__kzi_reach_th) 
                         & (IData)(vlTOPp->pe_flow_ctrl__DOT__kz_reach_th)) 
                        & (IData)(vlTOPp->pe_flow_ctrl__DOT__hki_reach_th)) 
                       & (IData)(vlTOPp->pe_flow_ctrl__DOT__wki_reach_th));
            }
            __Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_wr 
                = vlTOPp->pe_flags_ps_wr_ready;
            __Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_rd 
                = vlTOPp->pe_flags_ps_rd_ready;
            if (vlTOPp->subconv_finish) {
                vlTOPp->pe_flow_ctrl__DOT__dofetch = 0U;
            }
        } else {
            if ((2U != (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_curr_state))) {
                vlTOPp->pe_flow_ctrl__DOT__ifscp_ctrl_rgs_if_rd = 0U;
                __Vdly__pe_flow_ctrl__DOT__ifscp_ctrl_rgs_hw_addr = 0U;
                vlTOPp->pe_flow_ctrl__DOT__ifscp_ctrl_rgs_ich_addr = 0U;
                vlTOPp->pe_flow_ctrl__DOT__ifscp_ctrl_rgs_cast_mode = 0U;
                vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_we_rd = 0U;
                vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_bs_wr = 0U;
                vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_bs_rd = 0U;
                vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_sc_rd = 0U;
                vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_bs_byte_cnt = 0U;
                vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_och_gcnt = 0U;
                vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_back_en = 0U;
                vlTOPp->__Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_waddr = 0U;
                vlTOPp->__Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_raddr = 0U;
                __Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_wr = 0U;
                __Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_rd = 0U;
                vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_allow_rd = 0U;
                vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_pinA_bias_en = 0U;
                vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_pinB_bias_en = 0U;
                vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_byp_mul_en = 0U;
                vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_maxpool_en = 0U;
                vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_bias_mul_en = 0U;
                vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_scale_en = 0U;
                vlTOPp->pe_flow_ctrl__DOT__dofetch = 0U;
            }
        }
    }
    vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_wr = __Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_wr;
    vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_rd = __Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_rd;
    vlTOPp->pe_flow_ctrl__DOT__ifscp_ctrl_rgs_hw_addr 
        = __Vdly__pe_flow_ctrl__DOT__ifscp_ctrl_rgs_hw_addr;
}

VL_INLINE_OPT void Vpe_flow_ctrl::_sequent__TOP__3(Vpe_flow_ctrl__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpe_flow_ctrl::_sequent__TOP__3\n"); );
    Vpe_flow_ctrl* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_waddr 
        = vlTOPp->__Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_waddr;
    vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_raddr 
        = vlTOPp->__Vdly__pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_raddr;
    vlTOPp->pe_flow_ctrl__DOT__kzi__DOT__cnt_rg = vlTOPp->__Vdly__pe_flow_ctrl__DOT__kzi__DOT__cnt_rg;
    vlTOPp->pe_flow_ctrl__DOT__ozi__DOT__cnt_rg = vlTOPp->__Vdly__pe_flow_ctrl__DOT__ozi__DOT__cnt_rg;
    vlTOPp->pe_ctrl_ps_back_en = vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_back_en;
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
    vlTOPp->pe_ctrl_ps_waddr = vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_waddr;
    vlTOPp->pe_ctrl_ps_raddr = vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_raddr;
    vlTOPp->pe_flow_ctrl__DOT__fsm_curr_state = ((IData)(vlTOPp->reset)
                                                  ? 0U
                                                  : (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_next_state));
}

VL_INLINE_OPT void Vpe_flow_ctrl::_combo__TOP__5(Vpe_flow_ctrl__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpe_flow_ctrl::_combo__TOP__5\n"); );
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
    vlTOPp->pe_flow_ctrl__DOT__ps_waddr_ov = ((IData)(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_waddr) 
                                              == (IData)(vlTOPp->rg_para_xyzs));
    vlTOPp->pe_flow_ctrl__DOT__ps_raddr_ov = ((IData)(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_raddr) 
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

void Vpe_flow_ctrl::_eval(Vpe_flow_ctrl__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpe_flow_ctrl::_eval\n"); );
    Vpe_flow_ctrl* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    if ((((IData)(vlTOPp->clk) & (~ (IData)(vlTOPp->__Vclklast__TOP__clk))) 
         | ((IData)(vlTOPp->reset) & (~ (IData)(vlTOPp->__Vclklast__TOP__reset))))) {
        vlTOPp->__Vm_traceActivity[1U] = 1U;
        vlTOPp->_sequent__TOP__2(vlSymsp);
        vlTOPp->_sequent__TOP__3(vlSymsp);
    }
    vlTOPp->_combo__TOP__5(vlSymsp);
    vlTOPp->__Vm_traceActivity[2U] = 1U;
    // Final
    vlTOPp->__Vclklast__TOP__clk = vlTOPp->clk;
    vlTOPp->__Vclklast__TOP__reset = vlTOPp->reset;
}

VL_INLINE_OPT QData Vpe_flow_ctrl::_change_request(Vpe_flow_ctrl__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpe_flow_ctrl::_change_request\n"); );
    Vpe_flow_ctrl* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    return (vlTOPp->_change_request_1(vlSymsp));
}

VL_INLINE_OPT QData Vpe_flow_ctrl::_change_request_1(Vpe_flow_ctrl__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpe_flow_ctrl::_change_request_1\n"); );
    Vpe_flow_ctrl* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    // Change detection
    QData __req = false;  // Logically a bool
    return __req;
}

#ifdef VL_DEBUG
void Vpe_flow_ctrl::_eval_debug_assertions() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vpe_flow_ctrl::_eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((start_conv & 0xfeU))) {
        Verilated::overWidthError("start_conv");}
    if (VL_UNLIKELY((rg_para_yhat & 0xc0U))) {
        Verilated::overWidthError("rg_para_yhat");}
    if (VL_UNLIKELY((rg_para_xhat & 0xc0U))) {
        Verilated::overWidthError("rg_para_xhat");}
    if (VL_UNLIKELY((rg_para_y & 0xc0U))) {
        Verilated::overWidthError("rg_para_y");}
    if (VL_UNLIKELY((rg_para_x & 0xc0U))) {
        Verilated::overWidthError("rg_para_x");}
    if (VL_UNLIKELY((rg_para_sh & 0xf0U))) {
        Verilated::overWidthError("rg_para_sh");}
    if (VL_UNLIKELY((rg_para_sw & 0xf0U))) {
        Verilated::overWidthError("rg_para_sw");}
    if (VL_UNLIKELY((rg_para_ph & 0xf0U))) {
        Verilated::overWidthError("rg_para_ph");}
    if (VL_UNLIKELY((rg_para_pw & 0xf0U))) {
        Verilated::overWidthError("rg_para_pw");}
    if (VL_UNLIKELY((rg_para_dh & 0xf0U))) {
        Verilated::overWidthError("rg_para_dh");}
    if (VL_UNLIKELY((rg_para_dw & 0xf0U))) {
        Verilated::overWidthError("rg_para_dw");}
    if (VL_UNLIKELY((rg_para_zs & 0xf0U))) {
        Verilated::overWidthError("rg_para_zs");}
    if (VL_UNLIKELY((rg_para_zp & 0xf0U))) {
        Verilated::overWidthError("rg_para_zp");}
    if (VL_UNLIKELY((rg_para_k & 0xf0U))) {
        Verilated::overWidthError("rg_para_k");}
    if (VL_UNLIKELY((rg_para_shxhat & 0xc0U))) {
        Verilated::overWidthError("rg_para_shxhat");}
    if (VL_UNLIKELY((rg_para_xyzs & 0x80U))) {
        Verilated::overWidthError("rg_para_xyzs");}
    if (VL_UNLIKELY((rg_ctrl_bias_en & 0xfeU))) {
        Verilated::overWidthError("rg_ctrl_bias_en");}
    if (VL_UNLIKELY((rg_ctrl_scale_en & 0xfeU))) {
        Verilated::overWidthError("rg_ctrl_scale_en");}
    if (VL_UNLIKELY((rg_ctrl_tensor_op_en & 0xfeU))) {
        Verilated::overWidthError("rg_ctrl_tensor_op_en");}
    if (VL_UNLIKELY((pe_flags_ps_rd_ready & 0xfeU))) {
        Verilated::overWidthError("pe_flags_ps_rd_ready");}
    if (VL_UNLIKELY((pe_flags_ps_wr_ready & 0xfeU))) {
        Verilated::overWidthError("pe_flags_ps_wr_ready");}
    if (VL_UNLIKELY((clk & 0xfeU))) {
        Verilated::overWidthError("clk");}
    if (VL_UNLIKELY((reset & 0xfeU))) {
        Verilated::overWidthError("reset");}
}
#endif  // VL_DEBUG
