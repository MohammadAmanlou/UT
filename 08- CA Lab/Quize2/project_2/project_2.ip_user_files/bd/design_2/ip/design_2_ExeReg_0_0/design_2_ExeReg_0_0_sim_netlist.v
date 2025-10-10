// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun Apr 20 17:26:21 2025
// Host        : Ariyan running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/ariya/ARM/ARM.srcs/sources_1/bd/design_2/ip/design_2_ExeReg_0_0/design_2_ExeReg_0_0_sim_netlist.v
// Design      : design_2_ExeReg_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_2_ExeReg_0_0,ExeReg,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "ExeReg,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module design_2_ExeReg_0_0
   (clk,
    rst,
    WB_EN,
    MEM_R_EN,
    MEM_W_EN,
    ALU_Res,
    Val_Rm,
    dest,
    WB_EN_out,
    MEM_R_EN_out,
    MEM_W_EN_out,
    ALU_Res_out,
    Val_Rm_out,
    dest_out);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN design_2_clk_0, INSERT_VIP 0" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input rst;
  input WB_EN;
  input MEM_R_EN;
  input MEM_W_EN;
  input [31:0]ALU_Res;
  input [31:0]Val_Rm;
  input [3:0]dest;
  output WB_EN_out;
  output MEM_R_EN_out;
  output MEM_W_EN_out;
  output [31:0]ALU_Res_out;
  output [31:0]Val_Rm_out;
  output [3:0]dest_out;

  wire [31:0]ALU_Res;
  wire [31:0]ALU_Res_out;
  wire MEM_R_EN;
  wire MEM_R_EN_out;
  wire MEM_W_EN;
  wire MEM_W_EN_out;
  wire [31:0]Val_Rm;
  wire [31:0]Val_Rm_out;
  wire WB_EN;
  wire WB_EN_out;
  wire clk;
  wire [3:0]dest;
  wire [3:0]dest_out;
  wire rst;

  design_2_ExeReg_0_0_ExeReg inst
       (.ALU_Res(ALU_Res),
        .ALU_Res_out(ALU_Res_out),
        .MEM_R_EN(MEM_R_EN),
        .MEM_R_EN_out(MEM_R_EN_out),
        .MEM_W_EN(MEM_W_EN),
        .MEM_W_EN_out(MEM_W_EN_out),
        .Val_Rm(Val_Rm),
        .Val_Rm_out(Val_Rm_out),
        .WB_EN(WB_EN),
        .WB_EN_out(WB_EN_out),
        .clk(clk),
        .dest(dest),
        .dest_out(dest_out),
        .rst(rst));
endmodule

