// Generator : SpinalHDL v1.7.0    git head : eca519e78d4e6022e34911ec300a432ed9db8220
// Component : We_scratch_pad
// Git hash  : 3ad115d02ede82ce5afb11275af1efb2655ff862

`timescale 1ns/1ps

module We_scratch_pad (
  input               wescp_wbus_wr,
  input      [3:0]    wescp_wbus_waddr,
  input      [127:0]  wescp_wbus_wdata,
  input               wescp_ctrl_we_rd,
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
  input               clk,
  input               resetn
);

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
