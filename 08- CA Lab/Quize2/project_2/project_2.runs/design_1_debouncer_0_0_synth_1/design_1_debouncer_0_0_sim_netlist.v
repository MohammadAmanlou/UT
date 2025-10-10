// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun Mar  9 10:42:18 2025
// Host        : Ariyan running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_debouncer_0_0_sim_netlist.v
// Design      : design_1_debouncer_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_debouncer
   (SIGNAL_O,
    SIGNAL_I,
    CLK_I);
  output [0:0]SIGNAL_O;
  input [0:0]SIGNAL_I;
  input CLK_I;

  wire CLK_I;
  wire [0:0]SIGNAL_I;
  wire [0:0]SIGNAL_O;
  wire \sig_cntrs_ary[0][0]_i_1_n_0 ;
  wire \sig_cntrs_ary[0][0]_i_3_n_0 ;
  wire \sig_cntrs_ary_reg[0][0]_i_2_n_0 ;
  wire \sig_cntrs_ary_reg[0][0]_i_2_n_1 ;
  wire \sig_cntrs_ary_reg[0][0]_i_2_n_2 ;
  wire \sig_cntrs_ary_reg[0][0]_i_2_n_3 ;
  wire \sig_cntrs_ary_reg[0][0]_i_2_n_4 ;
  wire \sig_cntrs_ary_reg[0][0]_i_2_n_5 ;
  wire \sig_cntrs_ary_reg[0][0]_i_2_n_6 ;
  wire \sig_cntrs_ary_reg[0][0]_i_2_n_7 ;
  wire \sig_cntrs_ary_reg[0][12]_i_1_n_1 ;
  wire \sig_cntrs_ary_reg[0][12]_i_1_n_2 ;
  wire \sig_cntrs_ary_reg[0][12]_i_1_n_3 ;
  wire \sig_cntrs_ary_reg[0][12]_i_1_n_4 ;
  wire \sig_cntrs_ary_reg[0][12]_i_1_n_5 ;
  wire \sig_cntrs_ary_reg[0][12]_i_1_n_6 ;
  wire \sig_cntrs_ary_reg[0][12]_i_1_n_7 ;
  wire \sig_cntrs_ary_reg[0][4]_i_1_n_0 ;
  wire \sig_cntrs_ary_reg[0][4]_i_1_n_1 ;
  wire \sig_cntrs_ary_reg[0][4]_i_1_n_2 ;
  wire \sig_cntrs_ary_reg[0][4]_i_1_n_3 ;
  wire \sig_cntrs_ary_reg[0][4]_i_1_n_4 ;
  wire \sig_cntrs_ary_reg[0][4]_i_1_n_5 ;
  wire \sig_cntrs_ary_reg[0][4]_i_1_n_6 ;
  wire \sig_cntrs_ary_reg[0][4]_i_1_n_7 ;
  wire \sig_cntrs_ary_reg[0][8]_i_1_n_0 ;
  wire \sig_cntrs_ary_reg[0][8]_i_1_n_1 ;
  wire \sig_cntrs_ary_reg[0][8]_i_1_n_2 ;
  wire \sig_cntrs_ary_reg[0][8]_i_1_n_3 ;
  wire \sig_cntrs_ary_reg[0][8]_i_1_n_4 ;
  wire \sig_cntrs_ary_reg[0][8]_i_1_n_5 ;
  wire \sig_cntrs_ary_reg[0][8]_i_1_n_6 ;
  wire \sig_cntrs_ary_reg[0][8]_i_1_n_7 ;
  wire [15:0]\sig_cntrs_ary_reg[0]_0 ;
  wire \sig_out_reg[0]_i_1_n_0 ;
  wire \sig_out_reg[0]_i_2_n_0 ;
  wire \sig_out_reg[0]_i_3_n_0 ;
  wire \sig_out_reg[0]_i_4_n_0 ;
  wire \sig_out_reg[0]_i_5_n_0 ;
  wire [3:3]\NLW_sig_cntrs_ary_reg[0][12]_i_1_CO_UNCONNECTED ;

  LUT6 #(
    .INIT(64'hFFFF00800080FFFF)) 
    \sig_cntrs_ary[0][0]_i_1 
       (.I0(\sig_out_reg[0]_i_2_n_0 ),
        .I1(\sig_out_reg[0]_i_3_n_0 ),
        .I2(\sig_out_reg[0]_i_4_n_0 ),
        .I3(\sig_out_reg[0]_i_5_n_0 ),
        .I4(SIGNAL_O),
        .I5(SIGNAL_I),
        .O(\sig_cntrs_ary[0][0]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \sig_cntrs_ary[0][0]_i_3 
       (.I0(\sig_cntrs_ary_reg[0]_0 [0]),
        .O(\sig_cntrs_ary[0][0]_i_3_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \sig_cntrs_ary_reg[0][0] 
       (.C(CLK_I),
        .CE(1'b1),
        .D(\sig_cntrs_ary_reg[0][0]_i_2_n_7 ),
        .Q(\sig_cntrs_ary_reg[0]_0 [0]),
        .R(\sig_cntrs_ary[0][0]_i_1_n_0 ));
  CARRY4 \sig_cntrs_ary_reg[0][0]_i_2 
       (.CI(1'b0),
        .CO({\sig_cntrs_ary_reg[0][0]_i_2_n_0 ,\sig_cntrs_ary_reg[0][0]_i_2_n_1 ,\sig_cntrs_ary_reg[0][0]_i_2_n_2 ,\sig_cntrs_ary_reg[0][0]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\sig_cntrs_ary_reg[0][0]_i_2_n_4 ,\sig_cntrs_ary_reg[0][0]_i_2_n_5 ,\sig_cntrs_ary_reg[0][0]_i_2_n_6 ,\sig_cntrs_ary_reg[0][0]_i_2_n_7 }),
        .S({\sig_cntrs_ary_reg[0]_0 [3:1],\sig_cntrs_ary[0][0]_i_3_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \sig_cntrs_ary_reg[0][10] 
       (.C(CLK_I),
        .CE(1'b1),
        .D(\sig_cntrs_ary_reg[0][8]_i_1_n_5 ),
        .Q(\sig_cntrs_ary_reg[0]_0 [10]),
        .R(\sig_cntrs_ary[0][0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \sig_cntrs_ary_reg[0][11] 
       (.C(CLK_I),
        .CE(1'b1),
        .D(\sig_cntrs_ary_reg[0][8]_i_1_n_4 ),
        .Q(\sig_cntrs_ary_reg[0]_0 [11]),
        .R(\sig_cntrs_ary[0][0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \sig_cntrs_ary_reg[0][12] 
       (.C(CLK_I),
        .CE(1'b1),
        .D(\sig_cntrs_ary_reg[0][12]_i_1_n_7 ),
        .Q(\sig_cntrs_ary_reg[0]_0 [12]),
        .R(\sig_cntrs_ary[0][0]_i_1_n_0 ));
  CARRY4 \sig_cntrs_ary_reg[0][12]_i_1 
       (.CI(\sig_cntrs_ary_reg[0][8]_i_1_n_0 ),
        .CO({\NLW_sig_cntrs_ary_reg[0][12]_i_1_CO_UNCONNECTED [3],\sig_cntrs_ary_reg[0][12]_i_1_n_1 ,\sig_cntrs_ary_reg[0][12]_i_1_n_2 ,\sig_cntrs_ary_reg[0][12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\sig_cntrs_ary_reg[0][12]_i_1_n_4 ,\sig_cntrs_ary_reg[0][12]_i_1_n_5 ,\sig_cntrs_ary_reg[0][12]_i_1_n_6 ,\sig_cntrs_ary_reg[0][12]_i_1_n_7 }),
        .S(\sig_cntrs_ary_reg[0]_0 [15:12]));
  FDRE #(
    .INIT(1'b0)) 
    \sig_cntrs_ary_reg[0][13] 
       (.C(CLK_I),
        .CE(1'b1),
        .D(\sig_cntrs_ary_reg[0][12]_i_1_n_6 ),
        .Q(\sig_cntrs_ary_reg[0]_0 [13]),
        .R(\sig_cntrs_ary[0][0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \sig_cntrs_ary_reg[0][14] 
       (.C(CLK_I),
        .CE(1'b1),
        .D(\sig_cntrs_ary_reg[0][12]_i_1_n_5 ),
        .Q(\sig_cntrs_ary_reg[0]_0 [14]),
        .R(\sig_cntrs_ary[0][0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \sig_cntrs_ary_reg[0][15] 
       (.C(CLK_I),
        .CE(1'b1),
        .D(\sig_cntrs_ary_reg[0][12]_i_1_n_4 ),
        .Q(\sig_cntrs_ary_reg[0]_0 [15]),
        .R(\sig_cntrs_ary[0][0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \sig_cntrs_ary_reg[0][1] 
       (.C(CLK_I),
        .CE(1'b1),
        .D(\sig_cntrs_ary_reg[0][0]_i_2_n_6 ),
        .Q(\sig_cntrs_ary_reg[0]_0 [1]),
        .R(\sig_cntrs_ary[0][0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \sig_cntrs_ary_reg[0][2] 
       (.C(CLK_I),
        .CE(1'b1),
        .D(\sig_cntrs_ary_reg[0][0]_i_2_n_5 ),
        .Q(\sig_cntrs_ary_reg[0]_0 [2]),
        .R(\sig_cntrs_ary[0][0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \sig_cntrs_ary_reg[0][3] 
       (.C(CLK_I),
        .CE(1'b1),
        .D(\sig_cntrs_ary_reg[0][0]_i_2_n_4 ),
        .Q(\sig_cntrs_ary_reg[0]_0 [3]),
        .R(\sig_cntrs_ary[0][0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \sig_cntrs_ary_reg[0][4] 
       (.C(CLK_I),
        .CE(1'b1),
        .D(\sig_cntrs_ary_reg[0][4]_i_1_n_7 ),
        .Q(\sig_cntrs_ary_reg[0]_0 [4]),
        .R(\sig_cntrs_ary[0][0]_i_1_n_0 ));
  CARRY4 \sig_cntrs_ary_reg[0][4]_i_1 
       (.CI(\sig_cntrs_ary_reg[0][0]_i_2_n_0 ),
        .CO({\sig_cntrs_ary_reg[0][4]_i_1_n_0 ,\sig_cntrs_ary_reg[0][4]_i_1_n_1 ,\sig_cntrs_ary_reg[0][4]_i_1_n_2 ,\sig_cntrs_ary_reg[0][4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\sig_cntrs_ary_reg[0][4]_i_1_n_4 ,\sig_cntrs_ary_reg[0][4]_i_1_n_5 ,\sig_cntrs_ary_reg[0][4]_i_1_n_6 ,\sig_cntrs_ary_reg[0][4]_i_1_n_7 }),
        .S(\sig_cntrs_ary_reg[0]_0 [7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \sig_cntrs_ary_reg[0][5] 
       (.C(CLK_I),
        .CE(1'b1),
        .D(\sig_cntrs_ary_reg[0][4]_i_1_n_6 ),
        .Q(\sig_cntrs_ary_reg[0]_0 [5]),
        .R(\sig_cntrs_ary[0][0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \sig_cntrs_ary_reg[0][6] 
       (.C(CLK_I),
        .CE(1'b1),
        .D(\sig_cntrs_ary_reg[0][4]_i_1_n_5 ),
        .Q(\sig_cntrs_ary_reg[0]_0 [6]),
        .R(\sig_cntrs_ary[0][0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \sig_cntrs_ary_reg[0][7] 
       (.C(CLK_I),
        .CE(1'b1),
        .D(\sig_cntrs_ary_reg[0][4]_i_1_n_4 ),
        .Q(\sig_cntrs_ary_reg[0]_0 [7]),
        .R(\sig_cntrs_ary[0][0]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \sig_cntrs_ary_reg[0][8] 
       (.C(CLK_I),
        .CE(1'b1),
        .D(\sig_cntrs_ary_reg[0][8]_i_1_n_7 ),
        .Q(\sig_cntrs_ary_reg[0]_0 [8]),
        .R(\sig_cntrs_ary[0][0]_i_1_n_0 ));
  CARRY4 \sig_cntrs_ary_reg[0][8]_i_1 
       (.CI(\sig_cntrs_ary_reg[0][4]_i_1_n_0 ),
        .CO({\sig_cntrs_ary_reg[0][8]_i_1_n_0 ,\sig_cntrs_ary_reg[0][8]_i_1_n_1 ,\sig_cntrs_ary_reg[0][8]_i_1_n_2 ,\sig_cntrs_ary_reg[0][8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\sig_cntrs_ary_reg[0][8]_i_1_n_4 ,\sig_cntrs_ary_reg[0][8]_i_1_n_5 ,\sig_cntrs_ary_reg[0][8]_i_1_n_6 ,\sig_cntrs_ary_reg[0][8]_i_1_n_7 }),
        .S(\sig_cntrs_ary_reg[0]_0 [11:8]));
  FDRE #(
    .INIT(1'b0)) 
    \sig_cntrs_ary_reg[0][9] 
       (.C(CLK_I),
        .CE(1'b1),
        .D(\sig_cntrs_ary_reg[0][8]_i_1_n_6 ),
        .Q(\sig_cntrs_ary_reg[0]_0 [9]),
        .R(\sig_cntrs_ary[0][0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFF7F0080)) 
    \sig_out_reg[0]_i_1 
       (.I0(\sig_out_reg[0]_i_2_n_0 ),
        .I1(\sig_out_reg[0]_i_3_n_0 ),
        .I2(\sig_out_reg[0]_i_4_n_0 ),
        .I3(\sig_out_reg[0]_i_5_n_0 ),
        .I4(SIGNAL_O),
        .O(\sig_out_reg[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h8000)) 
    \sig_out_reg[0]_i_2 
       (.I0(\sig_cntrs_ary_reg[0]_0 [1]),
        .I1(\sig_cntrs_ary_reg[0]_0 [0]),
        .I2(\sig_cntrs_ary_reg[0]_0 [3]),
        .I3(\sig_cntrs_ary_reg[0]_0 [2]),
        .O(\sig_out_reg[0]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h8000)) 
    \sig_out_reg[0]_i_3 
       (.I0(\sig_cntrs_ary_reg[0]_0 [5]),
        .I1(\sig_cntrs_ary_reg[0]_0 [4]),
        .I2(\sig_cntrs_ary_reg[0]_0 [7]),
        .I3(\sig_cntrs_ary_reg[0]_0 [6]),
        .O(\sig_out_reg[0]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'h8000)) 
    \sig_out_reg[0]_i_4 
       (.I0(\sig_cntrs_ary_reg[0]_0 [13]),
        .I1(\sig_cntrs_ary_reg[0]_0 [12]),
        .I2(\sig_cntrs_ary_reg[0]_0 [14]),
        .I3(\sig_cntrs_ary_reg[0]_0 [15]),
        .O(\sig_out_reg[0]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \sig_out_reg[0]_i_5 
       (.I0(\sig_cntrs_ary_reg[0]_0 [9]),
        .I1(\sig_cntrs_ary_reg[0]_0 [8]),
        .I2(\sig_cntrs_ary_reg[0]_0 [11]),
        .I3(\sig_cntrs_ary_reg[0]_0 [10]),
        .O(\sig_out_reg[0]_i_5_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \sig_out_reg_reg[0] 
       (.C(CLK_I),
        .CE(1'b1),
        .D(\sig_out_reg[0]_i_1_n_0 ),
        .Q(SIGNAL_O),
        .R(1'b0));
endmodule

(* CHECK_LICENSE_TYPE = "design_1_debouncer_0_0,debouncer,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "debouncer,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (SIGNAL_I,
    CLK_I,
    SIGNAL_O);
  input [0:0]SIGNAL_I;
  input CLK_I;
  output [0:0]SIGNAL_O;

  wire CLK_I;
  wire [0:0]SIGNAL_I;
  wire [0:0]SIGNAL_O;

  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_debouncer inst
       (.CLK_I(CLK_I),
        .SIGNAL_I(SIGNAL_I),
        .SIGNAL_O(SIGNAL_O));
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
