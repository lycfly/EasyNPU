// Generator : SpinalHDL v1.7.0    git head : eca519e78d4e6022e34911ec300a432ed9db8220
// Component : pe_unit
// Git hash  : a8067f8b21100dedc7f8f4dc50eeab43e42ffc01

`timescale 1ns/1ps

module pe_unit (
  input               pe_weight_in_valid,
  input      [7:0]    pe_weight_in_payload,
  input               pe_ifmap_in_valid,
  input      [7:0]    pe_ifmap_in_payload,
  input               pe_bias_in_valid,
  input      [31:0]   pe_bias_in_payload,
  input               pe_shift_scale_valid,
  input      [7:0]    pe_shift_scale_payload,
  output              pe_ofmap_out_valid,
  output     [7:0]    pe_ofmap_out_payload,
  input               pe_ctrl_ps_back_en,
  input      [6:0]    pe_ctrl_ps_waddr,
  input      [6:0]    pe_ctrl_ps_raddr,
  input               pe_ctrl_ps_wr,
  input               pe_ctrl_ps_rd,
  input               pe_ctrl_ps_allow_rd,
  input               pe_ctrl_ps_pinA_bias_en,
  input               pe_ctrl_ps_pinB_bias_en,
  input               pe_ctrl_byp_mul_en,
  input               pe_ctrl_maxpool_en,
  input               pe_ctrl_bias_mul_en,
  input               pe_ctrl_ps_scale_en,
  output              pe_flags_ps_rd_ready,
  output              pe_flags_ps_wr_ready,
  input               clk,
  input               resetn
);

  wire       [31:0]   Ps_rgfile_wdata;
  wire       [15:0]   Multiplier_dout;
  wire                Multiplier_finish;
  wire                Multiplier_dout_vld;
  wire       [31:0]   Adder_result;
  wire       [31:0]   qnt_quant_data;
  wire       [31:0]   Ps_rgfile_rdata;
  wire       [31:0]   tmp_ps_rf_rdata_payload;
  wire       [31:0]   tmp_ps_rf_rdata_payload_1;
  reg        [7:0]    Mula;
  reg        [7:0]    Mulb;
  wire                MA_AfterMux_valid;
  wire       [7:0]    MA_AfterMux_payload;
  wire                MB_AfterMux_valid;
  wire       [7:0]    MB_AfterMux_payload;
  wire                bias_Mul_valid;
  wire       [7:0]    bias_Mul_payload;
  wire                Mul_out_valid;
  wire       [15:0]   Mul_out_payload;
  wire                Mul_finish;
  reg                 MA_AfterMux_valid_regNext;
  wire                adder_out_valid;
  wire       [31:0]   adder_out_payload;
  wire       [31:0]   mul_out_ext;
  wire       [31:0]   adder_pinB;
  wire       [31:0]   adder_pinA;
  wire                ps_rf_rdata_valid;
  wire       [31:0]   ps_rf_rdata_payload;
  wire                ps_true_rd_en;
  reg                 ps_true_rd_en_regNext;

  assign tmp_ps_rf_rdata_payload = Ps_rgfile_rdata;
  assign tmp_ps_rf_rdata_payload_1 = 32'h0;
  multiplier_wrap Multiplier (
    .dinA     (Mula[7:0]                ), //i
    .dinB     (Mulb[7:0]                ), //i
    .din_vld  (MA_AfterMux_valid_regNext), //i
    .dout     (Multiplier_dout[15:0]    ), //o
    .finish   (Multiplier_finish        ), //o
    .dout_vld (Multiplier_dout_vld      ), //o
    .clk      (clk                      ), //i
    .resetn   (resetn                   )  //i
  );
  adder_unit Adder (
    .pinA       (adder_pinA[31:0]  ), //i
    .pinB       (adder_pinB[31:0]  ), //i
    .maxpool_en (pe_ctrl_maxpool_en), //i
    .result     (Adder_result[31:0])  //o
  );
  QNT_unit qnt (
    .enable      (pe_ctrl_ps_scale_en        ), //i
    .indata      (adder_out_payload[31:0]    ), //i
    .shift_scale (pe_shift_scale_payload[7:0]), //i
    .quant_data  (qnt_quant_data[31:0]       )  //o
  );
  Ram1r1w Ps_rgfile (
    .rd     (ps_true_rd_en        ), //i
    .wr     (pe_ctrl_ps_wr        ), //i
    .waddr  (pe_ctrl_ps_waddr[6:0]), //i
    .raddr  (pe_ctrl_ps_raddr[6:0]), //i
    .wdata  (Ps_rgfile_wdata[31:0]), //i
    .rdata  (Ps_rgfile_rdata[31:0]), //o
    .clk    (clk                  ), //i
    .resetn (resetn               )  //i
  );
  assign bias_Mul_valid = pe_bias_in_valid;
  assign bias_Mul_payload = pe_bias_in_payload[7 : 0];
  assign MA_AfterMux_valid = (pe_ctrl_ps_back_en ? pe_ofmap_out_valid : pe_ifmap_in_valid);
  assign MA_AfterMux_payload = (pe_ctrl_ps_back_en ? pe_ofmap_out_payload : pe_ifmap_in_payload);
  assign MB_AfterMux_valid = (pe_ctrl_bias_mul_en ? bias_Mul_valid : pe_weight_in_valid);
  assign MB_AfterMux_payload = (pe_ctrl_bias_mul_en ? bias_Mul_payload : pe_weight_in_payload);
  assign pe_flags_ps_rd_ready = MA_AfterMux_valid;
  assign Mul_finish = Multiplier_finish;
  assign Mul_out_payload = Multiplier_dout;
  assign Mul_out_valid = Multiplier_dout_vld;
  assign pe_flags_ps_wr_ready = Mul_finish;
  assign mul_out_ext = {{16{Mul_out_payload[15]}}, Mul_out_payload};
  assign adder_out_payload = Adder_result;
  assign adder_out_valid = Mul_out_valid;
  assign adder_pinA = (pe_ctrl_ps_pinA_bias_en ? pe_bias_in_payload : mul_out_ext);
  assign ps_true_rd_en = (pe_ctrl_ps_rd && pe_ctrl_ps_allow_rd);
  assign Ps_rgfile_wdata = qnt_quant_data;
  assign ps_rf_rdata_payload = (ps_true_rd_en ? tmp_ps_rf_rdata_payload : tmp_ps_rf_rdata_payload_1);
  assign ps_rf_rdata_valid = ps_true_rd_en_regNext;
  assign adder_pinB = (pe_ctrl_ps_pinB_bias_en ? pe_bias_in_payload : ps_rf_rdata_payload);
  assign pe_ofmap_out_valid = ps_rf_rdata_valid;
  assign pe_ofmap_out_payload = ps_rf_rdata_payload[7 : 0];
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      Mula <= 8'h0;
      Mulb <= 8'h0;
      MA_AfterMux_valid_regNext <= 1'b0;
      ps_true_rd_en_regNext <= 1'b0;
    end else begin
      if(MA_AfterMux_valid) begin
        Mula <= MA_AfterMux_payload;
      end
      if(MB_AfterMux_valid) begin
        Mulb <= MB_AfterMux_payload;
      end
      MA_AfterMux_valid_regNext <= MA_AfterMux_valid;
      ps_true_rd_en_regNext <= ps_true_rd_en;
    end
  end


endmodule

module Ram1r1w (
  input               rd,
  input               wr,
  input      [6:0]    waddr,
  input      [6:0]    raddr,
  input      [31:0]   wdata,
  output     [31:0]   rdata,
  input               clk,
  input               resetn
);

  wire       [31:0]   ram_readData;

  regMem1r1w ram (
    .writeValid (wr                ), //i
    .readValid  (rd                ), //i
    .waddress   (waddr[6:0]        ), //i
    .raddress   (raddr[6:0]        ), //i
    .writeData  (wdata[31:0]       ), //i
    .readData   (ram_readData[31:0]), //o
    .clk        (clk               ), //i
    .resetn     (resetn            )  //i
  );
  assign rdata = ram_readData;

endmodule

module QNT_unit (
  input               enable,
  input      [31:0]   indata,
  input      [7:0]    shift_scale,
  output     [31:0]   quant_data
);

  wire       [31:0]   roundtoinf_indata;
  wire       [7:0]    roundtoinf_roundbits;
  wire       [31:0]   roundtoinf_outdata;
  wire       [7:0]    tmp_scale_abs;
  wire       [7:0]    tmp_scale_abs_1;
  wire       [7:0]    tmp_scale_abs_2;
  wire       [0:0]    tmp_scale_abs_3;
  wire       [31:0]   tmp_indata_after_shift;
  wire       [31:0]   tmp_indata_after_round;
  wire                isSign;
  wire       [7:0]    scale_abs;
  wire       [31:0]   indata_after_shift;
  wire       [31:0]   indata_after_round;

  assign tmp_scale_abs = (shift_scale[7] ? tmp_scale_abs_1 : shift_scale);
  assign tmp_scale_abs_1 = (~ shift_scale);
  assign tmp_scale_abs_3 = shift_scale[7];
  assign tmp_scale_abs_2 = {7'd0, tmp_scale_abs_3};
  assign tmp_indata_after_shift = ($signed(indata) <<< scale_abs);
  assign tmp_indata_after_round = roundtoinf_outdata;
  RoundToInf_unit roundtoinf (
    .indata    (roundtoinf_indata[31:0]  ), //i
    .roundbits (roundtoinf_roundbits[7:0]), //i
    .outdata   (roundtoinf_outdata[31:0] )  //o
  );
  assign isSign = shift_scale[7];
  assign scale_abs = (tmp_scale_abs + tmp_scale_abs_2);
  assign indata_after_shift = (isSign ? indata : tmp_indata_after_shift);
  assign roundtoinf_indata = indata_after_shift;
  assign roundtoinf_roundbits = (isSign ? scale_abs : 8'h0);
  assign indata_after_round = (enable ? tmp_indata_after_round : indata);
  assign quant_data = indata_after_round;

endmodule

module adder_unit (
  input      [31:0]   pinA,
  input      [31:0]   pinB,
  input               maxpool_en,
  output     [31:0]   result
);

  wire       [31:0]   tmp_adder_pinA;
  wire       [31:0]   tmp_adder_pinB;
  wire       [31:0]   tmp_comp_pinA;
  wire       [31:0]   tmp_comp_pinB;
  wire       [31:0]   adder_pinA;
  wire       [31:0]   adder_pinB;
  wire       [31:0]   adder_sum;
  wire       [31:0]   comp_pinA;
  wire       [31:0]   comp_pinB;
  wire       [31:0]   comp_res;
  wire                AgtB;

  assign tmp_adder_pinA = 32'h0;
  assign tmp_adder_pinB = 32'h0;
  assign tmp_comp_pinA = 32'h0;
  assign tmp_comp_pinB = 32'h0;
  assign adder_pinA = (maxpool_en ? tmp_adder_pinA : pinA);
  assign adder_pinB = (maxpool_en ? tmp_adder_pinB : pinB);
  assign adder_sum = ($signed(adder_pinA) + $signed(adder_pinB));
  assign AgtB = ($signed(comp_pinB) < $signed(comp_pinA));
  assign comp_pinA = (maxpool_en ? pinA : tmp_comp_pinA);
  assign comp_pinB = (maxpool_en ? pinB : tmp_comp_pinB);
  assign comp_res = (AgtB ? comp_pinA : comp_pinB);
  assign result = (maxpool_en ? comp_res : adder_sum);

endmodule

module multiplier_wrap (
  input      [7:0]    dinA,
  input      [7:0]    dinB,
  input               din_vld,
  output     [15:0]   dout,
  output              finish,
  output              dout_vld,
  input               clk,
  input               resetn
);

  wire       [15:0]   mul_dout;
  wire                mul_dout_vld;

  SimpleSignedMul mul (
    .dinA     (dinA[7:0]     ), //i
    .dinB     (dinB[7:0]     ), //i
    .din_vld  (din_vld       ), //i
    .dout     (mul_dout[15:0]), //o
    .dout_vld (mul_dout_vld  ), //o
    .clk      (clk           ), //i
    .resetn   (resetn        )  //i
  );
  assign dout = mul_dout;
  assign dout_vld = mul_dout_vld;
  assign finish = din_vld;

endmodule

module regMem1r1w (
  input               writeValid,
  input               readValid,
  input      [6:0]    waddress,
  input      [6:0]    raddress,
  input      [31:0]   writeData,
  output     [31:0]   readData,
  input               clk,
  input               resetn
);

  reg        [31:0]   tmp_mem_port1;
  reg [31:0] mem [0:127];

  always @(posedge clk) begin
    if(writeValid) begin
      mem[waddress] <= writeData;
    end
  end

  always @(posedge clk) begin
    if(readValid) begin
      tmp_mem_port1 <= mem[raddress];
    end
  end

  assign readData = tmp_mem_port1;

endmodule

module RoundToInf_unit (
  input      [31:0]   indata,
  input      [7:0]    roundbits,
  output     [31:0]   outdata
);

  wire       [4:0]    tmp_decide_bit;
  wire       [31:0]   tmp_outdata;
  wire       [31:0]   tmp_outdata_1;
  wire       [31:0]   tmp_outdata_2;
  wire       [31:0]   tmp_outdata_3;
  wire       [4:0]    roundbit;
  wire                isZero;
  wire       [31:0]   decide_bit;

  assign tmp_decide_bit = (roundbit - 5'h01);
  assign tmp_outdata = ($signed(tmp_outdata_1) + $signed(tmp_outdata_3));
  assign tmp_outdata_1 = ($signed(tmp_outdata_2) >>> roundbit);
  assign tmp_outdata_2 = indata;
  assign tmp_outdata_3 = decide_bit;
  assign roundbit = roundbits[4:0];
  assign isZero = (roundbits == 8'h0);
  assign decide_bit = {31'h0,indata[tmp_decide_bit]};
  assign outdata = (isZero ? indata : tmp_outdata);

endmodule

module SimpleSignedMul (
  input      [7:0]    dinA,
  input      [7:0]    dinB,
  input               din_vld,
  output     [15:0]   dout,
  output              dout_vld,
  input               clk,
  input               resetn
);

  wire       [15:0]   mul_io_dout;
  wire                mul_io_dout_vld;

  SignMultiplier mul (
    .io_dinA     (dinA[7:0]        ), //i
    .io_dinB     (dinB[7:0]        ), //i
    .io_din_vld  (din_vld          ), //i
    .io_dout     (mul_io_dout[15:0]), //o
    .io_dout_vld (mul_io_dout_vld  ), //o
    .clk         (clk              ), //i
    .resetn      (resetn           )  //i
  );
  assign dout = mul_io_dout;
  assign dout_vld = mul_io_dout_vld;

endmodule

module SignMultiplier (
  input      [7:0]    io_dinA,
  input      [7:0]    io_dinB,
  input               io_din_vld,
  output     [15:0]   io_dout,
  output              io_dout_vld,
  input               clk,
  input               resetn
);

  reg        [15:0]   Result;
  reg                 dout_vld_reg;

  assign io_dout = Result;
  assign io_dout_vld = dout_vld_reg;
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      Result <= 16'h0;
      dout_vld_reg <= 1'b0;
    end else begin
      dout_vld_reg <= io_din_vld;
      if(io_din_vld) begin
        Result <= ($signed(io_dinA) * $signed(io_dinB));
      end
    end
  end


endmodule
