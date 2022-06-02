// Generator : SpinalHDL v1.7.0    git head : eca519e78d4e6022e34911ec300a432ed9db8220
// Component : If_scratch_pad
// Git hash  : f1f795b65a2a20dfc7920bbbc2342e1f6ac30d62

`timescale 1ns/1ps

module If_scratch_pad (
  input               ifscp_wbus_wr,
  input      [5:0]    ifscp_wbus_waddr,
  input      [127:0]  ifscp_wbus_wdata,
  input               ifscp_ctrl_if_rd,
  input      [5:0]    ifscp_ctrl_hw_addr,
  input      [3:0]    ifscp_ctrl_ich_addr,
  input               ifscp_ctrl_cast_mode,
  output     [7:0]    if_pe_bus_0,
  output     [7:0]    if_pe_bus_1,
  output     [7:0]    if_pe_bus_2,
  output     [7:0]    if_pe_bus_3,
  output     [7:0]    if_pe_bus_4,
  output     [7:0]    if_pe_bus_5,
  output     [7:0]    if_pe_bus_6,
  output     [7:0]    if_pe_bus_7,
  output     [7:0]    if_pe_bus_8,
  output     [7:0]    if_pe_bus_9,
  output     [7:0]    if_pe_bus_10,
  output     [7:0]    if_pe_bus_11,
  output     [7:0]    if_pe_bus_12,
  output     [7:0]    if_pe_bus_13,
  output     [7:0]    if_pe_bus_14,
  output     [7:0]    if_pe_bus_15,
  input               clk,
  input               resetn
);

  wire       [7:0]    If_rf_0_rbus_rdata;
  wire       [7:0]    If_rf_1_rbus_rdata;
  wire       [7:0]    If_rf_2_rbus_rdata;
  wire       [7:0]    If_rf_3_rbus_rdata;
  wire       [7:0]    If_rf_4_rbus_rdata;
  wire       [7:0]    If_rf_5_rbus_rdata;
  wire       [7:0]    If_rf_6_rbus_rdata;
  wire       [7:0]    If_rf_7_rbus_rdata;
  wire       [7:0]    If_rf_8_rbus_rdata;
  wire       [7:0]    If_rf_9_rbus_rdata;
  wire       [7:0]    If_rf_10_rbus_rdata;
  wire       [7:0]    If_rf_11_rbus_rdata;
  wire       [7:0]    If_rf_12_rbus_rdata;
  wire       [7:0]    If_rf_13_rbus_rdata;
  wire       [7:0]    If_rf_14_rbus_rdata;
  wire       [7:0]    If_rf_15_rbus_rdata;
  reg        [7:0]    tmp_if_broadcast_out;
  wire       [7:0]    ifwdata_0;
  wire       [7:0]    ifwdata_1;
  wire       [7:0]    ifwdata_2;
  wire       [7:0]    ifwdata_3;
  wire       [7:0]    ifwdata_4;
  wire       [7:0]    ifwdata_5;
  wire       [7:0]    ifwdata_6;
  wire       [7:0]    ifwdata_7;
  wire       [7:0]    ifwdata_8;
  wire       [7:0]    ifwdata_9;
  wire       [7:0]    ifwdata_10;
  wire       [7:0]    ifwdata_11;
  wire       [7:0]    ifwdata_12;
  wire       [7:0]    ifwdata_13;
  wire       [7:0]    ifwdata_14;
  wire       [7:0]    ifwdata_15;
  wire       [7:0]    ifrdata_0;
  wire       [7:0]    ifrdata_1;
  wire       [7:0]    ifrdata_2;
  wire       [7:0]    ifrdata_3;
  wire       [7:0]    ifrdata_4;
  wire       [7:0]    ifrdata_5;
  wire       [7:0]    ifrdata_6;
  wire       [7:0]    ifrdata_7;
  wire       [7:0]    ifrdata_8;
  wire       [7:0]    ifrdata_9;
  wire       [7:0]    ifrdata_10;
  wire       [7:0]    ifrdata_11;
  wire       [7:0]    ifrdata_12;
  wire       [7:0]    ifrdata_13;
  wire       [7:0]    ifrdata_14;
  wire       [7:0]    ifrdata_15;
  wire       [7:0]    if_broadcast_out;

  regfile If_rf_0 (
    .wbus_wr    (ifscp_wbus_wr          ), //i
    .wbus_waddr (ifscp_wbus_waddr[5:0]  ), //i
    .wbus_wdata (ifwdata_0[7:0]         ), //i
    .rbus_rd    (ifscp_ctrl_if_rd       ), //i
    .rbus_raddr (ifscp_ctrl_hw_addr[5:0]), //i
    .rbus_rdata (If_rf_0_rbus_rdata[7:0]), //o
    .clk        (clk                    ), //i
    .resetn     (resetn                 )  //i
  );
  regfile If_rf_1 (
    .wbus_wr    (ifscp_wbus_wr          ), //i
    .wbus_waddr (ifscp_wbus_waddr[5:0]  ), //i
    .wbus_wdata (ifwdata_1[7:0]         ), //i
    .rbus_rd    (ifscp_ctrl_if_rd       ), //i
    .rbus_raddr (ifscp_ctrl_hw_addr[5:0]), //i
    .rbus_rdata (If_rf_1_rbus_rdata[7:0]), //o
    .clk        (clk                    ), //i
    .resetn     (resetn                 )  //i
  );
  regfile If_rf_2 (
    .wbus_wr    (ifscp_wbus_wr          ), //i
    .wbus_waddr (ifscp_wbus_waddr[5:0]  ), //i
    .wbus_wdata (ifwdata_2[7:0]         ), //i
    .rbus_rd    (ifscp_ctrl_if_rd       ), //i
    .rbus_raddr (ifscp_ctrl_hw_addr[5:0]), //i
    .rbus_rdata (If_rf_2_rbus_rdata[7:0]), //o
    .clk        (clk                    ), //i
    .resetn     (resetn                 )  //i
  );
  regfile If_rf_3 (
    .wbus_wr    (ifscp_wbus_wr          ), //i
    .wbus_waddr (ifscp_wbus_waddr[5:0]  ), //i
    .wbus_wdata (ifwdata_3[7:0]         ), //i
    .rbus_rd    (ifscp_ctrl_if_rd       ), //i
    .rbus_raddr (ifscp_ctrl_hw_addr[5:0]), //i
    .rbus_rdata (If_rf_3_rbus_rdata[7:0]), //o
    .clk        (clk                    ), //i
    .resetn     (resetn                 )  //i
  );
  regfile If_rf_4 (
    .wbus_wr    (ifscp_wbus_wr          ), //i
    .wbus_waddr (ifscp_wbus_waddr[5:0]  ), //i
    .wbus_wdata (ifwdata_4[7:0]         ), //i
    .rbus_rd    (ifscp_ctrl_if_rd       ), //i
    .rbus_raddr (ifscp_ctrl_hw_addr[5:0]), //i
    .rbus_rdata (If_rf_4_rbus_rdata[7:0]), //o
    .clk        (clk                    ), //i
    .resetn     (resetn                 )  //i
  );
  regfile If_rf_5 (
    .wbus_wr    (ifscp_wbus_wr          ), //i
    .wbus_waddr (ifscp_wbus_waddr[5:0]  ), //i
    .wbus_wdata (ifwdata_5[7:0]         ), //i
    .rbus_rd    (ifscp_ctrl_if_rd       ), //i
    .rbus_raddr (ifscp_ctrl_hw_addr[5:0]), //i
    .rbus_rdata (If_rf_5_rbus_rdata[7:0]), //o
    .clk        (clk                    ), //i
    .resetn     (resetn                 )  //i
  );
  regfile If_rf_6 (
    .wbus_wr    (ifscp_wbus_wr          ), //i
    .wbus_waddr (ifscp_wbus_waddr[5:0]  ), //i
    .wbus_wdata (ifwdata_6[7:0]         ), //i
    .rbus_rd    (ifscp_ctrl_if_rd       ), //i
    .rbus_raddr (ifscp_ctrl_hw_addr[5:0]), //i
    .rbus_rdata (If_rf_6_rbus_rdata[7:0]), //o
    .clk        (clk                    ), //i
    .resetn     (resetn                 )  //i
  );
  regfile If_rf_7 (
    .wbus_wr    (ifscp_wbus_wr          ), //i
    .wbus_waddr (ifscp_wbus_waddr[5:0]  ), //i
    .wbus_wdata (ifwdata_7[7:0]         ), //i
    .rbus_rd    (ifscp_ctrl_if_rd       ), //i
    .rbus_raddr (ifscp_ctrl_hw_addr[5:0]), //i
    .rbus_rdata (If_rf_7_rbus_rdata[7:0]), //o
    .clk        (clk                    ), //i
    .resetn     (resetn                 )  //i
  );
  regfile If_rf_8 (
    .wbus_wr    (ifscp_wbus_wr          ), //i
    .wbus_waddr (ifscp_wbus_waddr[5:0]  ), //i
    .wbus_wdata (ifwdata_8[7:0]         ), //i
    .rbus_rd    (ifscp_ctrl_if_rd       ), //i
    .rbus_raddr (ifscp_ctrl_hw_addr[5:0]), //i
    .rbus_rdata (If_rf_8_rbus_rdata[7:0]), //o
    .clk        (clk                    ), //i
    .resetn     (resetn                 )  //i
  );
  regfile If_rf_9 (
    .wbus_wr    (ifscp_wbus_wr          ), //i
    .wbus_waddr (ifscp_wbus_waddr[5:0]  ), //i
    .wbus_wdata (ifwdata_9[7:0]         ), //i
    .rbus_rd    (ifscp_ctrl_if_rd       ), //i
    .rbus_raddr (ifscp_ctrl_hw_addr[5:0]), //i
    .rbus_rdata (If_rf_9_rbus_rdata[7:0]), //o
    .clk        (clk                    ), //i
    .resetn     (resetn                 )  //i
  );
  regfile If_rf_10 (
    .wbus_wr    (ifscp_wbus_wr           ), //i
    .wbus_waddr (ifscp_wbus_waddr[5:0]   ), //i
    .wbus_wdata (ifwdata_10[7:0]         ), //i
    .rbus_rd    (ifscp_ctrl_if_rd        ), //i
    .rbus_raddr (ifscp_ctrl_hw_addr[5:0] ), //i
    .rbus_rdata (If_rf_10_rbus_rdata[7:0]), //o
    .clk        (clk                     ), //i
    .resetn     (resetn                  )  //i
  );
  regfile If_rf_11 (
    .wbus_wr    (ifscp_wbus_wr           ), //i
    .wbus_waddr (ifscp_wbus_waddr[5:0]   ), //i
    .wbus_wdata (ifwdata_11[7:0]         ), //i
    .rbus_rd    (ifscp_ctrl_if_rd        ), //i
    .rbus_raddr (ifscp_ctrl_hw_addr[5:0] ), //i
    .rbus_rdata (If_rf_11_rbus_rdata[7:0]), //o
    .clk        (clk                     ), //i
    .resetn     (resetn                  )  //i
  );
  regfile If_rf_12 (
    .wbus_wr    (ifscp_wbus_wr           ), //i
    .wbus_waddr (ifscp_wbus_waddr[5:0]   ), //i
    .wbus_wdata (ifwdata_12[7:0]         ), //i
    .rbus_rd    (ifscp_ctrl_if_rd        ), //i
    .rbus_raddr (ifscp_ctrl_hw_addr[5:0] ), //i
    .rbus_rdata (If_rf_12_rbus_rdata[7:0]), //o
    .clk        (clk                     ), //i
    .resetn     (resetn                  )  //i
  );
  regfile If_rf_13 (
    .wbus_wr    (ifscp_wbus_wr           ), //i
    .wbus_waddr (ifscp_wbus_waddr[5:0]   ), //i
    .wbus_wdata (ifwdata_13[7:0]         ), //i
    .rbus_rd    (ifscp_ctrl_if_rd        ), //i
    .rbus_raddr (ifscp_ctrl_hw_addr[5:0] ), //i
    .rbus_rdata (If_rf_13_rbus_rdata[7:0]), //o
    .clk        (clk                     ), //i
    .resetn     (resetn                  )  //i
  );
  regfile If_rf_14 (
    .wbus_wr    (ifscp_wbus_wr           ), //i
    .wbus_waddr (ifscp_wbus_waddr[5:0]   ), //i
    .wbus_wdata (ifwdata_14[7:0]         ), //i
    .rbus_rd    (ifscp_ctrl_if_rd        ), //i
    .rbus_raddr (ifscp_ctrl_hw_addr[5:0] ), //i
    .rbus_rdata (If_rf_14_rbus_rdata[7:0]), //o
    .clk        (clk                     ), //i
    .resetn     (resetn                  )  //i
  );
  regfile If_rf_15 (
    .wbus_wr    (ifscp_wbus_wr           ), //i
    .wbus_waddr (ifscp_wbus_waddr[5:0]   ), //i
    .wbus_wdata (ifwdata_15[7:0]         ), //i
    .rbus_rd    (ifscp_ctrl_if_rd        ), //i
    .rbus_raddr (ifscp_ctrl_hw_addr[5:0] ), //i
    .rbus_rdata (If_rf_15_rbus_rdata[7:0]), //o
    .clk        (clk                     ), //i
    .resetn     (resetn                  )  //i
  );
  always @(*) begin
    case(ifscp_ctrl_ich_addr)
      4'b0000 : tmp_if_broadcast_out = ifrdata_0;
      4'b0001 : tmp_if_broadcast_out = ifrdata_1;
      4'b0010 : tmp_if_broadcast_out = ifrdata_2;
      4'b0011 : tmp_if_broadcast_out = ifrdata_3;
      4'b0100 : tmp_if_broadcast_out = ifrdata_4;
      4'b0101 : tmp_if_broadcast_out = ifrdata_5;
      4'b0110 : tmp_if_broadcast_out = ifrdata_6;
      4'b0111 : tmp_if_broadcast_out = ifrdata_7;
      4'b1000 : tmp_if_broadcast_out = ifrdata_8;
      4'b1001 : tmp_if_broadcast_out = ifrdata_9;
      4'b1010 : tmp_if_broadcast_out = ifrdata_10;
      4'b1011 : tmp_if_broadcast_out = ifrdata_11;
      4'b1100 : tmp_if_broadcast_out = ifrdata_12;
      4'b1101 : tmp_if_broadcast_out = ifrdata_13;
      4'b1110 : tmp_if_broadcast_out = ifrdata_14;
      default : tmp_if_broadcast_out = ifrdata_15;
    endcase
  end

  assign ifwdata_0 = ifscp_wbus_wdata[7 : 0];
  assign ifwdata_1 = ifscp_wbus_wdata[15 : 8];
  assign ifwdata_2 = ifscp_wbus_wdata[23 : 16];
  assign ifwdata_3 = ifscp_wbus_wdata[31 : 24];
  assign ifwdata_4 = ifscp_wbus_wdata[39 : 32];
  assign ifwdata_5 = ifscp_wbus_wdata[47 : 40];
  assign ifwdata_6 = ifscp_wbus_wdata[55 : 48];
  assign ifwdata_7 = ifscp_wbus_wdata[63 : 56];
  assign ifwdata_8 = ifscp_wbus_wdata[71 : 64];
  assign ifwdata_9 = ifscp_wbus_wdata[79 : 72];
  assign ifwdata_10 = ifscp_wbus_wdata[87 : 80];
  assign ifwdata_11 = ifscp_wbus_wdata[95 : 88];
  assign ifwdata_12 = ifscp_wbus_wdata[103 : 96];
  assign ifwdata_13 = ifscp_wbus_wdata[111 : 104];
  assign ifwdata_14 = ifscp_wbus_wdata[119 : 112];
  assign ifwdata_15 = ifscp_wbus_wdata[127 : 120];
  assign ifrdata_0 = If_rf_0_rbus_rdata;
  assign ifrdata_1 = If_rf_1_rbus_rdata;
  assign ifrdata_2 = If_rf_2_rbus_rdata;
  assign ifrdata_3 = If_rf_3_rbus_rdata;
  assign ifrdata_4 = If_rf_4_rbus_rdata;
  assign ifrdata_5 = If_rf_5_rbus_rdata;
  assign ifrdata_6 = If_rf_6_rbus_rdata;
  assign ifrdata_7 = If_rf_7_rbus_rdata;
  assign ifrdata_8 = If_rf_8_rbus_rdata;
  assign ifrdata_9 = If_rf_9_rbus_rdata;
  assign ifrdata_10 = If_rf_10_rbus_rdata;
  assign ifrdata_11 = If_rf_11_rbus_rdata;
  assign ifrdata_12 = If_rf_12_rbus_rdata;
  assign ifrdata_13 = If_rf_13_rbus_rdata;
  assign ifrdata_14 = If_rf_14_rbus_rdata;
  assign ifrdata_15 = If_rf_15_rbus_rdata;
  assign if_broadcast_out = tmp_if_broadcast_out;
  assign if_pe_bus_0 = (ifscp_ctrl_cast_mode ? if_broadcast_out : ifrdata_0);
  assign if_pe_bus_1 = (ifscp_ctrl_cast_mode ? if_broadcast_out : ifrdata_1);
  assign if_pe_bus_2 = (ifscp_ctrl_cast_mode ? if_broadcast_out : ifrdata_2);
  assign if_pe_bus_3 = (ifscp_ctrl_cast_mode ? if_broadcast_out : ifrdata_3);
  assign if_pe_bus_4 = (ifscp_ctrl_cast_mode ? if_broadcast_out : ifrdata_4);
  assign if_pe_bus_5 = (ifscp_ctrl_cast_mode ? if_broadcast_out : ifrdata_5);
  assign if_pe_bus_6 = (ifscp_ctrl_cast_mode ? if_broadcast_out : ifrdata_6);
  assign if_pe_bus_7 = (ifscp_ctrl_cast_mode ? if_broadcast_out : ifrdata_7);
  assign if_pe_bus_8 = (ifscp_ctrl_cast_mode ? if_broadcast_out : ifrdata_8);
  assign if_pe_bus_9 = (ifscp_ctrl_cast_mode ? if_broadcast_out : ifrdata_9);
  assign if_pe_bus_10 = (ifscp_ctrl_cast_mode ? if_broadcast_out : ifrdata_10);
  assign if_pe_bus_11 = (ifscp_ctrl_cast_mode ? if_broadcast_out : ifrdata_11);
  assign if_pe_bus_12 = (ifscp_ctrl_cast_mode ? if_broadcast_out : ifrdata_12);
  assign if_pe_bus_13 = (ifscp_ctrl_cast_mode ? if_broadcast_out : ifrdata_13);
  assign if_pe_bus_14 = (ifscp_ctrl_cast_mode ? if_broadcast_out : ifrdata_14);
  assign if_pe_bus_15 = (ifscp_ctrl_cast_mode ? if_broadcast_out : ifrdata_15);

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
  input      [5:0]    wbus_waddr,
  input      [7:0]    wbus_wdata,
  input               rbus_rd,
  input      [5:0]    rbus_raddr,
  output     [7:0]    rbus_rdata,
  input               clk,
  input               resetn
);

  wire       [7:0]    rf_rdata;

  Ram1r1w rf (
    .rd     (rbus_rd        ), //i
    .wr     (wbus_wr        ), //i
    .waddr  (wbus_waddr[5:0]), //i
    .raddr  (rbus_raddr[5:0]), //i
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
  input      [5:0]    waddr,
  input      [5:0]    raddr,
  input      [7:0]    wdata,
  output     [7:0]    rdata,
  input               clk,
  input               resetn
);

  wire       [7:0]    ram_readData;

  regMem1r1w ram (
    .writeValid (wr               ), //i
    .readValid  (rd               ), //i
    .waddress   (waddr[5:0]       ), //i
    .raddress   (raddr[5:0]       ), //i
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
  input      [5:0]    waddress,
  input      [5:0]    raddress,
  input      [7:0]    writeData,
  output     [7:0]    readData,
  input               clk,
  input               resetn
);

  reg        [7:0]    tmp_mem_port1;
  reg [7:0] mem [0:63];

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
