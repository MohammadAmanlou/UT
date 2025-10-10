// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun May 11 11:31:33 2025
// Host        : Ariyan running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/ariya/OneDrive/Desktop/project_1/project_1/project_1.srcs/sources_1/bd/design_2/ip/design_2_StatusReg_0_0/design_2_StatusReg_0_0_sim_netlist.v
// Design      : design_2_StatusReg_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_2_StatusReg_0_0,StatusReg,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "StatusReg,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module design_2_StatusReg_0_0
   (clk,
    rst,
    s,
    status_bits,
    status_out);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN design_2_clk_0, INSERT_VIP 0" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input rst;
  input s;
  input [3:0]status_bits;
  output [3:0]status_out;

  wire clk;
  wire rst;
  wire s;
  wire [3:0]status_bits;
  wire [3:0]status_out;

  design_2_StatusReg_0_0_StatusReg inst
       (.clk(clk),
        .rst(rst),
        .s(s),
        .status_bits(status_bits),
        .status_out(status_out));
endmodule

(* ORIG_REF_NAME = "StatusReg" *) 
module design_2_StatusReg_0_0_StatusReg
   (status_out,
    s,
    status_bits,
    clk,
    rst);
  output [3:0]status_out;
  input s;
  input [3:0]status_bits;
  input clk;
  input rst;

  wire clk;
  wire rst;
  wire s;
  wire [3:0]status_bits;
  wire [3:0]status_out;

  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \status_out_reg[0] 
       (.C(clk),
        .CE(s),
        .CLR(rst),
        .D(status_bits[0]),
        .Q(status_out[0]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \status_out_reg[1] 
       (.C(clk),
        .CE(s),
        .CLR(rst),
        .D(status_bits[1]),
        .Q(status_out[1]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \status_out_reg[2] 
       (.C(clk),
        .CE(s),
        .CLR(rst),
        .D(status_bits[2]),
        .Q(status_out[2]));
  FDCE #(
    .IS_C_INVERTED(1'b1)) 
    \status_out_reg[3] 
       (.C(clk),
        .CE(s),
        .CLR(rst),
        .D(status_bits[3]),
        .Q(status_out[3]));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
