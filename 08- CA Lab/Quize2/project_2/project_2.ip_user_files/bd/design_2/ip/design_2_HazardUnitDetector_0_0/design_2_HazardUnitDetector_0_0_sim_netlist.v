// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun May 25 17:54:05 2025
// Host        : Ariyan running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/ariya/OneDrive/Desktop/project_1/project_1/project_1.srcs/sources_1/bd/design_2/ip/design_2_HazardUnitDetector_0_0/design_2_HazardUnitDetector_0_0_sim_netlist.v
// Design      : design_2_HazardUnitDetector_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_2_HazardUnitDetector_0_0,HazardUnitDetector,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "HazardUnitDetector,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module design_2_HazardUnitDetector_0_0
   (rn,
    register_file_mux_out,
    Exe_Dest,
    Exe_WB_EN,
    Exe_MEM_R_EN,
    Mem_Dest,
    Mem_WB_EN,
    is_two_source,
    has_forwarding_unit,
    hazard_detected);
  input [3:0]rn;
  input [3:0]register_file_mux_out;
  input [3:0]Exe_Dest;
  input Exe_WB_EN;
  input Exe_MEM_R_EN;
  input [3:0]Mem_Dest;
  input Mem_WB_EN;
  input is_two_source;
  input has_forwarding_unit;
  output hazard_detected;

  wire [3:0]Exe_Dest;
  wire Exe_MEM_R_EN;
  wire Exe_WB_EN;
  wire [3:0]Mem_Dest;
  wire Mem_WB_EN;
  wire has_forwarding_unit;
  wire hazard_detected;
  wire hazard_detected_INST_0_i_2_n_0;
  wire hazard_detected_INST_0_i_3_n_0;
  wire hazard_detected_INST_0_i_4_n_0;
  wire hazard_detected_INST_0_i_5_n_0;
  wire hazard_detected_INST_0_i_6_n_0;
  wire \inst/hazard_detected1__1 ;
  wire is_two_source;
  wire [3:0]register_file_mux_out;
  wire [3:0]rn;

  LUT6 #(
    .INIT(64'hD5D5D080D080D080)) 
    hazard_detected_INST_0
       (.I0(has_forwarding_unit),
        .I1(Exe_MEM_R_EN),
        .I2(\inst/hazard_detected1__1 ),
        .I3(Exe_WB_EN),
        .I4(Mem_WB_EN),
        .I5(hazard_detected_INST_0_i_2_n_0),
        .O(hazard_detected));
  LUT6 #(
    .INIT(64'hF82F882288228822)) 
    hazard_detected_INST_0_i_1
       (.I0(hazard_detected_INST_0_i_3_n_0),
        .I1(rn[3]),
        .I2(register_file_mux_out[3]),
        .I3(Exe_Dest[3]),
        .I4(hazard_detected_INST_0_i_4_n_0),
        .I5(is_two_source),
        .O(\inst/hazard_detected1__1 ));
  LUT6 #(
    .INIT(64'hF82F882288228822)) 
    hazard_detected_INST_0_i_2
       (.I0(hazard_detected_INST_0_i_5_n_0),
        .I1(rn[3]),
        .I2(register_file_mux_out[3]),
        .I3(Mem_Dest[3]),
        .I4(hazard_detected_INST_0_i_6_n_0),
        .I5(is_two_source),
        .O(hazard_detected_INST_0_i_2_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    hazard_detected_INST_0_i_3
       (.I0(rn[0]),
        .I1(Exe_Dest[0]),
        .I2(Exe_Dest[2]),
        .I3(rn[2]),
        .I4(Exe_Dest[1]),
        .I5(rn[1]),
        .O(hazard_detected_INST_0_i_3_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    hazard_detected_INST_0_i_4
       (.I0(register_file_mux_out[0]),
        .I1(Exe_Dest[0]),
        .I2(Exe_Dest[2]),
        .I3(register_file_mux_out[2]),
        .I4(Exe_Dest[1]),
        .I5(register_file_mux_out[1]),
        .O(hazard_detected_INST_0_i_4_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    hazard_detected_INST_0_i_5
       (.I0(rn[0]),
        .I1(Mem_Dest[0]),
        .I2(Mem_Dest[2]),
        .I3(rn[2]),
        .I4(Mem_Dest[1]),
        .I5(rn[1]),
        .O(hazard_detected_INST_0_i_5_n_0));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    hazard_detected_INST_0_i_6
       (.I0(register_file_mux_out[0]),
        .I1(Mem_Dest[0]),
        .I2(Mem_Dest[2]),
        .I3(register_file_mux_out[2]),
        .I4(Mem_Dest[1]),
        .I5(register_file_mux_out[1]),
        .O(hazard_detected_INST_0_i_6_n_0));
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
