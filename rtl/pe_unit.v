// Generator : SpinalHDL v1.7.0    git head : eca519e78d4e6022e34911ec300a432ed9db8220
// Component : pe_unit
// Git hash  : 3ad115d02ede82ce5afb11275af1efb2655ff862

`timescale 1ns/1ps

module pe_unit (
  input               pe_weight_in_valid,
  input      [7:0]    pe_weight_in_payload,
  input               pe_ifmap_in_valid,
  input      [7:0]    pe_ifmap_in_payload,
  input               pe_bias_in_valid,
  input      [31:0]   pe_bias_in_payload,
  output              pe_ofmap_out_valid,
  output     [7:0]    pe_ofmap_out_payload,
  input               pe_ctrl_ps_back_en,
  input      [6:0]    pe_ctrl_ps_addr,
  input               pe_ctrl_ps_wr,
  input               pe_ctrl_ps_rd,
  input               pe_ctrl_ps_outer_en,
  input               pe_ctrl_byp_mul_en,
  input               pe_ctrl_maxpool_en,
  input               pe_ctrl_bias_mul_en,
  input      [4:0]    pe_ctrl_shift_scale,
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
  wire       [31:0]   Ps_rgfile_rdata;
  wire       [7:0]    qnt_quant_data;
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
  wire       [31:0]   bias_Adder;
  wire                ps_rf_rdata_valid;
  wire       [31:0]   ps_rf_rdata_payload;
  reg                 pe_ctrl_ps_rd_regNext;

  multiplier_wrap Multiplier (
    .dinA     (Mula[7:0]            ), //i
    .dinB     (Mulb[7:0]            ), //i
    .din_vld  (pe_flags_ps_rd_ready ), //i
    .dout     (Multiplier_dout[15:0]), //o
    .finish   (Multiplier_finish    ), //o
    .dout_vld (Multiplier_dout_vld  ), //o
    .clk      (clk                  ), //i
    .resetn   (resetn               )  //i
  );
  adder_unit Adder (
    .pinA       (mul_out_ext[31:0] ), //i
    .pinB       (bias_Adder[31:0]  ), //i
    .maxpool_en (pe_ctrl_maxpool_en), //i
    .result     (Adder_result[31:0])  //o
  );
  Ram1rw Ps_rgfile (
    .rd     (pe_ctrl_ps_rd        ), //i
    .wr     (pe_ctrl_ps_wr        ), //i
    .addr   (pe_ctrl_ps_addr[6:0] ), //i
    .wdata  (Ps_rgfile_wdata[31:0]), //i
    .rdata  (Ps_rgfile_rdata[31:0]), //o
    .clk    (clk                  ), //i
    .resetn (resetn               )  //i
  );
  QNT_unit qnt (
    .indata      (ps_rf_rdata_payload[31:0]), //i
    .shift_scale (pe_ctrl_shift_scale[4:0] ), //i
    .quant_data  (qnt_quant_data[7:0]      )  //o
  );
  assign bias_Mul_valid = pe_bias_in_valid;
  assign bias_Mul_payload = pe_bias_in_payload[7 : 0];
  assign MA_AfterMux_valid = (pe_ctrl_ps_back_en ? pe_ofmap_out_valid : pe_ifmap_in_valid);
  assign MA_AfterMux_payload = (pe_ctrl_ps_back_en ? pe_ofmap_out_payload : pe_ifmap_in_payload);
  assign MB_AfterMux_valid = (pe_ctrl_bias_mul_en ? bias_Mul_valid : pe_weight_in_valid);
  assign MB_AfterMux_payload = (pe_ctrl_bias_mul_en ? bias_Mul_payload : pe_weight_in_payload);
  assign pe_flags_ps_rd_ready = MA_AfterMux_valid_regNext;
  assign Mul_finish = Multiplier_finish;
  assign Mul_out_payload = Multiplier_dout;
  assign Mul_out_valid = Multiplier_dout_vld;
  assign pe_flags_ps_wr_ready = Mul_finish;
  assign mul_out_ext = {{16{Mul_out_payload[15]}}, Mul_out_payload};
  assign adder_out_payload = Adder_result;
  assign adder_out_valid = Mul_out_valid;
  assign Ps_rgfile_wdata = adder_out_payload;
  assign ps_rf_rdata_payload = Ps_rgfile_rdata;
  assign ps_rf_rdata_valid = pe_ctrl_ps_rd_regNext;
  assign bias_Adder = (pe_ctrl_ps_outer_en ? pe_bias_in_payload : ps_rf_rdata_payload);
  assign pe_ofmap_out_valid = ps_rf_rdata_valid;
  assign pe_ofmap_out_payload = qnt_quant_data;
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      Mula <= 8'h0;
      Mulb <= 8'h0;
      MA_AfterMux_valid_regNext <= 1'b0;
      pe_ctrl_ps_rd_regNext <= 1'b0;
    end else begin
      if(MA_AfterMux_valid) begin
        Mula <= MA_AfterMux_payload;
      end
      if(MB_AfterMux_valid) begin
        Mulb <= MB_AfterMux_payload;
      end
      MA_AfterMux_valid_regNext <= MA_AfterMux_valid;
      pe_ctrl_ps_rd_regNext <= pe_ctrl_ps_rd;
    end
  end


endmodule

module QNT_unit (
  input      [31:0]   indata,
  input      [4:0]    shift_scale,
  output     [7:0]    quant_data
);

  wire       [31:0]   roundtoinf_indata;
  wire       [4:0]    roundtoinf_roundbits;
  wire       [31:0]   roundtoinf_outdata;
  wire       [4:0]    tmp_scale_abs;
  wire       [4:0]    tmp_scale_abs_1;
  wire       [4:0]    tmp_scale_abs_2;
  wire       [0:0]    tmp_scale_abs_3;
  wire       [31:0]   tmp_indata_after_shift;
  wire       [24:0]   tmp_when_SInt_l131;
  wire       [23:0]   tmp_when_SInt_l137;
  wire                isSign;
  wire       [4:0]    scale_abs;
  wire       [31:0]   indata_after_shift;
  wire       [31:0]   indata_after_round;
  reg        [7:0]    tmp_quant_data;
  wire                when_SInt_l130;
  wire                when_SInt_l131;
  wire                when_SInt_l137;

  assign tmp_scale_abs = (shift_scale[4] ? tmp_scale_abs_1 : shift_scale);
  assign tmp_scale_abs_1 = (~ shift_scale);
  assign tmp_scale_abs_3 = shift_scale[4];
  assign tmp_scale_abs_2 = {4'd0, tmp_scale_abs_3};
  assign tmp_indata_after_shift = ($signed(indata) <<< scale_abs);
  assign tmp_when_SInt_l131 = indata_after_round[31 : 7];
  assign tmp_when_SInt_l137 = indata_after_round[30 : 7];
  RoundToInf_unit roundtoinf (
    .indata    (roundtoinf_indata[31:0]  ), //i
    .roundbits (roundtoinf_roundbits[4:0]), //i
    .outdata   (roundtoinf_outdata[31:0] )  //o
  );
  assign isSign = shift_scale[4];
  assign scale_abs = (tmp_scale_abs + tmp_scale_abs_2);
  assign indata_after_shift = (isSign ? indata : tmp_indata_after_shift);
  assign roundtoinf_indata = indata_after_shift;
  assign roundtoinf_roundbits = (isSign ? scale_abs : 5'h0);
  assign indata_after_round = roundtoinf_outdata;
  assign when_SInt_l130 = indata_after_round[31];
  assign when_SInt_l131 = (! (&tmp_when_SInt_l131));
  always @(*) begin
    if(when_SInt_l130) begin
      if(when_SInt_l131) begin
        tmp_quant_data = 8'h80;
      end else begin
        tmp_quant_data = indata_after_round[7 : 0];
      end
    end else begin
      if(when_SInt_l137) begin
        tmp_quant_data = 8'h7f;
      end else begin
        tmp_quant_data = indata_after_round[7 : 0];
      end
    end
  end

  assign when_SInt_l137 = (|tmp_when_SInt_l137);
  assign quant_data = tmp_quant_data;

endmodule

module Ram1rw (
  input               rd,
  input               wr,
  input      [6:0]    addr,
  input      [31:0]   wdata,
  output     [31:0]   rdata,
  input               clk,
  input               resetn
);

  wire       [31:0]   ram_readData;

  regMem1rw ram (
    .writeValid (wr                ), //i
    .readValid  (rd                ), //i
    .address    (addr[6:0]         ), //i
    .writeData  (wdata[31:0]       ), //i
    .readData   (ram_readData[31:0]), //o
    .clk        (clk               ), //i
    .resetn     (resetn            )  //i
  );
  assign rdata = ram_readData;

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

module RoundToInf_unit (
  input      [31:0]   indata,
  input      [4:0]    roundbits,
  output     [31:0]   outdata
);

  wire       [4:0]    tmp_decide_bit;
  wire       [31:0]   tmp_outdata;
  wire       [31:0]   tmp_outdata_1;
  wire       [31:0]   tmp_outdata_2;
  wire       [31:0]   tmp_outdata_3;
  wire                isZero;
  wire       [31:0]   decide_bit;

  assign tmp_decide_bit = (roundbits - 5'h01);
  assign tmp_outdata = ($signed(tmp_outdata_1) + $signed(tmp_outdata_3));
  assign tmp_outdata_1 = ($signed(tmp_outdata_2) >>> roundbits);
  assign tmp_outdata_2 = indata;
  assign tmp_outdata_3 = decide_bit;
  assign isZero = (roundbits == 5'h0);
  assign decide_bit = {31'h0,indata[tmp_decide_bit]};
  assign outdata = (isZero ? indata : tmp_outdata);

endmodule

module regMem1rw (
  input               writeValid,
  input               readValid,
  input      [6:0]    address,
  input      [31:0]   writeData,
  output     [31:0]   readData,
  input               clk,
  input               resetn
);

  reg        [31:0]   tmp_mem_port1;
  reg [31:0] mem [0:127];

  always @(posedge clk) begin
    if(writeValid) begin
      mem[address] <= writeData;
    end
  end

  always @(posedge clk) begin
    if(readValid) begin
      tmp_mem_port1 <= mem[address];
    end
  end

  assign readData = tmp_mem_port1;

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
