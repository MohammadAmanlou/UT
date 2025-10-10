// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun May 11 11:31:32 2025
// Host        : Ariyan running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/ariya/OneDrive/Desktop/project_1/project_1/project_1.srcs/sources_1/bd/design_2/ip/design_2_RedAdder_0_0/design_2_RedAdder_0_0_sim_netlist.v
// Design      : design_2_RedAdder_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_2_RedAdder_0_0,RedAdder,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "RedAdder,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module design_2_RedAdder_0_0
   (a,
    b,
    out);
  input [23:0]a;
  input [31:0]b;
  output [31:0]out;

  wire [23:0]a;
  wire [31:0]b;
  wire [31:0]out;

  design_2_RedAdder_0_0_RedAdder inst
       (.a(a),
        .b(b),
        .out(out));
endmodule

(* ORIG_REF_NAME = "RedAdder" *) 
module design_2_RedAdder_0_0_RedAdder
   (out,
    b,
    a);
  output [31:0]out;
  input [31:0]b;
  input [23:0]a;

  wire [23:0]a;
  wire [31:0]b;
  wire [31:0]out;
  wire \out[0]_INST_0_i_1_n_0 ;
  wire \out[0]_INST_0_i_2_n_0 ;
  wire \out[0]_INST_0_i_3_n_0 ;
  wire \out[0]_INST_0_i_4_n_0 ;
  wire \out[0]_INST_0_n_0 ;
  wire \out[0]_INST_0_n_1 ;
  wire \out[0]_INST_0_n_2 ;
  wire \out[0]_INST_0_n_3 ;
  wire \out[12]_INST_0_i_1_n_0 ;
  wire \out[12]_INST_0_i_2_n_0 ;
  wire \out[12]_INST_0_i_3_n_0 ;
  wire \out[12]_INST_0_i_4_n_0 ;
  wire \out[12]_INST_0_n_0 ;
  wire \out[12]_INST_0_n_1 ;
  wire \out[12]_INST_0_n_2 ;
  wire \out[12]_INST_0_n_3 ;
  wire \out[16]_INST_0_i_1_n_0 ;
  wire \out[16]_INST_0_i_2_n_0 ;
  wire \out[16]_INST_0_i_3_n_0 ;
  wire \out[16]_INST_0_i_4_n_0 ;
  wire \out[16]_INST_0_n_0 ;
  wire \out[16]_INST_0_n_1 ;
  wire \out[16]_INST_0_n_2 ;
  wire \out[16]_INST_0_n_3 ;
  wire \out[20]_INST_0_i_1_n_0 ;
  wire \out[20]_INST_0_i_2_n_0 ;
  wire \out[20]_INST_0_i_3_n_0 ;
  wire \out[20]_INST_0_i_4_n_0 ;
  wire \out[20]_INST_0_i_5_n_0 ;
  wire \out[20]_INST_0_n_0 ;
  wire \out[20]_INST_0_n_1 ;
  wire \out[20]_INST_0_n_2 ;
  wire \out[20]_INST_0_n_3 ;
  wire \out[24]_INST_0_i_1_n_0 ;
  wire \out[24]_INST_0_i_2_n_0 ;
  wire \out[24]_INST_0_i_3_n_0 ;
  wire \out[24]_INST_0_i_4_n_0 ;
  wire \out[24]_INST_0_n_0 ;
  wire \out[24]_INST_0_n_1 ;
  wire \out[24]_INST_0_n_2 ;
  wire \out[24]_INST_0_n_3 ;
  wire \out[28]_INST_0_i_1_n_0 ;
  wire \out[28]_INST_0_i_2_n_0 ;
  wire \out[28]_INST_0_i_3_n_0 ;
  wire \out[28]_INST_0_i_4_n_0 ;
  wire \out[28]_INST_0_n_1 ;
  wire \out[28]_INST_0_n_2 ;
  wire \out[28]_INST_0_n_3 ;
  wire \out[4]_INST_0_i_1_n_0 ;
  wire \out[4]_INST_0_i_2_n_0 ;
  wire \out[4]_INST_0_i_3_n_0 ;
  wire \out[4]_INST_0_i_4_n_0 ;
  wire \out[4]_INST_0_n_0 ;
  wire \out[4]_INST_0_n_1 ;
  wire \out[4]_INST_0_n_2 ;
  wire \out[4]_INST_0_n_3 ;
  wire \out[8]_INST_0_i_1_n_0 ;
  wire \out[8]_INST_0_i_2_n_0 ;
  wire \out[8]_INST_0_i_3_n_0 ;
  wire \out[8]_INST_0_i_4_n_0 ;
  wire \out[8]_INST_0_n_0 ;
  wire \out[8]_INST_0_n_1 ;
  wire \out[8]_INST_0_n_2 ;
  wire \out[8]_INST_0_n_3 ;
  wire [3:3]\NLW_out[28]_INST_0_CO_UNCONNECTED ;

  CARRY4 \out[0]_INST_0 
       (.CI(1'b0),
        .CO({\out[0]_INST_0_n_0 ,\out[0]_INST_0_n_1 ,\out[0]_INST_0_n_2 ,\out[0]_INST_0_n_3 }),
        .CYINIT(1'b0),
        .DI(a[3:0]),
        .O(out[3:0]),
        .S({\out[0]_INST_0_i_1_n_0 ,\out[0]_INST_0_i_2_n_0 ,\out[0]_INST_0_i_3_n_0 ,\out[0]_INST_0_i_4_n_0 }));
  LUT2 #(
    .INIT(4'h6)) 
    \out[0]_INST_0_i_1 
       (.I0(a[3]),
        .I1(b[3]),
        .O(\out[0]_INST_0_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \out[0]_INST_0_i_2 
       (.I0(a[2]),
        .I1(b[2]),
        .O(\out[0]_INST_0_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \out[0]_INST_0_i_3 
       (.I0(a[1]),
        .I1(b[1]),
        .O(\out[0]_INST_0_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \out[0]_INST_0_i_4 
       (.I0(a[0]),
        .I1(b[0]),
        .O(\out[0]_INST_0_i_4_n_0 ));
  CARRY4 \out[12]_INST_0 
       (.CI(\out[8]_INST_0_n_0 ),
        .CO({\out[12]_INST_0_n_0 ,\out[12]_INST_0_n_1 ,\out[12]_INST_0_n_2 ,\out[12]_INST_0_n_3 }),
        .CYINIT(1'b0),
        .DI(a[15:12]),
        .O(out[15:12]),
        .S({\out[12]_INST_0_i_1_n_0 ,\out[12]_INST_0_i_2_n_0 ,\out[12]_INST_0_i_3_n_0 ,\out[12]_INST_0_i_4_n_0 }));
  LUT2 #(
    .INIT(4'h6)) 
    \out[12]_INST_0_i_1 
       (.I0(a[15]),
        .I1(b[15]),
        .O(\out[12]_INST_0_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \out[12]_INST_0_i_2 
       (.I0(a[14]),
        .I1(b[14]),
        .O(\out[12]_INST_0_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \out[12]_INST_0_i_3 
       (.I0(a[13]),
        .I1(b[13]),
        .O(\out[12]_INST_0_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \out[12]_INST_0_i_4 
       (.I0(a[12]),
        .I1(b[12]),
        .O(\out[12]_INST_0_i_4_n_0 ));
  CARRY4 \out[16]_INST_0 
       (.CI(\out[12]_INST_0_n_0 ),
        .CO({\out[16]_INST_0_n_0 ,\out[16]_INST_0_n_1 ,\out[16]_INST_0_n_2 ,\out[16]_INST_0_n_3 }),
        .CYINIT(1'b0),
        .DI(a[19:16]),
        .O(out[19:16]),
        .S({\out[16]_INST_0_i_1_n_0 ,\out[16]_INST_0_i_2_n_0 ,\out[16]_INST_0_i_3_n_0 ,\out[16]_INST_0_i_4_n_0 }));
  LUT2 #(
    .INIT(4'h6)) 
    \out[16]_INST_0_i_1 
       (.I0(a[19]),
        .I1(b[19]),
        .O(\out[16]_INST_0_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \out[16]_INST_0_i_2 
       (.I0(a[18]),
        .I1(b[18]),
        .O(\out[16]_INST_0_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \out[16]_INST_0_i_3 
       (.I0(a[17]),
        .I1(b[17]),
        .O(\out[16]_INST_0_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \out[16]_INST_0_i_4 
       (.I0(a[16]),
        .I1(b[16]),
        .O(\out[16]_INST_0_i_4_n_0 ));
  CARRY4 \out[20]_INST_0 
       (.CI(\out[16]_INST_0_n_0 ),
        .CO({\out[20]_INST_0_n_0 ,\out[20]_INST_0_n_1 ,\out[20]_INST_0_n_2 ,\out[20]_INST_0_n_3 }),
        .CYINIT(1'b0),
        .DI({\out[20]_INST_0_i_1_n_0 ,a[22:20]}),
        .O(out[23:20]),
        .S({\out[20]_INST_0_i_2_n_0 ,\out[20]_INST_0_i_3_n_0 ,\out[20]_INST_0_i_4_n_0 ,\out[20]_INST_0_i_5_n_0 }));
  LUT1 #(
    .INIT(2'h1)) 
    \out[20]_INST_0_i_1 
       (.I0(b[23]),
        .O(\out[20]_INST_0_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \out[20]_INST_0_i_2 
       (.I0(b[23]),
        .I1(a[23]),
        .O(\out[20]_INST_0_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \out[20]_INST_0_i_3 
       (.I0(a[22]),
        .I1(b[22]),
        .O(\out[20]_INST_0_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \out[20]_INST_0_i_4 
       (.I0(a[21]),
        .I1(b[21]),
        .O(\out[20]_INST_0_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \out[20]_INST_0_i_5 
       (.I0(a[20]),
        .I1(b[20]),
        .O(\out[20]_INST_0_i_5_n_0 ));
  CARRY4 \out[24]_INST_0 
       (.CI(\out[20]_INST_0_n_0 ),
        .CO({\out[24]_INST_0_n_0 ,\out[24]_INST_0_n_1 ,\out[24]_INST_0_n_2 ,\out[24]_INST_0_n_3 }),
        .CYINIT(1'b0),
        .DI(b[26:23]),
        .O(out[27:24]),
        .S({\out[24]_INST_0_i_1_n_0 ,\out[24]_INST_0_i_2_n_0 ,\out[24]_INST_0_i_3_n_0 ,\out[24]_INST_0_i_4_n_0 }));
  LUT2 #(
    .INIT(4'h9)) 
    \out[24]_INST_0_i_1 
       (.I0(b[26]),
        .I1(b[27]),
        .O(\out[24]_INST_0_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \out[24]_INST_0_i_2 
       (.I0(b[25]),
        .I1(b[26]),
        .O(\out[24]_INST_0_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \out[24]_INST_0_i_3 
       (.I0(b[24]),
        .I1(b[25]),
        .O(\out[24]_INST_0_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \out[24]_INST_0_i_4 
       (.I0(b[23]),
        .I1(b[24]),
        .O(\out[24]_INST_0_i_4_n_0 ));
  CARRY4 \out[28]_INST_0 
       (.CI(\out[24]_INST_0_n_0 ),
        .CO({\NLW_out[28]_INST_0_CO_UNCONNECTED [3],\out[28]_INST_0_n_1 ,\out[28]_INST_0_n_2 ,\out[28]_INST_0_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,b[29:27]}),
        .O(out[31:28]),
        .S({\out[28]_INST_0_i_1_n_0 ,\out[28]_INST_0_i_2_n_0 ,\out[28]_INST_0_i_3_n_0 ,\out[28]_INST_0_i_4_n_0 }));
  LUT2 #(
    .INIT(4'h9)) 
    \out[28]_INST_0_i_1 
       (.I0(b[30]),
        .I1(b[31]),
        .O(\out[28]_INST_0_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \out[28]_INST_0_i_2 
       (.I0(b[29]),
        .I1(b[30]),
        .O(\out[28]_INST_0_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \out[28]_INST_0_i_3 
       (.I0(b[28]),
        .I1(b[29]),
        .O(\out[28]_INST_0_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    \out[28]_INST_0_i_4 
       (.I0(b[27]),
        .I1(b[28]),
        .O(\out[28]_INST_0_i_4_n_0 ));
  CARRY4 \out[4]_INST_0 
       (.CI(\out[0]_INST_0_n_0 ),
        .CO({\out[4]_INST_0_n_0 ,\out[4]_INST_0_n_1 ,\out[4]_INST_0_n_2 ,\out[4]_INST_0_n_3 }),
        .CYINIT(1'b0),
        .DI(a[7:4]),
        .O(out[7:4]),
        .S({\out[4]_INST_0_i_1_n_0 ,\out[4]_INST_0_i_2_n_0 ,\out[4]_INST_0_i_3_n_0 ,\out[4]_INST_0_i_4_n_0 }));
  LUT2 #(
    .INIT(4'h6)) 
    \out[4]_INST_0_i_1 
       (.I0(a[7]),
        .I1(b[7]),
        .O(\out[4]_INST_0_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \out[4]_INST_0_i_2 
       (.I0(a[6]),
        .I1(b[6]),
        .O(\out[4]_INST_0_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \out[4]_INST_0_i_3 
       (.I0(a[5]),
        .I1(b[5]),
        .O(\out[4]_INST_0_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \out[4]_INST_0_i_4 
       (.I0(a[4]),
        .I1(b[4]),
        .O(\out[4]_INST_0_i_4_n_0 ));
  CARRY4 \out[8]_INST_0 
       (.CI(\out[4]_INST_0_n_0 ),
        .CO({\out[8]_INST_0_n_0 ,\out[8]_INST_0_n_1 ,\out[8]_INST_0_n_2 ,\out[8]_INST_0_n_3 }),
        .CYINIT(1'b0),
        .DI(a[11:8]),
        .O(out[11:8]),
        .S({\out[8]_INST_0_i_1_n_0 ,\out[8]_INST_0_i_2_n_0 ,\out[8]_INST_0_i_3_n_0 ,\out[8]_INST_0_i_4_n_0 }));
  LUT2 #(
    .INIT(4'h6)) 
    \out[8]_INST_0_i_1 
       (.I0(a[11]),
        .I1(b[11]),
        .O(\out[8]_INST_0_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \out[8]_INST_0_i_2 
       (.I0(a[10]),
        .I1(b[10]),
        .O(\out[8]_INST_0_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \out[8]_INST_0_i_3 
       (.I0(a[9]),
        .I1(b[9]),
        .O(\out[8]_INST_0_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \out[8]_INST_0_i_4 
       (.I0(a[8]),
        .I1(b[8]),
        .O(\out[8]_INST_0_i_4_n_0 ));
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
