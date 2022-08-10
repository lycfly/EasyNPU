// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Primary model header
//
// This header should be included by all source files instantiating the design.
// The class here is then constructed to instantiate the design.
// See the Verilator manual for examples.

#ifndef VERILATED_VPE_FLOW_CTRL_H_
#define VERILATED_VPE_FLOW_CTRL_H_  // guard

#include "verilated.h"

class Vpe_flow_ctrl__Syms;
class Vpe_flow_ctrl___024root;
class VerilatedFstC;

// This class is the main interface to the Verilated model
class Vpe_flow_ctrl VL_NOT_FINAL {
  private:
    // Symbol table holding complete model state (owned by this class)
    Vpe_flow_ctrl__Syms* const vlSymsp;

  public:

    // PORTS
    // The application code writes and reads these signals to
    // propagate new values into/out from the Verilated model.
    VL_IN8(&clk,0,0);
    VL_IN8(&reset,0,0);
    VL_IN8(&start_conv,0,0);
    VL_IN8(&rg_para_yhat,5,0);
    VL_IN8(&rg_para_xhat,5,0);
    VL_IN8(&rg_para_y,5,0);
    VL_IN8(&rg_para_x,5,0);
    VL_IN8(&rg_para_z,7,0);
    VL_IN8(&rg_para_Hk,7,0);
    VL_IN8(&rg_para_Wk,7,0);
    VL_IN8(&rg_para_Ho,7,0);
    VL_IN8(&rg_para_Wo,7,0);
    VL_IN8(&rg_para_Hi,7,0);
    VL_IN8(&rg_para_Wi,7,0);
    VL_IN8(&rg_para_Co,7,0);
    VL_IN8(&rg_para_Ci,7,0);
    VL_IN8(&rg_para_sh,3,0);
    VL_IN8(&rg_para_sw,3,0);
    VL_IN8(&rg_para_ph,3,0);
    VL_IN8(&rg_para_pw,3,0);
    VL_IN8(&rg_para_dh,3,0);
    VL_IN8(&rg_para_dw,3,0);
    VL_IN8(&rg_para_zs,3,0);
    VL_IN8(&rg_para_zp,3,0);
    VL_IN8(&rg_para_k,3,0);
    VL_IN8(&rg_para_shxhat,5,0);
    VL_IN8(&rg_para_xyzs,6,0);
    VL_IN8(&rg_ctrl_bias_en,0,0);
    VL_IN8(&rg_ctrl_scale_en,0,0);
    VL_IN8(&rg_ctrl_tensor_op_en,0,0);
    VL_OUT8(&pe_ctrl_ps_back_en,0,0);
    VL_OUT8(&pe_ctrl_ps_waddr,6,0);
    VL_OUT8(&pe_ctrl_ps_raddr,6,0);
    VL_OUT8(&pe_ctrl_ps_wr,0,0);
    VL_OUT8(&pe_ctrl_ps_rd,0,0);
    VL_OUT8(&pe_ctrl_ps_allow_rd,0,0);
    VL_OUT8(&pe_ctrl_ps_pinA_bias_en,0,0);
    VL_OUT8(&pe_ctrl_ps_pinB_bias_en,0,0);
    VL_OUT8(&pe_ctrl_byp_mul_en,0,0);
    VL_OUT8(&pe_ctrl_maxpool_en,0,0);
    VL_OUT8(&pe_ctrl_bias_mul_en,0,0);
    VL_OUT8(&pe_ctrl_ps_scale_en,0,0);
    VL_OUT8(&ifscp_ctrl_if_rd,0,0);
    VL_OUT8(&ifscp_ctrl_hw_addr,5,0);
    VL_OUT8(&ifscp_ctrl_ich_addr,3,0);
    VL_OUT8(&ifscp_ctrl_cast_mode,0,0);
    VL_OUT8(&wescp_ctrl_we_rd,0,0);
    VL_OUT8(&wescp_ctrl_bs_wr,0,0);
    VL_OUT8(&wescp_ctrl_bs_rd,0,0);
    VL_OUT8(&wescp_ctrl_sc_rd,0,0);
    VL_OUT8(&wescp_ctrl_bs_byte_cnt,2,0);
    VL_OUT8(&wescp_ctrl_och_gcnt,3,0);
    VL_IN8(&pe_flags_ps_rd_ready,0,0);
    VL_IN8(&pe_flags_ps_wr_ready,0,0);
    VL_OUT8(&subconv_finish,0,0);

    // CELLS
    // Public to allow access to /* verilator public */ items.
    // Otherwise the application code can consider these internals.

    // Root instance pointer to allow access to model internals,
    // including inlined /* verilator public_flat_* */ items.
    Vpe_flow_ctrl___024root* const rootp;

    // CONSTRUCTORS
    /// Construct the model; called by application code
    /// If contextp is null, then the model will use the default global context
    /// If name is "", then makes a wrapper with a
    /// single model invisible with respect to DPI scope names.
    explicit Vpe_flow_ctrl(VerilatedContext* contextp, const char* name = "TOP");
    explicit Vpe_flow_ctrl(const char* name = "TOP");
    /// Destroy the model; called (often implicitly) by application code
    virtual ~Vpe_flow_ctrl();
  private:
    VL_UNCOPYABLE(Vpe_flow_ctrl);  ///< Copying not allowed

  public:
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
    /// Trace signals in the model; called by application code
    void trace(VerilatedFstC* tfp, int levels, int options = 0);
    /// Return current simulation context for this model.
    /// Used to get to e.g. simulation time via contextp()->time()
    VerilatedContext* contextp() const;
    /// Retrieve name of this model instance (as passed to constructor).
    const char* name() const;
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

#endif  // guard
