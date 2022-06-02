// Generator : SpinalHDL v1.7.0    git head : eca519e78d4e6022e34911ec300a432ed9db8220
// Component : pe_flow_ctrl
// Git hash  : f1f795b65a2a20dfc7920bbbc2342e1f6ac30d62

`timescale 1ns/1ps

module pe_flow_ctrl (
  input               start_conv,
  input      [5:0]    rg_yhat,
  input      [5:0]    rg_xhat,
  input      [5:0]    rg_y,
  input      [5:0]    rg_x,
  input      [7:0]    rg_Hk,
  input      [7:0]    rg_Wk,
  input      [7:0]    rg_Ho,
  input      [7:0]    rg_Wo,
  input      [7:0]    rg_Hi,
  input      [7:0]    rg_Wi,
  input      [7:0]    rg_Co,
  input      [7:0]    rg_Ci,
  input      [3:0]    rg_sh,
  input      [3:0]    rg_sw,
  input      [3:0]    rg_ph,
  input      [3:0]    rg_pw,
  input      [3:0]    rg_dh,
  input      [3:0]    rg_dw,
  input      [3:0]    rg_zs,
  input      [3:0]    rg_zp,
  input      [3:0]    rg_k,
  input      [5:0]    rg_shxhat,
  input      [6:0]    rg_xyzs,
  output              pe_ctrl_ps_back_en,
  output     [6:0]    pe_ctrl_ps_waddr,
  output     [6:0]    pe_ctrl_ps_raddr,
  output              pe_ctrl_ps_wr,
  output              pe_ctrl_ps_rd,
  output              pe_ctrl_ps_outer_en,
  output              pe_ctrl_byp_mul_en,
  output              pe_ctrl_maxpool_en,
  output              pe_ctrl_bias_mul_en,
  output              pe_ctrl_ps_allow_rd,
  output     [4:0]    pe_ctrl_shift_scale,
  output              ifscp_ctrl_if_rd,
  output     [5:0]    ifscp_ctrl_hw_addr,
  output     [3:0]    ifscp_ctrl_ich_addr,
  output              ifscp_ctrl_cast_mode,
  output              wescp_ctrl_we_rd,
  output     [3:0]    wescp_ctrl_och_gcnt,
  input               pe_flags_ps_rd_ready,
  input               pe_flags_ps_wr_ready,
  input               clk,
  input               resetn
);
  localparam IDLE = 2'd0;
  localparam SUBCONV = 2'd1;
  localparam QUANT = 2'd2;

  wire       [3:0]    kzi_cnt;
  wire                kzi_this_ov;
  wire                hki_this_ov;
  wire                wki_this_ov;
  wire       [3:0]    ozi_cnt;
  wire                ozi_this_ov;
  wire                oyi_this_ov;
  wire                oxi_this_ov;
  wire       [5:0]    tmp_ifscp_ctrl_rgs_hw_addr;
  wire       [5:0]    tmp_ifscp_ctrl_rgs_hw_addr_1;
  reg                 dofetch;
  wire                hki_sigs_inc;
  wire                hki_sigs_this_ov;
  wire                wki_sigs_inc;
  wire                wki_sigs_this_ov;
  wire                kzi_sigs_inc;
  wire                kzi_sigs_this_ov;
  wire                ozi_sigs_inc;
  wire                ozi_sigs_this_ov;
  wire                oyi_sigs_inc;
  wire                oyi_sigs_this_ov;
  wire                oxi_sigs_inc;
  wire                oxi_sigs_this_ov;
  reg                 pe_ctrl_rgs_ps_back_en;
  reg        [6:0]    pe_ctrl_rgs_ps_waddr;
  reg        [6:0]    pe_ctrl_rgs_ps_raddr;
  reg                 pe_ctrl_rgs_ps_wr;
  reg                 pe_ctrl_rgs_ps_rd;
  reg                 pe_ctrl_rgs_ps_outer_en;
  reg                 pe_ctrl_rgs_byp_mul_en;
  reg                 pe_ctrl_rgs_maxpool_en;
  reg                 pe_ctrl_rgs_bias_mul_en;
  reg                 pe_ctrl_rgs_ps_allow_rd;
  reg        [4:0]    pe_ctrl_rgs_shift_scale;
  reg                 ifscp_ctrl_rgs_if_rd;
  reg        [5:0]    ifscp_ctrl_rgs_hw_addr;
  reg        [3:0]    ifscp_ctrl_rgs_ich_addr;
  reg                 ifscp_ctrl_rgs_cast_mode;
  reg                 wescp_ctrl_rgs_we_rd;
  reg        [3:0]    wescp_ctrl_rgs_och_gcnt;
  wire                ps_raddr_ov;
  wire                ps_waddr_ov;
  reg        [1:0]    fsm_curr_state;
  reg        [1:0]    fsm_next_state;
  `ifndef SYNTHESIS
  reg [55:0] fsm_curr_state_string;
  reg [55:0] fsm_next_state_string;
  `endif


  assign tmp_ifscp_ctrl_rgs_hw_addr = (rg_shxhat + 6'h01);
  assign tmp_ifscp_ctrl_rgs_hw_addr_1 = {2'd0, rg_sw};
  counter kzi (
    .threshold (rg_k[3:0]   ), //i
    .inc_en    (kzi_sigs_inc), //i
    .cnt       (kzi_cnt[3:0]), //o
    .this_ov   (kzi_this_ov ), //o
    .clk       (clk         ), //i
    .resetn    (resetn      )  //i
  );
  counter_1 hki (
    .threshold (rg_Hk[7:0]  ), //i
    .inc_en    (hki_sigs_inc), //i
    .this_ov   (hki_this_ov ), //o
    .clk       (clk         ), //i
    .resetn    (resetn      )  //i
  );
  counter_1 wki (
    .threshold (rg_Wk[7:0]  ), //i
    .inc_en    (wki_sigs_inc), //i
    .this_ov   (wki_this_ov ), //o
    .clk       (clk         ), //i
    .resetn    (resetn      )  //i
  );
  counter ozi (
    .threshold (rg_zs[3:0]  ), //i
    .inc_en    (ozi_sigs_inc), //i
    .cnt       (ozi_cnt[3:0]), //o
    .this_ov   (ozi_this_ov ), //o
    .clk       (clk         ), //i
    .resetn    (resetn      )  //i
  );
  counter_4 oyi (
    .threshold (rg_yhat[5:0]), //i
    .inc_en    (oyi_sigs_inc), //i
    .this_ov   (oyi_this_ov ), //o
    .clk       (clk         ), //i
    .resetn    (resetn      )  //i
  );
  counter_4 oxi (
    .threshold (rg_xhat[5:0]), //i
    .inc_en    (oxi_sigs_inc), //i
    .this_ov   (oxi_this_ov ), //o
    .clk       (clk         ), //i
    .resetn    (resetn      )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(fsm_curr_state)
      IDLE : fsm_curr_state_string = "IDLE   ";
      SUBCONV : fsm_curr_state_string = "SUBCONV";
      QUANT : fsm_curr_state_string = "QUANT  ";
      default : fsm_curr_state_string = "???????";
    endcase
  end
  always @(*) begin
    case(fsm_next_state)
      IDLE : fsm_next_state_string = "IDLE   ";
      SUBCONV : fsm_next_state_string = "SUBCONV";
      QUANT : fsm_next_state_string = "QUANT  ";
      default : fsm_next_state_string = "???????";
    endcase
  end
  `endif

  assign hki_sigs_inc = wki_sigs_this_ov;
  assign wki_sigs_inc = kzi_sigs_this_ov;
  assign kzi_sigs_inc = ozi_sigs_this_ov;
  assign ozi_sigs_inc = oyi_sigs_this_ov;
  assign oyi_sigs_inc = oxi_sigs_this_ov;
  assign oxi_sigs_inc = dofetch;
  assign kzi_sigs_this_ov = kzi_this_ov;
  assign hki_sigs_this_ov = hki_this_ov;
  assign wki_sigs_this_ov = wki_this_ov;
  assign ozi_sigs_this_ov = ozi_this_ov;
  assign oyi_sigs_this_ov = oyi_this_ov;
  assign oxi_sigs_this_ov = oxi_this_ov;
  assign pe_ctrl_ps_back_en = pe_ctrl_rgs_ps_back_en;
  assign pe_ctrl_ps_waddr = pe_ctrl_rgs_ps_waddr;
  assign pe_ctrl_ps_raddr = pe_ctrl_rgs_ps_raddr;
  assign pe_ctrl_ps_wr = pe_ctrl_rgs_ps_wr;
  assign pe_ctrl_ps_rd = pe_ctrl_rgs_ps_rd;
  assign pe_ctrl_ps_outer_en = pe_ctrl_rgs_ps_outer_en;
  assign pe_ctrl_byp_mul_en = pe_ctrl_rgs_byp_mul_en;
  assign pe_ctrl_maxpool_en = pe_ctrl_rgs_maxpool_en;
  assign pe_ctrl_bias_mul_en = pe_ctrl_rgs_bias_mul_en;
  assign pe_ctrl_ps_allow_rd = pe_ctrl_rgs_ps_allow_rd;
  assign pe_ctrl_shift_scale = pe_ctrl_rgs_shift_scale;
  assign ifscp_ctrl_if_rd = ifscp_ctrl_rgs_if_rd;
  assign ifscp_ctrl_hw_addr = ifscp_ctrl_rgs_hw_addr;
  assign ifscp_ctrl_ich_addr = ifscp_ctrl_rgs_ich_addr;
  assign ifscp_ctrl_cast_mode = ifscp_ctrl_rgs_cast_mode;
  assign wescp_ctrl_we_rd = wescp_ctrl_rgs_we_rd;
  assign wescp_ctrl_och_gcnt = wescp_ctrl_rgs_och_gcnt;
  assign ps_raddr_ov = (pe_ctrl_rgs_ps_raddr == rg_xyzs);
  assign ps_waddr_ov = (pe_ctrl_rgs_ps_waddr == rg_xyzs);
  always @(*) begin
    fsm_next_state = fsm_curr_state;
    case(fsm_curr_state)
      SUBCONV : begin
        if(hki_sigs_this_ov) begin
          fsm_next_state = QUANT;
        end
      end
      QUANT : begin
      end
      default : begin
        if(start_conv) begin
          fsm_next_state = SUBCONV;
        end
      end
    endcase
  end

  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      dofetch <= 1'b0;
      pe_ctrl_rgs_ps_back_en <= 1'b0;
      pe_ctrl_rgs_ps_waddr <= 7'h0;
      pe_ctrl_rgs_ps_raddr <= 7'h0;
      pe_ctrl_rgs_ps_wr <= 1'b0;
      pe_ctrl_rgs_ps_rd <= 1'b0;
      pe_ctrl_rgs_ps_outer_en <= 1'b0;
      pe_ctrl_rgs_byp_mul_en <= 1'b0;
      pe_ctrl_rgs_maxpool_en <= 1'b0;
      pe_ctrl_rgs_bias_mul_en <= 1'b0;
      pe_ctrl_rgs_ps_allow_rd <= 1'b0;
      pe_ctrl_rgs_shift_scale <= 5'h0;
      ifscp_ctrl_rgs_if_rd <= 1'b0;
      ifscp_ctrl_rgs_hw_addr <= 6'h0;
      ifscp_ctrl_rgs_ich_addr <= 4'b0000;
      ifscp_ctrl_rgs_cast_mode <= 1'b0;
      wescp_ctrl_rgs_we_rd <= 1'b0;
      wescp_ctrl_rgs_och_gcnt <= 4'b0000;
      fsm_curr_state <= IDLE;
    end else begin
      fsm_curr_state <= fsm_next_state;
      case(fsm_curr_state)
        SUBCONV : begin
          dofetch <= 1'b1;
          ifscp_ctrl_rgs_cast_mode <= 1'b0;
          if(oxi_sigs_this_ov) begin
            ifscp_ctrl_rgs_hw_addr <= (ifscp_ctrl_rgs_hw_addr + tmp_ifscp_ctrl_rgs_hw_addr);
          end else begin
            if(oyi_sigs_this_ov) begin
              ifscp_ctrl_rgs_hw_addr <= 6'h0;
            end else begin
              ifscp_ctrl_rgs_hw_addr <= (ifscp_ctrl_rgs_hw_addr + tmp_ifscp_ctrl_rgs_hw_addr_1);
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
          if(hki_sigs_this_ov) begin
            dofetch <= 1'b0;
          end
        end
        QUANT : begin
        end
        default : begin
          ifscp_ctrl_rgs_if_rd <= 1'b0;
          ifscp_ctrl_rgs_hw_addr <= 6'h0;
          ifscp_ctrl_rgs_ich_addr <= 4'b0000;
          ifscp_ctrl_rgs_cast_mode <= 1'b0;
          wescp_ctrl_rgs_we_rd <= 1'b0;
          wescp_ctrl_rgs_och_gcnt <= 4'b0000;
          pe_ctrl_rgs_ps_back_en <= 1'b0;
          pe_ctrl_rgs_ps_waddr <= 7'h0;
          pe_ctrl_rgs_ps_raddr <= 7'h0;
          pe_ctrl_rgs_ps_wr <= 1'b0;
          pe_ctrl_rgs_ps_rd <= 1'b0;
          pe_ctrl_rgs_ps_outer_en <= 1'b0;
          pe_ctrl_rgs_byp_mul_en <= 1'b0;
          pe_ctrl_rgs_maxpool_en <= 1'b0;
          pe_ctrl_rgs_bias_mul_en <= 1'b0;
          pe_ctrl_rgs_ps_allow_rd <= 1'b0;
          pe_ctrl_rgs_shift_scale <= 5'h0;
          dofetch <= 1'b0;
        end
      endcase
    end
  end


