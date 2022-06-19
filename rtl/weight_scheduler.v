// Generator : SpinalHDL v1.7.0    git head : eca519e78d4e6022e34911ec300a432ed9db8220
// Component : weight_scheduler
// Git hash  : 4cf7f97c71a2bf6b231eea3b8cc7534ce901135c

`timescale 1ns/1ps

module weight_scheduler (
  input               layer_start,
  input      [7:0]    start_addr_bs,
  input      [7:0]    start_addr_w,
  input               oz_inc_flag,
  input               wescp_ctrl_we_rd,
  input               wescp_ctrl_bs_wr,
  input               wescp_ctrl_bs_rd,
  input               wescp_ctrl_sc_rd,
  input      [2:0]    wescp_ctrl_bs_byte_cnt,
  input      [3:0]    wescp_ctrl_och_gcnt,
  input      [5:0]    rg_para_yhat,
  input      [5:0]    rg_para_xhat,
  input      [5:0]    rg_para_y,
  input      [5:0]    rg_para_x,
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
  input               clk,
  input               resetn
);
  localparam IDLE = 2'd0;
  localparam LOAD_BS = 2'd1;
  localparam FIRST_FETCH = 2'd2;
  localparam PRE_FETCH = 2'd3;

  wire       [7:0]    kz_cnt;
  wire                kz_this_ov;
  wire                kz_reach_th;
  wire       [7:0]    hki_cnt;
  wire                hki_this_ov;
  wire                hki_reach_th;
  wire       [7:0]    wki_cnt;
  wire                wki_this_ov;
  wire                wki_reach_th;
  wire       [3:0]    ozi_cnt;
  wire                ozi_this_ov;
  wire                ozi_reach_th;
  wire       [6:0]    bs_cnt_cnt;
  wire                bs_cnt_this_ov;
  wire                bs_cnt_reach_th;
  wire       [6:0]    tmp_bs_cnt_th;
  wire       [6:0]    tmp_bs_cnt_th_1;
  wire       [6:0]    tmp_bs_cnt_th_2;
  wire                weight_fetch_work;
  wire                kz_sigs_inc;
  wire                kz_sigs_this_ov;
  wire                kz_sigs_reach_th;
  wire                hki_sigs_inc;
  wire                hki_sigs_this_ov;
  wire                hki_sigs_reach_th;
  wire                wki_sigs_inc;
  wire                wki_sigs_this_ov;
  wire                wki_sigs_reach_th;
  wire                ozi_sigs_inc;
  wire                ozi_sigs_this_ov;
  wire                ozi_sigs_reach_th;
  reg                 isfirst;
  wire       [6:0]    bs_cnt_th;
  reg                 bias_scale_fetch_work;
  wire                bs_ozi_sigs_inc;
  wire                bs_ozi_sigs_this_ov;
  wire                bs_ozi_sigs_reach_th;
  wire                bs_load_end;
  wire                fsm_wantExit;
  wire                fsm_wantStart;
  wire                fsm_wantKill;
  reg        [1:0]    fsm_curr_state;
  reg        [1:0]    fsm_next_state;
  `ifndef SYNTHESIS
  reg [87:0] fsm_curr_state_string;
  reg [87:0] fsm_next_state_string;
  `endif


  assign tmp_bs_cnt_th = {3'd0, rg_para_zs};
  assign tmp_bs_cnt_th_1 = (tmp_bs_cnt_th_2 <<< 2);
  assign tmp_bs_cnt_th_2 = {3'd0, rg_para_zs};
  counter kz (
    .step      (8'h01          ), //i
    .threshold (rg_para_Ci[7:0]), //i
    .inc_en    (kz_sigs_inc    ), //i
    .cnt       (kz_cnt[7:0]    ), //o
    .this_ov   (kz_this_ov     ), //o
    .reach_th  (kz_reach_th    ), //o
    .clk       (clk            ), //i
    .resetn    (resetn         )  //i
  );
  counter hki (
    .step      (8'h01          ), //i
    .threshold (rg_para_Hk[7:0]), //i
    .inc_en    (hki_sigs_inc   ), //i
    .cnt       (hki_cnt[7:0]   ), //o
    .this_ov   (hki_this_ov    ), //o
    .reach_th  (hki_reach_th   ), //o
    .clk       (clk            ), //i
    .resetn    (resetn         )  //i
  );
  counter wki (
    .step      (8'h01          ), //i
    .threshold (rg_para_Wk[7:0]), //i
    .inc_en    (wki_sigs_inc   ), //i
    .cnt       (wki_cnt[7:0]   ), //o
    .this_ov   (wki_this_ov    ), //o
    .reach_th  (wki_reach_th   ), //o
    .clk       (clk            ), //i
    .resetn    (resetn         )  //i
  );
  counter_3 ozi (
    .step      (4'b0001        ), //i
    .threshold (rg_para_zs[3:0]), //i
    .inc_en    (ozi_sigs_inc   ), //i
    .cnt       (ozi_cnt[3:0]   ), //o
    .this_ov   (ozi_this_ov    ), //o
    .reach_th  (ozi_reach_th   ), //o
    .clk       (clk            ), //i
    .resetn    (resetn         )  //i
  );
  counter_4 bs_cnt (
    .step      (7'h01          ), //i
    .threshold (bs_cnt_th[6:0] ), //i
    .inc_en    (bs_ozi_sigs_inc), //i
    .cnt       (bs_cnt_cnt[6:0]), //o
    .this_ov   (bs_cnt_this_ov ), //o
    .reach_th  (bs_cnt_reach_th), //o
    .clk       (clk            ), //i
    .resetn    (resetn         )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(fsm_curr_state)
      IDLE : fsm_curr_state_string = "IDLE       ";
      LOAD_BS : fsm_curr_state_string = "LOAD_BS    ";
      FIRST_FETCH : fsm_curr_state_string = "FIRST_FETCH";
      PRE_FETCH : fsm_curr_state_string = "PRE_FETCH  ";
      default : fsm_curr_state_string = "???????????";
    endcase
  end
  always @(*) begin
    case(fsm_next_state)
      IDLE : fsm_next_state_string = "IDLE       ";
      LOAD_BS : fsm_next_state_string = "LOAD_BS    ";
      FIRST_FETCH : fsm_next_state_string = "FIRST_FETCH";
      PRE_FETCH : fsm_next_state_string = "PRE_FETCH  ";
      default : fsm_next_state_string = "???????????";
    endcase
  end
  `endif

  assign kz_sigs_inc = hki_sigs_this_ov;
  assign hki_sigs_inc = wki_sigs_this_ov;
  assign wki_sigs_inc = ozi_sigs_this_ov;
  assign ozi_sigs_inc = weight_fetch_work;
  assign kz_sigs_this_ov = kz_this_ov;
  assign kz_sigs_reach_th = kz_reach_th;
  assign hki_sigs_this_ov = hki_this_ov;
  assign hki_sigs_reach_th = hki_reach_th;
  assign wki_sigs_this_ov = wki_this_ov;
  assign wki_sigs_reach_th = wki_reach_th;
  assign ozi_sigs_this_ov = ozi_this_ov;
  assign ozi_sigs_reach_th = ozi_reach_th;
  assign bs_ozi_sigs_inc = bias_scale_fetch_work;
  assign bs_cnt_th = (tmp_bs_cnt_th + tmp_bs_cnt_th_1);
  assign bs_ozi_sigs_this_ov = bs_cnt_this_ov;
  assign bs_ozi_sigs_reach_th = bs_cnt_reach_th;
  assign bs_load_end = bs_cnt_this_ov;
  assign fsm_wantExit = 1'b0;
  assign fsm_wantStart = 1'b0;
  assign fsm_wantKill = 1'b0;
  always @(*) begin
    fsm_next_state = fsm_curr_state;
    case(fsm_curr_state)
      LOAD_BS : begin
        if(bs_load_end) begin
          fsm_next_state = FIRST_FETCH;
        end
      end
      FIRST_FETCH : begin
      end
      PRE_FETCH : begin
      end
      default : begin
        if(layer_start) begin
          fsm_next_state = LOAD_BS;
        end
      end
    endcase
  end

  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      isfirst <= 1'b1;
      bias_scale_fetch_work <= 1'b0;
      fsm_curr_state <= IDLE;
    end else begin
      fsm_curr_state <= fsm_next_state;
      case(fsm_curr_state)
        LOAD_BS : begin
          if(bs_load_end) begin
            bias_scale_fetch_work <= 1'b1;
          end else begin
            bias_scale_fetch_work <= 1'b0;
          end
        end
        FIRST_FETCH : begin
          isfirst <= 1'b0;
        end
        PRE_FETCH : begin
        end
        default : begin
          isfirst <= 1'b1;
          bias_scale_fetch_work <= 1'b0;
        end
      endcase
    end
  end


