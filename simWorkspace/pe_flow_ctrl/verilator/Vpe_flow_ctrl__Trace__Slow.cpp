// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vpe_flow_ctrl__Syms.h"


//======================

void Vpe_flow_ctrl::trace(VerilatedVcdC* tfp, int, int) {
    tfp->spTrace()->addInitCb(&traceInit, __VlSymsp);
    traceRegister(tfp->spTrace());
}

void Vpe_flow_ctrl::traceInit(void* userp, VerilatedVcd* tracep, uint32_t code) {
    // Callback from tracep->open()
    Vpe_flow_ctrl__Syms* __restrict vlSymsp = static_cast<Vpe_flow_ctrl__Syms*>(userp);
    if (!Verilated::calcUnusedSigs()) {
        VL_FATAL_MT(__FILE__, __LINE__, __FILE__,
                        "Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vlSymsp->__Vm_baseCode = code;
    tracep->module(vlSymsp->name());
    tracep->scopeEscape(' ');
    Vpe_flow_ctrl::traceInitTop(vlSymsp, tracep);
    tracep->scopeEscape('.');
}

//======================


void Vpe_flow_ctrl::traceInitTop(void* userp, VerilatedVcd* tracep) {
    Vpe_flow_ctrl__Syms* __restrict vlSymsp = static_cast<Vpe_flow_ctrl__Syms*>(userp);
    Vpe_flow_ctrl* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    {
        vlTOPp->traceInitSub0(userp, tracep);
    }
}

void Vpe_flow_ctrl::traceInitSub0(void* userp, VerilatedVcd* tracep) {
    Vpe_flow_ctrl__Syms* __restrict vlSymsp = static_cast<Vpe_flow_ctrl__Syms*>(userp);
    Vpe_flow_ctrl* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    const int c = vlSymsp->__Vm_baseCode;
    if (false && tracep && c) {}  // Prevent unused
    // Body
    {
        tracep->declBit(c+55,"start_conv", false,-1);
        tracep->declBus(c+56,"rg_para_yhat", false,-1, 5,0);
        tracep->declBus(c+57,"rg_para_xhat", false,-1, 5,0);
        tracep->declBus(c+58,"rg_para_y", false,-1, 5,0);
        tracep->declBus(c+59,"rg_para_x", false,-1, 5,0);
        tracep->declBus(c+60,"rg_para_Hk", false,-1, 7,0);
        tracep->declBus(c+61,"rg_para_Wk", false,-1, 7,0);
        tracep->declBus(c+62,"rg_para_Ho", false,-1, 7,0);
        tracep->declBus(c+63,"rg_para_Wo", false,-1, 7,0);
        tracep->declBus(c+64,"rg_para_Hi", false,-1, 7,0);
        tracep->declBus(c+65,"rg_para_Wi", false,-1, 7,0);
        tracep->declBus(c+66,"rg_para_Co", false,-1, 7,0);
        tracep->declBus(c+67,"rg_para_Ci", false,-1, 7,0);
        tracep->declBus(c+68,"rg_para_sh", false,-1, 3,0);
        tracep->declBus(c+69,"rg_para_sw", false,-1, 3,0);
        tracep->declBus(c+70,"rg_para_ph", false,-1, 3,0);
        tracep->declBus(c+71,"rg_para_pw", false,-1, 3,0);
        tracep->declBus(c+72,"rg_para_dh", false,-1, 3,0);
        tracep->declBus(c+73,"rg_para_dw", false,-1, 3,0);
        tracep->declBus(c+74,"rg_para_zs", false,-1, 3,0);
        tracep->declBus(c+75,"rg_para_zp", false,-1, 3,0);
        tracep->declBus(c+76,"rg_para_k", false,-1, 3,0);
        tracep->declBus(c+77,"rg_para_shxhat", false,-1, 5,0);
        tracep->declBus(c+78,"rg_para_xyzs", false,-1, 6,0);
        tracep->declBit(c+79,"rg_ctrl_bias_en", false,-1);
        tracep->declBit(c+80,"rg_ctrl_scale_en", false,-1);
        tracep->declBit(c+81,"rg_ctrl_tensor_op_en", false,-1);
        tracep->declBit(c+82,"pe_ctrl_ps_back_en", false,-1);
        tracep->declBus(c+83,"pe_ctrl_ps_waddr", false,-1, 6,0);
        tracep->declBus(c+84,"pe_ctrl_ps_raddr", false,-1, 6,0);
        tracep->declBit(c+85,"pe_ctrl_ps_wr", false,-1);
        tracep->declBit(c+86,"pe_ctrl_ps_rd", false,-1);
        tracep->declBit(c+87,"pe_ctrl_ps_allow_rd", false,-1);
        tracep->declBit(c+88,"pe_ctrl_ps_pinA_bias_en", false,-1);
        tracep->declBit(c+89,"pe_ctrl_ps_pinB_bias_en", false,-1);
        tracep->declBit(c+90,"pe_ctrl_byp_mul_en", false,-1);
        tracep->declBit(c+91,"pe_ctrl_maxpool_en", false,-1);
        tracep->declBit(c+92,"pe_ctrl_bias_mul_en", false,-1);
        tracep->declBit(c+93,"pe_ctrl_ps_scale_en", false,-1);
        tracep->declBit(c+94,"ifscp_ctrl_if_rd", false,-1);
        tracep->declBus(c+95,"ifscp_ctrl_hw_addr", false,-1, 5,0);
        tracep->declBus(c+96,"ifscp_ctrl_ich_addr", false,-1, 3,0);
        tracep->declBit(c+97,"ifscp_ctrl_cast_mode", false,-1);
        tracep->declBit(c+98,"wescp_ctrl_we_rd", false,-1);
        tracep->declBit(c+99,"wescp_ctrl_bs_wr", false,-1);
        tracep->declBit(c+100,"wescp_ctrl_bs_rd", false,-1);
        tracep->declBit(c+101,"wescp_ctrl_sc_rd", false,-1);
        tracep->declBus(c+102,"wescp_ctrl_bs_byte_cnt", false,-1, 2,0);
        tracep->declBus(c+103,"wescp_ctrl_och_gcnt", false,-1, 3,0);
        tracep->declBit(c+104,"pe_flags_ps_rd_ready", false,-1);
        tracep->declBit(c+105,"pe_flags_ps_wr_ready", false,-1);
        tracep->declBit(c+106,"subconv_finish", false,-1);
        tracep->declBit(c+107,"clk", false,-1);
        tracep->declBit(c+108,"reset", false,-1);
        tracep->declBit(c+55,"pe_flow_ctrl start_conv", false,-1);
        tracep->declBus(c+56,"pe_flow_ctrl rg_para_yhat", false,-1, 5,0);
        tracep->declBus(c+57,"pe_flow_ctrl rg_para_xhat", false,-1, 5,0);
        tracep->declBus(c+58,"pe_flow_ctrl rg_para_y", false,-1, 5,0);
        tracep->declBus(c+59,"pe_flow_ctrl rg_para_x", false,-1, 5,0);
        tracep->declBus(c+60,"pe_flow_ctrl rg_para_Hk", false,-1, 7,0);
        tracep->declBus(c+61,"pe_flow_ctrl rg_para_Wk", false,-1, 7,0);
        tracep->declBus(c+62,"pe_flow_ctrl rg_para_Ho", false,-1, 7,0);
        tracep->declBus(c+63,"pe_flow_ctrl rg_para_Wo", false,-1, 7,0);
        tracep->declBus(c+64,"pe_flow_ctrl rg_para_Hi", false,-1, 7,0);
        tracep->declBus(c+65,"pe_flow_ctrl rg_para_Wi", false,-1, 7,0);
        tracep->declBus(c+66,"pe_flow_ctrl rg_para_Co", false,-1, 7,0);
        tracep->declBus(c+67,"pe_flow_ctrl rg_para_Ci", false,-1, 7,0);
        tracep->declBus(c+68,"pe_flow_ctrl rg_para_sh", false,-1, 3,0);
        tracep->declBus(c+69,"pe_flow_ctrl rg_para_sw", false,-1, 3,0);
        tracep->declBus(c+70,"pe_flow_ctrl rg_para_ph", false,-1, 3,0);
        tracep->declBus(c+71,"pe_flow_ctrl rg_para_pw", false,-1, 3,0);
        tracep->declBus(c+72,"pe_flow_ctrl rg_para_dh", false,-1, 3,0);
        tracep->declBus(c+73,"pe_flow_ctrl rg_para_dw", false,-1, 3,0);
        tracep->declBus(c+74,"pe_flow_ctrl rg_para_zs", false,-1, 3,0);
        tracep->declBus(c+75,"pe_flow_ctrl rg_para_zp", false,-1, 3,0);
        tracep->declBus(c+76,"pe_flow_ctrl rg_para_k", false,-1, 3,0);
        tracep->declBus(c+77,"pe_flow_ctrl rg_para_shxhat", false,-1, 5,0);
        tracep->declBus(c+78,"pe_flow_ctrl rg_para_xyzs", false,-1, 6,0);
        tracep->declBit(c+79,"pe_flow_ctrl rg_ctrl_bias_en", false,-1);
        tracep->declBit(c+80,"pe_flow_ctrl rg_ctrl_scale_en", false,-1);
        tracep->declBit(c+81,"pe_flow_ctrl rg_ctrl_tensor_op_en", false,-1);
        tracep->declBit(c+82,"pe_flow_ctrl pe_ctrl_ps_back_en", false,-1);
        tracep->declBus(c+83,"pe_flow_ctrl pe_ctrl_ps_waddr", false,-1, 6,0);
        tracep->declBus(c+84,"pe_flow_ctrl pe_ctrl_ps_raddr", false,-1, 6,0);
        tracep->declBit(c+85,"pe_flow_ctrl pe_ctrl_ps_wr", false,-1);
        tracep->declBit(c+86,"pe_flow_ctrl pe_ctrl_ps_rd", false,-1);
        tracep->declBit(c+87,"pe_flow_ctrl pe_ctrl_ps_allow_rd", false,-1);
        tracep->declBit(c+88,"pe_flow_ctrl pe_ctrl_ps_pinA_bias_en", false,-1);
        tracep->declBit(c+89,"pe_flow_ctrl pe_ctrl_ps_pinB_bias_en", false,-1);
        tracep->declBit(c+90,"pe_flow_ctrl pe_ctrl_byp_mul_en", false,-1);
        tracep->declBit(c+91,"pe_flow_ctrl pe_ctrl_maxpool_en", false,-1);
        tracep->declBit(c+92,"pe_flow_ctrl pe_ctrl_bias_mul_en", false,-1);
        tracep->declBit(c+93,"pe_flow_ctrl pe_ctrl_ps_scale_en", false,-1);
        tracep->declBit(c+94,"pe_flow_ctrl ifscp_ctrl_if_rd", false,-1);
        tracep->declBus(c+95,"pe_flow_ctrl ifscp_ctrl_hw_addr", false,-1, 5,0);
        tracep->declBus(c+96,"pe_flow_ctrl ifscp_ctrl_ich_addr", false,-1, 3,0);
        tracep->declBit(c+97,"pe_flow_ctrl ifscp_ctrl_cast_mode", false,-1);
        tracep->declBit(c+98,"pe_flow_ctrl wescp_ctrl_we_rd", false,-1);
        tracep->declBit(c+99,"pe_flow_ctrl wescp_ctrl_bs_wr", false,-1);
        tracep->declBit(c+100,"pe_flow_ctrl wescp_ctrl_bs_rd", false,-1);
        tracep->declBit(c+101,"pe_flow_ctrl wescp_ctrl_sc_rd", false,-1);
        tracep->declBus(c+102,"pe_flow_ctrl wescp_ctrl_bs_byte_cnt", false,-1, 2,0);
        tracep->declBus(c+103,"pe_flow_ctrl wescp_ctrl_och_gcnt", false,-1, 3,0);
        tracep->declBit(c+104,"pe_flow_ctrl pe_flags_ps_rd_ready", false,-1);
        tracep->declBit(c+105,"pe_flow_ctrl pe_flags_ps_wr_ready", false,-1);
        tracep->declBit(c+106,"pe_flow_ctrl subconv_finish", false,-1);
        tracep->declBit(c+107,"pe_flow_ctrl clk", false,-1);
        tracep->declBit(c+108,"pe_flow_ctrl reset", false,-1);
        tracep->declBus(c+111,"pe_flow_ctrl fsm_enumDef_IDLE", false,-1, 1,0);
        tracep->declBus(c+112,"pe_flow_ctrl fsm_enumDef_SUBCONV", false,-1, 1,0);
        tracep->declBus(c+113,"pe_flow_ctrl fsm_enumDef_TENSOR_OP", false,-1, 1,0);
        tracep->declBus(c+109,"pe_flow_ctrl kz_step", false,-1, 7,0);
        tracep->declBus(c+1,"pe_flow_ctrl kz_cnt", false,-1, 7,0);
        tracep->declBit(c+35,"pe_flow_ctrl kz_this_ov", false,-1);
        tracep->declBit(c+36,"pe_flow_ctrl kz_reach_th", false,-1);
        tracep->declBus(c+2,"pe_flow_ctrl kzi_cnt", false,-1, 3,0);
        tracep->declBit(c+37,"pe_flow_ctrl kzi_this_ov", false,-1);
        tracep->declBit(c+38,"pe_flow_ctrl kzi_reach_th", false,-1);
        tracep->declBus(c+3,"pe_flow_ctrl hki_cnt", false,-1, 7,0);
        tracep->declBit(c+39,"pe_flow_ctrl hki_this_ov", false,-1);
        tracep->declBit(c+40,"pe_flow_ctrl hki_reach_th", false,-1);
        tracep->declBus(c+4,"pe_flow_ctrl wki_cnt", false,-1, 7,0);
        tracep->declBit(c+41,"pe_flow_ctrl wki_this_ov", false,-1);
        tracep->declBit(c+42,"pe_flow_ctrl wki_reach_th", false,-1);
        tracep->declBus(c+5,"pe_flow_ctrl ozi_cnt", false,-1, 3,0);
        tracep->declBit(c+43,"pe_flow_ctrl ozi_this_ov", false,-1);
        tracep->declBit(c+44,"pe_flow_ctrl ozi_reach_th", false,-1);
        tracep->declBus(c+6,"pe_flow_ctrl oyi_cnt", false,-1, 5,0);
        tracep->declBit(c+45,"pe_flow_ctrl oyi_this_ov", false,-1);
        tracep->declBit(c+46,"pe_flow_ctrl oyi_reach_th", false,-1);
        tracep->declBus(c+7,"pe_flow_ctrl oxi_cnt", false,-1, 5,0);
        tracep->declBit(c+47,"pe_flow_ctrl oxi_this_ov", false,-1);
        tracep->declBit(c+48,"pe_flow_ctrl oxi_reach_th", false,-1);
        tracep->declBit(c+8,"pe_flow_ctrl dofetch", false,-1);
        tracep->declBit(c+37,"pe_flow_ctrl kz_sigs_inc", false,-1);
        tracep->declBit(c+35,"pe_flow_ctrl kz_sigs_this_ov", false,-1);
        tracep->declBit(c+36,"pe_flow_ctrl kz_sigs_reach_th", false,-1);
        tracep->declBit(c+41,"pe_flow_ctrl hki_sigs_inc", false,-1);
        tracep->declBit(c+39,"pe_flow_ctrl hki_sigs_this_ov", false,-1);
        tracep->declBit(c+40,"pe_flow_ctrl hki_sigs_reach_th", false,-1);
        tracep->declBit(c+45,"pe_flow_ctrl wki_sigs_inc", false,-1);
        tracep->declBit(c+41,"pe_flow_ctrl wki_sigs_this_ov", false,-1);
        tracep->declBit(c+42,"pe_flow_ctrl wki_sigs_reach_th", false,-1);
        tracep->declBit(c+39,"pe_flow_ctrl kzi_sigs_inc", false,-1);
        tracep->declBit(c+37,"pe_flow_ctrl kzi_sigs_this_ov", false,-1);
        tracep->declBit(c+38,"pe_flow_ctrl kzi_sigs_reach_th", false,-1);
        tracep->declBit(c+8,"pe_flow_ctrl ozi_sigs_inc", false,-1);
        tracep->declBit(c+43,"pe_flow_ctrl ozi_sigs_this_ov", false,-1);
        tracep->declBit(c+44,"pe_flow_ctrl ozi_sigs_reach_th", false,-1);
        tracep->declBit(c+47,"pe_flow_ctrl oyi_sigs_inc", false,-1);
        tracep->declBit(c+45,"pe_flow_ctrl oyi_sigs_this_ov", false,-1);
        tracep->declBit(c+46,"pe_flow_ctrl oyi_sigs_reach_th", false,-1);
        tracep->declBit(c+43,"pe_flow_ctrl oxi_sigs_inc", false,-1);
        tracep->declBit(c+47,"pe_flow_ctrl oxi_sigs_this_ov", false,-1);
        tracep->declBit(c+48,"pe_flow_ctrl oxi_sigs_reach_th", false,-1);
        tracep->declBit(c+9,"pe_flow_ctrl pe_ctrl_rgs_ps_back_en", false,-1);
        tracep->declBus(c+10,"pe_flow_ctrl pe_ctrl_rgs_ps_waddr", false,-1, 6,0);
        tracep->declBus(c+11,"pe_flow_ctrl pe_ctrl_rgs_ps_raddr", false,-1, 6,0);
        tracep->declBit(c+12,"pe_flow_ctrl pe_ctrl_rgs_ps_wr", false,-1);
        tracep->declBit(c+13,"pe_flow_ctrl pe_ctrl_rgs_ps_rd", false,-1);
        tracep->declBit(c+14,"pe_flow_ctrl pe_ctrl_rgs_ps_allow_rd", false,-1);
        tracep->declBit(c+15,"pe_flow_ctrl pe_ctrl_rgs_ps_pinA_bias_en", false,-1);
        tracep->declBit(c+16,"pe_flow_ctrl pe_ctrl_rgs_ps_pinB_bias_en", false,-1);
        tracep->declBit(c+17,"pe_flow_ctrl pe_ctrl_rgs_byp_mul_en", false,-1);
        tracep->declBit(c+18,"pe_flow_ctrl pe_ctrl_rgs_maxpool_en", false,-1);
        tracep->declBit(c+19,"pe_flow_ctrl pe_ctrl_rgs_bias_mul_en", false,-1);
        tracep->declBit(c+20,"pe_flow_ctrl pe_ctrl_rgs_ps_scale_en", false,-1);
        tracep->declBit(c+21,"pe_flow_ctrl ifscp_ctrl_rgs_if_rd", false,-1);
        tracep->declBus(c+22,"pe_flow_ctrl ifscp_ctrl_rgs_hw_addr", false,-1, 5,0);
        tracep->declBus(c+23,"pe_flow_ctrl ifscp_ctrl_rgs_ich_addr", false,-1, 3,0);
        tracep->declBit(c+24,"pe_flow_ctrl ifscp_ctrl_rgs_cast_mode", false,-1);
        tracep->declBit(c+25,"pe_flow_ctrl wescp_ctrl_rgs_we_rd", false,-1);
        tracep->declBit(c+26,"pe_flow_ctrl wescp_ctrl_rgs_bs_wr", false,-1);
        tracep->declBit(c+27,"pe_flow_ctrl wescp_ctrl_rgs_bs_rd", false,-1);
        tracep->declBit(c+28,"pe_flow_ctrl wescp_ctrl_rgs_sc_rd", false,-1);
        tracep->declBus(c+29,"pe_flow_ctrl wescp_ctrl_rgs_bs_byte_cnt", false,-1, 2,0);
        tracep->declBus(c+30,"pe_flow_ctrl wescp_ctrl_rgs_och_gcnt", false,-1, 3,0);
        tracep->declBit(c+49,"pe_flow_ctrl ps_raddr_ov", false,-1);
        tracep->declBit(c+110,"pe_flow_ctrl ps_waddr_ov", false,-1);
        tracep->declBit(c+50,"pe_flow_ctrl ofmap_out_ready_flag", false,-1);
        tracep->declBit(c+114,"pe_flow_ctrl fsm_wantExit", false,-1);
        tracep->declBit(c+114,"pe_flow_ctrl fsm_wantStart", false,-1);
        tracep->declBit(c+114,"pe_flow_ctrl fsm_wantKill", false,-1);
        tracep->declBus(c+31,"pe_flow_ctrl fsm_curr_state", false,-1, 1,0);
        tracep->declBus(c+51,"pe_flow_ctrl fsm_next_state", false,-1, 1,0);
        tracep->declArray(c+32,"pe_flow_ctrl fsm_curr_state_string", false,-1, 71,0);
        tracep->declArray(c+52,"pe_flow_ctrl fsm_next_state_string", false,-1, 71,0);
        tracep->declBus(c+109,"pe_flow_ctrl kz step", false,-1, 7,0);
        tracep->declBus(c+67,"pe_flow_ctrl kz threshold", false,-1, 7,0);
        tracep->declBit(c+37,"pe_flow_ctrl kz inc_en", false,-1);
        tracep->declBus(c+1,"pe_flow_ctrl kz cnt", false,-1, 7,0);
        tracep->declBit(c+35,"pe_flow_ctrl kz this_ov", false,-1);
        tracep->declBit(c+36,"pe_flow_ctrl kz reach_th", false,-1);
        tracep->declBit(c+107,"pe_flow_ctrl kz clk", false,-1);
        tracep->declBit(c+108,"pe_flow_ctrl kz reset", false,-1);
        tracep->declBus(c+1,"pe_flow_ctrl kz cnt_rg", false,-1, 7,0);
        tracep->declBus(c+115,"pe_flow_ctrl kzi step", false,-1, 3,0);
        tracep->declBus(c+76,"pe_flow_ctrl kzi threshold", false,-1, 3,0);
        tracep->declBit(c+39,"pe_flow_ctrl kzi inc_en", false,-1);
        tracep->declBus(c+2,"pe_flow_ctrl kzi cnt", false,-1, 3,0);
        tracep->declBit(c+37,"pe_flow_ctrl kzi this_ov", false,-1);
        tracep->declBit(c+38,"pe_flow_ctrl kzi reach_th", false,-1);
        tracep->declBit(c+107,"pe_flow_ctrl kzi clk", false,-1);
        tracep->declBit(c+108,"pe_flow_ctrl kzi reset", false,-1);
        tracep->declBus(c+2,"pe_flow_ctrl kzi cnt_rg", false,-1, 3,0);
        tracep->declBus(c+116,"pe_flow_ctrl hki step", false,-1, 7,0);
        tracep->declBus(c+60,"pe_flow_ctrl hki threshold", false,-1, 7,0);
        tracep->declBit(c+41,"pe_flow_ctrl hki inc_en", false,-1);
        tracep->declBus(c+3,"pe_flow_ctrl hki cnt", false,-1, 7,0);
        tracep->declBit(c+39,"pe_flow_ctrl hki this_ov", false,-1);
        tracep->declBit(c+40,"pe_flow_ctrl hki reach_th", false,-1);
        tracep->declBit(c+107,"pe_flow_ctrl hki clk", false,-1);
        tracep->declBit(c+108,"pe_flow_ctrl hki reset", false,-1);
        tracep->declBus(c+3,"pe_flow_ctrl hki cnt_rg", false,-1, 7,0);
        tracep->declBus(c+116,"pe_flow_ctrl wki step", false,-1, 7,0);
        tracep->declBus(c+61,"pe_flow_ctrl wki threshold", false,-1, 7,0);
        tracep->declBit(c+45,"pe_flow_ctrl wki inc_en", false,-1);
        tracep->declBus(c+4,"pe_flow_ctrl wki cnt", false,-1, 7,0);
        tracep->declBit(c+41,"pe_flow_ctrl wki this_ov", false,-1);
        tracep->declBit(c+42,"pe_flow_ctrl wki reach_th", false,-1);
        tracep->declBit(c+107,"pe_flow_ctrl wki clk", false,-1);
        tracep->declBit(c+108,"pe_flow_ctrl wki reset", false,-1);
        tracep->declBus(c+4,"pe_flow_ctrl wki cnt_rg", false,-1, 7,0);
        tracep->declBus(c+115,"pe_flow_ctrl ozi step", false,-1, 3,0);
        tracep->declBus(c+74,"pe_flow_ctrl ozi threshold", false,-1, 3,0);
        tracep->declBit(c+8,"pe_flow_ctrl ozi inc_en", false,-1);
        tracep->declBus(c+5,"pe_flow_ctrl ozi cnt", false,-1, 3,0);
        tracep->declBit(c+43,"pe_flow_ctrl ozi this_ov", false,-1);
        tracep->declBit(c+44,"pe_flow_ctrl ozi reach_th", false,-1);
        tracep->declBit(c+107,"pe_flow_ctrl ozi clk", false,-1);
        tracep->declBit(c+108,"pe_flow_ctrl ozi reset", false,-1);
        tracep->declBus(c+5,"pe_flow_ctrl ozi cnt_rg", false,-1, 3,0);
        tracep->declBus(c+117,"pe_flow_ctrl oyi step", false,-1, 5,0);
        tracep->declBus(c+56,"pe_flow_ctrl oyi threshold", false,-1, 5,0);
        tracep->declBit(c+47,"pe_flow_ctrl oyi inc_en", false,-1);
        tracep->declBus(c+6,"pe_flow_ctrl oyi cnt", false,-1, 5,0);
        tracep->declBit(c+45,"pe_flow_ctrl oyi this_ov", false,-1);
        tracep->declBit(c+46,"pe_flow_ctrl oyi reach_th", false,-1);
        tracep->declBit(c+107,"pe_flow_ctrl oyi clk", false,-1);
        tracep->declBit(c+108,"pe_flow_ctrl oyi reset", false,-1);
        tracep->declBus(c+6,"pe_flow_ctrl oyi cnt_rg", false,-1, 5,0);
        tracep->declBus(c+117,"pe_flow_ctrl oxi step", false,-1, 5,0);
        tracep->declBus(c+57,"pe_flow_ctrl oxi threshold", false,-1, 5,0);
        tracep->declBit(c+43,"pe_flow_ctrl oxi inc_en", false,-1);
        tracep->declBus(c+7,"pe_flow_ctrl oxi cnt", false,-1, 5,0);
        tracep->declBit(c+47,"pe_flow_ctrl oxi this_ov", false,-1);
        tracep->declBit(c+48,"pe_flow_ctrl oxi reach_th", false,-1);
        tracep->declBit(c+107,"pe_flow_ctrl oxi clk", false,-1);
        tracep->declBit(c+108,"pe_flow_ctrl oxi reset", false,-1);
        tracep->declBus(c+7,"pe_flow_ctrl oxi cnt_rg", false,-1, 5,0);
    }
}

void Vpe_flow_ctrl::traceRegister(VerilatedVcd* tracep) {
    // Body
    {
        tracep->addFullCb(&traceFullTop0, __VlSymsp);
        tracep->addChgCb(&traceChgTop0, __VlSymsp);
        tracep->addCleanupCb(&traceCleanup, __VlSymsp);
    }
}

void Vpe_flow_ctrl::traceFullTop0(void* userp, VerilatedVcd* tracep) {
    Vpe_flow_ctrl__Syms* __restrict vlSymsp = static_cast<Vpe_flow_ctrl__Syms*>(userp);
    Vpe_flow_ctrl* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    {
        vlTOPp->traceFullSub0(userp, tracep);
    }
}

void Vpe_flow_ctrl::traceFullSub0(void* userp, VerilatedVcd* tracep) {
    Vpe_flow_ctrl__Syms* __restrict vlSymsp = static_cast<Vpe_flow_ctrl__Syms*>(userp);
    Vpe_flow_ctrl* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    vluint32_t* const oldp = tracep->oldp(vlSymsp->__Vm_baseCode);
    if (false && oldp) {}  // Prevent unused
    // Variables
    WData/*95:0*/ __Vtemp10[3];
    WData/*95:0*/ __Vtemp20[3];
    // Body
    {
        tracep->fullCData(oldp+1,(vlTOPp->pe_flow_ctrl__DOT__kz__DOT__cnt_rg),8);
        tracep->fullCData(oldp+2,(vlTOPp->pe_flow_ctrl__DOT__kzi__DOT__cnt_rg),4);
        tracep->fullCData(oldp+3,(vlTOPp->pe_flow_ctrl__DOT__hki__DOT__cnt_rg),8);
        tracep->fullCData(oldp+4,(vlTOPp->pe_flow_ctrl__DOT__wki__DOT__cnt_rg),8);
        tracep->fullCData(oldp+5,(vlTOPp->pe_flow_ctrl__DOT__ozi__DOT__cnt_rg),4);
        tracep->fullCData(oldp+6,(vlTOPp->pe_flow_ctrl__DOT__oyi__DOT__cnt_rg),6);
        tracep->fullCData(oldp+7,(vlTOPp->pe_flow_ctrl__DOT__oxi__DOT__cnt_rg),6);
        tracep->fullBit(oldp+8,(vlTOPp->pe_flow_ctrl__DOT__dofetch));
        tracep->fullBit(oldp+9,(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_back_en));
        tracep->fullCData(oldp+10,(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_waddr),7);
        tracep->fullCData(oldp+11,(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_raddr),7);
        tracep->fullBit(oldp+12,(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_wr));
        tracep->fullBit(oldp+13,(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_rd));
        tracep->fullBit(oldp+14,(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_allow_rd));
        tracep->fullBit(oldp+15,(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_pinA_bias_en));
        tracep->fullBit(oldp+16,(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_pinB_bias_en));
        tracep->fullBit(oldp+17,(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_byp_mul_en));
        tracep->fullBit(oldp+18,(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_maxpool_en));
        tracep->fullBit(oldp+19,(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_bias_mul_en));
        tracep->fullBit(oldp+20,(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_scale_en));
        tracep->fullBit(oldp+21,(vlTOPp->pe_flow_ctrl__DOT__ifscp_ctrl_rgs_if_rd));
        tracep->fullCData(oldp+22,(vlTOPp->pe_flow_ctrl__DOT__ifscp_ctrl_rgs_hw_addr),6);
        tracep->fullCData(oldp+23,(vlTOPp->pe_flow_ctrl__DOT__ifscp_ctrl_rgs_ich_addr),4);
        tracep->fullBit(oldp+24,(vlTOPp->pe_flow_ctrl__DOT__ifscp_ctrl_rgs_cast_mode));
        tracep->fullBit(oldp+25,(vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_we_rd));
        tracep->fullBit(oldp+26,(vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_bs_wr));
        tracep->fullBit(oldp+27,(vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_bs_rd));
        tracep->fullBit(oldp+28,(vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_sc_rd));
        tracep->fullCData(oldp+29,(vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_bs_byte_cnt),3);
        tracep->fullCData(oldp+30,(vlTOPp->pe_flow_ctrl__DOT__wescp_ctrl_rgs_och_gcnt),4);
        tracep->fullCData(oldp+31,(vlTOPp->pe_flow_ctrl__DOT__fsm_curr_state),2);
        if ((0U == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_curr_state))) {
            __Vtemp10[0U] = 0x20202020U;
            __Vtemp10[1U] = 0x444c4520U;
            __Vtemp10[2U] = 0x49U;
        } else {
            __Vtemp10[0U] = ((1U == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_curr_state))
                              ? 0x4e562020U : ((2U 
                                                == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_curr_state))
                                                ? 0x525f4f50U
                                                : 0x3f3f3f3fU));
            __Vtemp10[1U] = ((1U == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_curr_state))
                              ? 0x5542434fU : ((2U 
                                                == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_curr_state))
                                                ? 0x454e534fU
                                                : 0x3f3f3f3fU));
            __Vtemp10[2U] = ((1U == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_curr_state))
                              ? 0x53U : ((2U == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_curr_state))
                                          ? 0x54U : 0x3fU));
        }
        tracep->fullWData(oldp+32,(__Vtemp10),72);
        tracep->fullBit(oldp+35,(((IData)(vlTOPp->pe_flow_ctrl__DOT__kz_reach_th) 
                                  & (IData)(vlTOPp->pe_flow_ctrl__DOT__kzi_this_ov))));
        tracep->fullBit(oldp+36,(vlTOPp->pe_flow_ctrl__DOT__kz_reach_th));
        tracep->fullBit(oldp+37,(vlTOPp->pe_flow_ctrl__DOT__kzi_this_ov));
        tracep->fullBit(oldp+38,(vlTOPp->pe_flow_ctrl__DOT__kzi_reach_th));
        tracep->fullBit(oldp+39,(vlTOPp->pe_flow_ctrl__DOT__hki_this_ov));
        tracep->fullBit(oldp+40,(vlTOPp->pe_flow_ctrl__DOT__hki_reach_th));
        tracep->fullBit(oldp+41,(vlTOPp->pe_flow_ctrl__DOT__wki_this_ov));
        tracep->fullBit(oldp+42,(vlTOPp->pe_flow_ctrl__DOT__wki_reach_th));
        tracep->fullBit(oldp+43,(vlTOPp->pe_flow_ctrl__DOT__ozi_this_ov));
        tracep->fullBit(oldp+44,(vlTOPp->pe_flow_ctrl__DOT__ozi_reach_th));
        tracep->fullBit(oldp+45,(vlTOPp->pe_flow_ctrl__DOT__oyi_this_ov));
        tracep->fullBit(oldp+46,(vlTOPp->pe_flow_ctrl__DOT__oyi_reach_th));
        tracep->fullBit(oldp+47,(vlTOPp->pe_flow_ctrl__DOT__oxi_this_ov));
        tracep->fullBit(oldp+48,(vlTOPp->pe_flow_ctrl__DOT__oxi_reach_th));
        tracep->fullBit(oldp+49,(vlTOPp->pe_flow_ctrl__DOT__ps_raddr_ov));
        tracep->fullBit(oldp+50,(((((IData)(vlTOPp->pe_flow_ctrl__DOT__kzi_reach_th) 
                                    & (IData)(vlTOPp->pe_flow_ctrl__DOT__kz_reach_th)) 
                                   & (IData)(vlTOPp->pe_flow_ctrl__DOT__hki_reach_th)) 
                                  & (IData)(vlTOPp->pe_flow_ctrl__DOT__wki_reach_th))));
        tracep->fullCData(oldp+51,(vlTOPp->pe_flow_ctrl__DOT__fsm_next_state),2);
        if ((0U == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_next_state))) {
            __Vtemp20[0U] = 0x20202020U;
            __Vtemp20[1U] = 0x444c4520U;
            __Vtemp20[2U] = 0x49U;
        } else {
            __Vtemp20[0U] = ((1U == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_next_state))
                              ? 0x4e562020U : ((2U 
                                                == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_next_state))
                                                ? 0x525f4f50U
                                                : 0x3f3f3f3fU));
            __Vtemp20[1U] = ((1U == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_next_state))
                              ? 0x5542434fU : ((2U 
                                                == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_next_state))
                                                ? 0x454e534fU
                                                : 0x3f3f3f3fU));
            __Vtemp20[2U] = ((1U == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_next_state))
                              ? 0x53U : ((2U == (IData)(vlTOPp->pe_flow_ctrl__DOT__fsm_next_state))
                                          ? 0x54U : 0x3fU));
        }
        tracep->fullWData(oldp+52,(__Vtemp20),72);
        tracep->fullBit(oldp+55,(vlTOPp->start_conv));
        tracep->fullCData(oldp+56,(vlTOPp->rg_para_yhat),6);
        tracep->fullCData(oldp+57,(vlTOPp->rg_para_xhat),6);
        tracep->fullCData(oldp+58,(vlTOPp->rg_para_y),6);
        tracep->fullCData(oldp+59,(vlTOPp->rg_para_x),6);
        tracep->fullCData(oldp+60,(vlTOPp->rg_para_Hk),8);
        tracep->fullCData(oldp+61,(vlTOPp->rg_para_Wk),8);
        tracep->fullCData(oldp+62,(vlTOPp->rg_para_Ho),8);
        tracep->fullCData(oldp+63,(vlTOPp->rg_para_Wo),8);
        tracep->fullCData(oldp+64,(vlTOPp->rg_para_Hi),8);
        tracep->fullCData(oldp+65,(vlTOPp->rg_para_Wi),8);
        tracep->fullCData(oldp+66,(vlTOPp->rg_para_Co),8);
        tracep->fullCData(oldp+67,(vlTOPp->rg_para_Ci),8);
        tracep->fullCData(oldp+68,(vlTOPp->rg_para_sh),4);
        tracep->fullCData(oldp+69,(vlTOPp->rg_para_sw),4);
        tracep->fullCData(oldp+70,(vlTOPp->rg_para_ph),4);
        tracep->fullCData(oldp+71,(vlTOPp->rg_para_pw),4);
        tracep->fullCData(oldp+72,(vlTOPp->rg_para_dh),4);
        tracep->fullCData(oldp+73,(vlTOPp->rg_para_dw),4);
        tracep->fullCData(oldp+74,(vlTOPp->rg_para_zs),4);
        tracep->fullCData(oldp+75,(vlTOPp->rg_para_zp),4);
        tracep->fullCData(oldp+76,(vlTOPp->rg_para_k),4);
        tracep->fullCData(oldp+77,(vlTOPp->rg_para_shxhat),6);
        tracep->fullCData(oldp+78,(vlTOPp->rg_para_xyzs),7);
        tracep->fullBit(oldp+79,(vlTOPp->rg_ctrl_bias_en));
        tracep->fullBit(oldp+80,(vlTOPp->rg_ctrl_scale_en));
        tracep->fullBit(oldp+81,(vlTOPp->rg_ctrl_tensor_op_en));
        tracep->fullBit(oldp+82,(vlTOPp->pe_ctrl_ps_back_en));
        tracep->fullCData(oldp+83,(vlTOPp->pe_ctrl_ps_waddr),7);
        tracep->fullCData(oldp+84,(vlTOPp->pe_ctrl_ps_raddr),7);
        tracep->fullBit(oldp+85,(vlTOPp->pe_ctrl_ps_wr));
        tracep->fullBit(oldp+86,(vlTOPp->pe_ctrl_ps_rd));
        tracep->fullBit(oldp+87,(vlTOPp->pe_ctrl_ps_allow_rd));
        tracep->fullBit(oldp+88,(vlTOPp->pe_ctrl_ps_pinA_bias_en));
        tracep->fullBit(oldp+89,(vlTOPp->pe_ctrl_ps_pinB_bias_en));
        tracep->fullBit(oldp+90,(vlTOPp->pe_ctrl_byp_mul_en));
        tracep->fullBit(oldp+91,(vlTOPp->pe_ctrl_maxpool_en));
        tracep->fullBit(oldp+92,(vlTOPp->pe_ctrl_bias_mul_en));
        tracep->fullBit(oldp+93,(vlTOPp->pe_ctrl_ps_scale_en));
        tracep->fullBit(oldp+94,(vlTOPp->ifscp_ctrl_if_rd));
        tracep->fullCData(oldp+95,(vlTOPp->ifscp_ctrl_hw_addr),6);
        tracep->fullCData(oldp+96,(vlTOPp->ifscp_ctrl_ich_addr),4);
        tracep->fullBit(oldp+97,(vlTOPp->ifscp_ctrl_cast_mode));
        tracep->fullBit(oldp+98,(vlTOPp->wescp_ctrl_we_rd));
        tracep->fullBit(oldp+99,(vlTOPp->wescp_ctrl_bs_wr));
        tracep->fullBit(oldp+100,(vlTOPp->wescp_ctrl_bs_rd));
        tracep->fullBit(oldp+101,(vlTOPp->wescp_ctrl_sc_rd));
        tracep->fullCData(oldp+102,(vlTOPp->wescp_ctrl_bs_byte_cnt),3);
        tracep->fullCData(oldp+103,(vlTOPp->wescp_ctrl_och_gcnt),4);
        tracep->fullBit(oldp+104,(vlTOPp->pe_flags_ps_rd_ready));
        tracep->fullBit(oldp+105,(vlTOPp->pe_flags_ps_wr_ready));
        tracep->fullBit(oldp+106,(vlTOPp->subconv_finish));
        tracep->fullBit(oldp+107,(vlTOPp->clk));
        tracep->fullBit(oldp+108,(vlTOPp->reset));
        tracep->fullCData(oldp+109,(vlTOPp->rg_para_k),8);
        tracep->fullBit(oldp+110,(((IData)(vlTOPp->pe_flow_ctrl__DOT__pe_ctrl_rgs_ps_waddr) 
                                   == (IData)(vlTOPp->rg_para_xyzs))));
        tracep->fullCData(oldp+111,(0U),2);
        tracep->fullCData(oldp+112,(1U),2);
        tracep->fullCData(oldp+113,(2U),2);
        tracep->fullBit(oldp+114,(0U));
        tracep->fullCData(oldp+115,(1U),4);
        tracep->fullCData(oldp+116,(1U),8);
        tracep->fullCData(oldp+117,(1U),6);
    }
}
