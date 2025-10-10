// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun Mar  9 10:59:20 2025
// Host        : Ariyan running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_2_PC_0_sim_netlist.v
// Design      : design_2_PC_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Register
   (outReg,
    in,
    clk,
    rst,
    freeze);
  output [31:0]outReg;
  input [31:0]in;
  input clk;
  input rst;
  input freeze;

  wire clk;
  wire freeze;
  wire [31:0]in;
  wire [31:0]outReg;
  wire p_0_in;
  wire rst;

  LUT1 #(
    .INIT(2'h1)) 
    \outReg[31]_i_1 
       (.I0(freeze),
        .O(p_0_in));
  FDCE \outReg_reg[0] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[0]),
        .Q(outReg[0]));
  FDCE \outReg_reg[10] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[10]),
        .Q(outReg[10]));
  FDCE \outReg_reg[11] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[11]),
        .Q(outReg[11]));
  FDCE \outReg_reg[12] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[12]),
        .Q(outReg[12]));
  FDCE \outReg_reg[13] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[13]),
        .Q(outReg[13]));
  FDCE \outReg_reg[14] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[14]),
        .Q(outReg[14]));
  FDCE \outReg_reg[15] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[15]),
        .Q(outReg[15]));
  FDCE \outReg_reg[16] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[16]),
        .Q(outReg[16]));
  FDCE \outReg_reg[17] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[17]),
        .Q(outReg[17]));
  FDCE \outReg_reg[18] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[18]),
        .Q(outReg[18]));
  FDCE \outReg_reg[19] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[19]),
        .Q(outReg[19]));
  FDCE \outReg_reg[1] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[1]),
        .Q(outReg[1]));
  FDCE \outReg_reg[20] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[20]),
        .Q(outReg[20]));
  FDCE \outReg_reg[21] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[21]),
        .Q(outReg[21]));
  FDCE \outReg_reg[22] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[22]),
        .Q(outReg[22]));
  FDCE \outReg_reg[23] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[23]),
        .Q(outReg[23]));
  FDCE \outReg_reg[24] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[24]),
        .Q(outReg[24]));
  FDCE \outReg_reg[25] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[25]),
        .Q(outReg[25]));
  FDCE \outReg_reg[26] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[26]),
        .Q(outReg[26]));
  FDCE \outReg_reg[27] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[27]),
        .Q(outReg[27]));
  FDCE \outReg_reg[28] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[28]),
        .Q(outReg[28]));
  FDCE \outReg_reg[29] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[29]),
        .Q(outReg[29]));
  FDCE \outReg_reg[2] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[2]),
        .Q(outReg[2]));
  FDCE \outReg_reg[30] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[30]),
        .Q(outReg[30]));
  FDCE \outReg_reg[31] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[31]),
        .Q(outReg[31]));
  FDCE \outReg_reg[3] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[3]),
        .Q(outReg[3]));
  FDCE \outReg_reg[4] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[4]),
        .Q(outReg[4]));
  FDCE \outReg_reg[5] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[5]),
        .Q(outReg[5]));
  FDCE \outReg_reg[6] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[6]),
        .Q(outReg[6]));
  FDCE \outReg_reg[7] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[7]),
        .Q(outReg[7]));
  FDCE \outReg_reg[8] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[8]),
        .Q(outReg[8]));
  FDCE \outReg_reg[9] 
       (.C(clk),
        .CE(p_0_in),
        .CLR(rst),
        .D(in[9]),
        .Q(outReg[9]));
endmodule

(* CHECK_LICENSE_TYPE = "design_2_PC_0,Register,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "Register,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (clk,
    rst,
    freeze,
    in,
    outReg);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN design_2_clk_0, INSERT_VIP 0" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input rst;
  input freeze;
  input [31:0]in;
  output [31:0]outReg;

  wire clk;
  wire freeze;
  wire [31:0]in;
  wire [31:0]outReg;
  wire rst;

  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Register inst
       (.clk(clk),
        .freeze(freeze),
        .in(in),
        .outReg(outReg),
        .rst(rst));
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
