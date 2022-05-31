// Generator : SpinalHDL v1.7.0    git head : eca519e78d4e6022e34911ec300a432ed9db8220
// Component : Ram1rw
// Git hash  : 3ad115d02ede82ce5afb11275af1efb2655ff862

`timescale 1ns/1ps

module Ram1rw (
  input               rd,
  input               wr,
  input      [6:0]    addr,
  input      [31:0]   wdata,
  output     [31:0]   rdata,
  input               clk
);

  wire                ram_CEN;
  wire                ram_WEN;
  wire       [31:0]   ram_Q;

  Mwrapper_rfsp128x32m2b1w1 ram (
    .CLK (clk        ), //i
    .A   (addr[6:0]  ), //i
    .D   (wdata[31:0]), //i
    .CEN (ram_CEN    ), //i
    .WEN (ram_WEN    ), //i
    .Q   (ram_Q[31:0])  //o
  );
  assign ram_CEN = (! (rd || wr));
  assign ram_WEN = (! wr);
  assign rdata = ram_Q;

endmodule
