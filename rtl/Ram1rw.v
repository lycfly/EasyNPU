// Generator : SpinalHDL v1.7.1    git head : 0444bb76ab1d6e19f0ec46bc03c4769776deb7d5
// Component : Ram1rw
// Git hash  : e91621d6b84029ee28f493ff974d7c5daf120e36

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
