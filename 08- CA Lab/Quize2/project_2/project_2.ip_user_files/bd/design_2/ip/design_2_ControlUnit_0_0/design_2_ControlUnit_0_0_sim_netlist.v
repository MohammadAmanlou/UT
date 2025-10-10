// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun May 11 11:31:32 2025
// Host        : Ariyan running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/ariya/OneDrive/Desktop/project_1/project_1/project_1.srcs/sources_1/bd/design_2/ip/design_2_ControlUnit_0_0/design_2_ControlUnit_0_0_sim_netlist.v
// Design      : design_2_ControlUnit_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_2_ControlUnit_0_0,ControlUnit,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "ControlUnit,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module design_2_ControlUnit_0_0
   (instruction,
    WB_EN,
    imm,
    MEM_R_EN,
    MEM_W_EN,
    B,
    EXE_CMD,
    S);
  input [31:0]instruction;
  output WB_EN;
  output imm;
  output MEM_R_EN;
  output MEM_W_EN;
  output B;
  output [3:0]EXE_CMD;
  output S;

  wire B;
  wire [3:0]EXE_CMD;
  wire MEM_R_EN;
  wire MEM_W_EN;
  wire WB_EN;
  wire WB_EN_INST_0_i_1_n_0;
  wire imm;
  wire [31:0]instruction;

  assign S = instruction[20];
  LUT3 #(
    .INIT(8'h40)) 
    B_INST_0
       (.I0(instruction[26]),
        .I1(instruction[25]),
        .I2(instruction[27]),
        .O(B));
  LUT6 #(
    .INIT(64'h0000000041540000)) 
    \EXE_CMD[0]_INST_0 
       (.I0(instruction[26]),
        .I1(instruction[21]),
        .I2(instruction[24]),
        .I3(instruction[22]),
        .I4(instruction[23]),
        .I5(instruction[27]),
        .O(EXE_CMD[0]));
  LUT6 #(
    .INIT(64'h00000000AAAAAEFF)) 
    \EXE_CMD[1]_INST_0 
       (.I0(instruction[26]),
        .I1(instruction[23]),
        .I2(instruction[24]),
        .I3(instruction[21]),
        .I4(instruction[22]),
        .I5(instruction[27]),
        .O(EXE_CMD[1]));
  LUT6 #(
    .INIT(64'h0000000000001551)) 
    \EXE_CMD[2]_INST_0 
       (.I0(instruction[26]),
        .I1(instruction[23]),
        .I2(instruction[22]),
        .I3(instruction[24]),
        .I4(instruction[21]),
        .I5(instruction[27]),
        .O(EXE_CMD[2]));
  LUT6 #(
    .INIT(64'h0000000040010000)) 
    \EXE_CMD[3]_INST_0 
       (.I0(instruction[26]),
        .I1(instruction[23]),
        .I2(instruction[22]),
        .I3(instruction[24]),
        .I4(instruction[21]),
        .I5(instruction[27]),
        .O(EXE_CMD[3]));
  LUT3 #(
    .INIT(8'h08)) 
    MEM_R_EN_INST_0
       (.I0(instruction[26]),
        .I1(instruction[20]),
        .I2(instruction[27]),
        .O(MEM_R_EN));
  LUT3 #(
    .INIT(8'h04)) 
    MEM_W_EN_INST_0
       (.I0(instruction[20]),
        .I1(instruction[26]),
        .I2(instruction[27]),
        .O(MEM_W_EN));
  LUT2 #(
    .INIT(4'h2)) 
    WB_EN_INST_0
       (.I0(WB_EN_INST_0_i_1_n_0),
        .I1(instruction[27]),
        .O(WB_EN));
  LUT6 #(
    .INIT(64'hB8BB88888BBB8BBB)) 
    WB_EN_INST_0_i_1
       (.I0(instruction[20]),
        .I1(instruction[26]),
        .I2(instruction[21]),
        .I3(instruction[22]),
        .I4(instruction[23]),
        .I5(instruction[24]),
        .O(WB_EN_INST_0_i_1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    imm_INST_0
       (.I0(instruction[25]),
        .I1(instruction[26]),
        .O(imm));
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
