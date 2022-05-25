// Generator : SpinalHDL v1.7.0    git head : eca519e78d4e6022e34911ec300a432ed9db8220
// Component : pe_unit
// Git hash  : 78567cd3da2e286f693b2551ff06d9ff6f41c4ad

`timescale 1ns/1ps

module pe_unit (
  input               pe_ifmap_in_valid,
  input      [7:0]    pe_ifmap_in_payload,
  output              pe_ofmap_out_valid,
  output     [7:0]    pe_ofmap_out_payload,
  input               pe_ctrl_ps_back_en,
  input      [6:0]    pe_ctrl_ps_addr,
  input               pe_ctrl_ps_outer_en,
  input               pe_ctrl_byp_mul_en,
  input               pe_ctrl_maxpool_en,
  input               pe_ctrl_bias_mul_en,
  input      [15:0]   pe_ctrl_shift_scale,
  input               clk,
  input               resetn
);

  wire       [15:0]   Multiplier_dout;
  wire                Multiplier_dout_vld;
  reg        [7:0]    Mula;
  wire       [7:0]    Mulb;
  wire                MulaAfterMux_valid;
  wire       [7:0]    MulaAfterMux_payload;
  reg                 MulaAfterMux_valid_regNext;

  multiplier_wrap Multiplier (
    .dinA     (Mula[7:0]                 ), //i
    .dinB     (Mula[7:0]                 ), //i
    .din_vld  (MulaAfterMux_valid_regNext), //i
    .dout     (Multiplier_dout[15:0]     ), //o
    .dout_vld (Multiplier_dout_vld       )  //o
  );
  assign Mulb = 8'h0;
  assign MulaAfterMux_valid = (pe_ctrl_ps_back_en ? pe_ofmap_out_valid : pe_ifmap_in_valid);
  assign MulaAfterMux_payload = (pe_ctrl_ps_back_en ? pe_ofmap_out_payload : pe_ifmap_in_payload);
  assign pe_ofmap_out_valid = 1'b0;
  assign pe_ofmap_out_payload = 8'h0;
  always @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      Mula <= 8'h0;
      MulaAfterMux_valid_regNext <= 1'b0;
    end else begin
      if(MulaAfterMux_valid) begin
        Mula <= MulaAfterMux_payload;
      end
      MulaAfterMux_valid_regNext <= MulaAfterMux_valid;
    end
  end


endmodule

module multiplier_wrap (
  input      [7:0]    dinA,
  input      [7:0]    dinB,
  input               din_vld,
  output     [15:0]   dout,
  output              dout_vld
);

  wire       [15:0]   mul_dout;
  wire                mul_dout_vld;

  SimpleSignedMul mul (
    .dinA     (dinA[7:0]     ), //i
    .dinB     (dinB[7:0]     ), //i
    .din_vld  (din_vld       ), //i
    .dout     (mul_dout[15:0]), //o
    .dout_vld (mul_dout_vld  )  //o
  );
  assign dout = mul_dout;
  assign dout_vld = mul_dout_vld;

endmodule
