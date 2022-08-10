// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vpe_flow_ctrl.h"
#include "Vpe_flow_ctrl__Syms.h"
#include "verilated_fst_c.h"

//============================================================
// Constructors

Vpe_flow_ctrl::Vpe_flow_ctrl(VerilatedContext* _vcontextp__, const char* _vcname__)
    : vlSymsp{new Vpe_flow_ctrl__Syms(_vcontextp__, _vcname__, this)}
    , clk{vlSymsp->TOP.clk}
    , reset{vlSymsp->TOP.reset}
    , start_conv{vlSymsp->TOP.start_conv}
    , rg_para_yhat{vlSymsp->TOP.rg_para_yhat}
    , rg_para_xhat{vlSymsp->TOP.rg_para_xhat}
    , rg_para_y{vlSymsp->TOP.rg_para_y}
    , rg_para_x{vlSymsp->TOP.rg_para_x}
    , rg_para_z{vlSymsp->TOP.rg_para_z}
    , rg_para_Hk{vlSymsp->TOP.rg_para_Hk}
    , rg_para_Wk{vlSymsp->TOP.rg_para_Wk}
    , rg_para_Ho{vlSymsp->TOP.rg_para_Ho}
    , rg_para_Wo{vlSymsp->TOP.rg_para_Wo}
    , rg_para_Hi{vlSymsp->TOP.rg_para_Hi}
    , rg_para_Wi{vlSymsp->TOP.rg_para_Wi}
    , rg_para_Co{vlSymsp->TOP.rg_para_Co}
    , rg_para_Ci{vlSymsp->TOP.rg_para_Ci}
    , rg_para_sh{vlSymsp->TOP.rg_para_sh}
    , rg_para_sw{vlSymsp->TOP.rg_para_sw}
    , rg_para_ph{vlSymsp->TOP.rg_para_ph}
    , rg_para_pw{vlSymsp->TOP.rg_para_pw}
    , rg_para_dh{vlSymsp->TOP.rg_para_dh}
    , rg_para_dw{vlSymsp->TOP.rg_para_dw}
    , rg_para_zs{vlSymsp->TOP.rg_para_zs}
    , rg_para_zp{vlSymsp->TOP.rg_para_zp}
    , rg_para_k{vlSymsp->TOP.rg_para_k}
    , rg_para_shxhat{vlSymsp->TOP.rg_para_shxhat}
    , rg_para_xyzs{vlSymsp->TOP.rg_para_xyzs}
    , rg_ctrl_bias_en{vlSymsp->TOP.rg_ctrl_bias_en}
    , rg_ctrl_scale_en{vlSymsp->TOP.rg_ctrl_scale_en}
    , rg_ctrl_tensor_op_en{vlSymsp->TOP.rg_ctrl_tensor_op_en}
    , pe_ctrl_ps_back_en{vlSymsp->TOP.pe_ctrl_ps_back_en}
    , pe_ctrl_ps_waddr{vlSymsp->TOP.pe_ctrl_ps_waddr}
    , pe_ctrl_ps_raddr{vlSymsp->TOP.pe_ctrl_ps_raddr}
    , pe_ctrl_ps_wr{vlSymsp->TOP.pe_ctrl_ps_wr}
    , pe_ctrl_ps_rd{vlSymsp->TOP.pe_ctrl_ps_rd}
    , pe_ctrl_ps_allow_rd{vlSymsp->TOP.pe_ctrl_ps_allow_rd}
    , pe_ctrl_ps_pinA_bias_en{vlSymsp->TOP.pe_ctrl_ps_pinA_bias_en}
    , pe_ctrl_ps_pinB_bias_en{vlSymsp->TOP.pe_ctrl_ps_pinB_bias_en}
    , pe_ctrl_byp_mul_en{vlSymsp->TOP.pe_ctrl_byp_mul_en}
    , pe_ctrl_maxpool_en{vlSymsp->TOP.pe_ctrl_maxpool_en}
    , pe_ctrl_bias_mul_en{vlSymsp->TOP.pe_ctrl_bias_mul_en}
    , pe_ctrl_ps_scale_en{vlSymsp->TOP.pe_ctrl_ps_scale_en}
    , ifscp_ctrl_if_rd{vlSymsp->TOP.ifscp_ctrl_if_rd}
    , ifscp_ctrl_hw_addr{vlSymsp->TOP.ifscp_ctrl_hw_addr}
    , ifscp_ctrl_ich_addr{vlSymsp->TOP.ifscp_ctrl_ich_addr}
    , ifscp_ctrl_cast_mode{vlSymsp->TOP.ifscp_ctrl_cast_mode}
    , wescp_ctrl_we_rd{vlSymsp->TOP.wescp_ctrl_we_rd}
    , wescp_ctrl_bs_wr{vlSymsp->TOP.wescp_ctrl_bs_wr}
    , wescp_ctrl_bs_rd{vlSymsp->TOP.wescp_ctrl_bs_rd}
    , wescp_ctrl_sc_rd{vlSymsp->TOP.wescp_ctrl_sc_rd}
    , wescp_ctrl_bs_byte_cnt{vlSymsp->TOP.wescp_ctrl_bs_byte_cnt}
    , wescp_ctrl_och_gcnt{vlSymsp->TOP.wescp_ctrl_och_gcnt}
    , pe_flags_ps_rd_ready{vlSymsp->TOP.pe_flags_ps_rd_ready}
    , pe_flags_ps_wr_ready{vlSymsp->TOP.pe_flags_ps_wr_ready}
    , subconv_finish{vlSymsp->TOP.subconv_finish}
    , rootp{&(vlSymsp->TOP)}
{
}

