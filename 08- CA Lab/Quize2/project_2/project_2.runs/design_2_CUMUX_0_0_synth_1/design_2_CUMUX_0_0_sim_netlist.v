// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun May 11 11:31:30 2025
// Host        : Ariyan running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_2_CUMUX_0_0_sim_netlist.v
// Design      : design_2_CUMUX_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_2_CUMUX_0_0,CUMUX,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "CUMUX,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (sel,
    WB_EN,
    imm,
    MEM_R_EN,
    MEM_W_EN,
    B,
    EXE_CMD,
    S,
    WB_EN_out,
    imm_out,
    MEM_R_EN_out,
    MEM_W_EN_out,
    B_out,
    EXE_CMD_out,
    S_out);
  input sel;
  input WB_EN;
  input imm;
  input MEM_R_EN;
  input MEM_W_EN;
  input B;
  input [3:0]EXE_CMD;
  input S;
  output WB_EN_out;
  output imm_out;
  output MEM_R_EN_out;
  output MEM_W_EN_out;
  output B_out;
  output [3:0]EXE_CMD_out;
  output S_out;

  wire B;
  wire B_out;
  wire [3:0]EXE_CMD;
  wire [3:0]EXE_CMD_out;
  wire MEM_R_EN;
  wire MEM_R_EN_out;
  wire MEM_W_EN;
  wire MEM_W_EN_out;
  wire S;
  wire S_out;
  wire WB_EN;
  wire WB_EN_out;
  wire imm;
  wire imm_out;
  wire sel;

  LUT2 #(
    .INIT(4'h2)) 
    B_out_INST_0
       (.I0(B),
        .I1(sel),
        .O(B_out));
  LUT2 #(
    .INIT(4'h2)) 
    \EXE_CMD_out[0]_INST_0 
       (.I0(EXE_CMD[0]),
        .I1(sel),
        .O(EXE_CMD_out[0]));
  LUT2 #(
    .INIT(4'h2)) 
    \EXE_CMD_out[1]_INST_0 
       (.I0(EXE_CMD[1]),
        .I1(sel),
        .O(EXE_CMD_out[1]));
  LUT2 #(
    .INIT(4'h2)) 
    \EXE_CMD_out[2]_INST_0 
       (.I0(EXE_CMD[2]),
        .I1(sel),
        .O(EXE_CMD_out[2]));
  LUT2 #(
    .INIT(4'h2)) 
    \EXE_CMD_out[3]_INST_0 
       (.I0(EXE_CMD[3]),
        .I1(sel),
        .O(EXE_CMD_out[3]));
  LUT2 #(
    .INIT(4'h2)) 
    MEM_R_EN_out_INST_0
       (.I0(MEM_R_EN),
        .I1(sel),
        .O(MEM_R_EN_out));
  LUT2 #(
    .INIT(4'h2)) 
    MEM_W_EN_out_INST_0
       (.I0(MEM_W_EN),
        .I1(sel),
        .O(MEM_W_EN_out));
  LUT2 #(
    .INIT(4'h2)) 
    S_out_INST_0
       (.I0(S),
        .I1(sel),
        .O(S_out));
  LUT2 #(
    .INIT(4'h2)) 
    WB_EN_out_INST_0
       (.I0(WB_EN),
        .I1(sel),
        .O(WB_EN_out));
  LUT2 #(
    .INIT(4'h2)) 
    imm_out_INST_0
       (.I0(imm),
        .I1(sel),
        .O(imm_out));
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
