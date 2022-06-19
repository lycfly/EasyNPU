// Generator : SpinalHDL v1.7.0    git head : eca519e78d4e6022e34911ec300a432ed9db8220
// Component : We_scratch_pad
// Git hash  : 4cf7f97c71a2bf6b231eea3b8cc7534ce901135c

`timescale 1ns/1ps

module We_scratch_pad (
  input               wescp_wbus_wr,
  input      [3:0]    wescp_wbus_waddr,
  input      [127:0]  wescp_wbus_wdata,
  input               wescp_ctrl_we_rd,
  input               wescp_ctrl_bs_wr,
  input               wescp_ctrl_bs_rd,
  input               wescp_ctrl_sc_rd,
  input      [2:0]    wescp_ctrl_bs_byte_cnt,
  input      [3:0]    wescp_ctrl_och_gcnt,
  output     [7:0]    we_pe_bus_0,
  output     [7:0]    we_pe_bus_1,
  output     [7:0]    we_pe_bus_2,
  output     [7:0]    we_pe_bus_3,
  output     [7:0]    we_pe_bus_4,
  output     [7:0]    we_pe_bus_5,
  output     [7:0]    we_pe_bus_6,
  output     [7:0]    we_pe_bus_7,
  output     [7:0]    we_pe_bus_8,
  output     [7:0]    we_pe_bus_9,
  output     [7:0]    we_pe_bus_10,
  output     [7:0]    we_pe_bus_11,
  output     [7:0]    we_pe_bus_12,
  output     [7:0]    we_pe_bus_13,
  output     [7:0]    we_pe_bus_14,
  output     [7:0]    we_pe_bus_15,
  output reg [31:0]   bias_pe_bus_0,
  output reg [31:0]   bias_pe_bus_1,
  output reg [31:0]   bias_pe_bus_2,
  output reg [31:0]   bias_pe_bus_3,
  output reg [31:0]   bias_pe_bus_4,
  output reg [31:0]   bias_pe_bus_5,
  output reg [31:0]   bias_pe_bus_6,
  output reg [31:0]   bias_pe_bus_7,
  output reg [31:0]   bias_pe_bus_8,
  output reg [31:0]   bias_pe_bus_9,
  output reg [31:0]   bias_pe_bus_10,
  output reg [31:0]   bias_pe_bus_11,
  output reg [31:0]   bias_pe_bus_12,
  output reg [31:0]   bias_pe_bus_13,
  output reg [31:0]   bias_pe_bus_14,
  output reg [31:0]   bias_pe_bus_15,
  output     [7:0]    scale_pe_bus_0,
  output     [7:0]    scale_pe_bus_1,
  output     [7:0]    scale_pe_bus_2,
  output     [7:0]    scale_pe_bus_3,
  output     [7:0]    scale_pe_bus_4,
  output     [7:0]    scale_pe_bus_5,
  output     [7:0]    scale_pe_bus_6,
  output     [7:0]    scale_pe_bus_7,
  output     [7:0]    scale_pe_bus_8,
  output     [7:0]    scale_pe_bus_9,
  output     [7:0]    scale_pe_bus_10,
  output     [7:0]    scale_pe_bus_11,
  output     [7:0]    scale_pe_bus_12,
  output     [7:0]    scale_pe_bus_13,
  output     [7:0]    scale_pe_bus_14,
  output     [7:0]    scale_pe_bus_15,
  input               clk,
  input               resetn
);

  wire                Bs_rf_0_0_wbus_wr;
  wire                Bs_rf_0_1_wbus_wr;
  wire                Bs_rf_0_2_wbus_wr;
  wire                Bs_rf_0_3_wbus_wr;
  wire                Bs_rf_0_4_wbus_wr;
  wire                Bs_rf_1_0_wbus_wr;
  wire                Bs_rf_1_1_wbus_wr;
  wire                Bs_rf_1_2_wbus_wr;
  wire                Bs_rf_1_3_wbus_wr;
  wire                Bs_rf_1_4_wbus_wr;
  wire                Bs_rf_2_0_wbus_wr;
  wire                Bs_rf_2_1_wbus_wr;
  wire                Bs_rf_2_2_wbus_wr;
  wire                Bs_rf_2_3_wbus_wr;
  wire                Bs_rf_2_4_wbus_wr;
  wire                Bs_rf_3_0_wbus_wr;
  wire                Bs_rf_3_1_wbus_wr;
  wire                Bs_rf_3_2_wbus_wr;
  wire                Bs_rf_3_3_wbus_wr;
  wire                Bs_rf_3_4_wbus_wr;
  wire                Bs_rf_4_0_wbus_wr;
  wire                Bs_rf_4_1_wbus_wr;
  wire                Bs_rf_4_2_wbus_wr;
  wire                Bs_rf_4_3_wbus_wr;
  wire                Bs_rf_4_4_wbus_wr;
  wire                Bs_rf_5_0_wbus_wr;
  wire                Bs_rf_5_1_wbus_wr;
  wire                Bs_rf_5_2_wbus_wr;
  wire                Bs_rf_5_3_wbus_wr;
  wire                Bs_rf_5_4_wbus_wr;
  wire                Bs_rf_6_0_wbus_wr;
  wire                Bs_rf_6_1_wbus_wr;
  wire                Bs_rf_6_2_wbus_wr;
  wire                Bs_rf_6_3_wbus_wr;
  wire                Bs_rf_6_4_wbus_wr;
  wire                Bs_rf_7_0_wbus_wr;
  wire                Bs_rf_7_1_wbus_wr;
  wire                Bs_rf_7_2_wbus_wr;
  wire                Bs_rf_7_3_wbus_wr;
  wire                Bs_rf_7_4_wbus_wr;
  wire                Bs_rf_8_0_wbus_wr;
  wire                Bs_rf_8_1_wbus_wr;
  wire                Bs_rf_8_2_wbus_wr;
  wire                Bs_rf_8_3_wbus_wr;
  wire                Bs_rf_8_4_wbus_wr;
  wire                Bs_rf_9_0_wbus_wr;
  wire                Bs_rf_9_1_wbus_wr;
  wire                Bs_rf_9_2_wbus_wr;
  wire                Bs_rf_9_3_wbus_wr;
  wire                Bs_rf_9_4_wbus_wr;
  wire                Bs_rf_10_0_wbus_wr;
  wire                Bs_rf_10_1_wbus_wr;
  wire                Bs_rf_10_2_wbus_wr;
  wire                Bs_rf_10_3_wbus_wr;
  wire                Bs_rf_10_4_wbus_wr;
  wire                Bs_rf_11_0_wbus_wr;
  wire                Bs_rf_11_1_wbus_wr;
  wire                Bs_rf_11_2_wbus_wr;
  wire                Bs_rf_11_3_wbus_wr;
  wire                Bs_rf_11_4_wbus_wr;
  wire                Bs_rf_12_0_wbus_wr;
  wire                Bs_rf_12_1_wbus_wr;
  wire                Bs_rf_12_2_wbus_wr;
  wire                Bs_rf_12_3_wbus_wr;
  wire                Bs_rf_12_4_wbus_wr;
  wire                Bs_rf_13_0_wbus_wr;
  wire                Bs_rf_13_1_wbus_wr;
  wire                Bs_rf_13_2_wbus_wr;
  wire                Bs_rf_13_3_wbus_wr;
  wire                Bs_rf_13_4_wbus_wr;
  wire                Bs_rf_14_0_wbus_wr;
  wire                Bs_rf_14_1_wbus_wr;
  wire                Bs_rf_14_2_wbus_wr;
  wire                Bs_rf_14_3_wbus_wr;
  wire                Bs_rf_14_4_wbus_wr;
  wire                Bs_rf_15_0_wbus_wr;
  wire                Bs_rf_15_1_wbus_wr;
  wire                Bs_rf_15_2_wbus_wr;
  wire                Bs_rf_15_3_wbus_wr;
  wire                Bs_rf_15_4_wbus_wr;
  wire       [7:0]    We_rf_0_rbus_rdata;
  wire       [7:0]    We_rf_1_rbus_rdata;
  wire       [7:0]    We_rf_2_rbus_rdata;
  wire       [7:0]    We_rf_3_rbus_rdata;
  wire       [7:0]    We_rf_4_rbus_rdata;
  wire       [7:0]    We_rf_5_rbus_rdata;
  wire       [7:0]    We_rf_6_rbus_rdata;
  wire       [7:0]    We_rf_7_rbus_rdata;
  wire       [7:0]    We_rf_8_rbus_rdata;
  wire       [7:0]    We_rf_9_rbus_rdata;
  wire       [7:0]    We_rf_10_rbus_rdata;
  wire       [7:0]    We_rf_11_rbus_rdata;
  wire       [7:0]    We_rf_12_rbus_rdata;
  wire       [7:0]    We_rf_13_rbus_rdata;
  wire       [7:0]    We_rf_14_rbus_rdata;
  wire       [7:0]    We_rf_15_rbus_rdata;
  wire       [7:0]    Bs_rf_0_0_rbus_rdata;
  wire       [7:0]    Bs_rf_0_1_rbus_rdata;
  wire       [7:0]    Bs_rf_0_2_rbus_rdata;
  wire       [7:0]    Bs_rf_0_3_rbus_rdata;
  wire       [7:0]    Bs_rf_0_4_rbus_rdata;
  wire       [7:0]    Bs_rf_1_0_rbus_rdata;
  wire       [7:0]    Bs_rf_1_1_rbus_rdata;
  wire       [7:0]    Bs_rf_1_2_rbus_rdata;
  wire       [7:0]    Bs_rf_1_3_rbus_rdata;
  wire       [7:0]    Bs_rf_1_4_rbus_rdata;
  wire       [7:0]    Bs_rf_2_0_rbus_rdata;
  wire       [7:0]    Bs_rf_2_1_rbus_rdata;
  wire       [7:0]    Bs_rf_2_2_rbus_rdata;
  wire       [7:0]    Bs_rf_2_3_rbus_rdata;
  wire       [7:0]    Bs_rf_2_4_rbus_rdata;
  wire       [7:0]    Bs_rf_3_0_rbus_rdata;
  wire       [7:0]    Bs_rf_3_1_rbus_rdata;
  wire       [7:0]    Bs_rf_3_2_rbus_rdata;
  wire       [7:0]    Bs_rf_3_3_rbus_rdata;
  wire       [7:0]    Bs_rf_3_4_rbus_rdata;
  wire       [7:0]    Bs_rf_4_0_rbus_rdata;
  wire       [7:0]    Bs_rf_4_1_rbus_rdata;
  wire       [7:0]    Bs_rf_4_2_rbus_rdata;
  wire       [7:0]    Bs_rf_4_3_rbus_rdata;
  wire       [7:0]    Bs_rf_4_4_rbus_rdata;
  wire       [7:0]    Bs_rf_5_0_rbus_rdata;
  wire       [7:0]    Bs_rf_5_1_rbus_rdata;
  wire       [7:0]    Bs_rf_5_2_rbus_rdata;
  wire       [7:0]    Bs_rf_5_3_rbus_rdata;
  wire       [7:0]    Bs_rf_5_4_rbus_rdata;
  wire       [7:0]    Bs_rf_6_0_rbus_rdata;
  wire       [7:0]    Bs_rf_6_1_rbus_rdata;
  wire       [7:0]    Bs_rf_6_2_rbus_rdata;
  wire       [7:0]    Bs_rf_6_3_rbus_rdata;
  wire       [7:0]    Bs_rf_6_4_rbus_rdata;
  wire       [7:0]    Bs_rf_7_0_rbus_rdata;
  wire       [7:0]    Bs_rf_7_1_rbus_rdata;
  wire       [7:0]    Bs_rf_7_2_rbus_rdata;
  wire       [7:0]    Bs_rf_7_3_rbus_rdata;
  wire       [7:0]    Bs_rf_7_4_rbus_rdata;
  wire       [7:0]    Bs_rf_8_0_rbus_rdata;
  wire       [7:0]    Bs_rf_8_1_rbus_rdata;
  wire       [7:0]    Bs_rf_8_2_rbus_rdata;
  wire       [7:0]    Bs_rf_8_3_rbus_rdata;
  wire       [7:0]    Bs_rf_8_4_rbus_rdata;
  wire       [7:0]    Bs_rf_9_0_rbus_rdata;
  wire       [7:0]    Bs_rf_9_1_rbus_rdata;
  wire       [7:0]    Bs_rf_9_2_rbus_rdata;
  wire       [7:0]    Bs_rf_9_3_rbus_rdata;
  wire       [7:0]    Bs_rf_9_4_rbus_rdata;
  wire       [7:0]    Bs_rf_10_0_rbus_rdata;
  wire       [7:0]    Bs_rf_10_1_rbus_rdata;
  wire       [7:0]    Bs_rf_10_2_rbus_rdata;
  wire       [7:0]    Bs_rf_10_3_rbus_rdata;
  wire       [7:0]    Bs_rf_10_4_rbus_rdata;
  wire       [7:0]    Bs_rf_11_0_rbus_rdata;
  wire       [7:0]    Bs_rf_11_1_rbus_rdata;
  wire       [7:0]    Bs_rf_11_2_rbus_rdata;
  wire       [7:0]    Bs_rf_11_3_rbus_rdata;
  wire       [7:0]    Bs_rf_11_4_rbus_rdata;
  wire       [7:0]    Bs_rf_12_0_rbus_rdata;
  wire       [7:0]    Bs_rf_12_1_rbus_rdata;
  wire       [7:0]    Bs_rf_12_2_rbus_rdata;
  wire       [7:0]    Bs_rf_12_3_rbus_rdata;
  wire       [7:0]    Bs_rf_12_4_rbus_rdata;
  wire       [7:0]    Bs_rf_13_0_rbus_rdata;
  wire       [7:0]    Bs_rf_13_1_rbus_rdata;
  wire       [7:0]    Bs_rf_13_2_rbus_rdata;
  wire       [7:0]    Bs_rf_13_3_rbus_rdata;
  wire       [7:0]    Bs_rf_13_4_rbus_rdata;
  wire       [7:0]    Bs_rf_14_0_rbus_rdata;
  wire       [7:0]    Bs_rf_14_1_rbus_rdata;
  wire       [7:0]    Bs_rf_14_2_rbus_rdata;
  wire       [7:0]    Bs_rf_14_3_rbus_rdata;
  wire       [7:0]    Bs_rf_14_4_rbus_rdata;
  wire       [7:0]    Bs_rf_15_0_rbus_rdata;
  wire       [7:0]    Bs_rf_15_1_rbus_rdata;
  wire       [7:0]    Bs_rf_15_2_rbus_rdata;
  wire       [7:0]    Bs_rf_15_3_rbus_rdata;
  wire       [7:0]    Bs_rf_15_4_rbus_rdata;
  wire       [7:0]    wewdata_0;
  wire       [7:0]    wewdata_1;
  wire       [7:0]    wewdata_2;
  wire       [7:0]    wewdata_3;
  wire       [7:0]    wewdata_4;
  wire       [7:0]    wewdata_5;
  wire       [7:0]    wewdata_6;
  wire       [7:0]    wewdata_7;
  wire       [7:0]    wewdata_8;
  wire       [7:0]    wewdata_9;
  wire       [7:0]    wewdata_10;
  wire       [7:0]    wewdata_11;
  wire       [7:0]    wewdata_12;
  wire       [7:0]    wewdata_13;
  wire       [7:0]    wewdata_14;
  wire       [7:0]    wewdata_15;
  reg                 bs_wr_byte_sel_0;
  reg                 bs_wr_byte_sel_1;
  reg                 bs_wr_byte_sel_2;
  reg                 bs_wr_byte_sel_3;
  reg                 bs_wr_byte_sel_4;
  wire                when_we_scratch_pad_l59;
  wire                when_we_scratch_pad_l59_1;
  wire                when_we_scratch_pad_l59_2;
  wire                when_we_scratch_pad_l59_3;
  wire                when_we_scratch_pad_l59_4;

  regfile We_rf_0 (
    .wbus_wr    (wescp_wbus_wr           ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]   ), //i
    .wbus_wdata (wewdata_0[7:0]          ), //i
    .rbus_rd    (wescp_ctrl_we_rd        ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]), //i
    .rbus_rdata (We_rf_0_rbus_rdata[7:0] ), //o
    .clk        (clk                     ), //i
    .resetn     (resetn                  )  //i
  );
  regfile We_rf_1 (
    .wbus_wr    (wescp_wbus_wr           ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]   ), //i
    .wbus_wdata (wewdata_1[7:0]          ), //i
    .rbus_rd    (wescp_ctrl_we_rd        ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]), //i
    .rbus_rdata (We_rf_1_rbus_rdata[7:0] ), //o
    .clk        (clk                     ), //i
    .resetn     (resetn                  )  //i
  );
  regfile We_rf_2 (
    .wbus_wr    (wescp_wbus_wr           ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]   ), //i
    .wbus_wdata (wewdata_2[7:0]          ), //i
    .rbus_rd    (wescp_ctrl_we_rd        ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]), //i
    .rbus_rdata (We_rf_2_rbus_rdata[7:0] ), //o
    .clk        (clk                     ), //i
    .resetn     (resetn                  )  //i
  );
  regfile We_rf_3 (
    .wbus_wr    (wescp_wbus_wr           ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]   ), //i
    .wbus_wdata (wewdata_3[7:0]          ), //i
    .rbus_rd    (wescp_ctrl_we_rd        ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]), //i
    .rbus_rdata (We_rf_3_rbus_rdata[7:0] ), //o
    .clk        (clk                     ), //i
    .resetn     (resetn                  )  //i
  );
  regfile We_rf_4 (
    .wbus_wr    (wescp_wbus_wr           ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]   ), //i
    .wbus_wdata (wewdata_4[7:0]          ), //i
    .rbus_rd    (wescp_ctrl_we_rd        ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]), //i
    .rbus_rdata (We_rf_4_rbus_rdata[7:0] ), //o
    .clk        (clk                     ), //i
    .resetn     (resetn                  )  //i
  );
  regfile We_rf_5 (
    .wbus_wr    (wescp_wbus_wr           ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]   ), //i
    .wbus_wdata (wewdata_5[7:0]          ), //i
    .rbus_rd    (wescp_ctrl_we_rd        ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]), //i
    .rbus_rdata (We_rf_5_rbus_rdata[7:0] ), //o
    .clk        (clk                     ), //i
    .resetn     (resetn                  )  //i
  );
  regfile We_rf_6 (
    .wbus_wr    (wescp_wbus_wr           ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]   ), //i
    .wbus_wdata (wewdata_6[7:0]          ), //i
    .rbus_rd    (wescp_ctrl_we_rd        ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]), //i
    .rbus_rdata (We_rf_6_rbus_rdata[7:0] ), //o
    .clk        (clk                     ), //i
    .resetn     (resetn                  )  //i
  );
  regfile We_rf_7 (
    .wbus_wr    (wescp_wbus_wr           ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]   ), //i
    .wbus_wdata (wewdata_7[7:0]          ), //i
    .rbus_rd    (wescp_ctrl_we_rd        ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]), //i
    .rbus_rdata (We_rf_7_rbus_rdata[7:0] ), //o
    .clk        (clk                     ), //i
    .resetn     (resetn                  )  //i
  );
  regfile We_rf_8 (
    .wbus_wr    (wescp_wbus_wr           ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]   ), //i
    .wbus_wdata (wewdata_8[7:0]          ), //i
    .rbus_rd    (wescp_ctrl_we_rd        ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]), //i
    .rbus_rdata (We_rf_8_rbus_rdata[7:0] ), //o
    .clk        (clk                     ), //i
    .resetn     (resetn                  )  //i
  );
  regfile We_rf_9 (
    .wbus_wr    (wescp_wbus_wr           ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]   ), //i
    .wbus_wdata (wewdata_9[7:0]          ), //i
    .rbus_rd    (wescp_ctrl_we_rd        ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]), //i
    .rbus_rdata (We_rf_9_rbus_rdata[7:0] ), //o
    .clk        (clk                     ), //i
    .resetn     (resetn                  )  //i
  );
  regfile We_rf_10 (
    .wbus_wr    (wescp_wbus_wr           ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]   ), //i
    .wbus_wdata (wewdata_10[7:0]         ), //i
    .rbus_rd    (wescp_ctrl_we_rd        ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]), //i
    .rbus_rdata (We_rf_10_rbus_rdata[7:0]), //o
    .clk        (clk                     ), //i
    .resetn     (resetn                  )  //i
  );
  regfile We_rf_11 (
    .wbus_wr    (wescp_wbus_wr           ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]   ), //i
    .wbus_wdata (wewdata_11[7:0]         ), //i
    .rbus_rd    (wescp_ctrl_we_rd        ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]), //i
    .rbus_rdata (We_rf_11_rbus_rdata[7:0]), //o
    .clk        (clk                     ), //i
    .resetn     (resetn                  )  //i
  );
  regfile We_rf_12 (
    .wbus_wr    (wescp_wbus_wr           ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]   ), //i
    .wbus_wdata (wewdata_12[7:0]         ), //i
    .rbus_rd    (wescp_ctrl_we_rd        ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]), //i
    .rbus_rdata (We_rf_12_rbus_rdata[7:0]), //o
    .clk        (clk                     ), //i
    .resetn     (resetn                  )  //i
  );
  regfile We_rf_13 (
    .wbus_wr    (wescp_wbus_wr           ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]   ), //i
    .wbus_wdata (wewdata_13[7:0]         ), //i
    .rbus_rd    (wescp_ctrl_we_rd        ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]), //i
    .rbus_rdata (We_rf_13_rbus_rdata[7:0]), //o
    .clk        (clk                     ), //i
    .resetn     (resetn                  )  //i
  );
  regfile We_rf_14 (
    .wbus_wr    (wescp_wbus_wr           ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]   ), //i
    .wbus_wdata (wewdata_14[7:0]         ), //i
    .rbus_rd    (wescp_ctrl_we_rd        ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]), //i
    .rbus_rdata (We_rf_14_rbus_rdata[7:0]), //o
    .clk        (clk                     ), //i
    .resetn     (resetn                  )  //i
  );
  regfile We_rf_15 (
    .wbus_wr    (wescp_wbus_wr           ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]   ), //i
    .wbus_wdata (wewdata_15[7:0]         ), //i
    .rbus_rd    (wescp_ctrl_we_rd        ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]), //i
    .rbus_rdata (We_rf_15_rbus_rdata[7:0]), //o
    .clk        (clk                     ), //i
    .resetn     (resetn                  )  //i
  );
  regfile Bs_rf_0_0 (
    .wbus_wr    (Bs_rf_0_0_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_0[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_0_0_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_0_1 (
    .wbus_wr    (Bs_rf_0_1_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_0[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_0_1_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_0_2 (
    .wbus_wr    (Bs_rf_0_2_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_0[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_0_2_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_0_3 (
    .wbus_wr    (Bs_rf_0_3_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_0[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_0_3_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_0_4 (
    .wbus_wr    (Bs_rf_0_4_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_0[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_sc_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_0_4_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_1_0 (
    .wbus_wr    (Bs_rf_1_0_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_1[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_1_0_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_1_1 (
    .wbus_wr    (Bs_rf_1_1_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_1[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_1_1_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_1_2 (
    .wbus_wr    (Bs_rf_1_2_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_1[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_1_2_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_1_3 (
    .wbus_wr    (Bs_rf_1_3_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_1[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_1_3_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_1_4 (
    .wbus_wr    (Bs_rf_1_4_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_1[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_sc_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_1_4_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_2_0 (
    .wbus_wr    (Bs_rf_2_0_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_2[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_2_0_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_2_1 (
    .wbus_wr    (Bs_rf_2_1_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_2[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_2_1_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_2_2 (
    .wbus_wr    (Bs_rf_2_2_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_2[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_2_2_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_2_3 (
    .wbus_wr    (Bs_rf_2_3_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_2[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_2_3_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_2_4 (
    .wbus_wr    (Bs_rf_2_4_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_2[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_sc_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_2_4_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_3_0 (
    .wbus_wr    (Bs_rf_3_0_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_3[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_3_0_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_3_1 (
    .wbus_wr    (Bs_rf_3_1_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_3[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_3_1_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_3_2 (
    .wbus_wr    (Bs_rf_3_2_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_3[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_3_2_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_3_3 (
    .wbus_wr    (Bs_rf_3_3_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_3[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_3_3_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_3_4 (
    .wbus_wr    (Bs_rf_3_4_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_3[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_sc_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_3_4_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_4_0 (
    .wbus_wr    (Bs_rf_4_0_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_4[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_4_0_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_4_1 (
    .wbus_wr    (Bs_rf_4_1_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_4[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_4_1_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_4_2 (
    .wbus_wr    (Bs_rf_4_2_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_4[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_4_2_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_4_3 (
    .wbus_wr    (Bs_rf_4_3_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_4[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_4_3_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_4_4 (
    .wbus_wr    (Bs_rf_4_4_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_4[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_sc_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_4_4_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_5_0 (
    .wbus_wr    (Bs_rf_5_0_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_5[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_5_0_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_5_1 (
    .wbus_wr    (Bs_rf_5_1_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_5[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_5_1_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_5_2 (
    .wbus_wr    (Bs_rf_5_2_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_5[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_5_2_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_5_3 (
    .wbus_wr    (Bs_rf_5_3_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_5[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_5_3_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_5_4 (
    .wbus_wr    (Bs_rf_5_4_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_5[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_sc_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_5_4_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_6_0 (
    .wbus_wr    (Bs_rf_6_0_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_6[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_6_0_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_6_1 (
    .wbus_wr    (Bs_rf_6_1_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_6[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_6_1_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_6_2 (
    .wbus_wr    (Bs_rf_6_2_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_6[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_6_2_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_6_3 (
    .wbus_wr    (Bs_rf_6_3_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_6[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_6_3_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_6_4 (
    .wbus_wr    (Bs_rf_6_4_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_6[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_sc_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_6_4_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_7_0 (
    .wbus_wr    (Bs_rf_7_0_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_7[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_7_0_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_7_1 (
    .wbus_wr    (Bs_rf_7_1_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_7[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_7_1_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_7_2 (
    .wbus_wr    (Bs_rf_7_2_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_7[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_7_2_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_7_3 (
    .wbus_wr    (Bs_rf_7_3_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_7[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_7_3_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_7_4 (
    .wbus_wr    (Bs_rf_7_4_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_7[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_sc_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_7_4_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_8_0 (
    .wbus_wr    (Bs_rf_8_0_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_8[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_8_0_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_8_1 (
    .wbus_wr    (Bs_rf_8_1_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_8[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_8_1_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_8_2 (
    .wbus_wr    (Bs_rf_8_2_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_8[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_8_2_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_8_3 (
    .wbus_wr    (Bs_rf_8_3_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_8[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_8_3_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_8_4 (
    .wbus_wr    (Bs_rf_8_4_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_8[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_sc_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_8_4_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_9_0 (
    .wbus_wr    (Bs_rf_9_0_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_9[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_9_0_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_9_1 (
    .wbus_wr    (Bs_rf_9_1_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_9[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_9_1_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_9_2 (
    .wbus_wr    (Bs_rf_9_2_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_9[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_9_2_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_9_3 (
    .wbus_wr    (Bs_rf_9_3_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_9[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_9_3_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_9_4 (
    .wbus_wr    (Bs_rf_9_4_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]    ), //i
    .wbus_wdata (wewdata_9[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_sc_rd         ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0] ), //i
    .rbus_rdata (Bs_rf_9_4_rbus_rdata[7:0]), //o
    .clk        (clk                      ), //i
    .resetn     (resetn                   )  //i
  );
  regfile Bs_rf_10_0 (
    .wbus_wr    (Bs_rf_10_0_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_10[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_10_0_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_10_1 (
    .wbus_wr    (Bs_rf_10_1_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_10[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_10_1_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_10_2 (
    .wbus_wr    (Bs_rf_10_2_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_10[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_10_2_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_10_3 (
    .wbus_wr    (Bs_rf_10_3_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_10[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_10_3_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_10_4 (
    .wbus_wr    (Bs_rf_10_4_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_10[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_sc_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_10_4_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_11_0 (
    .wbus_wr    (Bs_rf_11_0_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_11[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_11_0_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_11_1 (
    .wbus_wr    (Bs_rf_11_1_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_11[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_11_1_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_11_2 (
    .wbus_wr    (Bs_rf_11_2_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_11[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_11_2_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_11_3 (
    .wbus_wr    (Bs_rf_11_3_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_11[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_11_3_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_11_4 (
    .wbus_wr    (Bs_rf_11_4_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_11[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_sc_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_11_4_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_12_0 (
    .wbus_wr    (Bs_rf_12_0_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_12[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_12_0_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_12_1 (
    .wbus_wr    (Bs_rf_12_1_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_12[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_12_1_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_12_2 (
    .wbus_wr    (Bs_rf_12_2_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_12[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_12_2_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_12_3 (
    .wbus_wr    (Bs_rf_12_3_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_12[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_12_3_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_12_4 (
    .wbus_wr    (Bs_rf_12_4_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_12[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_sc_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_12_4_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_13_0 (
    .wbus_wr    (Bs_rf_13_0_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_13[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_13_0_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_13_1 (
    .wbus_wr    (Bs_rf_13_1_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_13[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_13_1_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_13_2 (
    .wbus_wr    (Bs_rf_13_2_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_13[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_13_2_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_13_3 (
    .wbus_wr    (Bs_rf_13_3_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_13[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_13_3_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_13_4 (
    .wbus_wr    (Bs_rf_13_4_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_13[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_sc_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_13_4_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_14_0 (
    .wbus_wr    (Bs_rf_14_0_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_14[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_14_0_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_14_1 (
    .wbus_wr    (Bs_rf_14_1_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_14[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_14_1_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_14_2 (
    .wbus_wr    (Bs_rf_14_2_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_14[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_14_2_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_14_3 (
    .wbus_wr    (Bs_rf_14_3_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_14[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_14_3_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_14_4 (
    .wbus_wr    (Bs_rf_14_4_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_14[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_sc_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_14_4_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_15_0 (
    .wbus_wr    (Bs_rf_15_0_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_15[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_15_0_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_15_1 (
    .wbus_wr    (Bs_rf_15_1_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_15[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_15_1_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_15_2 (
    .wbus_wr    (Bs_rf_15_2_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_15[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_15_2_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_15_3 (
    .wbus_wr    (Bs_rf_15_3_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_15[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_bs_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_15_3_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  regfile Bs_rf_15_4 (
    .wbus_wr    (Bs_rf_15_4_wbus_wr        ), //i
    .wbus_waddr (wescp_wbus_waddr[3:0]     ), //i
    .wbus_wdata (wewdata_15[7:0]           ), //i
    .rbus_rd    (wescp_ctrl_sc_rd          ), //i
    .rbus_raddr (wescp_ctrl_och_gcnt[3:0]  ), //i
    .rbus_rdata (Bs_rf_15_4_rbus_rdata[7:0]), //o
    .clk        (clk                       ), //i
    .resetn     (resetn                    )  //i
  );
  assign wewdata_0 = wescp_wbus_wdata[7 : 0];
  assign wewdata_1 = wescp_wbus_wdata[15 : 8];
  assign wewdata_2 = wescp_wbus_wdata[23 : 16];
  assign wewdata_3 = wescp_wbus_wdata[31 : 24];
  assign wewdata_4 = wescp_wbus_wdata[39 : 32];
  assign wewdata_5 = wescp_wbus_wdata[47 : 40];
  assign wewdata_6 = wescp_wbus_wdata[55 : 48];
  assign wewdata_7 = wescp_wbus_wdata[63 : 56];
  assign wewdata_8 = wescp_wbus_wdata[71 : 64];
  assign wewdata_9 = wescp_wbus_wdata[79 : 72];
  assign wewdata_10 = wescp_wbus_wdata[87 : 80];
  assign wewdata_11 = wescp_wbus_wdata[95 : 88];
  assign wewdata_12 = wescp_wbus_wdata[103 : 96];
  assign wewdata_13 = wescp_wbus_wdata[111 : 104];
  assign wewdata_14 = wescp_wbus_wdata[119 : 112];
  assign wewdata_15 = wescp_wbus_wdata[127 : 120];
  assign we_pe_bus_0 = We_rf_0_rbus_rdata;
  assign we_pe_bus_1 = We_rf_1_rbus_rdata;
  assign we_pe_bus_2 = We_rf_2_rbus_rdata;
  assign we_pe_bus_3 = We_rf_3_rbus_rdata;
  assign we_pe_bus_4 = We_rf_4_rbus_rdata;
  assign we_pe_bus_5 = We_rf_5_rbus_rdata;
  assign we_pe_bus_6 = We_rf_6_rbus_rdata;
  assign we_pe_bus_7 = We_rf_7_rbus_rdata;
  assign we_pe_bus_8 = We_rf_8_rbus_rdata;
  assign we_pe_bus_9 = We_rf_9_rbus_rdata;
  assign we_pe_bus_10 = We_rf_10_rbus_rdata;
  assign we_pe_bus_11 = We_rf_11_rbus_rdata;
  assign we_pe_bus_12 = We_rf_12_rbus_rdata;
  assign we_pe_bus_13 = We_rf_13_rbus_rdata;
  assign we_pe_bus_14 = We_rf_14_rbus_rdata;
  assign we_pe_bus_15 = We_rf_15_rbus_rdata;
  assign when_we_scratch_pad_l59 = (wescp_ctrl_bs_byte_cnt == 3'b000);
  always @(*) begin
    if(when_we_scratch_pad_l59) begin
      bs_wr_byte_sel_0 = 1'b0;
    end else begin
      bs_wr_byte_sel_0 = wescp_ctrl_bs_wr;
    end
  end

  assign when_we_scratch_pad_l59_1 = (wescp_ctrl_bs_byte_cnt == 3'b001);
  always @(*) begin
    if(when_we_scratch_pad_l59_1) begin
      bs_wr_byte_sel_1 = 1'b0;
    end else begin
      bs_wr_byte_sel_1 = wescp_ctrl_bs_wr;
    end
  end

  assign when_we_scratch_pad_l59_2 = (wescp_ctrl_bs_byte_cnt == 3'b010);
  always @(*) begin
    if(when_we_scratch_pad_l59_2) begin
      bs_wr_byte_sel_2 = 1'b0;
    end else begin
      bs_wr_byte_sel_2 = wescp_ctrl_bs_wr;
    end
  end

  assign when_we_scratch_pad_l59_3 = (wescp_ctrl_bs_byte_cnt == 3'b011);
  always @(*) begin
    if(when_we_scratch_pad_l59_3) begin
      bs_wr_byte_sel_3 = 1'b0;
    end else begin
      bs_wr_byte_sel_3 = wescp_ctrl_bs_wr;
    end
  end

  assign when_we_scratch_pad_l59_4 = (wescp_ctrl_bs_byte_cnt == 3'b100);
  always @(*) begin
    if(when_we_scratch_pad_l59_4) begin
      bs_wr_byte_sel_4 = 1'b0;
    end else begin
      bs_wr_byte_sel_4 = wescp_ctrl_bs_wr;
    end
  end

  assign Bs_rf_0_0_wbus_wr = (bs_wr_byte_sel_0 && wescp_wbus_wr);
  always @(*) begin
    bias_pe_bus_0[7 : 0] = Bs_rf_0_0_rbus_rdata;
    bias_pe_bus_0[15 : 8] = Bs_rf_0_1_rbus_rdata;
    bias_pe_bus_0[23 : 16] = Bs_rf_0_2_rbus_rdata;
    bias_pe_bus_0[31 : 24] = Bs_rf_0_3_rbus_rdata;
  end

  assign Bs_rf_0_1_wbus_wr = (bs_wr_byte_sel_1 && wescp_wbus_wr);
  assign Bs_rf_0_2_wbus_wr = (bs_wr_byte_sel_2 && wescp_wbus_wr);
  assign Bs_rf_0_3_wbus_wr = (bs_wr_byte_sel_3 && wescp_wbus_wr);
  assign Bs_rf_0_4_wbus_wr = (bs_wr_byte_sel_4 && wescp_wbus_wr);
  assign scale_pe_bus_0 = Bs_rf_0_4_rbus_rdata;
  assign Bs_rf_1_0_wbus_wr = (bs_wr_byte_sel_0 && wescp_wbus_wr);
  always @(*) begin
    bias_pe_bus_1[7 : 0] = Bs_rf_1_0_rbus_rdata;
    bias_pe_bus_1[15 : 8] = Bs_rf_1_1_rbus_rdata;
    bias_pe_bus_1[23 : 16] = Bs_rf_1_2_rbus_rdata;
    bias_pe_bus_1[31 : 24] = Bs_rf_1_3_rbus_rdata;
  end

  assign Bs_rf_1_1_wbus_wr = (bs_wr_byte_sel_1 && wescp_wbus_wr);
  assign Bs_rf_1_2_wbus_wr = (bs_wr_byte_sel_2 && wescp_wbus_wr);
  assign Bs_rf_1_3_wbus_wr = (bs_wr_byte_sel_3 && wescp_wbus_wr);
  assign Bs_rf_1_4_wbus_wr = (bs_wr_byte_sel_4 && wescp_wbus_wr);
  assign scale_pe_bus_1 = Bs_rf_1_4_rbus_rdata;
  assign Bs_rf_2_0_wbus_wr = (bs_wr_byte_sel_0 && wescp_wbus_wr);
  always @(*) begin
    bias_pe_bus_2[7 : 0] = Bs_rf_2_0_rbus_rdata;
    bias_pe_bus_2[15 : 8] = Bs_rf_2_1_rbus_rdata;
    bias_pe_bus_2[23 : 16] = Bs_rf_2_2_rbus_rdata;
    bias_pe_bus_2[31 : 24] = Bs_rf_2_3_rbus_rdata;
  end

  assign Bs_rf_2_1_wbus_wr = (bs_wr_byte_sel_1 && wescp_wbus_wr);
  assign Bs_rf_2_2_wbus_wr = (bs_wr_byte_sel_2 && wescp_wbus_wr);
  assign Bs_rf_2_3_wbus_wr = (bs_wr_byte_sel_3 && wescp_wbus_wr);
  assign Bs_rf_2_4_wbus_wr = (bs_wr_byte_sel_4 && wescp_wbus_wr);
  assign scale_pe_bus_2 = Bs_rf_2_4_rbus_rdata;
  assign Bs_rf_3_0_wbus_wr = (bs_wr_byte_sel_0 && wescp_wbus_wr);
  always @(*) begin
    bias_pe_bus_3[7 : 0] = Bs_rf_3_0_rbus_rdata;
    bias_pe_bus_3[15 : 8] = Bs_rf_3_1_rbus_rdata;
    bias_pe_bus_3[23 : 16] = Bs_rf_3_2_rbus_rdata;
    bias_pe_bus_3[31 : 24] = Bs_rf_3_3_rbus_rdata;
  end

  assign Bs_rf_3_1_wbus_wr = (bs_wr_byte_sel_1 && wescp_wbus_wr);
  assign Bs_rf_3_2_wbus_wr = (bs_wr_byte_sel_2 && wescp_wbus_wr);
  assign Bs_rf_3_3_wbus_wr = (bs_wr_byte_sel_3 && wescp_wbus_wr);
  assign Bs_rf_3_4_wbus_wr = (bs_wr_byte_sel_4 && wescp_wbus_wr);
  assign scale_pe_bus_3 = Bs_rf_3_4_rbus_rdata;
  assign Bs_rf_4_0_wbus_wr = (bs_wr_byte_sel_0 && wescp_wbus_wr);
  always @(*) begin
    bias_pe_bus_4[7 : 0] = Bs_rf_4_0_rbus_rdata;
    bias_pe_bus_4[15 : 8] = Bs_rf_4_1_rbus_rdata;
    bias_pe_bus_4[23 : 16] = Bs_rf_4_2_rbus_rdata;
    bias_pe_bus_4[31 : 24] = Bs_rf_4_3_rbus_rdata;
  end

  assign Bs_rf_4_1_wbus_wr = (bs_wr_byte_sel_1 && wescp_wbus_wr);
  assign Bs_rf_4_2_wbus_wr = (bs_wr_byte_sel_2 && wescp_wbus_wr);
  assign Bs_rf_4_3_wbus_wr = (bs_wr_byte_sel_3 && wescp_wbus_wr);
  assign Bs_rf_4_4_wbus_wr = (bs_wr_byte_sel_4 && wescp_wbus_wr);
  assign scale_pe_bus_4 = Bs_rf_4_4_rbus_rdata;
  assign Bs_rf_5_0_wbus_wr = (bs_wr_byte_sel_0 && wescp_wbus_wr);
  always @(*) begin
    bias_pe_bus_5[7 : 0] = Bs_rf_5_0_rbus_rdata;
    bias_pe_bus_5[15 : 8] = Bs_rf_5_1_rbus_rdata;
    bias_pe_bus_5[23 : 16] = Bs_rf_5_2_rbus_rdata;
    bias_pe_bus_5[31 : 24] = Bs_rf_5_3_rbus_rdata;
  end

  assign Bs_rf_5_1_wbus_wr = (bs_wr_byte_sel_1 && wescp_wbus_wr);
  assign Bs_rf_5_2_wbus_wr = (bs_wr_byte_sel_2 && wescp_wbus_wr);
  assign Bs_rf_5_3_wbus_wr = (bs_wr_byte_sel_3 && wescp_wbus_wr);
  assign Bs_rf_5_4_wbus_wr = (bs_wr_byte_sel_4 && wescp_wbus_wr);
  assign scale_pe_bus_5 = Bs_rf_5_4_rbus_rdata;
  assign Bs_rf_6_0_wbus_wr = (bs_wr_byte_sel_0 && wescp_wbus_wr);
  always @(*) begin
    bias_pe_bus_6[7 : 0] = Bs_rf_6_0_rbus_rdata;
    bias_pe_bus_6[15 : 8] = Bs_rf_6_1_rbus_rdata;
    bias_pe_bus_6[23 : 16] = Bs_rf_6_2_rbus_rdata;
    bias_pe_bus_6[31 : 24] = Bs_rf_6_3_rbus_rdata;
  end

  assign Bs_rf_6_1_wbus_wr = (bs_wr_byte_sel_1 && wescp_wbus_wr);
  assign Bs_rf_6_2_wbus_wr = (bs_wr_byte_sel_2 && wescp_wbus_wr);
  assign Bs_rf_6_3_wbus_wr = (bs_wr_byte_sel_3 && wescp_wbus_wr);
  assign Bs_rf_6_4_wbus_wr = (bs_wr_byte_sel_4 && wescp_wbus_wr);
  assign scale_pe_bus_6 = Bs_rf_6_4_rbus_rdata;
  assign Bs_rf_7_0_wbus_wr = (bs_wr_byte_sel_0 && wescp_wbus_wr);
  always @(*) begin
    bias_pe_bus_7[7 : 0] = Bs_rf_7_0_rbus_rdata;
    bias_pe_bus_7[15 : 8] = Bs_rf_7_1_rbus_rdata;
    bias_pe_bus_7[23 : 16] = Bs_rf_7_2_rbus_rdata;
    bias_pe_bus_7[31 : 24] = Bs_rf_7_3_rbus_rdata;
  end

  assign Bs_rf_7_1_wbus_wr = (bs_wr_byte_sel_1 && wescp_wbus_wr);
  assign Bs_rf_7_2_wbus_wr = (bs_wr_byte_sel_2 && wescp_wbus_wr);
  assign Bs_rf_7_3_wbus_wr = (bs_wr_byte_sel_3 && wescp_wbus_wr);
  assign Bs_rf_7_4_wbus_wr = (bs_wr_byte_sel_4 && wescp_wbus_wr);
  assign scale_pe_bus_7 = Bs_rf_7_4_rbus_rdata;
  assign Bs_rf_8_0_wbus_wr = (bs_wr_byte_sel_0 && wescp_wbus_wr);
  always @(*) begin
    bias_pe_bus_8[7 : 0] = Bs_rf_8_0_rbus_rdata;
    bias_pe_bus_8[15 : 8] = Bs_rf_8_1_rbus_rdata;
    bias_pe_bus_8[23 : 16] = Bs_rf_8_2_rbus_rdata;
    bias_pe_bus_8[31 : 24] = Bs_rf_8_3_rbus_rdata;
  end

  assign Bs_rf_8_1_wbus_wr = (bs_wr_byte_sel_1 && wescp_wbus_wr);
  assign Bs_rf_8_2_wbus_wr = (bs_wr_byte_sel_2 && wescp_wbus_wr);
  assign Bs_rf_8_3_wbus_wr = (bs_wr_byte_sel_3 && wescp_wbus_wr);
  assign Bs_rf_8_4_wbus_wr = (bs_wr_byte_sel_4 && wescp_wbus_wr);
  assign scale_pe_bus_8 = Bs_rf_8_4_rbus_rdata;
  assign Bs_rf_9_0_wbus_wr = (bs_wr_byte_sel_0 && wescp_wbus_wr);
  always @(*) begin
    bias_pe_bus_9[7 : 0] = Bs_rf_9_0_rbus_rdata;
    bias_pe_bus_9[15 : 8] = Bs_rf_9_1_rbus_rdata;
    bias_pe_bus_9[23 : 16] = Bs_rf_9_2_rbus_rdata;
    bias_pe_bus_9[31 : 24] = Bs_rf_9_3_rbus_rdata;
  end

  assign Bs_rf_9_1_wbus_wr = (bs_wr_byte_sel_1 && wescp_wbus_wr);
  assign Bs_rf_9_2_wbus_wr = (bs_wr_byte_sel_2 && wescp_wbus_wr);
  assign Bs_rf_9_3_wbus_wr = (bs_wr_byte_sel_3 && wescp_wbus_wr);
  assign Bs_rf_9_4_wbus_wr = (bs_wr_byte_sel_4 && wescp_wbus_wr);
  assign scale_pe_bus_9 = Bs_rf_9_4_rbus_rdata;
  assign Bs_rf_10_0_wbus_wr = (bs_wr_byte_sel_0 && wescp_wbus_wr);
  always @(*) begin
    bias_pe_bus_10[7 : 0] = Bs_rf_10_0_rbus_rdata;
    bias_pe_bus_10[15 : 8] = Bs_rf_10_1_rbus_rdata;
    bias_pe_bus_10[23 : 16] = Bs_rf_10_2_rbus_rdata;
    bias_pe_bus_10[31 : 24] = Bs_rf_10_3_rbus_rdata;
  end

  assign Bs_rf_10_1_wbus_wr = (bs_wr_byte_sel_1 && wescp_wbus_wr);
  assign Bs_rf_10_2_wbus_wr = (bs_wr_byte_sel_2 && wescp_wbus_wr);
  assign Bs_rf_10_3_wbus_wr = (bs_wr_byte_sel_3 && wescp_wbus_wr);
  assign Bs_rf_10_4_wbus_wr = (bs_wr_byte_sel_4 && wescp_wbus_wr);
  assign scale_pe_bus_10 = Bs_rf_10_4_rbus_rdata;
  assign Bs_rf_11_0_wbus_wr = (bs_wr_byte_sel_0 && wescp_wbus_wr);
  always @(*) begin
    bias_pe_bus_11[7 : 0] = Bs_rf_11_0_rbus_rdata;
    bias_pe_bus_11[15 : 8] = Bs_rf_11_1_rbus_rdata;
    bias_pe_bus_11[23 : 16] = Bs_rf_11_2_rbus_rdata;
    bias_pe_bus_11[31 : 24] = Bs_rf_11_3_rbus_rdata;
  end

  assign Bs_rf_11_1_wbus_wr = (bs_wr_byte_sel_1 && wescp_wbus_wr);
  assign Bs_rf_11_2_wbus_wr = (bs_wr_byte_sel_2 && wescp_wbus_wr);
  assign Bs_rf_11_3_wbus_wr = (bs_wr_byte_sel_3 && wescp_wbus_wr);
  assign Bs_rf_11_4_wbus_wr = (bs_wr_byte_sel_4 && wescp_wbus_wr);
  assign scale_pe_bus_11 = Bs_rf_11_4_rbus_rdata;
  assign Bs_rf_12_0_wbus_wr = (bs_wr_byte_sel_0 && wescp_wbus_wr);
  always @(*) begin
    bias_pe_bus_12[7 : 0] = Bs_rf_12_0_rbus_rdata;
    bias_pe_bus_12[15 : 8] = Bs_rf_12_1_rbus_rdata;
    bias_pe_bus_12[23 : 16] = Bs_rf_12_2_rbus_rdata;
    bias_pe_bus_12[31 : 24] = Bs_rf_12_3_rbus_rdata;
  end

  assign Bs_rf_12_1_wbus_wr = (bs_wr_byte_sel_1 && wescp_wbus_wr);
  assign Bs_rf_12_2_wbus_wr = (bs_wr_byte_sel_2 && wescp_wbus_wr);
  assign Bs_rf_12_3_wbus_wr = (bs_wr_byte_sel_3 && wescp_wbus_wr);
  assign Bs_rf_12_4_wbus_wr = (bs_wr_byte_sel_4 && wescp_wbus_wr);
  assign scale_pe_bus_12 = Bs_rf_12_4_rbus_rdata;
  assign Bs_rf_13_0_wbus_wr = (bs_wr_byte_sel_0 && wescp_wbus_wr);
  always @(*) begin
    bias_pe_bus_13[7 : 0] = Bs_rf_13_0_rbus_rdata;
    bias_pe_bus_13[15 : 8] = Bs_rf_13_1_rbus_rdata;
    bias_pe_bus_13[23 : 16] = Bs_rf_13_2_rbus_rdata;
    bias_pe_bus_13[31 : 24] = Bs_rf_13_3_rbus_rdata;
  end

  assign Bs_rf_13_1_wbus_wr = (bs_wr_byte_sel_1 && wescp_wbus_wr);
  assign Bs_rf_13_2_wbus_wr = (bs_wr_byte_sel_2 && wescp_wbus_wr);
  assign Bs_rf_13_3_wbus_wr = (bs_wr_byte_sel_3 && wescp_wbus_wr);
  assign Bs_rf_13_4_wbus_wr = (bs_wr_byte_sel_4 && wescp_wbus_wr);
  assign scale_pe_bus_13 = Bs_rf_13_4_rbus_rdata;
  assign Bs_rf_14_0_wbus_wr = (bs_wr_byte_sel_0 && wescp_wbus_wr);
  always @(*) begin
    bias_pe_bus_14[7 : 0] = Bs_rf_14_0_rbus_rdata;
    bias_pe_bus_14[15 : 8] = Bs_rf_14_1_rbus_rdata;
    bias_pe_bus_14[23 : 16] = Bs_rf_14_2_rbus_rdata;
    bias_pe_bus_14[31 : 24] = Bs_rf_14_3_rbus_rdata;
  end

  assign Bs_rf_14_1_wbus_wr = (bs_wr_byte_sel_1 && wescp_wbus_wr);
  assign Bs_rf_14_2_wbus_wr = (bs_wr_byte_sel_2 && wescp_wbus_wr);
  assign Bs_rf_14_3_wbus_wr = (bs_wr_byte_sel_3 && wescp_wbus_wr);
  assign Bs_rf_14_4_wbus_wr = (bs_wr_byte_sel_4 && wescp_wbus_wr);
  assign scale_pe_bus_14 = Bs_rf_14_4_rbus_rdata;
  assign Bs_rf_15_0_wbus_wr = (bs_wr_byte_sel_0 && wescp_wbus_wr);
  always @(*) begin
    bias_pe_bus_15[7 : 0] = Bs_rf_15_0_rbus_rdata;
    bias_pe_bus_15[15 : 8] = Bs_rf_15_1_rbus_rdata;
    bias_pe_bus_15[23 : 16] = Bs_rf_15_2_rbus_rdata;
    bias_pe_bus_15[31 : 24] = Bs_rf_15_3_rbus_rdata;
  end

  assign Bs_rf_15_1_wbus_wr = (bs_wr_byte_sel_1 && wescp_wbus_wr);
  assign Bs_rf_15_2_wbus_wr = (bs_wr_byte_sel_2 && wescp_wbus_wr);
  assign Bs_rf_15_3_wbus_wr = (bs_wr_byte_sel_3 && wescp_wbus_wr);
  assign Bs_rf_15_4_wbus_wr = (bs_wr_byte_sel_4 && wescp_wbus_wr);
  assign scale_pe_bus_15 = Bs_rf_15_4_rbus_rdata;

endmodule

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

//regfile replaced by regfile

module regfile (
  input               wbus_wr,
  input      [3:0]    wbus_waddr,
  input      [7:0]    wbus_wdata,
  input               rbus_rd,
  input      [3:0]    rbus_raddr,
  output     [7:0]    rbus_rdata,
  input               clk,
  input               resetn
);

  wire       [7:0]    rf_rdata;

  Ram1r1w rf (
    .rd     (rbus_rd        ), //i
    .wr     (wbus_wr        ), //i
    .waddr  (wbus_waddr[3:0]), //i
    .raddr  (rbus_raddr[3:0]), //i
    .wdata  (wbus_wdata[7:0]), //i
    .rdata  (rf_rdata[7:0]  ), //o
    .clk    (clk            ), //i
    .resetn (resetn         )  //i
  );
  assign rbus_rdata = rf_rdata;

endmodule

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

//Ram1r1w replaced by Ram1r1w

module Ram1r1w (
  input               rd,
  input               wr,
  input      [3:0]    waddr,
  input      [3:0]    raddr,
  input      [7:0]    wdata,
  output     [7:0]    rdata,
  input               clk,
  input               resetn
);

  wire       [7:0]    ram_readData;

  regMem1r1w ram (
    .writeValid (wr               ), //i
    .readValid  (rd               ), //i
    .waddress   (waddr[3:0]       ), //i
    .raddress   (raddr[3:0]       ), //i
    .writeData  (wdata[7:0]       ), //i
    .readData   (ram_readData[7:0]), //o
    .clk        (clk              ), //i
    .resetn     (resetn           )  //i
  );
  assign rdata = ram_readData;

endmodule

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

//regMem1r1w replaced by regMem1r1w

module regMem1r1w (
  input               writeValid,
  input               readValid,
  input      [3:0]    waddress,
  input      [3:0]    raddress,
  input      [7:0]    writeData,
  output     [7:0]    readData,
  input               clk,
  input               resetn
);

  reg        [7:0]    tmp_mem_port1;
  reg [7:0] mem [0:15];

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