Vpe_flow_ctrl::Vpe_flow_ctrl(const char* _vcname__)
    : Vpe_flow_ctrl(nullptr, _vcname__)
{
}

//============================================================
// Destructor

Vpe_flow_ctrl::~Vpe_flow_ctrl() {
    delete vlSymsp;
}

//============================================================
// Evaluation loop

void Vpe_flow_ctrl___024root___eval_initial(Vpe_flow_ctrl___024root* vlSelf);
void Vpe_flow_ctrl___024root___eval_settle(Vpe_flow_ctrl___024root* vlSelf);
void Vpe_flow_ctrl___024root___eval(Vpe_flow_ctrl___024root* vlSelf);
#ifdef VL_DEBUG
void Vpe_flow_ctrl___024root___eval_debug_assertions(Vpe_flow_ctrl___024root* vlSelf);
#endif  // VL_DEBUG
void Vpe_flow_ctrl___024root___final(Vpe_flow_ctrl___024root* vlSelf);

static void _eval_initial_loop(Vpe_flow_ctrl__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    Vpe_flow_ctrl___024root___eval_initial(&(vlSymsp->TOP));
    // Evaluate till stable
    vlSymsp->__Vm_activity = true;
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial loop\n"););
        Vpe_flow_ctrl___024root___eval_settle(&(vlSymsp->TOP));
        Vpe_flow_ctrl___024root___eval(&(vlSymsp->TOP));
    } while (0);
}

void Vpe_flow_ctrl::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vpe_flow_ctrl::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vpe_flow_ctrl___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // Evaluate till stable
    vlSymsp->__Vm_activity = true;
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Clock loop\n"););
        Vpe_flow_ctrl___024root___eval(&(vlSymsp->TOP));
    } while (0);
    // Evaluate cleanup
}

//============================================================
// Utilities

VerilatedContext* Vpe_flow_ctrl::contextp() const {
    return vlSymsp->_vm_contextp__;
}

const char* Vpe_flow_ctrl::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

VL_ATTR_COLD void Vpe_flow_ctrl::final() {
    Vpe_flow_ctrl___024root___final(&(vlSymsp->TOP));
}

//============================================================
// Trace configuration

void Vpe_flow_ctrl___024root__trace_init_top(Vpe_flow_ctrl___024root* vlSelf, VerilatedFst* tracep);

VL_ATTR_COLD static void trace_init(void* voidSelf, VerilatedFst* tracep, uint32_t code) {
    // Callback from tracep->open()
    Vpe_flow_ctrl___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vpe_flow_ctrl___024root*>(voidSelf);
    Vpe_flow_ctrl__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (!vlSymsp->_vm_contextp__->calcUnusedSigs()) {
        VL_FATAL_MT(__FILE__, __LINE__, __FILE__,
            "Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vlSymsp->__Vm_baseCode = code;
    tracep->scopeEscape(' ');
    tracep->pushNamePrefix(std::string{vlSymsp->name()} + ' ');
    Vpe_flow_ctrl___024root__trace_init_top(vlSelf, tracep);
    tracep->popNamePrefix();
    tracep->scopeEscape('.');
}

VL_ATTR_COLD void Vpe_flow_ctrl___024root__trace_register(Vpe_flow_ctrl___024root* vlSelf, VerilatedFst* tracep);

VL_ATTR_COLD void Vpe_flow_ctrl::trace(VerilatedFstC* tfp, int levels, int options) {
    if (false && levels && options) {}  // Prevent unused
    tfp->spTrace()->addInitCb(&trace_init, &(vlSymsp->TOP));
    Vpe_flow_ctrl___024root__trace_register(&(vlSymsp->TOP), tfp->spTrace());
}
