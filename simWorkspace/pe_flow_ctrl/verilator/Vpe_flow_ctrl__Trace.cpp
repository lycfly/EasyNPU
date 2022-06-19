// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vpe_flow_ctrl__Syms.h"


void Vpe_flow_ctrl::traceChgTop0(void* userp, VerilatedVcd* tracep) {
    Vpe_flow_ctrl__Syms* __restrict vlSymsp = static_cast<Vpe_flow_ctrl__Syms*>(userp);
    Vpe_flow_ctrl* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Variables
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    {
        vlTOPp->traceChgSub0(userp, tracep);
    }
}

void Vpe_flow_ctrl::traceChgSub0(void* userp, VerilatedVcd* tracep) {
    Vpe_flow_ctrl__Syms* __restrict vlSymsp = static_cast<Vpe_flow_ctrl__Syms*>(userp);
    Vpe_flow_ctrl* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    vluint32_t* const oldp = tracep->oldp(vlSymsp->__Vm_baseCode + 1);
    if (false && oldp) {}  // Prevent unused
    // Variables
    WData/*95:0*/ __Vtemp30[3];
    WData/*95:0*/ __Vtemp40[3];
    // Body
    {
        if (VL_UNLIKELY(vlTOPp->__Vm_traceActivity[1U])) {
            tracep->chgCData(oldp+0,(vlTOPp->pe_flow_ctrl__DOT__kz__DOT__cnt_rg),8);
            tracep->chgCData(oldp+1,(vlTOPp->pe_flow_ctrl__DOT__kzi__DOT__cnt_rg),4);
            tracep->chgCData(oldp+2,(vlTOPp->pe_flow_ctrl__DOT__hki__DOT__cnt_rg),8);
            tracep->chgCData(oldp+3,(vlTOPp->pe_flow_ctrl__DOT__wki__DOT__cnt_rg),8);
            tracep->chgCData(oldp+4,(vlTOPp->pe_flow_ctrl__DOT__ozi__DOT__cnt_rg),4);
            tracep->chgCData(oldp+5,(vlTOPp->pe_flow_ctrl__DOT__oyi__DOT__cnt_rg),6);
            tracep->chgCData(oldp+6,(vlTOPp->pe_flow_ctrl__DOT__oxi__DOT__cnt_rg),6);
            tracep->chgBit(oldp+7,(vlTOPp->pe_flow_ctrl__DOT__dofetch));
            tracep->chgBit(oldp+8,(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_back_en));
            tracep->chgCData(oldp+9,(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_waddr),7);
            tracep->chgCData(oldp+10,(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_raddr),7);
            tracep->chgBit(oldp+11,(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_wr));
            tracep->chgBit(oldp+12,(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_rd));
            tracep->chgBit(oldp+13,(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_allow_rd));
            tracep->chgBit(oldp+14,(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_pinA_bias_en));
            tracep->chgBit(oldp+15,(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_pinB_bias_en));
            tracep->chgBit(oldp+16,(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_byp_mul_en));
            tracep->chgBit(oldp+17,(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_maxpool_en));
            tracep->chgBit(oldp+18,(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_bias_mul_en));
            tracep->chgBit(oldp+19,(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_scale_en));
            tracep->chgBit(oldp+20,(vlTOPp->pe_flow_ctrl__DOT__ifscp_ctrl_rgs_if_rd));
            tracep->chgCData(oldp+21,(vlTOPp->pe_flow_ctrl__DOT__ifscp_ctrl_rgs_hw_addr),6);
            tracep->chgCData(oldp+22,(vlTOPp->pe_flow_ctrl__DOT__ifscp_ctrl_rgs_ich_addr),4);
            tracep->chgBit(oldp+23,(vlTOPp->pe_flow_ctrl__DOT__ifscp_ctrl_rgs_cast_mode));
            tracep->chgBit(oldp+24,(vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_we_rd));
            tracep->chgBit(oldp+25,(vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_bs_wr));
            tracep->chgBit(oldp+26,(vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_bs_rd));
            tracep->chgBit(oldp+27,(vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_sc_rd));
            tracep->chgCData(oldp+28,(vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_bs_byte_cnt),3);
            tracep->chgCData(oldp+29,(vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_och_gcnt),4);
            tracep->chgCData(oldp+30,(vlTOPp->pe_flow_ctrl__DOT__fsm_curr_state),2);
            if ((0U == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_curr_state))) {
                __Vtemp30[0U] = 0x20202020U;
                __Vtemp30[1U] = 0x444c4520U;
                __Vtemp30[2U] = 0x49U;
            } else {
                __Vtemp30[0U] = ((1U == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_curr_state))
                                  ? 0x4e562020U : (
                                                   (2U 
                                                    == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_curr_state))
                                                    ? 0x525f4f50U
                                                    : 0x3f3f3f3fU));
                __Vtemp30[1U] = ((1U == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_curr_state))
                                  ? 0x5542434fU : (
                                                   (2U 
                                                    == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_curr_state))
                                                    ? 0x454e534fU
                                                    : 0x3f3f3f3fU));
                __Vtemp30[2U] = ((1U == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_curr_state))
                                  ? 0x53U : ((2U == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_curr_state))
                                              ? 0x54U
                                              : 0x3fU));
            }
            tracep->chgWData(oldp+31,(__Vtemp30),72);
        }
        if (VL_UNLIKELY(vlTOPp->__Vm_traceActivity[2U])) {
            tracep->chgBit(oldp+34,(((IData)(vlTOPp->pe_flow_ctrl__DOT__kz_reach_th) 
                                     & (IData)(vlTOPp->pe_flow_ctrl__DOT__kzi_this_ov))));
            tracep->chgBit(oldp+35,(vlTOPp->pe_flow_ctrl__DOT__kz_reach_th));
            tracep->chgBit(oldp+36,(vlTOPp->pe_flow_ctrl__DOT__kzi_this_ov));
            tracep->chgBit(oldp+37,(vlTOPp->pe_flow_ctrl__DOT__kzi_reach_th));
            tracep->chgBit(oldp+38,(vlTOPp->pe_flow_ctrl__DOT__hki_this_ov));
            tracep->chgBit(oldp+39,(vlTOPp->pe_flow_ctrl__DOT__hki_reach_th));
            tracep->chgBit(oldp+40,(vlTOPp->pe_flow_ctrl__DOT__wki_this_ov));
            tracep->chgBit(oldp+41,(vlTOPp->pe_flow_ctrl__DOT__wki_reach_th));
            tracep->chgBit(oldp+42,(vlTOPp->pe_flow_ctrl__DOT__ozi_this_ov));
            tracep->chgBit(oldp+43,(vlTOPp->pe_flow_ctrl__DOT__ozi_reach_th));
            tracep->chgBit(oldp+44,(vlTOPp->pe_flow_ctrl__DOT__oyi_this_ov));
            tracep->chgBit(oldp+45,(vlTOPp->pe_flow_ctrl__DOT__oyi_reach_th));
            tracep->chgBit(oldp+46,(vlTOPp->pe_flow_ctrl__DOT__oxi_this_ov));
            tracep->chgBit(oldp+47,(vlTOPp->pe_flow_ctrl__DOT__oxi_reach_th));
            tracep->chgBit(oldp+48,(vlTOPp->pe_flow_ctrl__DOT__ps_raddr_ov));
            tracep->chgBit(oldp+49,(((((IData)(vlTOPp->pe_flow_ctrl__DOT__kzi_reach_th) 
                                       & (IData)(vlTOPp->pe_flow_ctrl__DOT__kz_reach_th)) 
                                      & (IData)(vlTOPp->pe_flow_ctrl__DOT__hki_reach_th)) 
                                     & (IData)(vlTOPp->pe_flow_ctrl__DOT__wki_reach_th))));
            tracep->chgCData(oldp+50,(vlTOPp->pe_flow_ctrl__DOT__fsm_next_state),2);
            if ((0U == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_next_state))) {
                __Vtemp40[0U] = 0x20202020U;
                __Vtemp40[1U] = 0x444c4520U;
                __Vtemp40[2U] = 0x49U;
            } else {
                __Vtemp40[0U] = ((1U == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_next_state))
                                  ? 0x4e562020U : (
                                                   (2U 
                                                    == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_next_state))
                                                    ? 0x525f4f50U
                                                    : 0x3f3f3f3fU));
                __Vtemp40[1U] = ((1U == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_next_state))
                                  ? 0x5542434fU : (
                                                   (2U 
                                                    == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_next_state))
                                                    ? 0x454e534fU
                                                    : 0x3f3f3f3fU));
                __Vtemp40[2U] = ((1U == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_next_state))
                                  ? 0x53U : ((2U == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_next_state))
                                              ? 0x54U
                                              : 0x3fU));
            }
            tracep->chgWData(oldp+51,(__Vtemp40),72);
        }
        tracep->chgBit(oldp+54,(vlTOPp->start_conv));
        tracep->chgCData(oldp+55,(vlTOPp->rg_para_yhat),6);
        tracep->chgCData(oldp+56,(vlTOPp->rg_para_xhat),6);
        tracep->chgCData(oldp+57,(vlTOPp->rg_para_y),6);
        tracep->chgCData(oldp+58,(vlTOPp->rg_para_x),6);
        tracep->chgCData(oldp+59,(vlTOPp->rg_para_Hk),8);
        tracep->chgCData(oldp+60,(vlTOPp->rg_para_Wk),8);
        tracep->chgCData(oldp+61,(vlTOPp->rg_para_Ho),8);
        tracep->chgCData(oldp+62,(vlTOPp->rg_para_Wo),8);
        tracep->chgCData(oldp+63,(vlTOPp->rg_para_Hi),8);
        tracep->chgCData(oldp+64,(vlTOPp->rg_para_Wi),8);
        tracep->chgCData(oldp+65,(vlTOPp->rg_para_Co),8);
        tracep->chgCData(oldp+66,(vlTOPp->rg_para_Ci),8);
        tracep->chgCData(oldp+67,(vlTOPp->rg_para_sh),4);
        tracep->chgCData(oldp+68,(vlTOPp->rg_para_sw),4);
        tracep->chgCData(oldp+69,(vlTOPp->rg_para_ph),4);
        tracep->chgCData(oldp+70,(vlTOPp->rg_para_pw),4);
        tracep->chgCData(oldp+71,(vlTOPp->rg_para_dh),4);
        tracep->chgCData(oldp+72,(vlTOPp->rg_para_dw),4);
        tracep->chgCData(oldp+73,(vlTOPp->rg_para_zs),4);
        tracep->chgCData(oldp+74,(vlTOPp->rg_para_zp),4);
        tracep->chgCData(oldp+75,(vlTOPp->rg_para_k),4);
        tracep->chgCData(oldp+76,(vlTOPp->rg_para_shxhat),6);
        tracep->chgCData(oldp+77,(vlTOPp->rg_para_xyzs),7);
        tracep->chgBit(oldp+78,(vlTOPp->rg_ctrl_bias_en));
        tracep->chgBit(oldp+79,(vlTOPp->rg_ctrl_scale_en));
        tracep->chgBit(oldp+80,(vlTOPp->rg_ctrl_tensor_op_en));
        tracep->chgBit(oldp+81,(vlTOPp->pe_ctrl_ps_back_en));
        tracep->chgCData(oldp+82,(vlTOPp->pe_ctrl_ps_waddr),7);
        tracep->chgCData(oldp+83,(vlTOPp->pe_ctrl_ps_raddr),7);
        tracep->chgBit(oldp+84,(vlTOPp->pe_ctrl_ps_wr));
        tracep->chgBit(oldp+85,(vlTOPp->pe_ctrl_ps_rd));
        tracep->chgBit(oldp+86,(vlTOPp->pe_ctrl_ps_allow_rd));
        tracep->chgBit(oldp+87,(vlTOPp->pe_ctrl_ps_pinA_bias_en));
        tracep->chgBit(oldp+88,(vlTOPp->pe_ctrl_ps_pinB_bias_en));
        tracep->chgBit(oldp+89,(vlTOPp->pe_ctrl_byp_mul_en));
        tracep->chgBit(oldp+90,(vlTOPp->pe_ctrl_maxpool_en));
        tracep->chgBit(oldp+91,(vlTOPp->pe_ctrl_bias_mul_en));
        tracep->chgBit(oldp+92,(vlTOPp->pe_ctrl_ps_scale_en));
        tracep->chgBit(oldp+93,(vlTOPp->ifscp_ctrl_if_rd));
        tracep->chgCData(oldp+94,(vlTOPp->ifscp_ctrl_hw_addr),6);
        tracep->chgCData(oldp+95,(vlTOPp->ifscp_ctrl_ich_addr),4);
        tracep->chgBit(oldp+96,(vlTOPp->ifscp_ctrl_cast_mode));
        tracep->chgBit(oldp+97,(vlTOPp->wescp_ctrl_we_rd));
        tracep->chgBit(oldp+98,(vlTOPp->wescp_ctrl_bs_wr));
        tracep->chgBit(oldp+99,(vlTOPp->wescp_ctrl_bs_rd));
        tracep->chgBit(oldp+100,(vlTOPp->wescp_ctrl_sc_rd));
        tracep->chgCData(oldp+101,(vlTOPp->wescp_ctrl_bs_byte_cnt),3);
        tracep->chgCData(oldp+102,(vlTOPp->wescp_ctrl_och_gcnt),4);
        tracep->chgBit(oldp+103,(vlTOPp->pe_flags_ps_rd_ready));
        tracep->chgBit(oldp+104,(vlTOPp->pe_flags_ps_wr_ready));
        tracep->chgBit(oldp+105,(vlTOPp->subconv_finish));
        tracep->chgBit(oldp+106,(vlTOPp->clk));
        tracep->chgBit(oldp+107,(vlTOPp->reset));
        tracep->chgCData(oldp+108,(vlTOPp->rg_para_k),8);
        tracep->chgBit(oldp+109,(((IData)(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_waddr) 
                                  == (IData)(vlTOPp->rg_para_xyzs))));
    }
}

void Vpe_flow_ctrl::traceCleanup(void* userp, VerilatedVcd* /*unused*/) {
    Vpe_flow_ctrl__Syms* __restrict vlSymsp = static_cast<Vpe_flow_ctrl__Syms*>(userp);
    Vpe_flow_ctrl* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    {
        vlSymsp->__Vm_activity = false;
        vlTOPp->__Vm_traceActivity[0U] = 0U;
        vlTOPp->__Vm_traceActivity[1U] = 0U;
        vlTOPp->__Vm_traceActivity[2U] = 0U;
    }
}
