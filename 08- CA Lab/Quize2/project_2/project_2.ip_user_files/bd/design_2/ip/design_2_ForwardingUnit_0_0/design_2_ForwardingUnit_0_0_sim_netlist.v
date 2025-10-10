// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun May 18 17:20:27 2025
// Host        : Ariyan running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/ariya/OneDrive/Desktop/project_1/project_1/project_1.srcs/sources_1/bd/design_2/ip/design_2_ForwardingUnit_0_0/design_2_ForwardingUnit_0_0_sim_netlist.v
// Design      : design_2_ForwardingUnit_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_2_ForwardingUnit_0_0,ForwardingUnit,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "ForwardingUnit,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module design_2_ForwardingUnit_0_0
   (MEM_DEST,
    WB_DEST,
    MEM_WB_EN,
    WB_WB_EN,
    src1,
    src2,
    ForwardA,
    ForwardB);
  input [3:0]MEM_DEST;
  input [3:0]WB_DEST;
  input MEM_WB_EN;
  input WB_WB_EN;
  input [3:0]src1;
  input [3:0]src2;
  output [1:0]ForwardA;
  output [1:0]ForwardB;

  wire [1:0]ForwardA;
  wire \ForwardA[1]_INST_0_i_1_n_0 ;
  wire \ForwardA[1]_INST_0_i_2_n_0 ;
  wire \ForwardA[1]_INST_0_i_3_n_0 ;
  wire [1:0]ForwardB;
  wire \ForwardB[1]_INST_0_i_1_n_0 ;
  wire \ForwardB[1]_INST_0_i_2_n_0 ;
  wire \ForwardB[1]_INST_0_i_3_n_0 ;
  wire [3:0]MEM_DEST;
  wire MEM_WB_EN;
  wire [3:0]WB_DEST;
  wire WB_WB_EN;
  wire [3:0]src1;
  wire [3:0]src2;

  LUT4 #(
    .INIT(16'h8008)) 
    \ForwardA[0]_INST_0 
       (.I0(\ForwardA[1]_INST_0_i_3_n_0 ),
        .I1(MEM_WB_EN),
        .I2(src1[1]),
        .I3(MEM_DEST[1]),
        .O(ForwardA[0]));
  LUT6 #(
    .INIT(64'h0000900090009000)) 
    \ForwardA[1]_INST_0 
       (.I0(WB_DEST[1]),
        .I1(src1[1]),
        .I2(WB_WB_EN),
        .I3(\ForwardA[1]_INST_0_i_1_n_0 ),
        .I4(\ForwardA[1]_INST_0_i_2_n_0 ),
        .I5(\ForwardA[1]_INST_0_i_3_n_0 ),
        .O(ForwardA[1]));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \ForwardA[1]_INST_0_i_1 
       (.I0(src1[0]),
        .I1(WB_DEST[0]),
        .I2(src1[3]),
        .I3(WB_DEST[3]),
        .I4(src1[2]),
        .I5(WB_DEST[2]),
        .O(\ForwardA[1]_INST_0_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h90)) 
    \ForwardA[1]_INST_0_i_2 
       (.I0(MEM_DEST[1]),
        .I1(src1[1]),
        .I2(MEM_WB_EN),
        .O(\ForwardA[1]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \ForwardA[1]_INST_0_i_3 
       (.I0(src1[0]),
        .I1(MEM_DEST[0]),
        .I2(src1[3]),
        .I3(MEM_DEST[3]),
        .I4(MEM_DEST[2]),
        .I5(src1[2]),
        .O(\ForwardA[1]_INST_0_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h8008)) 
    \ForwardB[0]_INST_0 
       (.I0(\ForwardB[1]_INST_0_i_3_n_0 ),
        .I1(MEM_WB_EN),
        .I2(src2[1]),
        .I3(MEM_DEST[1]),
        .O(ForwardB[0]));
  LUT6 #(
    .INIT(64'h0000900090009000)) 
    \ForwardB[1]_INST_0 
       (.I0(WB_DEST[1]),
        .I1(src2[1]),
        .I2(WB_WB_EN),
        .I3(\ForwardB[1]_INST_0_i_1_n_0 ),
        .I4(\ForwardB[1]_INST_0_i_2_n_0 ),
        .I5(\ForwardB[1]_INST_0_i_3_n_0 ),
        .O(ForwardB[1]));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \ForwardB[1]_INST_0_i_1 
       (.I0(src2[0]),
        .I1(WB_DEST[0]),
        .I2(src2[3]),
        .I3(WB_DEST[3]),
        .I4(WB_DEST[2]),
        .I5(src2[2]),
        .O(\ForwardB[1]_INST_0_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h90)) 
    \ForwardB[1]_INST_0_i_2 
       (.I0(MEM_DEST[1]),
        .I1(src2[1]),
        .I2(MEM_WB_EN),
        .O(\ForwardB[1]_INST_0_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \ForwardB[1]_INST_0_i_3 
       (.I0(src2[0]),
        .I1(MEM_DEST[0]),
        .I2(src2[3]),
        .I3(MEM_DEST[3]),
        .I4(MEM_DEST[2]),
        .I5(src2[2]),
        .O(\ForwardB[1]_INST_0_i_3_n_0 ));
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
