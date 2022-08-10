// Generator : SpinalHDL v1.7.1    git head : 0444bb76ab1d6e19f0ec46bc03c4769776deb7d5
// Component : pe_flow_ctrl
// Git hash  : 598278383b4999ed4d26d5a8ecd7912b879da931

`timescale 1ns/1ps

module pe_flow_ctrl (
  input               start_conv,
  input      [5:0]    rg_para_yhat,
  input      [5:0]    rg_para_xhat,
  input      [5:0]    rg_para_y,
  input      [5:0]    rg_para_x,
  input      [7:0]    rg_para_z,
  input      [7:0]    rg_para_Hk,
  input      [7:0]    rg_para_Wk,
  input      [7:0]    rg_para_Ho,
  input      [7:0]    rg_para_Wo,
  input      [7:0]    rg_para_Hi,
  input      [7:0]    rg_para_Wi,
  input      [7:0]    rg_para_Co,
  input      [7:0]    rg_para_Ci,
  input      [3:0]    rg_para_sh,
  input      [3:0]    rg_para_sw,
  input      [3:0]    rg_para_ph,
  input      [3:0]    rg_para_pw,
  input      [3:0]    rg_para_dh,
  input      [3:0]    rg_para_dw,
  input      [3:0]    rg_para_zs,
  input      [3:0]    rg_para_zp,
  input      [3:0]    rg_para_k,
  input      [5:0]    rg_para_shxhat,
  input      [6:0]    rg_para_xyzs,
  input               rg_ctrl_bias_en,
  input               rg_ctrl_scale_en,
  input               rg_ctrl_tensor_op_en,
  output              pe_ctrl_ps_back_en,
  output     [6:0]    pe_ctrl_ps_waddr,
  output     [6:0]    pe_ctrl_ps_raddr,
  output              pe_ctrl_ps_wr,
  output              pe_ctrl_ps_rd,
  output              pe_ctrl_ps_allow_rd,
  output              pe_ctrl_ps_pinA_bias_en,
  output              pe_ctrl_ps_pinB_bias_en,
  output              pe_ctrl_byp_mul_en,
  output              pe_ctrl_maxpool_en,
  output              pe_ctrl_bias_mul_en,
  output              pe_ctrl_ps_scale_en,
  output              ifscp_ctrl_if_rd,
  output     [5:0]    ifscp_ctrl_hw_addr,
  output     [3:0]    ifscp_ctrl_ich_addr,
  output              ifscp_ctrl_cast_mode,
  output              wescp_ctrl_we_rd,
  output              wescp_ctrl_bs_wr,
  output              wescp_ctrl_bs_rd,
  output              wescp_ctrl_sc_rd,
  output     [2:0]    wescp_ctrl_bs_byte_cnt,
  output     [3:0]    wescp_ctrl_och_gcnt,
  input               pe_flags_ps_rd_ready,
  input               pe_flags_ps_wr_ready,
  output              subconv_finish,
  input               clk,
  input               reset
);
  localparam fsm_enumDef_IDLE = 2'd0;
  localparam fsm_enumDef_SUBCONV = 2'd1;
  localparam fsm_enumDef_TENSOR_OP = 2'd2;

  wire       [8:0]    kz_step;
  wire       [7:0]    kz_cnt;
  wire       [8:0]    kz_nxt_cnt;
  wire                kz_this_ov;
  wire                kz_reach_th;
  wire                kz_isInitial;
  wire       [3:0]    kzi_cnt;
  wire       [4:0]    kzi_nxt_cnt;
  wire                kzi_this_ov;
  wire                kzi_reach_th;
  wire                kzi_isInitial;
  wire       [7:0]    hki_cnt;
  wire       [8:0]    hki_nxt_cnt;
  wire                hki_this_ov;
  wire                hki_reach_th;
  wire                hki_isInitial;
  wire       [7:0]    wki_cnt;
  wire       [8:0]    wki_nxt_cnt;
  wire                wki_this_ov;
  wire                wki_reach_th;
  wire                wki_isInitial;
  wire       [5:0]    oyi_cnt;
  wire       [6:0]    oyi_nxt_cnt;
  wire                oyi_this_ov;
  wire                oyi_reach_th;
  wire                oyi_isInitial;
  wire       [5:0]    oxi_cnt;
  wire       [6:0]    oxi_nxt_cnt;
  wire                oxi_this_ov;
  wire                oxi_reach_th;
  wire                oxi_isInitial;
  wire       [3:0]    ozi_cnt;
  wire       [4:0]    ozi_nxt_cnt;
  wire                ozi_this_ov;
  wire                ozi_reach_th;
  wire                ozi_isInitial;
  wire       [3:0]    _zz_step;
  wire       [5:0]    _zz_ifscp_ctrl_rgs_hw_addr;
  wire       [5:0]    _zz_ifscp_ctrl_rgs_hw_addr_1;
  reg                 dofetch;
  wire                kz_sigs_inc;
  wire                kz_sigs_this_ov;
  wire                kz_sigs_reach_th;
  wire                kz_sigs_isInitial;
  wire                hki_sigs_inc;
  wire                hki_sigs_this_ov;
  wire                hki_sigs_reach_th;
  wire                hki_sigs_isInitial;
  wire                wki_sigs_inc;
  wire                wki_sigs_this_ov;
  wire                wki_sigs_reach_th;
  wire                wki_sigs_isInitial;
  wire                kzi_sigs_inc;
  wire                kzi_sigs_this_ov;
  wire                kzi_sigs_reach_th;
  wire                kzi_sigs_isInitial;
  wire                ozi_sigs_inc;
  wire                ozi_sigs_this_ov;
  wire                ozi_sigs_reach_th;
  wire                ozi_sigs_isInitial;
  wire                oyi_sigs_inc;
  wire                oyi_sigs_this_ov;
  wire                oyi_sigs_reach_th;
  wire                oyi_sigs_isInitial;
  wire                oxi_sigs_inc;
  wire                oxi_sigs_this_ov;
  wire                oxi_sigs_reach_th;
  wire                oxi_sigs_isInitial;
  reg                 pe_ctrl_rgs_ps_back_en;
  reg        [6:0]    pe_ctrl_rgs_ps_waddr;
  reg        [6:0]    pe_ctrl_rgs_ps_raddr;
  reg                 pe_ctrl_rgs_ps_wr;
  reg                 pe_ctrl_rgs_ps_rd;
  reg                 pe_ctrl_rgs_ps_allow_rd;
  reg                 pe_ctrl_rgs_ps_pinA_bias_en;
  reg                 pe_ctrl_rgs_ps_pinB_bias_en;
  reg                 pe_ctrl_rgs_byp_mul_en;
  reg                 pe_ctrl_rgs_maxpool_en;
  reg                 pe_ctrl_rgs_bias_mul_en;
  reg                 pe_ctrl_rgs_ps_scale_en;
  reg                 ifscp_ctrl_rgs_if_rd;
  reg        [5:0]    ifscp_ctrl_rgs_hw_addr;
  reg        [3:0]    ifscp_ctrl_rgs_ich_addr;
  reg                 ifscp_ctrl_rgs_cast_mode;
  reg                 wescp_ctrl_rgs_we_rd;
  reg                 wescp_ctrl_rgs_bs_wr;
  reg                 wescp_ctrl_rgs_bs_rd;
  reg                 wescp_ctrl_rgs_sc_rd;
  reg        [2:0]    wescp_ctrl_rgs_bs_byte_cnt;
  reg        [3:0]    wescp_ctrl_rgs_och_gcnt;
  wire                ps_raddr_ov;
  wire                ps_waddr_ov;
  wire                ofmap_out_ready_flag;
  wire                fsm_wantExit;
  wire                fsm_wantStart;
  wire                fsm_wantKill;
  reg        [1:0]    fsm_curr_state;
  reg        [1:0]    fsm_next_state;
  `ifndef SYNTHESIS
  reg [71:0] fsm_curr_state_string;
  reg [71:0] fsm_next_state_string;
  `endif


  assign _zz_step = (rg_para_k + 4'b0001);
  assign _zz_ifscp_ctrl_rgs_hw_addr = (rg_para_shxhat + 6'h01);
  assign _zz_ifscp_ctrl_rgs_hw_addr_1 = {2'd0, rg_para_sw};
  counter kz (
    .step      (kz_step[8:0]   ), //i
    .threshold (rg_para_Ci[7:0]), //i
    .inc_en    (kz_sigs_inc    ), //i
    .cnt       (kz_cnt[7:0]    ), //o
    .nxt_cnt   (kz_nxt_cnt[8:0]), //o
    .this_ov   (kz_this_ov     ), //o
    .reach_th  (kz_reach_th    ), //o
    .isInitial (kz_isInitial   ), //o
    .clk       (clk            ), //i
    .reset     (reset          )  //i
  );
  counter_1 kzi (
    .step      (5'h01           ), //i
    .threshold (rg_para_k[3:0]  ), //i
    .inc_en    (kzi_sigs_inc    ), //i
    .cnt       (kzi_cnt[3:0]    ), //o
    .nxt_cnt   (kzi_nxt_cnt[4:0]), //o
    .this_ov   (kzi_this_ov     ), //o
    .reach_th  (kzi_reach_th    ), //o
    .isInitial (kzi_isInitial   ), //o
    .clk       (clk             ), //i
    .reset     (reset           )  //i
  );
  counter hki (
    .step      (9'h001          ), //i
    .threshold (rg_para_Hk[7:0] ), //i
    .inc_en    (hki_sigs_inc    ), //i
    .cnt       (hki_cnt[7:0]    ), //o
    .nxt_cnt   (hki_nxt_cnt[8:0]), //o
    .this_ov   (hki_this_ov     ), //o
    .reach_th  (hki_reach_th    ), //o
    .isInitial (hki_isInitial   ), //o
    .clk       (clk             ), //i
    .reset     (reset           )  //i
  );
  counter wki (
    .step      (9'h001          ), //i
    .threshold (rg_para_Wk[7:0] ), //i
    .inc_en    (wki_sigs_inc    ), //i
    .cnt       (wki_cnt[7:0]    ), //o
    .nxt_cnt   (wki_nxt_cnt[8:0]), //o
    .this_ov   (wki_this_ov     ), //o
    .reach_th  (wki_reach_th    ), //o
    .isInitial (wki_isInitial   ), //o
    .clk       (clk             ), //i
    .reset     (reset           )  //i
  );
  counter_4 oyi (
    .step      (7'h01            ), //i
    .threshold (rg_para_yhat[5:0]), //i
    .inc_en    (oyi_sigs_inc     ), //i
    .cnt       (oyi_cnt[5:0]     ), //o
    .nxt_cnt   (oyi_nxt_cnt[6:0] ), //o
    .this_ov   (oyi_this_ov      ), //o
    .reach_th  (oyi_reach_th     ), //o
    .isInitial (oyi_isInitial    ), //o
    .clk       (clk              ), //i
    .reset     (reset            )  //i
  );
  counter_4 oxi (
    .step      (7'h01            ), //i
    .threshold (rg_para_xhat[5:0]), //i
    .inc_en    (oxi_sigs_inc     ), //i
    .cnt       (oxi_cnt[5:0]     ), //o
    .nxt_cnt   (oxi_nxt_cnt[6:0] ), //o
    .this_ov   (oxi_this_ov      ), //o
    .reach_th  (oxi_reach_th     ), //o
    .isInitial (oxi_isInitial    ), //o
    .clk       (clk              ), //i
    .reset     (reset            )  //i
  );
  counter_1 ozi (
    .step      (5'h01           ), //i
    .threshold (rg_para_zs[3:0] ), //i
    .inc_en    (ozi_sigs_inc    ), //i
    .cnt       (ozi_cnt[3:0]    ), //o
    .nxt_cnt   (ozi_nxt_cnt[4:0]), //o
    .this_ov   (ozi_this_ov     ), //o
    .reach_th  (ozi_reach_th    ), //o
    .isInitial (ozi_isInitial   ), //o
    .clk       (clk             ), //i
    .reset     (reset           )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(fsm_curr_state)
      fsm_enumDef_IDLE : fsm_curr_state_string = "IDLE     ";
      fsm_enumDef_SUBCONV : fsm_curr_state_string = "SUBCONV  ";
      fsm_enumDef_TENSOR_OP : fsm_curr_state_string = "TENSOR_OP";
      default : fsm_curr_state_string = "?????????";
    endcase
  end
  always @(*) begin
    case(fsm_next_state)
      fsm_enumDef_IDLE : fsm_next_state_string = "IDLE     ";
      fsm_enumDef_SUBCONV : fsm_next_state_string = "SUBCONV  ";
      fsm_enumDef_TENSOR_OP : fsm_next_state_string = "TENSOR_OP";
      default : fsm_next_state_string = "?????????";
    endcase
  end
  `endif

  assign kz_sigs_inc = kzi_sigs_this_ov;
  assign kzi_sigs_inc = hki_sigs_this_ov;
  assign hki_sigs_inc = wki_sigs_this_ov;
  assign wki_sigs_inc = oyi_sigs_this_ov;
  assign oyi_sigs_inc = oxi_sigs_this_ov;
  assign oxi_sigs_inc = ozi_sigs_this_ov;
  assign ozi_sigs_inc = dofetch;
  assign kz_step = {5'd0, _zz_step};
  assign kz_sigs_this_ov = kz_this_ov;
  assign kz_sigs_reach_th = kz_reach_th;
  assign kz_sigs_isInitial = kz_isInitial;
  assign kzi_sigs_this_ov = kzi_this_ov;
  assign kzi_sigs_reach_th = kzi_reach_th;
  assign kzi_sigs_isInitial = kzi_isInitial;
  assign hki_sigs_this_ov = hki_this_ov;
  assign hki_sigs_reach_th = hki_reach_th;
  assign hki_sigs_isInitial = hki_isInitial;
  assign wki_sigs_this_ov = wki_this_ov;
  assign wki_sigs_reach_th = wki_reach_th;
  assign wki_sigs_isInitial = wki_isInitial;
  assign oyi_sigs_this_ov = oyi_this_ov;
  assign oyi_sigs_reach_th = oyi_reach_th;
  assign oyi_sigs_isInitial = oyi_isInitial;
  assign oxi_sigs_this_ov = oxi_this_ov;
  assign oxi_sigs_reach_th = oxi_reach_th;
  assign oxi_sigs_isInitial = oxi_isInitial;
  assign ozi_sigs_this_ov = ozi_this_ov;
  assign ozi_sigs_reach_th = ozi_reach_th;
  assign ozi_sigs_isInitial = ozi_isInitial;
  assign pe_ctrl_ps_back_en = pe_ctrl_rgs_ps_back_en;
  assign pe_ctrl_ps_waddr = pe_ctrl_rgs_ps_waddr;
  assign pe_ctrl_ps_raddr = pe_ctrl_rgs_ps_raddr;
  assign pe_ctrl_ps_wr = pe_ctrl_rgs_ps_wr;
  assign pe_ctrl_ps_rd = pe_ctrl_rgs_ps_rd;
  assign pe_ctrl_ps_allow_rd = pe_ctrl_rgs_ps_allow_rd;
  assign pe_ctrl_ps_pinA_bias_en = pe_ctrl_rgs_ps_pinA_bias_en;
  assign pe_ctrl_ps_pinB_bias_en = pe_ctrl_rgs_ps_pinB_bias_en;
  assign pe_ctrl_byp_mul_en = pe_ctrl_rgs_byp_mul_en;
  assign pe_ctrl_maxpool_en = pe_ctrl_rgs_maxpool_en;
  assign pe_ctrl_bias_mul_en = pe_ctrl_rgs_bias_mul_en;
  assign pe_ctrl_ps_scale_en = pe_ctrl_rgs_ps_scale_en;
  assign ifscp_ctrl_if_rd = ifscp_ctrl_rgs_if_rd;
  assign ifscp_ctrl_hw_addr = ifscp_ctrl_rgs_hw_addr;
  assign ifscp_ctrl_ich_addr = ifscp_ctrl_rgs_ich_addr;
  assign ifscp_ctrl_cast_mode = ifscp_ctrl_rgs_cast_mode;
  assign wescp_ctrl_we_rd = wescp_ctrl_rgs_we_rd;
  assign wescp_ctrl_bs_wr = wescp_ctrl_rgs_bs_wr;
  assign wescp_ctrl_bs_rd = wescp_ctrl_rgs_bs_rd;
  assign wescp_ctrl_sc_rd = wescp_ctrl_rgs_sc_rd;
  assign wescp_ctrl_bs_byte_cnt = wescp_ctrl_rgs_bs_byte_cnt;
  assign wescp_ctrl_och_gcnt = wescp_ctrl_rgs_och_gcnt;
  assign ps_raddr_ov = (pe_ctrl_rgs_ps_raddr == rg_para_xyzs);
  assign ps_waddr_ov = (pe_ctrl_rgs_ps_waddr == rg_para_xyzs);
  assign ofmap_out_ready_flag = (((kzi_reach_th && kz_reach_th) && hki_reach_th) && wki_reach_th);
  assign subconv_finish = (kz_sigs_this_ov && rg_ctrl_tensor_op_en);
  assign fsm_wantExit = 1'b0;
  assign fsm_wantStart = 1'b0;
  assign fsm_wantKill = 1'b0;
  always @(*) begin
    fsm_next_state = fsm_curr_state;
    case(fsm_curr_state)
      fsm_enumDef_SUBCONV : begin
        if(subconv_finish) begin
          fsm_next_state = fsm_enumDef_TENSOR_OP;
        end
      end
      fsm_enumDef_TENSOR_OP : begin
      end
      default : begin
        if(start_conv) begin
          fsm_next_state = fsm_enumDef_SUBCONV;
        end
      end
    endcase
  end

  always @(posedge clk or posedge reset) begin
    if(reset) begin
      dofetch <= 1'b0;
      pe_ctrl_rgs_ps_back_en <= 1'b0;
      pe_ctrl_rgs_ps_waddr <= 7'h0;
      pe_ctrl_rgs_ps_raddr <= 7'h0;
      pe_ctrl_rgs_ps_wr <= 1'b0;
      pe_ctrl_rgs_ps_rd <= 1'b0;
      pe_ctrl_rgs_ps_allow_rd <= 1'b0;
      pe_ctrl_rgs_ps_pinA_bias_en <= 1'b0;
      pe_ctrl_rgs_ps_pinB_bias_en <= 1'b0;
      pe_ctrl_rgs_byp_mul_en <= 1'b0;
      pe_ctrl_rgs_maxpool_en <= 1'b0;
      pe_ctrl_rgs_bias_mul_en <= 1'b0;
      pe_ctrl_rgs_ps_scale_en <= 1'b0;
      ifscp_ctrl_rgs_if_rd <= 1'b0;
      ifscp_ctrl_rgs_hw_addr <= 6'h0;
      ifscp_ctrl_rgs_ich_addr <= 4'b0000;
      ifscp_ctrl_rgs_cast_mode <= 1'b0;
      wescp_ctrl_rgs_we_rd <= 1'b0;
      wescp_ctrl_rgs_bs_wr <= 1'b0;
      wescp_ctrl_rgs_bs_rd <= 1'b0;
      wescp_ctrl_rgs_sc_rd <= 1'b0;
      wescp_ctrl_rgs_bs_byte_cnt <= 3'b000;
      wescp_ctrl_rgs_och_gcnt <= 4'b0000;
      fsm_curr_state <= fsm_enumDef_IDLE;
    end else begin
      fsm_curr_state <= fsm_next_state;
      case(fsm_curr_state)
        fsm_enumDef_SUBCONV : begin
          dofetch <= 1'b1;
          ifscp_ctrl_rgs_cast_mode <= 1'b0;
          if(oxi_sigs_this_ov) begin
            ifscp_ctrl_rgs_hw_addr <= (ifscp_ctrl_rgs_hw_addr + _zz_ifscp_ctrl_rgs_hw_addr);
          end else begin
            if(oyi_sigs_this_ov) begin
              ifscp_ctrl_rgs_hw_addr <= 6'h0;
            end else begin
              ifscp_ctrl_rgs_hw_addr <= (ifscp_ctrl_rgs_hw_addr + _zz_ifscp_ctrl_rgs_hw_addr_1);
            end
          end
          ifscp_ctrl_rgs_ich_addr <= kzi_cnt;
          wescp_ctrl_rgs_och_gcnt <= ozi_cnt;
          ifscp_ctrl_rgs_if_rd <= 1'b1;
          wescp_ctrl_rgs_we_rd <= 1'b1;
          pe_ctrl_rgs_ps_wr <= pe_flags_ps_wr_ready;
          pe_ctrl_rgs_ps_rd <= pe_flags_ps_rd_ready;
          if(ps_raddr_ov) begin
            pe_ctrl_rgs_ps_allow_rd <= 1'b1;
          end
          if(pe_ctrl_rgs_ps_rd) begin
            if(ps_raddr_ov) begin
              pe_ctrl_rgs_ps_raddr <= 7'h0;
            end else begin
              pe_ctrl_rgs_ps_raddr <= (pe_ctrl_rgs_ps_raddr + 7'h01);
            end
          end
          if(pe_ctrl_rgs_ps_wr) begin
            if(ps_waddr_ov) begin
              pe_ctrl_rgs_ps_waddr <= 7'h0;
            end else begin
              pe_ctrl_rgs_ps_waddr <= (pe_ctrl_rgs_ps_waddr + 7'h01);
            end
          end
          if(rg_ctrl_bias_en) begin
            if(ps_raddr_ov) begin
              wescp_ctrl_rgs_bs_rd <= 1'b0;
              pe_ctrl_rgs_ps_pinB_bias_en <= 1'b0;
            end else begin
              wescp_ctrl_rgs_bs_rd <= 1'b1;
              pe_ctrl_rgs_ps_pinB_bias_en <= 1'b1;
            end
          end
          if(rg_ctrl_scale_en) begin
            if(ofmap_out_ready_flag) begin
              pe_ctrl_rgs_ps_scale_en <= 1'b1;
            end else begin
              pe_ctrl_rgs_ps_scale_en <= 1'b0;
            end
          end
          if(subconv_finish) begin
            dofetch <= 1'b0;
          end
        end
        fsm_enumDef_TENSOR_OP : begin
        end
        default : begin
          ifscp_ctrl_rgs_if_rd <= 1'b0;
          ifscp_ctrl_rgs_hw_addr <= 6'h0;
          ifscp_ctrl_rgs_ich_addr <= 4'b0000;
          ifscp_ctrl_rgs_cast_mode <= 1'b0;
          wescp_ctrl_rgs_we_rd <= 1'b0;
          wescp_ctrl_rgs_bs_wr <= 1'b0;
          wescp_ctrl_rgs_bs_rd <= 1'b0;
          wescp_ctrl_rgs_sc_rd <= 1'b0;
          wescp_ctrl_rgs_bs_byte_cnt <= 3'b000;
          wescp_ctrl_rgs_och_gcnt <= 4'b0000;
          pe_ctrl_rgs_ps_back_en <= 1'b0;
          pe_ctrl_rgs_ps_waddr <= 7'h0;
          pe_ctrl_rgs_ps_raddr <= 7'h0;
          pe_ctrl_rgs_ps_wr <= 1'b0;
          pe_ctrl_rgs_ps_rd <= 1'b0;
          pe_ctrl_rgs_ps_allow_rd <= 1'b0;
          pe_ctrl_rgs_ps_pinA_bias_en <= 1'b0;
          pe_ctrl_rgs_ps_pinB_bias_en <= 1'b0;
          pe_ctrl_rgs_byp_mul_en <= 1'b0;
          pe_ctrl_rgs_maxpool_en <= 1'b0;
          pe_ctrl_rgs_bias_mul_en <= 1'b0;
          pe_ctrl_rgs_ps_scale_en <= 1'b0;
          dofetch <= 1'b0;
        end
      endcase
    end
  end


endmodule

//counter_1 replaced by counter_1

//counter_4 replaced by counter_4

module counter_4 (
  input      [6:0]    step,
  input      [5:0]    threshold,
  input               inc_en,
  output     [5:0]    cnt,
  output     [6:0]    nxt_cnt,
  output              this_ov,
  output              reach_th,
  output              isInitial,
  input               clk,
  input               reset
);

  wire       [6:0]    _zz_reach_th;
  reg        [6:0]    cnt_rg;
  wire       [5:0]    true_threshold;

  assign _zz_reach_th = {1'd0, true_threshold};
  assign true_threshold = threshold;
  assign nxt_cnt = (cnt_rg + step);
  assign reach_th = (_zz_reach_th <= nxt_cnt);
  assign cnt = cnt_rg[5:0];
  assign this_ov = (reach_th && inc_en);
  assign isInitial = (cnt[5 : 0] == 6'h0);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      cnt_rg <= 7'h0;
    end else begin
      if(inc_en) begin
        if(reach_th) begin
          cnt_rg <= 7'h0;
        end else begin
          cnt_rg <= nxt_cnt;
        end
      end
    end
  end


endmodule

//counter replaced by counter

//counter replaced by counter

module counter_1 (
  input      [4:0]    step,
  input      [3:0]    threshold,
  input               inc_en,
  output     [3:0]    cnt,
  output     [4:0]    nxt_cnt,
  output              this_ov,
  output              reach_th,
  output              isInitial,
  input               clk,
  input               reset
);

  wire       [4:0]    _zz_reach_th;
  reg        [4:0]    cnt_rg;
  wire       [3:0]    true_threshold;

  assign _zz_reach_th = {1'd0, true_threshold};
  assign true_threshold = threshold;
  assign nxt_cnt = (cnt_rg + step);
  assign reach_th = (_zz_reach_th <= nxt_cnt);
  assign cnt = cnt_rg[3:0];
  assign this_ov = (reach_th && inc_en);
  assign isInitial = (cnt[3 : 0] == 4'b0000);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      cnt_rg <= 5'h0;
    end else begin
      if(inc_en) begin
        if(reach_th) begin
          cnt_rg <= 5'h0;
        end else begin
          cnt_rg <= nxt_cnt;
        end
      end
    end
  end


endmodule

module counter (
  input      [8:0]    step,
  input      [7:0]    threshold,
  input               inc_en,
  output     [7:0]    cnt,
  output     [8:0]    nxt_cnt,
  output              this_ov,
  output              reach_th,
  output              isInitial,
  input               clk,
  input               reset
);

  wire       [8:0]    _zz_reach_th;
  reg        [8:0]    cnt_rg;
  wire       [7:0]    true_threshold;

  assign _zz_reach_th = {1'd0, true_threshold};
  assign true_threshold = threshold;
  assign nxt_cnt = (cnt_rg + step);
  assign reach_th = (_zz_reach_th <= nxt_cnt);
  assign cnt = cnt_rg[7:0];
  assign this_ov = (reach_th && inc_en);
  assign isInitial = (cnt[7 : 0] == 8'h0);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      cnt_rg <= 9'h0;
    end else begin
      if(inc_en) begin
        if(reach_th) begin
          cnt_rg <= 9'h0;
        end else begin
          cnt_rg <= nxt_cnt;
        end
      end
    end
  end


endmodule