endmodule

module counter_4 (
  input      [6:0]    step,
  input      [6:0]    threshold,
  input               inc_en,
  output     [6:0]    cnt,
  output              this_ov,
  output              reach_th,
  input               clk,
  input               resetn
);

  reg        [6:0]    cnt_rg;

  assign reach_th = (cnt_rg == threshold);
  assign cnt = cnt_rg;
  assign this_ov = (reach_th && inc_en);
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      cnt_rg <= 7'h0;
    end else begin
      if(inc_en) begin
        if(reach_th) begin
          cnt_rg <= 7'h0;
        end else begin
          cnt_rg <= (cnt_rg + step);
        end
      end
    end
  end


endmodule

module counter_3 (
  input      [3:0]    step,
  input      [3:0]    threshold,
  input               inc_en,
  output     [3:0]    cnt,
  output              this_ov,
  output              reach_th,
  input               clk,
  input               resetn
);

  reg        [3:0]    cnt_rg;

  assign reach_th = (cnt_rg == threshold);
  assign cnt = cnt_rg;
  assign this_ov = (reach_th && inc_en);
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      cnt_rg <= 4'b0000;
    end else begin
      if(inc_en) begin
        if(reach_th) begin
          cnt_rg <= 4'b0000;
        end else begin
          cnt_rg <= (cnt_rg + step);
        end
      end
    end
  end


endmodule

//counter replaced by counter

//counter replaced by counter

module counter (
  input      [7:0]    step,
  input      [7:0]    threshold,
  input               inc_en,
  output     [7:0]    cnt,
  output              this_ov,
  output              reach_th,
  input               clk,
  input               resetn
);

  reg        [7:0]    cnt_rg;

  assign reach_th = (cnt_rg == threshold);
  assign cnt = cnt_rg;
  assign this_ov = (reach_th && inc_en);
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      cnt_rg <= 8'h0;
    end else begin
      if(inc_en) begin
        if(reach_th) begin
          cnt_rg <= 8'h0;
        end else begin
          cnt_rg <= (cnt_rg + step);
        end
      end
    end
  end


endmodule