(* ORIG_REF_NAME = "ExeReg" *) 
module design_2_ExeReg_0_0_ExeReg
   (WB_EN_out,
    MEM_R_EN_out,
    MEM_W_EN_out,
    ALU_Res_out,
    Val_Rm_out,
    dest_out,
    WB_EN,
    clk,
    rst,
    MEM_R_EN,
    MEM_W_EN,
    ALU_Res,
    Val_Rm,
    dest);
  output WB_EN_out;
  output MEM_R_EN_out;
  output MEM_W_EN_out;
  output [31:0]ALU_Res_out;
  output [31:0]Val_Rm_out;
  output [3:0]dest_out;
  input WB_EN;
  input clk;
  input rst;
  input MEM_R_EN;
  input MEM_W_EN;
  input [31:0]ALU_Res;
  input [31:0]Val_Rm;
  input [3:0]dest;

  wire [31:0]ALU_Res;
  wire [31:0]ALU_Res_out;
  wire MEM_R_EN;
  wire MEM_R_EN_out;
  wire MEM_W_EN;
  wire MEM_W_EN_out;
  wire [31:0]Val_Rm;
  wire [31:0]Val_Rm_out;
  wire WB_EN;
  wire WB_EN_out;
  wire clk;
  wire [3:0]dest;
  wire [3:0]dest_out;
  wire rst;

  FDCE \ALU_Res_out_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[0]),
        .Q(ALU_Res_out[0]));
  FDCE \ALU_Res_out_reg[10] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[10]),
        .Q(ALU_Res_out[10]));
  FDCE \ALU_Res_out_reg[11] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[11]),
        .Q(ALU_Res_out[11]));
  FDCE \ALU_Res_out_reg[12] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[12]),
        .Q(ALU_Res_out[12]));
  FDCE \ALU_Res_out_reg[13] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[13]),
        .Q(ALU_Res_out[13]));
  FDCE \ALU_Res_out_reg[14] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[14]),
        .Q(ALU_Res_out[14]));
  FDCE \ALU_Res_out_reg[15] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[15]),
        .Q(ALU_Res_out[15]));
  FDCE \ALU_Res_out_reg[16] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[16]),
        .Q(ALU_Res_out[16]));
  FDCE \ALU_Res_out_reg[17] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[17]),
        .Q(ALU_Res_out[17]));
  FDCE \ALU_Res_out_reg[18] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[18]),
        .Q(ALU_Res_out[18]));
  FDCE \ALU_Res_out_reg[19] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[19]),
        .Q(ALU_Res_out[19]));
  FDCE \ALU_Res_out_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[1]),
        .Q(ALU_Res_out[1]));
  FDCE \ALU_Res_out_reg[20] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[20]),
        .Q(ALU_Res_out[20]));
  FDCE \ALU_Res_out_reg[21] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[21]),
        .Q(ALU_Res_out[21]));
  FDCE \ALU_Res_out_reg[22] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[22]),
        .Q(ALU_Res_out[22]));
  FDCE \ALU_Res_out_reg[23] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[23]),
        .Q(ALU_Res_out[23]));
  FDCE \ALU_Res_out_reg[24] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[24]),
        .Q(ALU_Res_out[24]));
  FDCE \ALU_Res_out_reg[25] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[25]),
        .Q(ALU_Res_out[25]));
  FDCE \ALU_Res_out_reg[26] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[26]),
        .Q(ALU_Res_out[26]));
  FDCE \ALU_Res_out_reg[27] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[27]),
        .Q(ALU_Res_out[27]));
  FDCE \ALU_Res_out_reg[28] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[28]),
        .Q(ALU_Res_out[28]));
  FDCE \ALU_Res_out_reg[29] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[29]),
        .Q(ALU_Res_out[29]));
  FDCE \ALU_Res_out_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[2]),
        .Q(ALU_Res_out[2]));
  FDCE \ALU_Res_out_reg[30] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[30]),
        .Q(ALU_Res_out[30]));
  FDCE \ALU_Res_out_reg[31] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[31]),
        .Q(ALU_Res_out[31]));
  FDCE \ALU_Res_out_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[3]),
        .Q(ALU_Res_out[3]));
  FDCE \ALU_Res_out_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[4]),
        .Q(ALU_Res_out[4]));
  FDCE \ALU_Res_out_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[5]),
        .Q(ALU_Res_out[5]));
  FDCE \ALU_Res_out_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[6]),
        .Q(ALU_Res_out[6]));
  FDCE \ALU_Res_out_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[7]),
        .Q(ALU_Res_out[7]));
  FDCE \ALU_Res_out_reg[8] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[8]),
        .Q(ALU_Res_out[8]));
  FDCE \ALU_Res_out_reg[9] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(ALU_Res[9]),
        .Q(ALU_Res_out[9]));
  FDCE MEM_R_EN_out_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(MEM_R_EN),
        .Q(MEM_R_EN_out));
  FDCE MEM_W_EN_out_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(MEM_W_EN),
        .Q(MEM_W_EN_out));
  FDCE \Val_Rm_out_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[0]),
        .Q(Val_Rm_out[0]));
  FDCE \Val_Rm_out_reg[10] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[10]),
        .Q(Val_Rm_out[10]));
  FDCE \Val_Rm_out_reg[11] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[11]),
        .Q(Val_Rm_out[11]));
  FDCE \Val_Rm_out_reg[12] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[12]),
        .Q(Val_Rm_out[12]));
  FDCE \Val_Rm_out_reg[13] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[13]),
        .Q(Val_Rm_out[13]));
  FDCE \Val_Rm_out_reg[14] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[14]),
        .Q(Val_Rm_out[14]));
  FDCE \Val_Rm_out_reg[15] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[15]),
        .Q(Val_Rm_out[15]));
  FDCE \Val_Rm_out_reg[16] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[16]),
        .Q(Val_Rm_out[16]));
  FDCE \Val_Rm_out_reg[17] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[17]),
        .Q(Val_Rm_out[17]));
  FDCE \Val_Rm_out_reg[18] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[18]),
        .Q(Val_Rm_out[18]));
  FDCE \Val_Rm_out_reg[19] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[19]),
        .Q(Val_Rm_out[19]));
  FDCE \Val_Rm_out_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[1]),
        .Q(Val_Rm_out[1]));
  FDCE \Val_Rm_out_reg[20] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[20]),
        .Q(Val_Rm_out[20]));
  FDCE \Val_Rm_out_reg[21] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[21]),
        .Q(Val_Rm_out[21]));
  FDCE \Val_Rm_out_reg[22] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[22]),
        .Q(Val_Rm_out[22]));
  FDCE \Val_Rm_out_reg[23] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[23]),
        .Q(Val_Rm_out[23]));
  FDCE \Val_Rm_out_reg[24] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[24]),
        .Q(Val_Rm_out[24]));
  FDCE \Val_Rm_out_reg[25] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[25]),
        .Q(Val_Rm_out[25]));
  FDCE \Val_Rm_out_reg[26] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[26]),
        .Q(Val_Rm_out[26]));
  FDCE \Val_Rm_out_reg[27] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[27]),
        .Q(Val_Rm_out[27]));
  FDCE \Val_Rm_out_reg[28] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[28]),
        .Q(Val_Rm_out[28]));
  FDCE \Val_Rm_out_reg[29] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[29]),
        .Q(Val_Rm_out[29]));
  FDCE \Val_Rm_out_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[2]),
        .Q(Val_Rm_out[2]));
  FDCE \Val_Rm_out_reg[30] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[30]),
        .Q(Val_Rm_out[30]));
  FDCE \Val_Rm_out_reg[31] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[31]),
        .Q(Val_Rm_out[31]));
  FDCE \Val_Rm_out_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[3]),
        .Q(Val_Rm_out[3]));
  FDCE \Val_Rm_out_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[4]),
        .Q(Val_Rm_out[4]));
  FDCE \Val_Rm_out_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[5]),
        .Q(Val_Rm_out[5]));
  FDCE \Val_Rm_out_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[6]),
        .Q(Val_Rm_out[6]));
  FDCE \Val_Rm_out_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[7]),
        .Q(Val_Rm_out[7]));
  FDCE \Val_Rm_out_reg[8] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[8]),
        .Q(Val_Rm_out[8]));
  FDCE \Val_Rm_out_reg[9] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(Val_Rm[9]),
        .Q(Val_Rm_out[9]));
  FDCE WB_EN_out_reg
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(WB_EN),
        .Q(WB_EN_out));
  FDCE \dest_out_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(dest[0]),
        .Q(dest_out[0]));
  FDCE \dest_out_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(dest[1]),
        .Q(dest_out[1]));
  FDCE \dest_out_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(dest[2]),
        .Q(dest_out[2]));
  FDCE \dest_out_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .CLR(rst),
        .D(dest[3]),
        .Q(dest_out[3]));
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
