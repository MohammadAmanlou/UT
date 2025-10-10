// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun Mar  9 10:01:39 2025
// Host        : Ariyan running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/ariya/ARM/ARM.srcs/sources_1/bd/design_1/ip/design_1_Mux2to1_0_0/design_1_Mux2to1_0_0_sim_netlist.v
// Design      : design_1_Mux2to1_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_Mux2to1_0_0,Mux2to1,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "Mux2to1,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module design_1_Mux2to1_0_0
   (select,
    a,
    b,
    out0);
  input select;
  input [31:0]a;
  input [31:0]b;
  output [31:0]out0;

  wire [31:0]a;
  wire [31:0]b;
  wire [31:0]out0;
  wire select;

  design_1_Mux2to1_0_0_Mux2to1 inst
       (.a(a),
        .b(b),
        .out0(out0),
        .select(select));
endmodule

(* ORIG_REF_NAME = "Mux2to1" *) 
module design_1_Mux2to1_0_0_Mux2to1
   (out0,
    b,
    a,
    select);
  output [31:0]out0;
  input [31:0]b;
  input [31:0]a;
  input select;

  wire [31:0]a;
  wire [31:0]b;
  wire [31:0]out0;
  wire select;

  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[0]_INST_0 
       (.I0(b[0]),
        .I1(a[0]),
        .I2(select),
        .O(out0[0]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[10]_INST_0 
       (.I0(b[10]),
        .I1(a[10]),
        .I2(select),
        .O(out0[10]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[11]_INST_0 
       (.I0(b[11]),
        .I1(a[11]),
        .I2(select),
        .O(out0[11]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[12]_INST_0 
       (.I0(b[12]),
        .I1(a[12]),
        .I2(select),
        .O(out0[12]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[13]_INST_0 
       (.I0(b[13]),
        .I1(a[13]),
        .I2(select),
        .O(out0[13]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[14]_INST_0 
       (.I0(b[14]),
        .I1(a[14]),
        .I2(select),
        .O(out0[14]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[15]_INST_0 
       (.I0(b[15]),
        .I1(a[15]),
        .I2(select),
        .O(out0[15]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[16]_INST_0 
       (.I0(b[16]),
        .I1(a[16]),
        .I2(select),
        .O(out0[16]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[17]_INST_0 
       (.I0(b[17]),
        .I1(a[17]),
        .I2(select),
        .O(out0[17]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[18]_INST_0 
       (.I0(b[18]),
        .I1(a[18]),
        .I2(select),
        .O(out0[18]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[19]_INST_0 
       (.I0(b[19]),
        .I1(a[19]),
        .I2(select),
        .O(out0[19]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[1]_INST_0 
       (.I0(b[1]),
        .I1(a[1]),
        .I2(select),
        .O(out0[1]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[20]_INST_0 
       (.I0(b[20]),
        .I1(a[20]),
        .I2(select),
        .O(out0[20]));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[21]_INST_0 
       (.I0(b[21]),
        .I1(a[21]),
        .I2(select),
        .O(out0[21]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[22]_INST_0 
       (.I0(b[22]),
        .I1(a[22]),
        .I2(select),
        .O(out0[22]));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[23]_INST_0 
       (.I0(b[23]),
        .I1(a[23]),
        .I2(select),
        .O(out0[23]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[24]_INST_0 
       (.I0(b[24]),
        .I1(a[24]),
        .I2(select),
        .O(out0[24]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[25]_INST_0 
       (.I0(b[25]),
        .I1(a[25]),
        .I2(select),
        .O(out0[25]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[26]_INST_0 
       (.I0(b[26]),
        .I1(a[26]),
        .I2(select),
        .O(out0[26]));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[27]_INST_0 
       (.I0(b[27]),
        .I1(a[27]),
        .I2(select),
        .O(out0[27]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[28]_INST_0 
       (.I0(b[28]),
        .I1(a[28]),
        .I2(select),
        .O(out0[28]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[29]_INST_0 
       (.I0(b[29]),
        .I1(a[29]),
        .I2(select),
        .O(out0[29]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[2]_INST_0 
       (.I0(b[2]),
        .I1(a[2]),
        .I2(select),
        .O(out0[2]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[30]_INST_0 
       (.I0(b[30]),
        .I1(a[30]),
        .I2(select),
        .O(out0[30]));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[31]_INST_0 
       (.I0(b[31]),
        .I1(a[31]),
        .I2(select),
        .O(out0[31]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[3]_INST_0 
       (.I0(b[3]),
        .I1(a[3]),
        .I2(select),
        .O(out0[3]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[4]_INST_0 
       (.I0(b[4]),
        .I1(a[4]),
        .I2(select),
        .O(out0[4]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[5]_INST_0 
       (.I0(b[5]),
        .I1(a[5]),
        .I2(select),
        .O(out0[5]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[6]_INST_0 
       (.I0(b[6]),
        .I1(a[6]),
        .I2(select),
        .O(out0[6]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[7]_INST_0 
       (.I0(b[7]),
        .I1(a[7]),
        .I2(select),
        .O(out0[7]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[8]_INST_0 
       (.I0(b[8]),
        .I1(a[8]),
        .I2(select),
        .O(out0[8]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \out0[9]_INST_0 
       (.I0(b[9]),
        .I1(a[9]),
        .I2(select),
        .O(out0[9]));
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
