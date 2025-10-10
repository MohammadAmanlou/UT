// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun May 18 17:03:59 2025
// Host        : Ariyan running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/ariya/OneDrive/Desktop/project_1/project_1/project_1.srcs/sources_1/bd/design_2/ip/design_2_Exe_Mux_0_1/design_2_Exe_Mux_0_1_sim_netlist.v
// Design      : design_2_Exe_Mux_0_1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_2_Exe_Mux_0_1,Exe_Mux,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "Exe_Mux,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module design_2_Exe_Mux_0_1
   (sel,
    val,
    ALU_res,
    WB_value,
    out);
  input [1:0]sel;
  input [31:0]val;
  input [31:0]ALU_res;
  input [31:0]WB_value;
  output [31:0]out;

  wire [31:0]ALU_res;
  wire [31:0]WB_value;
  wire [31:0]out;
  wire [1:0]sel;
  wire [31:0]val;

  design_2_Exe_Mux_0_1_Exe_Mux inst
       (.ALU_res(ALU_res),
        .WB_value(WB_value),
        .out(out),
        .sel(sel),
        .val(val));
endmodule

(* ORIG_REF_NAME = "Exe_Mux" *) 
module design_2_Exe_Mux_0_1_Exe_Mux
   (out,
    WB_value,
    sel,
    ALU_res,
    val);
  output [31:0]out;
  input [31:0]WB_value;
  input [1:0]sel;
  input [31:0]ALU_res;
  input [31:0]val;

  wire [31:0]ALU_res;
  wire [31:0]WB_value;
  wire [31:0]out;
  wire [1:0]sel;
  wire [31:0]val;

  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[0]_INST_0 
       (.I0(WB_value[0]),
        .I1(sel[1]),
        .I2(ALU_res[0]),
        .I3(sel[0]),
        .I4(val[0]),
        .O(out[0]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[10]_INST_0 
       (.I0(WB_value[10]),
        .I1(sel[1]),
        .I2(ALU_res[10]),
        .I3(sel[0]),
        .I4(val[10]),
        .O(out[10]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[11]_INST_0 
       (.I0(WB_value[11]),
        .I1(sel[1]),
        .I2(ALU_res[11]),
        .I3(sel[0]),
        .I4(val[11]),
        .O(out[11]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[12]_INST_0 
       (.I0(WB_value[12]),
        .I1(sel[1]),
        .I2(ALU_res[12]),
        .I3(sel[0]),
        .I4(val[12]),
        .O(out[12]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[13]_INST_0 
       (.I0(WB_value[13]),
        .I1(sel[1]),
        .I2(ALU_res[13]),
        .I3(sel[0]),
        .I4(val[13]),
        .O(out[13]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[14]_INST_0 
       (.I0(WB_value[14]),
        .I1(sel[1]),
        .I2(ALU_res[14]),
        .I3(sel[0]),
        .I4(val[14]),
        .O(out[14]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[15]_INST_0 
       (.I0(WB_value[15]),
        .I1(sel[1]),
        .I2(ALU_res[15]),
        .I3(sel[0]),
        .I4(val[15]),
        .O(out[15]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[16]_INST_0 
       (.I0(WB_value[16]),
        .I1(sel[1]),
        .I2(ALU_res[16]),
        .I3(sel[0]),
        .I4(val[16]),
        .O(out[16]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[17]_INST_0 
       (.I0(WB_value[17]),
        .I1(sel[1]),
        .I2(ALU_res[17]),
        .I3(sel[0]),
        .I4(val[17]),
        .O(out[17]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[18]_INST_0 
       (.I0(WB_value[18]),
        .I1(sel[1]),
        .I2(ALU_res[18]),
        .I3(sel[0]),
        .I4(val[18]),
        .O(out[18]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[19]_INST_0 
       (.I0(WB_value[19]),
        .I1(sel[1]),
        .I2(ALU_res[19]),
        .I3(sel[0]),
        .I4(val[19]),
        .O(out[19]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[1]_INST_0 
       (.I0(WB_value[1]),
        .I1(sel[1]),
        .I2(ALU_res[1]),
        .I3(sel[0]),
        .I4(val[1]),
        .O(out[1]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[20]_INST_0 
       (.I0(WB_value[20]),
        .I1(sel[1]),
        .I2(ALU_res[20]),
        .I3(sel[0]),
        .I4(val[20]),
        .O(out[20]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[21]_INST_0 
       (.I0(WB_value[21]),
        .I1(sel[1]),
        .I2(ALU_res[21]),
        .I3(sel[0]),
        .I4(val[21]),
        .O(out[21]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[22]_INST_0 
       (.I0(WB_value[22]),
        .I1(sel[1]),
        .I2(ALU_res[22]),
        .I3(sel[0]),
        .I4(val[22]),
        .O(out[22]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[23]_INST_0 
       (.I0(WB_value[23]),
        .I1(sel[1]),
        .I2(ALU_res[23]),
        .I3(sel[0]),
        .I4(val[23]),
        .O(out[23]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[24]_INST_0 
       (.I0(WB_value[24]),
        .I1(sel[1]),
        .I2(ALU_res[24]),
        .I3(sel[0]),
        .I4(val[24]),
        .O(out[24]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[25]_INST_0 
       (.I0(WB_value[25]),
        .I1(sel[1]),
        .I2(ALU_res[25]),
        .I3(sel[0]),
        .I4(val[25]),
        .O(out[25]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[26]_INST_0 
       (.I0(WB_value[26]),
        .I1(sel[1]),
        .I2(ALU_res[26]),
        .I3(sel[0]),
        .I4(val[26]),
        .O(out[26]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[27]_INST_0 
       (.I0(WB_value[27]),
        .I1(sel[1]),
        .I2(ALU_res[27]),
        .I3(sel[0]),
        .I4(val[27]),
        .O(out[27]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[28]_INST_0 
       (.I0(WB_value[28]),
        .I1(sel[1]),
        .I2(ALU_res[28]),
        .I3(sel[0]),
        .I4(val[28]),
        .O(out[28]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[29]_INST_0 
       (.I0(WB_value[29]),
        .I1(sel[1]),
        .I2(ALU_res[29]),
        .I3(sel[0]),
        .I4(val[29]),
        .O(out[29]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[2]_INST_0 
       (.I0(WB_value[2]),
        .I1(sel[1]),
        .I2(ALU_res[2]),
        .I3(sel[0]),
        .I4(val[2]),
        .O(out[2]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[30]_INST_0 
       (.I0(WB_value[30]),
        .I1(sel[1]),
        .I2(ALU_res[30]),
        .I3(sel[0]),
        .I4(val[30]),
        .O(out[30]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[31]_INST_0 
       (.I0(WB_value[31]),
        .I1(sel[1]),
        .I2(ALU_res[31]),
        .I3(sel[0]),
        .I4(val[31]),
        .O(out[31]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[3]_INST_0 
       (.I0(WB_value[3]),
        .I1(sel[1]),
        .I2(ALU_res[3]),
        .I3(sel[0]),
        .I4(val[3]),
        .O(out[3]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[4]_INST_0 
       (.I0(WB_value[4]),
        .I1(sel[1]),
        .I2(ALU_res[4]),
        .I3(sel[0]),
        .I4(val[4]),
        .O(out[4]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[5]_INST_0 
       (.I0(WB_value[5]),
        .I1(sel[1]),
        .I2(ALU_res[5]),
        .I3(sel[0]),
        .I4(val[5]),
        .O(out[5]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[6]_INST_0 
       (.I0(WB_value[6]),
        .I1(sel[1]),
        .I2(ALU_res[6]),
        .I3(sel[0]),
        .I4(val[6]),
        .O(out[6]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[7]_INST_0 
       (.I0(WB_value[7]),
        .I1(sel[1]),
        .I2(ALU_res[7]),
        .I3(sel[0]),
        .I4(val[7]),
        .O(out[7]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[8]_INST_0 
       (.I0(WB_value[8]),
        .I1(sel[1]),
        .I2(ALU_res[8]),
        .I3(sel[0]),
        .I4(val[8]),
        .O(out[8]));
  LUT5 #(
    .INIT(32'hB8BBB888)) 
    \out[9]_INST_0 
       (.I0(WB_value[9]),
        .I1(sel[1]),
        .I2(ALU_res[9]),
        .I3(sel[0]),
        .I4(val[9]),
        .O(out[9]));
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