endmodule

//counter_4 replaced by counter_4

module counter_4 (
  input      [5:0]    threshold,
  input               inc_en,
  output              this_ov,
  input               clk,
  input               resetn
);

  reg        [5:0]    cnt_rg;
  wire                overflow;

  assign overflow = (cnt_rg == threshold);
  assign this_ov = (overflow && inc_en);
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      cnt_rg <= 6'h0;
    end else begin
      if(inc_en) begin
        if(overflow) begin
          cnt_rg <= 6'h0;
        end else begin
          cnt_rg <= (cnt_rg + 6'h01);
        end
      end
    end
  end


endmodule

//counter replaced by counter

//counter_1 replaced by counter_1

module counter_1 (
  input      [7:0]    threshold,
  input               inc_en,
  output              this_ov,
  input               clk,
  input               resetn
);

  reg        [7:0]    cnt_rg;
  wire                overflow;

  assign overflow = (cnt_rg == threshold);
  assign this_ov = (overflow && inc_en);
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      cnt_rg <= 8'h0;
    end else begin
      if(inc_en) begin
        if(overflow) begin
          cnt_rg <= 8'h0;
        end else begin
          cnt_rg <= (cnt_rg + 8'h01);
        end
      end
    end
  end


endmodule

module counter (
  input      [3:0]    threshold,
  input               inc_en,
  output     [3:0]    cnt,
  output              this_ov,
  input               clk,
  input               resetn
);

  reg        [3:0]    cnt_rg;
  wire                overflow;

  assign overflow = (cnt_rg == threshold);
  assign cnt = cnt_rg;
  assign this_ov = (overflow && inc_en);
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      cnt_rg <= 4'b0000;
    end else begin
      if(inc_en) begin
        if(overflow) begin
          cnt_rg <= 4'b0000;
        end else begin
          cnt_rg <= (cnt_rg + 4'b0001);
        end
      end
    end
  end


endmodule
