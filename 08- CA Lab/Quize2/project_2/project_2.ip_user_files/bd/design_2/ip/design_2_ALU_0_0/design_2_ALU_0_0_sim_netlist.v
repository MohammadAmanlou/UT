// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Sun May 11 11:31:34 2025
// Host        : Ariyan running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               C:/Users/ariya/OneDrive/Desktop/project_1/project_1/project_1.srcs/sources_1/bd/design_2/ip/design_2_ALU_0_0/design_2_ALU_0_0_sim_netlist.v
// Design      : design_2_ALU_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_2_ALU_0_0,ALU,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "ALU,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module design_2_ALU_0_0
   (in1,
    in2,
    carry_in,
    ALU_op,
    result,
    NZCV);
  input [31:0]in1;
  input [31:0]in2;
  input carry_in;
  input [3:0]ALU_op;
  output [31:0]result;
  output [3:0]NZCV;

  wire [3:0]ALU_op;
  wire [2:0]\^NZCV ;
  wire NZCV13_out;
  wire \NZCV[0]_INST_0_i_2_n_0 ;
  wire \NZCV[2]_INST_0_i_11_n_0 ;
  wire \NZCV[2]_INST_0_i_12_n_0 ;
  wire \NZCV[2]_INST_0_i_13_n_0 ;
  wire \NZCV[2]_INST_0_i_14_n_0 ;
  wire \NZCV[2]_INST_0_i_15_n_0 ;
  wire \NZCV[2]_INST_0_i_16_n_0 ;
  wire \NZCV[2]_INST_0_i_17_n_0 ;
  wire \NZCV[2]_INST_0_i_18_n_0 ;
  wire \NZCV[3]_INST_0_i_1_n_0 ;
  wire \NZCV[3]_INST_0_i_2_n_0 ;
  wire \NZCV[3]_INST_0_i_4_n_0 ;
  wire \NZCV[3]_INST_0_i_6_n_0 ;
  wire \NZCV[3]_INST_0_i_6_n_1 ;
  wire \NZCV[3]_INST_0_i_6_n_2 ;
  wire \NZCV[3]_INST_0_i_6_n_3 ;
  wire \NZCV[3]_INST_0_i_6_n_4 ;
  wire \NZCV[3]_INST_0_i_6_n_5 ;
  wire \NZCV[3]_INST_0_i_6_n_6 ;
  wire \NZCV[3]_INST_0_i_6_n_7 ;
  wire carry_in;
  wire data0;
  wire data1;
  wire [31:0]in1;
  wire [31:0]in2;
  wire inst_n_36;
  wire inst_n_37;
  wire inst_n_38;
  wire inst_n_39;
  wire inst_n_40;
  wire inst_n_41;
  wire inst_n_42;
  wire inst_n_43;
  wire inst_n_44;
  wire inst_n_45;
  wire inst_n_46;
  wire inst_n_47;
  wire inst_n_48;
  wire inst_n_49;
  wire inst_n_50;
  wire inst_n_51;
  wire inst_n_52;
  wire inst_n_53;
  wire inst_n_54;
  wire inst_n_55;
  wire inst_n_56;
  wire inst_n_57;
  wire inst_n_58;
  wire inst_n_59;
  wire inst_n_60;
  wire inst_n_61;
  wire inst_n_62;
  wire inst_n_63;
  wire inst_n_64;
  wire inst_n_65;
  wire inst_n_66;
  wire inst_n_67;
  wire [31:0]result;
  wire \result[0]_INST_0_i_2_n_0 ;
  wire \result[10]_INST_0_i_2_n_0 ;
  wire \result[11]_INST_0_i_2_n_0 ;
  wire \result[11]_INST_0_i_4_n_0 ;
  wire \result[11]_INST_0_i_4_n_1 ;
  wire \result[11]_INST_0_i_4_n_2 ;
  wire \result[11]_INST_0_i_4_n_3 ;
  wire \result[11]_INST_0_i_4_n_4 ;
  wire \result[11]_INST_0_i_4_n_5 ;
  wire \result[11]_INST_0_i_4_n_6 ;
  wire \result[11]_INST_0_i_4_n_7 ;
  wire \result[12]_INST_0_i_2_n_0 ;
  wire \result[13]_INST_0_i_2_n_0 ;
  wire \result[14]_INST_0_i_2_n_0 ;
  wire \result[15]_INST_0_i_2_n_0 ;
  wire \result[15]_INST_0_i_4_n_0 ;
  wire \result[15]_INST_0_i_4_n_1 ;
  wire \result[15]_INST_0_i_4_n_2 ;
  wire \result[15]_INST_0_i_4_n_3 ;
  wire \result[15]_INST_0_i_4_n_4 ;
  wire \result[15]_INST_0_i_4_n_5 ;
  wire \result[15]_INST_0_i_4_n_6 ;
  wire \result[15]_INST_0_i_4_n_7 ;
  wire \result[16]_INST_0_i_2_n_0 ;
  wire \result[17]_INST_0_i_2_n_0 ;
  wire \result[18]_INST_0_i_2_n_0 ;
  wire \result[19]_INST_0_i_2_n_0 ;
  wire \result[19]_INST_0_i_4_n_0 ;
  wire \result[19]_INST_0_i_4_n_1 ;
  wire \result[19]_INST_0_i_4_n_2 ;
  wire \result[19]_INST_0_i_4_n_3 ;
  wire \result[19]_INST_0_i_4_n_4 ;
  wire \result[19]_INST_0_i_4_n_5 ;
  wire \result[19]_INST_0_i_4_n_6 ;
  wire \result[19]_INST_0_i_4_n_7 ;
  wire \result[1]_INST_0_i_2_n_0 ;
  wire \result[20]_INST_0_i_2_n_0 ;
  wire \result[21]_INST_0_i_2_n_0 ;
  wire \result[22]_INST_0_i_2_n_0 ;
  wire \result[23]_INST_0_i_2_n_0 ;
  wire \result[23]_INST_0_i_4_n_0 ;
  wire \result[23]_INST_0_i_4_n_1 ;
  wire \result[23]_INST_0_i_4_n_2 ;
  wire \result[23]_INST_0_i_4_n_3 ;
  wire \result[23]_INST_0_i_4_n_4 ;
  wire \result[23]_INST_0_i_4_n_5 ;
  wire \result[23]_INST_0_i_4_n_6 ;
  wire \result[23]_INST_0_i_4_n_7 ;
  wire \result[24]_INST_0_i_2_n_0 ;
  wire \result[25]_INST_0_i_2_n_0 ;
  wire \result[26]_INST_0_i_2_n_0 ;
  wire \result[27]_INST_0_i_2_n_0 ;
  wire \result[27]_INST_0_i_4_n_0 ;
  wire \result[27]_INST_0_i_4_n_1 ;
  wire \result[27]_INST_0_i_4_n_2 ;
  wire \result[27]_INST_0_i_4_n_3 ;
  wire \result[27]_INST_0_i_4_n_4 ;
  wire \result[27]_INST_0_i_4_n_5 ;
  wire \result[27]_INST_0_i_4_n_6 ;
  wire \result[27]_INST_0_i_4_n_7 ;
  wire \result[28]_INST_0_i_2_n_0 ;
  wire \result[29]_INST_0_i_2_n_0 ;
  wire \result[2]_INST_0_i_2_n_0 ;
  wire \result[30]_INST_0_i_2_n_0 ;
  wire \result[3]_INST_0_i_2_n_0 ;
  wire \result[3]_INST_0_i_4_n_0 ;
  wire \result[3]_INST_0_i_4_n_1 ;
  wire \result[3]_INST_0_i_4_n_2 ;
  wire \result[3]_INST_0_i_4_n_3 ;
  wire \result[3]_INST_0_i_4_n_4 ;
  wire \result[3]_INST_0_i_4_n_5 ;
  wire \result[3]_INST_0_i_4_n_6 ;
  wire \result[3]_INST_0_i_4_n_7 ;
  wire \result[3]_INST_0_i_6_n_0 ;
  wire \result[4]_INST_0_i_2_n_0 ;
  wire \result[5]_INST_0_i_2_n_0 ;
  wire \result[6]_INST_0_i_2_n_0 ;
  wire \result[7]_INST_0_i_2_n_0 ;
  wire \result[7]_INST_0_i_4_n_0 ;
  wire \result[7]_INST_0_i_4_n_1 ;
  wire \result[7]_INST_0_i_4_n_2 ;
  wire \result[7]_INST_0_i_4_n_3 ;
  wire \result[7]_INST_0_i_4_n_4 ;
  wire \result[7]_INST_0_i_4_n_5 ;
  wire \result[7]_INST_0_i_4_n_6 ;
  wire \result[7]_INST_0_i_4_n_7 ;
  wire \result[8]_INST_0_i_2_n_0 ;
  wire \result[9]_INST_0_i_2_n_0 ;
  wire [3:0]\NLW_NZCV[1]_INST_0_i_2_CO_UNCONNECTED ;
  wire [3:1]\NLW_NZCV[1]_INST_0_i_2_O_UNCONNECTED ;

  assign NZCV[3] = result[31];
  assign NZCV[2:0] = \^NZCV [2:0];
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h02)) 
    \NZCV[0]_INST_0_i_1 
       (.I0(ALU_op[1]),
        .I1(ALU_op[3]),
        .I2(ALU_op[2]),
        .O(NZCV13_out));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h02)) 
    \NZCV[0]_INST_0_i_2 
       (.I0(ALU_op[2]),
        .I1(ALU_op[3]),
        .I2(ALU_op[1]),
        .O(\NZCV[0]_INST_0_i_2_n_0 ));
  CARRY4 \NZCV[1]_INST_0_i_2 
       (.CI(\NZCV[3]_INST_0_i_6_n_0 ),
        .CO(\NLW_NZCV[1]_INST_0_i_2_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_NZCV[1]_INST_0_i_2_O_UNCONNECTED [3:1],data1}),
        .S({1'b0,1'b0,1'b0,data0}));
  LUT5 #(
    .INIT(32'h00000036)) 
    \NZCV[2]_INST_0_i_11 
       (.I0(in1[1]),
        .I1(in2[1]),
        .I2(ALU_op[0]),
        .I3(ALU_op[2]),
        .I4(ALU_op[1]),
        .O(\NZCV[2]_INST_0_i_11_n_0 ));
  LUT5 #(
    .INIT(32'h00000036)) 
    \NZCV[2]_INST_0_i_12 
       (.I0(in1[0]),
        .I1(in2[0]),
        .I2(ALU_op[0]),
        .I3(ALU_op[2]),
        .I4(ALU_op[1]),
        .O(\NZCV[2]_INST_0_i_12_n_0 ));
  LUT5 #(
    .INIT(32'h00000036)) 
    \NZCV[2]_INST_0_i_13 
       (.I0(in1[3]),
        .I1(in2[3]),
        .I2(ALU_op[0]),
        .I3(ALU_op[2]),
        .I4(ALU_op[1]),
        .O(\NZCV[2]_INST_0_i_13_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h00000036)) 
    \NZCV[2]_INST_0_i_14 
       (.I0(in1[2]),
        .I1(in2[2]),
        .I2(ALU_op[0]),
        .I3(ALU_op[2]),
        .I4(ALU_op[1]),
        .O(\NZCV[2]_INST_0_i_14_n_0 ));
  LUT5 #(
    .INIT(32'h00000036)) 
    \NZCV[2]_INST_0_i_15 
       (.I0(in1[9]),
        .I1(in2[9]),
        .I2(ALU_op[0]),
        .I3(ALU_op[2]),
        .I4(ALU_op[1]),
        .O(\NZCV[2]_INST_0_i_15_n_0 ));
  LUT5 #(
    .INIT(32'h00000036)) 
    \NZCV[2]_INST_0_i_16 
       (.I0(in1[8]),
        .I1(in2[8]),
        .I2(ALU_op[0]),
        .I3(ALU_op[2]),
        .I4(ALU_op[1]),
        .O(\NZCV[2]_INST_0_i_16_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h00000036)) 
    \NZCV[2]_INST_0_i_17 
       (.I0(in1[11]),
        .I1(in2[11]),
        .I2(ALU_op[0]),
        .I3(ALU_op[2]),
        .I4(ALU_op[1]),
        .O(\NZCV[2]_INST_0_i_17_n_0 ));
  LUT5 #(
    .INIT(32'h00000036)) 
    \NZCV[2]_INST_0_i_18 
       (.I0(in1[10]),
        .I1(in2[10]),
        .I2(ALU_op[0]),
        .I3(ALU_op[2]),
        .I4(ALU_op[1]),
        .O(\NZCV[2]_INST_0_i_18_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hBA)) 
    \NZCV[3]_INST_0_i_1 
       (.I0(ALU_op[2]),
        .I1(ALU_op[1]),
        .I2(ALU_op[0]),
        .O(\NZCV[3]_INST_0_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \NZCV[3]_INST_0_i_2 
       (.I0(ALU_op[1]),
        .I1(ALU_op[2]),
        .O(\NZCV[3]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \NZCV[3]_INST_0_i_4 
       (.I0(\NZCV[3]_INST_0_i_6_n_4 ),
        .I1(inst_n_64),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[31]),
        .O(\NZCV[3]_INST_0_i_4_n_0 ));
  CARRY4 \NZCV[3]_INST_0_i_6 
       (.CI(\result[27]_INST_0_i_4_n_0 ),
        .CO({\NZCV[3]_INST_0_i_6_n_0 ,\NZCV[3]_INST_0_i_6_n_1 ,\NZCV[3]_INST_0_i_6_n_2 ,\NZCV[3]_INST_0_i_6_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NZCV[3]_INST_0_i_6_n_4 ,\NZCV[3]_INST_0_i_6_n_5 ,\NZCV[3]_INST_0_i_6_n_6 ,\NZCV[3]_INST_0_i_6_n_7 }),
        .S({inst_n_64,inst_n_65,inst_n_66,inst_n_67}));
  design_2_ALU_0_0_ALU inst
       (.ALU_op(ALU_op),
        .CO(data0),
        .NZCV({result[31],\^NZCV }),
        .NZCV13_out(NZCV13_out),
        .\NZCV[2]_INST_0_i_5_0 (\NZCV[2]_INST_0_i_11_n_0 ),
        .\NZCV[2]_INST_0_i_5_1 (\NZCV[2]_INST_0_i_12_n_0 ),
        .\NZCV[2]_INST_0_i_5_2 (\NZCV[2]_INST_0_i_13_n_0 ),
        .\NZCV[2]_INST_0_i_5_3 (\NZCV[2]_INST_0_i_14_n_0 ),
        .\NZCV[2]_INST_0_i_6_0 (\NZCV[2]_INST_0_i_15_n_0 ),
        .\NZCV[2]_INST_0_i_6_1 (\NZCV[2]_INST_0_i_16_n_0 ),
        .\NZCV[2]_INST_0_i_6_2 (\NZCV[2]_INST_0_i_17_n_0 ),
        .\NZCV[2]_INST_0_i_6_3 (\NZCV[2]_INST_0_i_18_n_0 ),
        .NZCV_0_sp_1(\NZCV[0]_INST_0_i_2_n_0 ),
        .O(data1),
        .carry_in(carry_in),
        .in1(in1),
        .\in1[11] ({inst_n_44,inst_n_45,inst_n_46,inst_n_47}),
        .\in1[15] ({inst_n_48,inst_n_49,inst_n_50,inst_n_51}),
        .\in1[19] ({inst_n_52,inst_n_53,inst_n_54,inst_n_55}),
        .\in1[23] ({inst_n_56,inst_n_57,inst_n_58,inst_n_59}),
        .\in1[27] ({inst_n_60,inst_n_61,inst_n_62,inst_n_63}),
        .\in1[31] ({inst_n_64,inst_n_65,inst_n_66,inst_n_67}),
        .\in1[3] ({inst_n_36,inst_n_37,inst_n_38,inst_n_39}),
        .\in1[7] ({inst_n_40,inst_n_41,inst_n_42,inst_n_43}),
        .in2(in2),
        .result(result[30:0]),
        .\result[0]_0 (\NZCV[3]_INST_0_i_2_n_0 ),
        .\result[0]_1 (\result[0]_INST_0_i_2_n_0 ),
        .\result[31] (\NZCV[3]_INST_0_i_4_n_0 ),
        .result_0_sp_1(\NZCV[3]_INST_0_i_1_n_0 ),
        .result_10_sp_1(\result[10]_INST_0_i_2_n_0 ),
        .result_11_sp_1(\result[11]_INST_0_i_2_n_0 ),
        .result_12_sp_1(\result[12]_INST_0_i_2_n_0 ),
        .result_13_sp_1(\result[13]_INST_0_i_2_n_0 ),
        .result_14_sp_1(\result[14]_INST_0_i_2_n_0 ),
        .result_15_sp_1(\result[15]_INST_0_i_2_n_0 ),
        .result_16_sp_1(\result[16]_INST_0_i_2_n_0 ),
        .result_17_sp_1(\result[17]_INST_0_i_2_n_0 ),
        .result_18_sp_1(\result[18]_INST_0_i_2_n_0 ),
        .result_19_sp_1(\result[19]_INST_0_i_2_n_0 ),
        .result_1_sp_1(\result[1]_INST_0_i_2_n_0 ),
        .result_20_sp_1(\result[20]_INST_0_i_2_n_0 ),
        .result_21_sp_1(\result[21]_INST_0_i_2_n_0 ),
        .result_22_sp_1(\result[22]_INST_0_i_2_n_0 ),
        .result_23_sp_1(\result[23]_INST_0_i_2_n_0 ),
        .result_24_sp_1(\result[24]_INST_0_i_2_n_0 ),
        .result_25_sp_1(\result[25]_INST_0_i_2_n_0 ),
        .result_26_sp_1(\result[26]_INST_0_i_2_n_0 ),
        .result_27_sp_1(\result[27]_INST_0_i_2_n_0 ),
        .result_28_sp_1(\result[28]_INST_0_i_2_n_0 ),
        .result_29_sp_1(\result[29]_INST_0_i_2_n_0 ),
        .result_2_sp_1(\result[2]_INST_0_i_2_n_0 ),
        .result_30_sp_1(\result[30]_INST_0_i_2_n_0 ),
        .result_3_sp_1(\result[3]_INST_0_i_2_n_0 ),
        .result_4_sp_1(\result[4]_INST_0_i_2_n_0 ),
        .result_5_sp_1(\result[5]_INST_0_i_2_n_0 ),
        .result_6_sp_1(\result[6]_INST_0_i_2_n_0 ),
        .result_7_sp_1(\result[7]_INST_0_i_2_n_0 ),
        .result_8_sp_1(\result[8]_INST_0_i_2_n_0 ),
        .result_9_sp_1(\result[9]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[0]_INST_0_i_2 
       (.I0(\result[3]_INST_0_i_4_n_7 ),
        .I1(inst_n_39),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[0]),
        .O(\result[0]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[10]_INST_0_i_2 
       (.I0(\result[11]_INST_0_i_4_n_5 ),
        .I1(inst_n_45),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[10]),
        .O(\result[10]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[11]_INST_0_i_2 
       (.I0(\result[11]_INST_0_i_4_n_4 ),
        .I1(inst_n_44),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[11]),
        .O(\result[11]_INST_0_i_2_n_0 ));
  CARRY4 \result[11]_INST_0_i_4 
       (.CI(\result[7]_INST_0_i_4_n_0 ),
        .CO({\result[11]_INST_0_i_4_n_0 ,\result[11]_INST_0_i_4_n_1 ,\result[11]_INST_0_i_4_n_2 ,\result[11]_INST_0_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\result[11]_INST_0_i_4_n_4 ,\result[11]_INST_0_i_4_n_5 ,\result[11]_INST_0_i_4_n_6 ,\result[11]_INST_0_i_4_n_7 }),
        .S({inst_n_44,inst_n_45,inst_n_46,inst_n_47}));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[12]_INST_0_i_2 
       (.I0(\result[15]_INST_0_i_4_n_7 ),
        .I1(inst_n_51),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[12]),
        .O(\result[12]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[13]_INST_0_i_2 
       (.I0(\result[15]_INST_0_i_4_n_6 ),
        .I1(inst_n_50),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[13]),
        .O(\result[13]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[14]_INST_0_i_2 
       (.I0(\result[15]_INST_0_i_4_n_5 ),
        .I1(inst_n_49),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[14]),
        .O(\result[14]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[15]_INST_0_i_2 
       (.I0(\result[15]_INST_0_i_4_n_4 ),
        .I1(inst_n_48),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[15]),
        .O(\result[15]_INST_0_i_2_n_0 ));
  CARRY4 \result[15]_INST_0_i_4 
       (.CI(\result[11]_INST_0_i_4_n_0 ),
        .CO({\result[15]_INST_0_i_4_n_0 ,\result[15]_INST_0_i_4_n_1 ,\result[15]_INST_0_i_4_n_2 ,\result[15]_INST_0_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\result[15]_INST_0_i_4_n_4 ,\result[15]_INST_0_i_4_n_5 ,\result[15]_INST_0_i_4_n_6 ,\result[15]_INST_0_i_4_n_7 }),
        .S({inst_n_48,inst_n_49,inst_n_50,inst_n_51}));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[16]_INST_0_i_2 
       (.I0(\result[19]_INST_0_i_4_n_7 ),
        .I1(inst_n_55),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[16]),
        .O(\result[16]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[17]_INST_0_i_2 
       (.I0(\result[19]_INST_0_i_4_n_6 ),
        .I1(inst_n_54),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[17]),
        .O(\result[17]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[18]_INST_0_i_2 
       (.I0(\result[19]_INST_0_i_4_n_5 ),
        .I1(inst_n_53),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[18]),
        .O(\result[18]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[19]_INST_0_i_2 
       (.I0(\result[19]_INST_0_i_4_n_4 ),
        .I1(inst_n_52),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[19]),
        .O(\result[19]_INST_0_i_2_n_0 ));
  CARRY4 \result[19]_INST_0_i_4 
       (.CI(\result[15]_INST_0_i_4_n_0 ),
        .CO({\result[19]_INST_0_i_4_n_0 ,\result[19]_INST_0_i_4_n_1 ,\result[19]_INST_0_i_4_n_2 ,\result[19]_INST_0_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\result[19]_INST_0_i_4_n_4 ,\result[19]_INST_0_i_4_n_5 ,\result[19]_INST_0_i_4_n_6 ,\result[19]_INST_0_i_4_n_7 }),
        .S({inst_n_52,inst_n_53,inst_n_54,inst_n_55}));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[1]_INST_0_i_2 
       (.I0(\result[3]_INST_0_i_4_n_6 ),
        .I1(inst_n_38),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[1]),
        .O(\result[1]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[20]_INST_0_i_2 
       (.I0(\result[23]_INST_0_i_4_n_7 ),
        .I1(inst_n_59),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[20]),
        .O(\result[20]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[21]_INST_0_i_2 
       (.I0(\result[23]_INST_0_i_4_n_6 ),
        .I1(inst_n_58),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[21]),
        .O(\result[21]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[22]_INST_0_i_2 
       (.I0(\result[23]_INST_0_i_4_n_5 ),
        .I1(inst_n_57),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[22]),
        .O(\result[22]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[23]_INST_0_i_2 
       (.I0(\result[23]_INST_0_i_4_n_4 ),
        .I1(inst_n_56),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[23]),
        .O(\result[23]_INST_0_i_2_n_0 ));
  CARRY4 \result[23]_INST_0_i_4 
       (.CI(\result[19]_INST_0_i_4_n_0 ),
        .CO({\result[23]_INST_0_i_4_n_0 ,\result[23]_INST_0_i_4_n_1 ,\result[23]_INST_0_i_4_n_2 ,\result[23]_INST_0_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\result[23]_INST_0_i_4_n_4 ,\result[23]_INST_0_i_4_n_5 ,\result[23]_INST_0_i_4_n_6 ,\result[23]_INST_0_i_4_n_7 }),
        .S({inst_n_56,inst_n_57,inst_n_58,inst_n_59}));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[24]_INST_0_i_2 
       (.I0(\result[27]_INST_0_i_4_n_7 ),
        .I1(inst_n_63),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[24]),
        .O(\result[24]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[25]_INST_0_i_2 
       (.I0(\result[27]_INST_0_i_4_n_6 ),
        .I1(inst_n_62),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[25]),
        .O(\result[25]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[26]_INST_0_i_2 
       (.I0(\result[27]_INST_0_i_4_n_5 ),
        .I1(inst_n_61),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[26]),
        .O(\result[26]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[27]_INST_0_i_2 
       (.I0(\result[27]_INST_0_i_4_n_4 ),
        .I1(inst_n_60),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[27]),
        .O(\result[27]_INST_0_i_2_n_0 ));
  CARRY4 \result[27]_INST_0_i_4 
       (.CI(\result[23]_INST_0_i_4_n_0 ),
        .CO({\result[27]_INST_0_i_4_n_0 ,\result[27]_INST_0_i_4_n_1 ,\result[27]_INST_0_i_4_n_2 ,\result[27]_INST_0_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\result[27]_INST_0_i_4_n_4 ,\result[27]_INST_0_i_4_n_5 ,\result[27]_INST_0_i_4_n_6 ,\result[27]_INST_0_i_4_n_7 }),
        .S({inst_n_60,inst_n_61,inst_n_62,inst_n_63}));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[28]_INST_0_i_2 
       (.I0(\NZCV[3]_INST_0_i_6_n_7 ),
        .I1(inst_n_67),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[28]),
        .O(\result[28]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[29]_INST_0_i_2 
       (.I0(\NZCV[3]_INST_0_i_6_n_6 ),
        .I1(inst_n_66),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[29]),
        .O(\result[29]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[2]_INST_0_i_2 
       (.I0(\result[3]_INST_0_i_4_n_5 ),
        .I1(inst_n_37),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[2]),
        .O(\result[2]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[30]_INST_0_i_2 
       (.I0(\NZCV[3]_INST_0_i_6_n_5 ),
        .I1(inst_n_65),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[30]),
        .O(\result[30]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[3]_INST_0_i_2 
       (.I0(\result[3]_INST_0_i_4_n_4 ),
        .I1(inst_n_36),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[3]),
        .O(\result[3]_INST_0_i_2_n_0 ));
  CARRY4 \result[3]_INST_0_i_4 
       (.CI(1'b0),
        .CO({\result[3]_INST_0_i_4_n_0 ,\result[3]_INST_0_i_4_n_1 ,\result[3]_INST_0_i_4_n_2 ,\result[3]_INST_0_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,inst_n_39}),
        .O({\result[3]_INST_0_i_4_n_4 ,\result[3]_INST_0_i_4_n_5 ,\result[3]_INST_0_i_4_n_6 ,\result[3]_INST_0_i_4_n_7 }),
        .S({inst_n_36,inst_n_37,inst_n_38,\result[3]_INST_0_i_6_n_0 }));
  LUT2 #(
    .INIT(4'h6)) 
    \result[3]_INST_0_i_6 
       (.I0(inst_n_39),
        .I1(carry_in),
        .O(\result[3]_INST_0_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[4]_INST_0_i_2 
       (.I0(\result[7]_INST_0_i_4_n_7 ),
        .I1(inst_n_43),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[4]),
        .O(\result[4]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[5]_INST_0_i_2 
       (.I0(\result[7]_INST_0_i_4_n_6 ),
        .I1(inst_n_42),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[5]),
        .O(\result[5]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[6]_INST_0_i_2 
       (.I0(\result[7]_INST_0_i_4_n_5 ),
        .I1(inst_n_41),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[6]),
        .O(\result[6]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[7]_INST_0_i_2 
       (.I0(\result[7]_INST_0_i_4_n_4 ),
        .I1(inst_n_40),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[7]),
        .O(\result[7]_INST_0_i_2_n_0 ));
  CARRY4 \result[7]_INST_0_i_4 
       (.CI(\result[3]_INST_0_i_4_n_0 ),
        .CO({\result[7]_INST_0_i_4_n_0 ,\result[7]_INST_0_i_4_n_1 ,\result[7]_INST_0_i_4_n_2 ,\result[7]_INST_0_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\result[7]_INST_0_i_4_n_4 ,\result[7]_INST_0_i_4_n_5 ,\result[7]_INST_0_i_4_n_6 ,\result[7]_INST_0_i_4_n_7 }),
        .S({inst_n_40,inst_n_41,inst_n_42,inst_n_43}));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[8]_INST_0_i_2 
       (.I0(\result[11]_INST_0_i_4_n_7 ),
        .I1(inst_n_47),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[8]),
        .O(\result[8]_INST_0_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hAFC0A0C0)) 
    \result[9]_INST_0_i_2 
       (.I0(\result[11]_INST_0_i_4_n_6 ),
        .I1(inst_n_46),
        .I2(ALU_op[1]),
        .I3(ALU_op[0]),
        .I4(in2[9]),
        .O(\result[9]_INST_0_i_2_n_0 ));
endmodule

(* ORIG_REF_NAME = "ALU" *) 
module design_2_ALU_0_0_ALU
   (NZCV,
    result,
    CO,
    \in1[3] ,
    \in1[7] ,
    \in1[11] ,
    \in1[15] ,
    \in1[19] ,
    \in1[23] ,
    \in1[27] ,
    \in1[31] ,
    in1,
    NZCV13_out,
    NZCV_0_sp_1,
    in2,
    \NZCV[2]_INST_0_i_5_0 ,
    ALU_op,
    \NZCV[2]_INST_0_i_5_1 ,
    result_0_sp_1,
    \result[0]_0 ,
    \result[0]_1 ,
    result_1_sp_1,
    \NZCV[2]_INST_0_i_5_2 ,
    \NZCV[2]_INST_0_i_5_3 ,
    result_2_sp_1,
    result_3_sp_1,
    result_4_sp_1,
    result_5_sp_1,
    result_6_sp_1,
    result_7_sp_1,
    \NZCV[2]_INST_0_i_6_0 ,
    \NZCV[2]_INST_0_i_6_1 ,
    result_8_sp_1,
    result_9_sp_1,
    \NZCV[2]_INST_0_i_6_2 ,
    \NZCV[2]_INST_0_i_6_3 ,
    result_10_sp_1,
    result_11_sp_1,
    result_12_sp_1,
    result_13_sp_1,
    result_14_sp_1,
    result_15_sp_1,
    result_16_sp_1,
    result_17_sp_1,
    result_18_sp_1,
    result_19_sp_1,
    result_20_sp_1,
    result_21_sp_1,
    result_22_sp_1,
    result_23_sp_1,
    result_24_sp_1,
    result_25_sp_1,
    result_26_sp_1,
    result_27_sp_1,
    result_28_sp_1,
    result_29_sp_1,
    result_30_sp_1,
    \result[31] ,
    O,
    carry_in);
  output [3:0]NZCV;
  output [30:0]result;
  output [0:0]CO;
  output [3:0]\in1[3] ;
  output [3:0]\in1[7] ;
  output [3:0]\in1[11] ;
  output [3:0]\in1[15] ;
  output [3:0]\in1[19] ;
  output [3:0]\in1[23] ;
  output [3:0]\in1[27] ;
  output [3:0]\in1[31] ;
  input [31:0]in1;
  input NZCV13_out;
  input NZCV_0_sp_1;
  input [31:0]in2;
  input \NZCV[2]_INST_0_i_5_0 ;
  input [3:0]ALU_op;
  input \NZCV[2]_INST_0_i_5_1 ;
  input result_0_sp_1;
  input \result[0]_0 ;
  input \result[0]_1 ;
  input result_1_sp_1;
  input \NZCV[2]_INST_0_i_5_2 ;
  input \NZCV[2]_INST_0_i_5_3 ;
  input result_2_sp_1;
  input result_3_sp_1;
  input result_4_sp_1;
  input result_5_sp_1;
  input result_6_sp_1;
  input result_7_sp_1;
  input \NZCV[2]_INST_0_i_6_0 ;
  input \NZCV[2]_INST_0_i_6_1 ;
  input result_8_sp_1;
  input result_9_sp_1;
  input \NZCV[2]_INST_0_i_6_2 ;
  input \NZCV[2]_INST_0_i_6_3 ;
  input result_10_sp_1;
  input result_11_sp_1;
  input result_12_sp_1;
  input result_13_sp_1;
  input result_14_sp_1;
  input result_15_sp_1;
  input result_16_sp_1;
  input result_17_sp_1;
  input result_18_sp_1;
  input result_19_sp_1;
  input result_20_sp_1;
  input result_21_sp_1;
  input result_22_sp_1;
  input result_23_sp_1;
  input result_24_sp_1;
  input result_25_sp_1;
  input result_26_sp_1;
  input result_27_sp_1;
  input result_28_sp_1;
  input result_29_sp_1;
  input result_30_sp_1;
  input \result[31] ;
  input [0:0]O;
  input carry_in;

  wire [3:0]ALU_op;
  wire [0:0]CO;
  wire [3:0]NZCV;
  wire NZCV13_out;
  wire \NZCV[2]_INST_0_i_10_n_0 ;
  wire \NZCV[2]_INST_0_i_1_n_0 ;
  wire \NZCV[2]_INST_0_i_2_n_0 ;
  wire \NZCV[2]_INST_0_i_3_n_0 ;
  wire \NZCV[2]_INST_0_i_4_n_0 ;
  wire \NZCV[2]_INST_0_i_5_0 ;
  wire \NZCV[2]_INST_0_i_5_1 ;
  wire \NZCV[2]_INST_0_i_5_2 ;
  wire \NZCV[2]_INST_0_i_5_3 ;
  wire \NZCV[2]_INST_0_i_5_n_0 ;
  wire \NZCV[2]_INST_0_i_6_0 ;
  wire \NZCV[2]_INST_0_i_6_1 ;
  wire \NZCV[2]_INST_0_i_6_2 ;
  wire \NZCV[2]_INST_0_i_6_3 ;
  wire \NZCV[2]_INST_0_i_6_n_0 ;
  wire \NZCV[2]_INST_0_i_7_n_0 ;
  wire \NZCV[2]_INST_0_i_8_n_0 ;
  wire \NZCV[2]_INST_0_i_9_n_0 ;
  wire \NZCV[3]_INST_0_i_10_n_0 ;
  wire \NZCV[3]_INST_0_i_11_n_0 ;
  wire \NZCV[3]_INST_0_i_3_n_0 ;
  wire \NZCV[3]_INST_0_i_5_n_0 ;
  wire \NZCV[3]_INST_0_i_7_n_0 ;
  wire \NZCV[3]_INST_0_i_7_n_1 ;
  wire \NZCV[3]_INST_0_i_7_n_2 ;
  wire \NZCV[3]_INST_0_i_7_n_3 ;
  wire \NZCV[3]_INST_0_i_8_n_0 ;
  wire \NZCV[3]_INST_0_i_9_n_0 ;
  wire NZCV_0_sn_1;
  wire [0:0]O;
  wire carry_in;
  wire data2;
  wire data3;
  wire i__carry__0_i_1__0_n_0;
  wire i__carry__0_i_1_n_0;
  wire i__carry__0_i_2__0_n_0;
  wire i__carry__0_i_2_n_0;
  wire i__carry__0_i_3__0_n_0;
  wire i__carry__0_i_3_n_0;
  wire i__carry__0_i_4__0_n_0;
  wire i__carry__0_i_4_n_0;
  wire i__carry__1_i_1__0_n_0;
  wire i__carry__1_i_1_n_0;
  wire i__carry__1_i_2__0_n_0;
  wire i__carry__1_i_2_n_0;
  wire i__carry__1_i_3__0_n_0;
  wire i__carry__1_i_3_n_0;
  wire i__carry__1_i_4__0_n_0;
  wire i__carry__1_i_4_n_0;
  wire i__carry__2_i_1__0_n_0;
  wire i__carry__2_i_1_n_0;
  wire i__carry__2_i_2__0_n_0;
  wire i__carry__2_i_2_n_0;
  wire i__carry__2_i_3__0_n_0;
  wire i__carry__2_i_3_n_0;
  wire i__carry__2_i_4__0_n_0;
  wire i__carry__2_i_4_n_0;
  wire i__carry__3_i_1__0_n_0;
  wire i__carry__3_i_1_n_0;
  wire i__carry__3_i_2__0_n_0;
  wire i__carry__3_i_2_n_0;
  wire i__carry__3_i_3__0_n_0;
  wire i__carry__3_i_3_n_0;
  wire i__carry__3_i_4__0_n_0;
  wire i__carry__3_i_4_n_0;
  wire i__carry__4_i_1__0_n_0;
  wire i__carry__4_i_1_n_0;
  wire i__carry__4_i_2__0_n_0;
  wire i__carry__4_i_2_n_0;
  wire i__carry__4_i_3__0_n_0;
  wire i__carry__4_i_3_n_0;
  wire i__carry__4_i_4__0_n_0;
  wire i__carry__4_i_4_n_0;
  wire i__carry__5_i_1__0_n_0;
  wire i__carry__5_i_1_n_0;
  wire i__carry__5_i_2__0_n_0;
  wire i__carry__5_i_2_n_0;
  wire i__carry__5_i_3__0_n_0;
  wire i__carry__5_i_3_n_0;
  wire i__carry__5_i_4__0_n_0;
  wire i__carry__5_i_4_n_0;
  wire i__carry__6_i_1__0_n_0;
  wire i__carry__6_i_1_n_0;
  wire i__carry__6_i_2__0_n_0;
  wire i__carry__6_i_2_n_0;
  wire i__carry__6_i_3__0_n_0;
  wire i__carry__6_i_3_n_0;
  wire i__carry__6_i_4__0_n_0;
  wire i__carry__6_i_4_n_0;
  wire i__carry_i_1__0_n_0;
  wire i__carry_i_2__0_n_0;
  wire i__carry_i_2_n_0;
  wire i__carry_i_3__0_n_0;
  wire i__carry_i_3_n_0;
  wire i__carry_i_4__0_n_0;
  wire i__carry_i_4_n_0;
  wire i__carry_i_5_n_0;
  wire [31:0]in1;
  wire [3:0]\in1[11] ;
  wire [3:0]\in1[15] ;
  wire [3:0]\in1[19] ;
  wire [3:0]\in1[23] ;
  wire [3:0]\in1[27] ;
  wire [3:0]\in1[31] ;
  wire [3:0]\in1[3] ;
  wire [3:0]\in1[7] ;
  wire [31:0]in2;
  wire [0:0]p_0_in;
  wire [1:1]p_1_in;
  wire [30:0]result;
  wire \result0_inferred__2/i__carry__0_n_0 ;
  wire \result0_inferred__2/i__carry__0_n_1 ;
  wire \result0_inferred__2/i__carry__0_n_2 ;
  wire \result0_inferred__2/i__carry__0_n_3 ;
  wire \result0_inferred__2/i__carry__0_n_4 ;
  wire \result0_inferred__2/i__carry__0_n_5 ;
  wire \result0_inferred__2/i__carry__0_n_6 ;
  wire \result0_inferred__2/i__carry__0_n_7 ;
  wire \result0_inferred__2/i__carry__1_n_0 ;
  wire \result0_inferred__2/i__carry__1_n_1 ;
  wire \result0_inferred__2/i__carry__1_n_2 ;
  wire \result0_inferred__2/i__carry__1_n_3 ;
  wire \result0_inferred__2/i__carry__1_n_4 ;
  wire \result0_inferred__2/i__carry__1_n_5 ;
  wire \result0_inferred__2/i__carry__1_n_6 ;
  wire \result0_inferred__2/i__carry__1_n_7 ;
  wire \result0_inferred__2/i__carry__2_n_0 ;
  wire \result0_inferred__2/i__carry__2_n_1 ;
  wire \result0_inferred__2/i__carry__2_n_2 ;
  wire \result0_inferred__2/i__carry__2_n_3 ;
  wire \result0_inferred__2/i__carry__2_n_4 ;
  wire \result0_inferred__2/i__carry__2_n_5 ;
  wire \result0_inferred__2/i__carry__2_n_6 ;
  wire \result0_inferred__2/i__carry__2_n_7 ;
  wire \result0_inferred__2/i__carry__3_n_0 ;
  wire \result0_inferred__2/i__carry__3_n_1 ;
  wire \result0_inferred__2/i__carry__3_n_2 ;
  wire \result0_inferred__2/i__carry__3_n_3 ;
  wire \result0_inferred__2/i__carry__3_n_4 ;
  wire \result0_inferred__2/i__carry__3_n_5 ;
  wire \result0_inferred__2/i__carry__3_n_6 ;
  wire \result0_inferred__2/i__carry__3_n_7 ;
  wire \result0_inferred__2/i__carry__4_n_0 ;
  wire \result0_inferred__2/i__carry__4_n_1 ;
  wire \result0_inferred__2/i__carry__4_n_2 ;
  wire \result0_inferred__2/i__carry__4_n_3 ;
  wire \result0_inferred__2/i__carry__4_n_4 ;
  wire \result0_inferred__2/i__carry__4_n_5 ;
  wire \result0_inferred__2/i__carry__4_n_6 ;
  wire \result0_inferred__2/i__carry__4_n_7 ;
  wire \result0_inferred__2/i__carry__5_n_0 ;
  wire \result0_inferred__2/i__carry__5_n_1 ;
  wire \result0_inferred__2/i__carry__5_n_2 ;
  wire \result0_inferred__2/i__carry__5_n_3 ;
  wire \result0_inferred__2/i__carry__5_n_4 ;
  wire \result0_inferred__2/i__carry__5_n_5 ;
  wire \result0_inferred__2/i__carry__5_n_6 ;
  wire \result0_inferred__2/i__carry__5_n_7 ;
  wire \result0_inferred__2/i__carry__6_n_0 ;
  wire \result0_inferred__2/i__carry__6_n_1 ;
  wire \result0_inferred__2/i__carry__6_n_2 ;
  wire \result0_inferred__2/i__carry__6_n_3 ;
  wire \result0_inferred__2/i__carry__6_n_4 ;
  wire \result0_inferred__2/i__carry__6_n_5 ;
  wire \result0_inferred__2/i__carry__6_n_6 ;
  wire \result0_inferred__2/i__carry__6_n_7 ;
  wire \result0_inferred__2/i__carry_n_0 ;
  wire \result0_inferred__2/i__carry_n_1 ;
  wire \result0_inferred__2/i__carry_n_2 ;
  wire \result0_inferred__2/i__carry_n_3 ;
  wire \result0_inferred__2/i__carry_n_4 ;
  wire \result0_inferred__2/i__carry_n_5 ;
  wire \result0_inferred__2/i__carry_n_6 ;
  wire \result0_inferred__2/i__carry_n_7 ;
  wire \result0_inferred__3/i__carry__0_n_0 ;
  wire \result0_inferred__3/i__carry__0_n_1 ;
  wire \result0_inferred__3/i__carry__0_n_2 ;
  wire \result0_inferred__3/i__carry__0_n_3 ;
  wire \result0_inferred__3/i__carry__0_n_4 ;
  wire \result0_inferred__3/i__carry__0_n_5 ;
  wire \result0_inferred__3/i__carry__0_n_6 ;
  wire \result0_inferred__3/i__carry__0_n_7 ;
  wire \result0_inferred__3/i__carry__1_n_0 ;
  wire \result0_inferred__3/i__carry__1_n_1 ;
  wire \result0_inferred__3/i__carry__1_n_2 ;
  wire \result0_inferred__3/i__carry__1_n_3 ;
  wire \result0_inferred__3/i__carry__1_n_4 ;
  wire \result0_inferred__3/i__carry__1_n_5 ;
  wire \result0_inferred__3/i__carry__1_n_6 ;
  wire \result0_inferred__3/i__carry__1_n_7 ;
  wire \result0_inferred__3/i__carry__2_n_0 ;
  wire \result0_inferred__3/i__carry__2_n_1 ;
  wire \result0_inferred__3/i__carry__2_n_2 ;
  wire \result0_inferred__3/i__carry__2_n_3 ;
  wire \result0_inferred__3/i__carry__2_n_4 ;
  wire \result0_inferred__3/i__carry__2_n_5 ;
  wire \result0_inferred__3/i__carry__2_n_6 ;
  wire \result0_inferred__3/i__carry__2_n_7 ;
  wire \result0_inferred__3/i__carry__3_n_0 ;
  wire \result0_inferred__3/i__carry__3_n_1 ;
  wire \result0_inferred__3/i__carry__3_n_2 ;
  wire \result0_inferred__3/i__carry__3_n_3 ;
  wire \result0_inferred__3/i__carry__3_n_4 ;
  wire \result0_inferred__3/i__carry__3_n_5 ;
  wire \result0_inferred__3/i__carry__3_n_6 ;
  wire \result0_inferred__3/i__carry__3_n_7 ;
  wire \result0_inferred__3/i__carry__4_n_0 ;
  wire \result0_inferred__3/i__carry__4_n_1 ;
  wire \result0_inferred__3/i__carry__4_n_2 ;
  wire \result0_inferred__3/i__carry__4_n_3 ;
  wire \result0_inferred__3/i__carry__4_n_4 ;
  wire \result0_inferred__3/i__carry__4_n_5 ;
  wire \result0_inferred__3/i__carry__4_n_6 ;
  wire \result0_inferred__3/i__carry__4_n_7 ;
  wire \result0_inferred__3/i__carry__5_n_0 ;
  wire \result0_inferred__3/i__carry__5_n_1 ;
  wire \result0_inferred__3/i__carry__5_n_2 ;
  wire \result0_inferred__3/i__carry__5_n_3 ;
  wire \result0_inferred__3/i__carry__5_n_4 ;
  wire \result0_inferred__3/i__carry__5_n_5 ;
  wire \result0_inferred__3/i__carry__5_n_6 ;
  wire \result0_inferred__3/i__carry__5_n_7 ;
  wire \result0_inferred__3/i__carry__6_n_0 ;
  wire \result0_inferred__3/i__carry__6_n_1 ;
  wire \result0_inferred__3/i__carry__6_n_2 ;
  wire \result0_inferred__3/i__carry__6_n_3 ;
  wire \result0_inferred__3/i__carry__6_n_4 ;
  wire \result0_inferred__3/i__carry__6_n_5 ;
  wire \result0_inferred__3/i__carry__6_n_6 ;
  wire \result0_inferred__3/i__carry__6_n_7 ;
  wire \result0_inferred__3/i__carry_n_0 ;
  wire \result0_inferred__3/i__carry_n_1 ;
  wire \result0_inferred__3/i__carry_n_2 ;
  wire \result0_inferred__3/i__carry_n_3 ;
  wire \result0_inferred__3/i__carry_n_4 ;
  wire \result0_inferred__3/i__carry_n_5 ;
  wire \result0_inferred__3/i__carry_n_6 ;
  wire \result0_inferred__3/i__carry_n_7 ;
  wire \result[0]_0 ;
  wire \result[0]_1 ;
  wire \result[0]_INST_0_i_1_n_0 ;
  wire \result[0]_INST_0_i_3_n_0 ;
  wire \result[10]_INST_0_i_1_n_0 ;
  wire \result[10]_INST_0_i_3_n_0 ;
  wire \result[11]_INST_0_i_1_n_0 ;
  wire \result[11]_INST_0_i_3_n_0 ;
  wire \result[11]_INST_0_i_5_n_0 ;
  wire \result[11]_INST_0_i_5_n_1 ;
  wire \result[11]_INST_0_i_5_n_2 ;
  wire \result[11]_INST_0_i_5_n_3 ;
  wire \result[11]_INST_0_i_6_n_0 ;
  wire \result[11]_INST_0_i_7_n_0 ;
  wire \result[11]_INST_0_i_8_n_0 ;
  wire \result[11]_INST_0_i_9_n_0 ;
  wire \result[12]_INST_0_i_1_n_0 ;
  wire \result[12]_INST_0_i_3_n_0 ;
  wire \result[13]_INST_0_i_1_n_0 ;
  wire \result[13]_INST_0_i_3_n_0 ;
  wire \result[14]_INST_0_i_1_n_0 ;
  wire \result[14]_INST_0_i_3_n_0 ;
  wire \result[15]_INST_0_i_1_n_0 ;
  wire \result[15]_INST_0_i_3_n_0 ;
  wire \result[15]_INST_0_i_5_n_0 ;
  wire \result[15]_INST_0_i_5_n_1 ;
  wire \result[15]_INST_0_i_5_n_2 ;
  wire \result[15]_INST_0_i_5_n_3 ;
  wire \result[15]_INST_0_i_6_n_0 ;
  wire \result[15]_INST_0_i_7_n_0 ;
  wire \result[15]_INST_0_i_8_n_0 ;
  wire \result[15]_INST_0_i_9_n_0 ;
  wire \result[16]_INST_0_i_1_n_0 ;
  wire \result[16]_INST_0_i_3_n_0 ;
  wire \result[17]_INST_0_i_1_n_0 ;
  wire \result[17]_INST_0_i_3_n_0 ;
  wire \result[18]_INST_0_i_1_n_0 ;
  wire \result[18]_INST_0_i_3_n_0 ;
  wire \result[19]_INST_0_i_1_n_0 ;
  wire \result[19]_INST_0_i_3_n_0 ;
  wire \result[19]_INST_0_i_5_n_0 ;
  wire \result[19]_INST_0_i_5_n_1 ;
  wire \result[19]_INST_0_i_5_n_2 ;
  wire \result[19]_INST_0_i_5_n_3 ;
  wire \result[19]_INST_0_i_6_n_0 ;
  wire \result[19]_INST_0_i_7_n_0 ;
  wire \result[19]_INST_0_i_8_n_0 ;
  wire \result[19]_INST_0_i_9_n_0 ;
  wire \result[1]_INST_0_i_1_n_0 ;
  wire \result[1]_INST_0_i_3_n_0 ;
  wire \result[20]_INST_0_i_1_n_0 ;
  wire \result[20]_INST_0_i_3_n_0 ;
  wire \result[21]_INST_0_i_1_n_0 ;
  wire \result[21]_INST_0_i_3_n_0 ;
  wire \result[22]_INST_0_i_1_n_0 ;
  wire \result[22]_INST_0_i_3_n_0 ;
  wire \result[23]_INST_0_i_1_n_0 ;
  wire \result[23]_INST_0_i_3_n_0 ;
  wire \result[23]_INST_0_i_5_n_0 ;
  wire \result[23]_INST_0_i_5_n_1 ;
  wire \result[23]_INST_0_i_5_n_2 ;
  wire \result[23]_INST_0_i_5_n_3 ;
  wire \result[23]_INST_0_i_6_n_0 ;
  wire \result[23]_INST_0_i_7_n_0 ;
  wire \result[23]_INST_0_i_8_n_0 ;
  wire \result[23]_INST_0_i_9_n_0 ;
  wire \result[24]_INST_0_i_1_n_0 ;
  wire \result[24]_INST_0_i_3_n_0 ;
  wire \result[25]_INST_0_i_1_n_0 ;
  wire \result[25]_INST_0_i_3_n_0 ;
  wire \result[26]_INST_0_i_1_n_0 ;
  wire \result[26]_INST_0_i_3_n_0 ;
  wire \result[27]_INST_0_i_1_n_0 ;
  wire \result[27]_INST_0_i_3_n_0 ;
  wire \result[27]_INST_0_i_5_n_0 ;
  wire \result[27]_INST_0_i_5_n_1 ;
  wire \result[27]_INST_0_i_5_n_2 ;
  wire \result[27]_INST_0_i_5_n_3 ;
  wire \result[27]_INST_0_i_6_n_0 ;
  wire \result[27]_INST_0_i_7_n_0 ;
  wire \result[27]_INST_0_i_8_n_0 ;
  wire \result[27]_INST_0_i_9_n_0 ;
  wire \result[28]_INST_0_i_1_n_0 ;
  wire \result[28]_INST_0_i_3_n_0 ;
  wire \result[29]_INST_0_i_1_n_0 ;
  wire \result[29]_INST_0_i_3_n_0 ;
  wire \result[2]_INST_0_i_1_n_0 ;
  wire \result[2]_INST_0_i_3_n_0 ;
  wire \result[30]_INST_0_i_1_n_0 ;
  wire \result[30]_INST_0_i_3_n_0 ;
  wire \result[31] ;
  wire \result[3]_INST_0_i_10_n_0 ;
  wire \result[3]_INST_0_i_1_n_0 ;
  wire \result[3]_INST_0_i_3_n_0 ;
  wire \result[3]_INST_0_i_5_n_0 ;
  wire \result[3]_INST_0_i_5_n_1 ;
  wire \result[3]_INST_0_i_5_n_2 ;
  wire \result[3]_INST_0_i_5_n_3 ;
  wire \result[3]_INST_0_i_7_n_0 ;
  wire \result[3]_INST_0_i_8_n_0 ;
  wire \result[3]_INST_0_i_9_n_0 ;
  wire \result[4]_INST_0_i_1_n_0 ;
  wire \result[4]_INST_0_i_3_n_0 ;
  wire \result[5]_INST_0_i_1_n_0 ;
  wire \result[5]_INST_0_i_3_n_0 ;
  wire \result[6]_INST_0_i_1_n_0 ;
  wire \result[6]_INST_0_i_3_n_0 ;
  wire \result[7]_INST_0_i_1_n_0 ;
  wire \result[7]_INST_0_i_3_n_0 ;
  wire \result[7]_INST_0_i_5_n_0 ;
  wire \result[7]_INST_0_i_5_n_1 ;
  wire \result[7]_INST_0_i_5_n_2 ;
  wire \result[7]_INST_0_i_5_n_3 ;
  wire \result[7]_INST_0_i_6_n_0 ;
  wire \result[7]_INST_0_i_7_n_0 ;
  wire \result[7]_INST_0_i_8_n_0 ;
  wire \result[7]_INST_0_i_9_n_0 ;
  wire \result[8]_INST_0_i_1_n_0 ;
  wire \result[8]_INST_0_i_3_n_0 ;
  wire \result[9]_INST_0_i_1_n_0 ;
  wire \result[9]_INST_0_i_3_n_0 ;
  wire result_0_sn_1;
  wire result_10_sn_1;
  wire result_11_sn_1;
  wire result_12_sn_1;
  wire result_13_sn_1;
  wire result_14_sn_1;
  wire result_15_sn_1;
  wire result_16_sn_1;
  wire result_17_sn_1;
  wire result_18_sn_1;
  wire result_19_sn_1;
  wire result_1_sn_1;
  wire result_20_sn_1;
  wire result_21_sn_1;
  wire result_22_sn_1;
  wire result_23_sn_1;
  wire result_24_sn_1;
  wire result_25_sn_1;
  wire result_26_sn_1;
  wire result_27_sn_1;
  wire result_28_sn_1;
  wire result_29_sn_1;
  wire result_2_sn_1;
  wire result_30_sn_1;
  wire result_3_sn_1;
  wire result_4_sn_1;
  wire result_5_sn_1;
  wire result_6_sn_1;
  wire result_7_sn_1;
  wire result_8_sn_1;
  wire result_9_sn_1;
  wire [3:1]\NLW_NZCV[1]_INST_0_i_3_CO_UNCONNECTED ;
  wire [3:0]\NLW_NZCV[1]_INST_0_i_3_O_UNCONNECTED ;
  wire [3:0]\NLW_result0_inferred__2/i__carry__7_CO_UNCONNECTED ;
  wire [3:1]\NLW_result0_inferred__2/i__carry__7_O_UNCONNECTED ;
  wire [3:0]\NLW_result0_inferred__3/i__carry__7_CO_UNCONNECTED ;
  wire [3:1]\NLW_result0_inferred__3/i__carry__7_O_UNCONNECTED ;

  assign NZCV_0_sn_1 = NZCV_0_sp_1;
  assign result_0_sn_1 = result_0_sp_1;
  assign result_10_sn_1 = result_10_sp_1;
  assign result_11_sn_1 = result_11_sp_1;
  assign result_12_sn_1 = result_12_sp_1;
  assign result_13_sn_1 = result_13_sp_1;
  assign result_14_sn_1 = result_14_sp_1;
  assign result_15_sn_1 = result_15_sp_1;
  assign result_16_sn_1 = result_16_sp_1;
  assign result_17_sn_1 = result_17_sp_1;
  assign result_18_sn_1 = result_18_sp_1;
  assign result_19_sn_1 = result_19_sp_1;
  assign result_1_sn_1 = result_1_sp_1;
  assign result_20_sn_1 = result_20_sp_1;
  assign result_21_sn_1 = result_21_sp_1;
  assign result_22_sn_1 = result_22_sp_1;
  assign result_23_sn_1 = result_23_sp_1;
  assign result_24_sn_1 = result_24_sp_1;
  assign result_25_sn_1 = result_25_sp_1;
  assign result_26_sn_1 = result_26_sp_1;
  assign result_27_sn_1 = result_27_sp_1;
  assign result_28_sn_1 = result_28_sp_1;
  assign result_29_sn_1 = result_29_sp_1;
  assign result_2_sn_1 = result_2_sp_1;
  assign result_30_sn_1 = result_30_sp_1;
  assign result_3_sn_1 = result_3_sp_1;
  assign result_4_sn_1 = result_4_sp_1;
  assign result_5_sn_1 = result_5_sp_1;
  assign result_6_sn_1 = result_6_sp_1;
  assign result_7_sn_1 = result_7_sp_1;
  assign result_8_sn_1 = result_8_sp_1;
  assign result_9_sn_1 = result_9_sp_1;
  LUT5 #(
    .INIT(32'h04A00A00)) 
    \NZCV[0]_INST_0 
       (.I0(NZCV13_out),
        .I1(NZCV_0_sn_1),
        .I2(in1[31]),
        .I3(NZCV[3]),
        .I4(in2[31]),
        .O(NZCV[0]));
  LUT4 #(
    .INIT(16'h1200)) 
    \NZCV[1]_INST_0 
       (.I0(ALU_op[1]),
        .I1(ALU_op[3]),
        .I2(ALU_op[2]),
        .I3(p_1_in),
        .O(NZCV[1]));
  LUT6 #(
    .INIT(64'hAFA0CFCFAFA0C0C0)) 
    \NZCV[1]_INST_0_i_1 
       (.I0(data3),
        .I1(data2),
        .I2(ALU_op[2]),
        .I3(O),
        .I4(ALU_op[0]),
        .I5(CO),
        .O(p_1_in));
  CARRY4 \NZCV[1]_INST_0_i_3 
       (.CI(\NZCV[3]_INST_0_i_7_n_0 ),
        .CO({\NLW_NZCV[1]_INST_0_i_3_CO_UNCONNECTED [3:1],CO}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(\NLW_NZCV[1]_INST_0_i_3_O_UNCONNECTED [3:0]),
        .S({1'b0,1'b0,1'b0,1'b1}));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \NZCV[2]_INST_0 
       (.I0(\NZCV[2]_INST_0_i_1_n_0 ),
        .I1(\NZCV[2]_INST_0_i_2_n_0 ),
        .I2(\NZCV[2]_INST_0_i_3_n_0 ),
        .I3(\NZCV[2]_INST_0_i_4_n_0 ),
        .I4(\NZCV[2]_INST_0_i_5_n_0 ),
        .I5(\NZCV[2]_INST_0_i_6_n_0 ),
        .O(NZCV[2]));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \NZCV[2]_INST_0_i_1 
       (.I0(result[22]),
        .I1(result[23]),
        .I2(result[20]),
        .I3(result[21]),
        .O(\NZCV[2]_INST_0_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hFFFACCFA)) 
    \NZCV[2]_INST_0_i_10 
       (.I0(\result[11]_INST_0_i_1_n_0 ),
        .I1(\NZCV[2]_INST_0_i_6_2 ),
        .I2(\result[10]_INST_0_i_1_n_0 ),
        .I3(ALU_op[3]),
        .I4(\NZCV[2]_INST_0_i_6_3 ),
        .O(\NZCV[2]_INST_0_i_10_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \NZCV[2]_INST_0_i_2 
       (.I0(result[18]),
        .I1(result[19]),
        .I2(result[16]),
        .I3(result[17]),
        .O(\NZCV[2]_INST_0_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \NZCV[2]_INST_0_i_3 
       (.I0(NZCV[3]),
        .I1(result[30]),
        .I2(result[28]),
        .I3(result[29]),
        .O(\NZCV[2]_INST_0_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \NZCV[2]_INST_0_i_4 
       (.I0(result[26]),
        .I1(result[27]),
        .I2(result[24]),
        .I3(result[25]),
        .O(\NZCV[2]_INST_0_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \NZCV[2]_INST_0_i_5 
       (.I0(result[5]),
        .I1(result[4]),
        .I2(result[7]),
        .I3(result[6]),
        .I4(\NZCV[2]_INST_0_i_7_n_0 ),
        .I5(\NZCV[2]_INST_0_i_8_n_0 ),
        .O(\NZCV[2]_INST_0_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \NZCV[2]_INST_0_i_6 
       (.I0(result[13]),
        .I1(result[12]),
        .I2(result[15]),
        .I3(result[14]),
        .I4(\NZCV[2]_INST_0_i_9_n_0 ),
        .I5(\NZCV[2]_INST_0_i_10_n_0 ),
        .O(\NZCV[2]_INST_0_i_6_n_0 ));
  LUT5 #(
    .INIT(32'hFFFACCFA)) 
    \NZCV[2]_INST_0_i_7 
       (.I0(\result[1]_INST_0_i_1_n_0 ),
        .I1(\NZCV[2]_INST_0_i_5_0 ),
        .I2(\result[0]_INST_0_i_1_n_0 ),
        .I3(ALU_op[3]),
        .I4(\NZCV[2]_INST_0_i_5_1 ),
        .O(\NZCV[2]_INST_0_i_7_n_0 ));
  LUT5 #(
    .INIT(32'hFFFACCFA)) 
    \NZCV[2]_INST_0_i_8 
       (.I0(\result[3]_INST_0_i_1_n_0 ),
        .I1(\NZCV[2]_INST_0_i_5_2 ),
        .I2(\result[2]_INST_0_i_1_n_0 ),
        .I3(ALU_op[3]),
        .I4(\NZCV[2]_INST_0_i_5_3 ),
        .O(\NZCV[2]_INST_0_i_8_n_0 ));
  LUT5 #(
    .INIT(32'hFFFACCFA)) 
    \NZCV[2]_INST_0_i_9 
       (.I0(\result[9]_INST_0_i_1_n_0 ),
        .I1(\NZCV[2]_INST_0_i_6_0 ),
        .I2(\result[8]_INST_0_i_1_n_0 ),
        .I3(ALU_op[3]),
        .I4(\NZCV[2]_INST_0_i_6_1 ),
        .O(\NZCV[2]_INST_0_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \NZCV[3]_INST_0 
       (.I0(in1[31]),
        .I1(in2[31]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\NZCV[3]_INST_0_i_3_n_0 ),
        .O(NZCV[3]));
  LUT2 #(
    .INIT(4'h6)) 
    \NZCV[3]_INST_0_i_10 
       (.I0(in1[29]),
        .I1(in2[29]),
        .O(\NZCV[3]_INST_0_i_10_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \NZCV[3]_INST_0_i_11 
       (.I0(in1[28]),
        .I1(in2[28]),
        .O(\NZCV[3]_INST_0_i_11_n_0 ));
  MUXF7 \NZCV[3]_INST_0_i_3 
       (.I0(\result[31] ),
        .I1(\NZCV[3]_INST_0_i_5_n_0 ),
        .O(\NZCV[3]_INST_0_i_3_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \NZCV[3]_INST_0_i_5 
       (.I0(in1[31]),
        .I1(in2[31]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__6_n_4 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__6_n_4 ),
        .O(\NZCV[3]_INST_0_i_5_n_0 ));
  CARRY4 \NZCV[3]_INST_0_i_7 
       (.CI(\result[27]_INST_0_i_5_n_0 ),
        .CO({\NZCV[3]_INST_0_i_7_n_0 ,\NZCV[3]_INST_0_i_7_n_1 ,\NZCV[3]_INST_0_i_7_n_2 ,\NZCV[3]_INST_0_i_7_n_3 }),
        .CYINIT(1'b0),
        .DI(in1[31:28]),
        .O(\in1[31] ),
        .S({\NZCV[3]_INST_0_i_8_n_0 ,\NZCV[3]_INST_0_i_9_n_0 ,\NZCV[3]_INST_0_i_10_n_0 ,\NZCV[3]_INST_0_i_11_n_0 }));
  LUT2 #(
    .INIT(4'h6)) 
    \NZCV[3]_INST_0_i_8 
       (.I0(in1[31]),
        .I1(in2[31]),
        .O(\NZCV[3]_INST_0_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \NZCV[3]_INST_0_i_9 
       (.I0(in1[30]),
        .I1(in2[30]),
        .O(\NZCV[3]_INST_0_i_9_n_0 ));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__0_i_1
       (.I0(in1[7]),
        .I1(in2[7]),
        .O(i__carry__0_i_1_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__0_i_1__0
       (.I0(in1[7]),
        .I1(in2[7]),
        .O(i__carry__0_i_1__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__0_i_2
       (.I0(in1[6]),
        .I1(in2[6]),
        .O(i__carry__0_i_2_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__0_i_2__0
       (.I0(in1[6]),
        .I1(in2[6]),
        .O(i__carry__0_i_2__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__0_i_3
       (.I0(in1[5]),
        .I1(in2[5]),
        .O(i__carry__0_i_3_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__0_i_3__0
       (.I0(in1[5]),
        .I1(in2[5]),
        .O(i__carry__0_i_3__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__0_i_4
       (.I0(in1[4]),
        .I1(in2[4]),
        .O(i__carry__0_i_4_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__0_i_4__0
       (.I0(in1[4]),
        .I1(in2[4]),
        .O(i__carry__0_i_4__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__1_i_1
       (.I0(in1[11]),
        .I1(in2[11]),
        .O(i__carry__1_i_1_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__1_i_1__0
       (.I0(in1[11]),
        .I1(in2[11]),
        .O(i__carry__1_i_1__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__1_i_2
       (.I0(in1[10]),
        .I1(in2[10]),
        .O(i__carry__1_i_2_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__1_i_2__0
       (.I0(in1[10]),
        .I1(in2[10]),
        .O(i__carry__1_i_2__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__1_i_3
       (.I0(in1[9]),
        .I1(in2[9]),
        .O(i__carry__1_i_3_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__1_i_3__0
       (.I0(in1[9]),
        .I1(in2[9]),
        .O(i__carry__1_i_3__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__1_i_4
       (.I0(in1[8]),
        .I1(in2[8]),
        .O(i__carry__1_i_4_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__1_i_4__0
       (.I0(in1[8]),
        .I1(in2[8]),
        .O(i__carry__1_i_4__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__2_i_1
       (.I0(in1[15]),
        .I1(in2[15]),
        .O(i__carry__2_i_1_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__2_i_1__0
       (.I0(in1[15]),
        .I1(in2[15]),
        .O(i__carry__2_i_1__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__2_i_2
       (.I0(in1[14]),
        .I1(in2[14]),
        .O(i__carry__2_i_2_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__2_i_2__0
       (.I0(in1[14]),
        .I1(in2[14]),
        .O(i__carry__2_i_2__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__2_i_3
       (.I0(in1[13]),
        .I1(in2[13]),
        .O(i__carry__2_i_3_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__2_i_3__0
       (.I0(in1[13]),
        .I1(in2[13]),
        .O(i__carry__2_i_3__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__2_i_4
       (.I0(in1[12]),
        .I1(in2[12]),
        .O(i__carry__2_i_4_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__2_i_4__0
       (.I0(in1[12]),
        .I1(in2[12]),
        .O(i__carry__2_i_4__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__3_i_1
       (.I0(in1[19]),
        .I1(in2[19]),
        .O(i__carry__3_i_1_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__3_i_1__0
       (.I0(in1[19]),
        .I1(in2[19]),
        .O(i__carry__3_i_1__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__3_i_2
       (.I0(in1[18]),
        .I1(in2[18]),
        .O(i__carry__3_i_2_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__3_i_2__0
       (.I0(in1[18]),
        .I1(in2[18]),
        .O(i__carry__3_i_2__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__3_i_3
       (.I0(in1[17]),
        .I1(in2[17]),
        .O(i__carry__3_i_3_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__3_i_3__0
       (.I0(in1[17]),
        .I1(in2[17]),
        .O(i__carry__3_i_3__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__3_i_4
       (.I0(in1[16]),
        .I1(in2[16]),
        .O(i__carry__3_i_4_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__3_i_4__0
       (.I0(in1[16]),
        .I1(in2[16]),
        .O(i__carry__3_i_4__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__4_i_1
       (.I0(in1[23]),
        .I1(in2[23]),
        .O(i__carry__4_i_1_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__4_i_1__0
       (.I0(in1[23]),
        .I1(in2[23]),
        .O(i__carry__4_i_1__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__4_i_2
       (.I0(in1[22]),
        .I1(in2[22]),
        .O(i__carry__4_i_2_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__4_i_2__0
       (.I0(in1[22]),
        .I1(in2[22]),
        .O(i__carry__4_i_2__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__4_i_3
       (.I0(in1[21]),
        .I1(in2[21]),
        .O(i__carry__4_i_3_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__4_i_3__0
       (.I0(in1[21]),
        .I1(in2[21]),
        .O(i__carry__4_i_3__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__4_i_4
       (.I0(in1[20]),
        .I1(in2[20]),
        .O(i__carry__4_i_4_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__4_i_4__0
       (.I0(in1[20]),
        .I1(in2[20]),
        .O(i__carry__4_i_4__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__5_i_1
       (.I0(in1[27]),
        .I1(in2[27]),
        .O(i__carry__5_i_1_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__5_i_1__0
       (.I0(in1[27]),
        .I1(in2[27]),
        .O(i__carry__5_i_1__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__5_i_2
       (.I0(in1[26]),
        .I1(in2[26]),
        .O(i__carry__5_i_2_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__5_i_2__0
       (.I0(in1[26]),
        .I1(in2[26]),
        .O(i__carry__5_i_2__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__5_i_3
       (.I0(in1[25]),
        .I1(in2[25]),
        .O(i__carry__5_i_3_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__5_i_3__0
       (.I0(in1[25]),
        .I1(in2[25]),
        .O(i__carry__5_i_3__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__5_i_4
       (.I0(in1[24]),
        .I1(in2[24]),
        .O(i__carry__5_i_4_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__5_i_4__0
       (.I0(in1[24]),
        .I1(in2[24]),
        .O(i__carry__5_i_4__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__6_i_1
       (.I0(in1[31]),
        .I1(in2[31]),
        .O(i__carry__6_i_1_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__6_i_1__0
       (.I0(in1[31]),
        .I1(in2[31]),
        .O(i__carry__6_i_1__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__6_i_2
       (.I0(in1[30]),
        .I1(in2[30]),
        .O(i__carry__6_i_2_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__6_i_2__0
       (.I0(in1[30]),
        .I1(in2[30]),
        .O(i__carry__6_i_2__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__6_i_3
       (.I0(in1[29]),
        .I1(in2[29]),
        .O(i__carry__6_i_3_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__6_i_3__0
       (.I0(in1[29]),
        .I1(in2[29]),
        .O(i__carry__6_i_3__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__6_i_4
       (.I0(in1[28]),
        .I1(in2[28]),
        .O(i__carry__6_i_4_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry__6_i_4__0
       (.I0(in1[28]),
        .I1(in2[28]),
        .O(i__carry__6_i_4__0_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    i__carry_i_1
       (.I0(in2[0]),
        .O(p_0_in));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_1__0
       (.I0(in1[3]),
        .I1(in2[3]),
        .O(i__carry_i_1__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_2
       (.I0(in1[3]),
        .I1(in2[3]),
        .O(i__carry_i_2_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_2__0
       (.I0(in1[2]),
        .I1(in2[2]),
        .O(i__carry_i_2__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_3
       (.I0(in1[2]),
        .I1(in2[2]),
        .O(i__carry_i_3_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_3__0
       (.I0(in1[1]),
        .I1(in2[1]),
        .O(i__carry_i_3__0_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_4
       (.I0(in1[0]),
        .I1(in2[0]),
        .O(i__carry_i_4_n_0));
  LUT2 #(
    .INIT(4'h9)) 
    i__carry_i_4__0
       (.I0(in1[1]),
        .I1(in2[1]),
        .O(i__carry_i_4__0_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    i__carry_i_5
       (.I0(in1[0]),
        .I1(carry_in),
        .O(i__carry_i_5_n_0));
  CARRY4 \result0_inferred__2/i__carry 
       (.CI(1'b0),
        .CO({\result0_inferred__2/i__carry_n_0 ,\result0_inferred__2/i__carry_n_1 ,\result0_inferred__2/i__carry_n_2 ,\result0_inferred__2/i__carry_n_3 }),
        .CYINIT(1'b1),
        .DI(in1[3:0]),
        .O({\result0_inferred__2/i__carry_n_4 ,\result0_inferred__2/i__carry_n_5 ,\result0_inferred__2/i__carry_n_6 ,\result0_inferred__2/i__carry_n_7 }),
        .S({i__carry_i_1__0_n_0,i__carry_i_2__0_n_0,i__carry_i_3__0_n_0,i__carry_i_4_n_0}));
  CARRY4 \result0_inferred__2/i__carry__0 
       (.CI(\result0_inferred__2/i__carry_n_0 ),
        .CO({\result0_inferred__2/i__carry__0_n_0 ,\result0_inferred__2/i__carry__0_n_1 ,\result0_inferred__2/i__carry__0_n_2 ,\result0_inferred__2/i__carry__0_n_3 }),
        .CYINIT(1'b0),
        .DI(in1[7:4]),
        .O({\result0_inferred__2/i__carry__0_n_4 ,\result0_inferred__2/i__carry__0_n_5 ,\result0_inferred__2/i__carry__0_n_6 ,\result0_inferred__2/i__carry__0_n_7 }),
        .S({i__carry__0_i_1__0_n_0,i__carry__0_i_2__0_n_0,i__carry__0_i_3__0_n_0,i__carry__0_i_4__0_n_0}));
  CARRY4 \result0_inferred__2/i__carry__1 
       (.CI(\result0_inferred__2/i__carry__0_n_0 ),
        .CO({\result0_inferred__2/i__carry__1_n_0 ,\result0_inferred__2/i__carry__1_n_1 ,\result0_inferred__2/i__carry__1_n_2 ,\result0_inferred__2/i__carry__1_n_3 }),
        .CYINIT(1'b0),
        .DI(in1[11:8]),
        .O({\result0_inferred__2/i__carry__1_n_4 ,\result0_inferred__2/i__carry__1_n_5 ,\result0_inferred__2/i__carry__1_n_6 ,\result0_inferred__2/i__carry__1_n_7 }),
        .S({i__carry__1_i_1__0_n_0,i__carry__1_i_2__0_n_0,i__carry__1_i_3__0_n_0,i__carry__1_i_4__0_n_0}));
  CARRY4 \result0_inferred__2/i__carry__2 
       (.CI(\result0_inferred__2/i__carry__1_n_0 ),
        .CO({\result0_inferred__2/i__carry__2_n_0 ,\result0_inferred__2/i__carry__2_n_1 ,\result0_inferred__2/i__carry__2_n_2 ,\result0_inferred__2/i__carry__2_n_3 }),
        .CYINIT(1'b0),
        .DI(in1[15:12]),
        .O({\result0_inferred__2/i__carry__2_n_4 ,\result0_inferred__2/i__carry__2_n_5 ,\result0_inferred__2/i__carry__2_n_6 ,\result0_inferred__2/i__carry__2_n_7 }),
        .S({i__carry__2_i_1__0_n_0,i__carry__2_i_2__0_n_0,i__carry__2_i_3__0_n_0,i__carry__2_i_4__0_n_0}));
  CARRY4 \result0_inferred__2/i__carry__3 
       (.CI(\result0_inferred__2/i__carry__2_n_0 ),
        .CO({\result0_inferred__2/i__carry__3_n_0 ,\result0_inferred__2/i__carry__3_n_1 ,\result0_inferred__2/i__carry__3_n_2 ,\result0_inferred__2/i__carry__3_n_3 }),
        .CYINIT(1'b0),
        .DI(in1[19:16]),
        .O({\result0_inferred__2/i__carry__3_n_4 ,\result0_inferred__2/i__carry__3_n_5 ,\result0_inferred__2/i__carry__3_n_6 ,\result0_inferred__2/i__carry__3_n_7 }),
        .S({i__carry__3_i_1__0_n_0,i__carry__3_i_2__0_n_0,i__carry__3_i_3__0_n_0,i__carry__3_i_4__0_n_0}));
  CARRY4 \result0_inferred__2/i__carry__4 
       (.CI(\result0_inferred__2/i__carry__3_n_0 ),
        .CO({\result0_inferred__2/i__carry__4_n_0 ,\result0_inferred__2/i__carry__4_n_1 ,\result0_inferred__2/i__carry__4_n_2 ,\result0_inferred__2/i__carry__4_n_3 }),
        .CYINIT(1'b0),
        .DI(in1[23:20]),
        .O({\result0_inferred__2/i__carry__4_n_4 ,\result0_inferred__2/i__carry__4_n_5 ,\result0_inferred__2/i__carry__4_n_6 ,\result0_inferred__2/i__carry__4_n_7 }),
        .S({i__carry__4_i_1__0_n_0,i__carry__4_i_2__0_n_0,i__carry__4_i_3__0_n_0,i__carry__4_i_4__0_n_0}));
  CARRY4 \result0_inferred__2/i__carry__5 
       (.CI(\result0_inferred__2/i__carry__4_n_0 ),
        .CO({\result0_inferred__2/i__carry__5_n_0 ,\result0_inferred__2/i__carry__5_n_1 ,\result0_inferred__2/i__carry__5_n_2 ,\result0_inferred__2/i__carry__5_n_3 }),
        .CYINIT(1'b0),
        .DI(in1[27:24]),
        .O({\result0_inferred__2/i__carry__5_n_4 ,\result0_inferred__2/i__carry__5_n_5 ,\result0_inferred__2/i__carry__5_n_6 ,\result0_inferred__2/i__carry__5_n_7 }),
        .S({i__carry__5_i_1__0_n_0,i__carry__5_i_2__0_n_0,i__carry__5_i_3__0_n_0,i__carry__5_i_4__0_n_0}));
  CARRY4 \result0_inferred__2/i__carry__6 
       (.CI(\result0_inferred__2/i__carry__5_n_0 ),
        .CO({\result0_inferred__2/i__carry__6_n_0 ,\result0_inferred__2/i__carry__6_n_1 ,\result0_inferred__2/i__carry__6_n_2 ,\result0_inferred__2/i__carry__6_n_3 }),
        .CYINIT(1'b0),
        .DI(in1[31:28]),
        .O({\result0_inferred__2/i__carry__6_n_4 ,\result0_inferred__2/i__carry__6_n_5 ,\result0_inferred__2/i__carry__6_n_6 ,\result0_inferred__2/i__carry__6_n_7 }),
        .S({i__carry__6_i_1__0_n_0,i__carry__6_i_2__0_n_0,i__carry__6_i_3__0_n_0,i__carry__6_i_4__0_n_0}));
  CARRY4 \result0_inferred__2/i__carry__7 
       (.CI(\result0_inferred__2/i__carry__6_n_0 ),
        .CO(\NLW_result0_inferred__2/i__carry__7_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_result0_inferred__2/i__carry__7_O_UNCONNECTED [3:1],data2}),
        .S({1'b0,1'b0,1'b0,1'b1}));
  CARRY4 \result0_inferred__3/i__carry 
       (.CI(1'b0),
        .CO({\result0_inferred__3/i__carry_n_0 ,\result0_inferred__3/i__carry_n_1 ,\result0_inferred__3/i__carry_n_2 ,\result0_inferred__3/i__carry_n_3 }),
        .CYINIT(p_0_in),
        .DI(in1[3:0]),
        .O({\result0_inferred__3/i__carry_n_4 ,\result0_inferred__3/i__carry_n_5 ,\result0_inferred__3/i__carry_n_6 ,\result0_inferred__3/i__carry_n_7 }),
        .S({i__carry_i_2_n_0,i__carry_i_3_n_0,i__carry_i_4__0_n_0,i__carry_i_5_n_0}));
  CARRY4 \result0_inferred__3/i__carry__0 
       (.CI(\result0_inferred__3/i__carry_n_0 ),
        .CO({\result0_inferred__3/i__carry__0_n_0 ,\result0_inferred__3/i__carry__0_n_1 ,\result0_inferred__3/i__carry__0_n_2 ,\result0_inferred__3/i__carry__0_n_3 }),
        .CYINIT(1'b0),
        .DI(in1[7:4]),
        .O({\result0_inferred__3/i__carry__0_n_4 ,\result0_inferred__3/i__carry__0_n_5 ,\result0_inferred__3/i__carry__0_n_6 ,\result0_inferred__3/i__carry__0_n_7 }),
        .S({i__carry__0_i_1_n_0,i__carry__0_i_2_n_0,i__carry__0_i_3_n_0,i__carry__0_i_4_n_0}));
  CARRY4 \result0_inferred__3/i__carry__1 
       (.CI(\result0_inferred__3/i__carry__0_n_0 ),
        .CO({\result0_inferred__3/i__carry__1_n_0 ,\result0_inferred__3/i__carry__1_n_1 ,\result0_inferred__3/i__carry__1_n_2 ,\result0_inferred__3/i__carry__1_n_3 }),
        .CYINIT(1'b0),
        .DI(in1[11:8]),
        .O({\result0_inferred__3/i__carry__1_n_4 ,\result0_inferred__3/i__carry__1_n_5 ,\result0_inferred__3/i__carry__1_n_6 ,\result0_inferred__3/i__carry__1_n_7 }),
        .S({i__carry__1_i_1_n_0,i__carry__1_i_2_n_0,i__carry__1_i_3_n_0,i__carry__1_i_4_n_0}));
  CARRY4 \result0_inferred__3/i__carry__2 
       (.CI(\result0_inferred__3/i__carry__1_n_0 ),
        .CO({\result0_inferred__3/i__carry__2_n_0 ,\result0_inferred__3/i__carry__2_n_1 ,\result0_inferred__3/i__carry__2_n_2 ,\result0_inferred__3/i__carry__2_n_3 }),
        .CYINIT(1'b0),
        .DI(in1[15:12]),
        .O({\result0_inferred__3/i__carry__2_n_4 ,\result0_inferred__3/i__carry__2_n_5 ,\result0_inferred__3/i__carry__2_n_6 ,\result0_inferred__3/i__carry__2_n_7 }),
        .S({i__carry__2_i_1_n_0,i__carry__2_i_2_n_0,i__carry__2_i_3_n_0,i__carry__2_i_4_n_0}));
  CARRY4 \result0_inferred__3/i__carry__3 
       (.CI(\result0_inferred__3/i__carry__2_n_0 ),
        .CO({\result0_inferred__3/i__carry__3_n_0 ,\result0_inferred__3/i__carry__3_n_1 ,\result0_inferred__3/i__carry__3_n_2 ,\result0_inferred__3/i__carry__3_n_3 }),
        .CYINIT(1'b0),
        .DI(in1[19:16]),
        .O({\result0_inferred__3/i__carry__3_n_4 ,\result0_inferred__3/i__carry__3_n_5 ,\result0_inferred__3/i__carry__3_n_6 ,\result0_inferred__3/i__carry__3_n_7 }),
        .S({i__carry__3_i_1_n_0,i__carry__3_i_2_n_0,i__carry__3_i_3_n_0,i__carry__3_i_4_n_0}));
  CARRY4 \result0_inferred__3/i__carry__4 
       (.CI(\result0_inferred__3/i__carry__3_n_0 ),
        .CO({\result0_inferred__3/i__carry__4_n_0 ,\result0_inferred__3/i__carry__4_n_1 ,\result0_inferred__3/i__carry__4_n_2 ,\result0_inferred__3/i__carry__4_n_3 }),
        .CYINIT(1'b0),
        .DI(in1[23:20]),
        .O({\result0_inferred__3/i__carry__4_n_4 ,\result0_inferred__3/i__carry__4_n_5 ,\result0_inferred__3/i__carry__4_n_6 ,\result0_inferred__3/i__carry__4_n_7 }),
        .S({i__carry__4_i_1_n_0,i__carry__4_i_2_n_0,i__carry__4_i_3_n_0,i__carry__4_i_4_n_0}));
  CARRY4 \result0_inferred__3/i__carry__5 
       (.CI(\result0_inferred__3/i__carry__4_n_0 ),
        .CO({\result0_inferred__3/i__carry__5_n_0 ,\result0_inferred__3/i__carry__5_n_1 ,\result0_inferred__3/i__carry__5_n_2 ,\result0_inferred__3/i__carry__5_n_3 }),
        .CYINIT(1'b0),
        .DI(in1[27:24]),
        .O({\result0_inferred__3/i__carry__5_n_4 ,\result0_inferred__3/i__carry__5_n_5 ,\result0_inferred__3/i__carry__5_n_6 ,\result0_inferred__3/i__carry__5_n_7 }),
        .S({i__carry__5_i_1_n_0,i__carry__5_i_2_n_0,i__carry__5_i_3_n_0,i__carry__5_i_4_n_0}));
  CARRY4 \result0_inferred__3/i__carry__6 
       (.CI(\result0_inferred__3/i__carry__5_n_0 ),
        .CO({\result0_inferred__3/i__carry__6_n_0 ,\result0_inferred__3/i__carry__6_n_1 ,\result0_inferred__3/i__carry__6_n_2 ,\result0_inferred__3/i__carry__6_n_3 }),
        .CYINIT(1'b0),
        .DI(in1[31:28]),
        .O({\result0_inferred__3/i__carry__6_n_4 ,\result0_inferred__3/i__carry__6_n_5 ,\result0_inferred__3/i__carry__6_n_6 ,\result0_inferred__3/i__carry__6_n_7 }),
        .S({i__carry__6_i_1_n_0,i__carry__6_i_2_n_0,i__carry__6_i_3_n_0,i__carry__6_i_4_n_0}));
  CARRY4 \result0_inferred__3/i__carry__7 
       (.CI(\result0_inferred__3/i__carry__6_n_0 ),
        .CO(\NLW_result0_inferred__3/i__carry__7_CO_UNCONNECTED [3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_result0_inferred__3/i__carry__7_O_UNCONNECTED [3:1],data3}),
        .S({1'b0,1'b0,1'b0,1'b1}));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[0]_INST_0 
       (.I0(in1[0]),
        .I1(in2[0]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[0]_INST_0_i_1_n_0 ),
        .O(result[0]));
  MUXF7 \result[0]_INST_0_i_1 
       (.I0(\result[0]_1 ),
        .I1(\result[0]_INST_0_i_3_n_0 ),
        .O(\result[0]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[0]_INST_0_i_3 
       (.I0(in1[0]),
        .I1(in2[0]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry_n_7 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry_n_7 ),
        .O(\result[0]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[10]_INST_0 
       (.I0(in1[10]),
        .I1(in2[10]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[10]_INST_0_i_1_n_0 ),
        .O(result[10]));
  MUXF7 \result[10]_INST_0_i_1 
       (.I0(result_10_sn_1),
        .I1(\result[10]_INST_0_i_3_n_0 ),
        .O(\result[10]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[10]_INST_0_i_3 
       (.I0(in1[10]),
        .I1(in2[10]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__1_n_5 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__1_n_5 ),
        .O(\result[10]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[11]_INST_0 
       (.I0(in1[11]),
        .I1(in2[11]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[11]_INST_0_i_1_n_0 ),
        .O(result[11]));
  MUXF7 \result[11]_INST_0_i_1 
       (.I0(result_11_sn_1),
        .I1(\result[11]_INST_0_i_3_n_0 ),
        .O(\result[11]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[11]_INST_0_i_3 
       (.I0(in1[11]),
        .I1(in2[11]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__1_n_4 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__1_n_4 ),
        .O(\result[11]_INST_0_i_3_n_0 ));
  CARRY4 \result[11]_INST_0_i_5 
       (.CI(\result[7]_INST_0_i_5_n_0 ),
        .CO({\result[11]_INST_0_i_5_n_0 ,\result[11]_INST_0_i_5_n_1 ,\result[11]_INST_0_i_5_n_2 ,\result[11]_INST_0_i_5_n_3 }),
        .CYINIT(1'b0),
        .DI(in1[11:8]),
        .O(\in1[11] ),
        .S({\result[11]_INST_0_i_6_n_0 ,\result[11]_INST_0_i_7_n_0 ,\result[11]_INST_0_i_8_n_0 ,\result[11]_INST_0_i_9_n_0 }));
  LUT2 #(
    .INIT(4'h6)) 
    \result[11]_INST_0_i_6 
       (.I0(in1[11]),
        .I1(in2[11]),
        .O(\result[11]_INST_0_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \result[11]_INST_0_i_7 
       (.I0(in1[10]),
        .I1(in2[10]),
        .O(\result[11]_INST_0_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \result[11]_INST_0_i_8 
       (.I0(in1[9]),
        .I1(in2[9]),
        .O(\result[11]_INST_0_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \result[11]_INST_0_i_9 
       (.I0(in1[8]),
        .I1(in2[8]),
        .O(\result[11]_INST_0_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[12]_INST_0 
       (.I0(in1[12]),
        .I1(in2[12]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[12]_INST_0_i_1_n_0 ),
        .O(result[12]));
  MUXF7 \result[12]_INST_0_i_1 
       (.I0(result_12_sn_1),
        .I1(\result[12]_INST_0_i_3_n_0 ),
        .O(\result[12]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[12]_INST_0_i_3 
       (.I0(in1[12]),
        .I1(in2[12]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__2_n_7 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__2_n_7 ),
        .O(\result[12]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[13]_INST_0 
       (.I0(in1[13]),
        .I1(in2[13]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[13]_INST_0_i_1_n_0 ),
        .O(result[13]));
  MUXF7 \result[13]_INST_0_i_1 
       (.I0(result_13_sn_1),
        .I1(\result[13]_INST_0_i_3_n_0 ),
        .O(\result[13]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[13]_INST_0_i_3 
       (.I0(in1[13]),
        .I1(in2[13]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__2_n_6 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__2_n_6 ),
        .O(\result[13]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[14]_INST_0 
       (.I0(in1[14]),
        .I1(in2[14]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[14]_INST_0_i_1_n_0 ),
        .O(result[14]));
  MUXF7 \result[14]_INST_0_i_1 
       (.I0(result_14_sn_1),
        .I1(\result[14]_INST_0_i_3_n_0 ),
        .O(\result[14]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[14]_INST_0_i_3 
       (.I0(in1[14]),
        .I1(in2[14]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__2_n_5 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__2_n_5 ),
        .O(\result[14]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[15]_INST_0 
       (.I0(in1[15]),
        .I1(in2[15]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[15]_INST_0_i_1_n_0 ),
        .O(result[15]));
  MUXF7 \result[15]_INST_0_i_1 
       (.I0(result_15_sn_1),
        .I1(\result[15]_INST_0_i_3_n_0 ),
        .O(\result[15]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[15]_INST_0_i_3 
       (.I0(in1[15]),
        .I1(in2[15]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__2_n_4 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__2_n_4 ),
        .O(\result[15]_INST_0_i_3_n_0 ));
  CARRY4 \result[15]_INST_0_i_5 
       (.CI(\result[11]_INST_0_i_5_n_0 ),
        .CO({\result[15]_INST_0_i_5_n_0 ,\result[15]_INST_0_i_5_n_1 ,\result[15]_INST_0_i_5_n_2 ,\result[15]_INST_0_i_5_n_3 }),
        .CYINIT(1'b0),
        .DI(in1[15:12]),
        .O(\in1[15] ),
        .S({\result[15]_INST_0_i_6_n_0 ,\result[15]_INST_0_i_7_n_0 ,\result[15]_INST_0_i_8_n_0 ,\result[15]_INST_0_i_9_n_0 }));
  LUT2 #(
    .INIT(4'h6)) 
    \result[15]_INST_0_i_6 
       (.I0(in1[15]),
        .I1(in2[15]),
        .O(\result[15]_INST_0_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \result[15]_INST_0_i_7 
       (.I0(in1[14]),
        .I1(in2[14]),
        .O(\result[15]_INST_0_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \result[15]_INST_0_i_8 
       (.I0(in1[13]),
        .I1(in2[13]),
        .O(\result[15]_INST_0_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \result[15]_INST_0_i_9 
       (.I0(in1[12]),
        .I1(in2[12]),
        .O(\result[15]_INST_0_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[16]_INST_0 
       (.I0(in1[16]),
        .I1(in2[16]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[16]_INST_0_i_1_n_0 ),
        .O(result[16]));
  MUXF7 \result[16]_INST_0_i_1 
       (.I0(result_16_sn_1),
        .I1(\result[16]_INST_0_i_3_n_0 ),
        .O(\result[16]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[16]_INST_0_i_3 
       (.I0(in1[16]),
        .I1(in2[16]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__3_n_7 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__3_n_7 ),
        .O(\result[16]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[17]_INST_0 
       (.I0(in1[17]),
        .I1(in2[17]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[17]_INST_0_i_1_n_0 ),
        .O(result[17]));
  MUXF7 \result[17]_INST_0_i_1 
       (.I0(result_17_sn_1),
        .I1(\result[17]_INST_0_i_3_n_0 ),
        .O(\result[17]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[17]_INST_0_i_3 
       (.I0(in1[17]),
        .I1(in2[17]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__3_n_6 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__3_n_6 ),
        .O(\result[17]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[18]_INST_0 
       (.I0(in1[18]),
        .I1(in2[18]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[18]_INST_0_i_1_n_0 ),
        .O(result[18]));
  MUXF7 \result[18]_INST_0_i_1 
       (.I0(result_18_sn_1),
        .I1(\result[18]_INST_0_i_3_n_0 ),
        .O(\result[18]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[18]_INST_0_i_3 
       (.I0(in1[18]),
        .I1(in2[18]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__3_n_5 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__3_n_5 ),
        .O(\result[18]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[19]_INST_0 
       (.I0(in1[19]),
        .I1(in2[19]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[19]_INST_0_i_1_n_0 ),
        .O(result[19]));
  MUXF7 \result[19]_INST_0_i_1 
       (.I0(result_19_sn_1),
        .I1(\result[19]_INST_0_i_3_n_0 ),
        .O(\result[19]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[19]_INST_0_i_3 
       (.I0(in1[19]),
        .I1(in2[19]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__3_n_4 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__3_n_4 ),
        .O(\result[19]_INST_0_i_3_n_0 ));
  CARRY4 \result[19]_INST_0_i_5 
       (.CI(\result[15]_INST_0_i_5_n_0 ),
        .CO({\result[19]_INST_0_i_5_n_0 ,\result[19]_INST_0_i_5_n_1 ,\result[19]_INST_0_i_5_n_2 ,\result[19]_INST_0_i_5_n_3 }),
        .CYINIT(1'b0),
        .DI(in1[19:16]),
        .O(\in1[19] ),
        .S({\result[19]_INST_0_i_6_n_0 ,\result[19]_INST_0_i_7_n_0 ,\result[19]_INST_0_i_8_n_0 ,\result[19]_INST_0_i_9_n_0 }));
  LUT2 #(
    .INIT(4'h6)) 
    \result[19]_INST_0_i_6 
       (.I0(in1[19]),
        .I1(in2[19]),
        .O(\result[19]_INST_0_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \result[19]_INST_0_i_7 
       (.I0(in1[18]),
        .I1(in2[18]),
        .O(\result[19]_INST_0_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \result[19]_INST_0_i_8 
       (.I0(in1[17]),
        .I1(in2[17]),
        .O(\result[19]_INST_0_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \result[19]_INST_0_i_9 
       (.I0(in1[16]),
        .I1(in2[16]),
        .O(\result[19]_INST_0_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[1]_INST_0 
       (.I0(in1[1]),
        .I1(in2[1]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[1]_INST_0_i_1_n_0 ),
        .O(result[1]));
  MUXF7 \result[1]_INST_0_i_1 
       (.I0(result_1_sn_1),
        .I1(\result[1]_INST_0_i_3_n_0 ),
        .O(\result[1]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[1]_INST_0_i_3 
       (.I0(in1[1]),
        .I1(in2[1]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry_n_6 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry_n_6 ),
        .O(\result[1]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[20]_INST_0 
       (.I0(in1[20]),
        .I1(in2[20]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[20]_INST_0_i_1_n_0 ),
        .O(result[20]));
  MUXF7 \result[20]_INST_0_i_1 
       (.I0(result_20_sn_1),
        .I1(\result[20]_INST_0_i_3_n_0 ),
        .O(\result[20]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[20]_INST_0_i_3 
       (.I0(in1[20]),
        .I1(in2[20]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__4_n_7 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__4_n_7 ),
        .O(\result[20]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[21]_INST_0 
       (.I0(in1[21]),
        .I1(in2[21]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[21]_INST_0_i_1_n_0 ),
        .O(result[21]));
  MUXF7 \result[21]_INST_0_i_1 
       (.I0(result_21_sn_1),
        .I1(\result[21]_INST_0_i_3_n_0 ),
        .O(\result[21]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[21]_INST_0_i_3 
       (.I0(in1[21]),
        .I1(in2[21]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__4_n_6 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__4_n_6 ),
        .O(\result[21]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[22]_INST_0 
       (.I0(in1[22]),
        .I1(in2[22]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[22]_INST_0_i_1_n_0 ),
        .O(result[22]));
  MUXF7 \result[22]_INST_0_i_1 
       (.I0(result_22_sn_1),
        .I1(\result[22]_INST_0_i_3_n_0 ),
        .O(\result[22]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[22]_INST_0_i_3 
       (.I0(in1[22]),
        .I1(in2[22]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__4_n_5 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__4_n_5 ),
        .O(\result[22]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[23]_INST_0 
       (.I0(in1[23]),
        .I1(in2[23]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[23]_INST_0_i_1_n_0 ),
        .O(result[23]));
  MUXF7 \result[23]_INST_0_i_1 
       (.I0(result_23_sn_1),
        .I1(\result[23]_INST_0_i_3_n_0 ),
        .O(\result[23]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[23]_INST_0_i_3 
       (.I0(in1[23]),
        .I1(in2[23]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__4_n_4 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__4_n_4 ),
        .O(\result[23]_INST_0_i_3_n_0 ));
  CARRY4 \result[23]_INST_0_i_5 
       (.CI(\result[19]_INST_0_i_5_n_0 ),
        .CO({\result[23]_INST_0_i_5_n_0 ,\result[23]_INST_0_i_5_n_1 ,\result[23]_INST_0_i_5_n_2 ,\result[23]_INST_0_i_5_n_3 }),
        .CYINIT(1'b0),
        .DI(in1[23:20]),
        .O(\in1[23] ),
        .S({\result[23]_INST_0_i_6_n_0 ,\result[23]_INST_0_i_7_n_0 ,\result[23]_INST_0_i_8_n_0 ,\result[23]_INST_0_i_9_n_0 }));
  LUT2 #(
    .INIT(4'h6)) 
    \result[23]_INST_0_i_6 
       (.I0(in1[23]),
        .I1(in2[23]),
        .O(\result[23]_INST_0_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \result[23]_INST_0_i_7 
       (.I0(in1[22]),
        .I1(in2[22]),
        .O(\result[23]_INST_0_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \result[23]_INST_0_i_8 
       (.I0(in1[21]),
        .I1(in2[21]),
        .O(\result[23]_INST_0_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \result[23]_INST_0_i_9 
       (.I0(in1[20]),
        .I1(in2[20]),
        .O(\result[23]_INST_0_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[24]_INST_0 
       (.I0(in1[24]),
        .I1(in2[24]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[24]_INST_0_i_1_n_0 ),
        .O(result[24]));
  MUXF7 \result[24]_INST_0_i_1 
       (.I0(result_24_sn_1),
        .I1(\result[24]_INST_0_i_3_n_0 ),
        .O(\result[24]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[24]_INST_0_i_3 
       (.I0(in1[24]),
        .I1(in2[24]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__5_n_7 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__5_n_7 ),
        .O(\result[24]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[25]_INST_0 
       (.I0(in1[25]),
        .I1(in2[25]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[25]_INST_0_i_1_n_0 ),
        .O(result[25]));
  MUXF7 \result[25]_INST_0_i_1 
       (.I0(result_25_sn_1),
        .I1(\result[25]_INST_0_i_3_n_0 ),
        .O(\result[25]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[25]_INST_0_i_3 
       (.I0(in1[25]),
        .I1(in2[25]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__5_n_6 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__5_n_6 ),
        .O(\result[25]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[26]_INST_0 
       (.I0(in1[26]),
        .I1(in2[26]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[26]_INST_0_i_1_n_0 ),
        .O(result[26]));
  MUXF7 \result[26]_INST_0_i_1 
       (.I0(result_26_sn_1),
        .I1(\result[26]_INST_0_i_3_n_0 ),
        .O(\result[26]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[26]_INST_0_i_3 
       (.I0(in1[26]),
        .I1(in2[26]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__5_n_5 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__5_n_5 ),
        .O(\result[26]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[27]_INST_0 
       (.I0(in1[27]),
        .I1(in2[27]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[27]_INST_0_i_1_n_0 ),
        .O(result[27]));
  MUXF7 \result[27]_INST_0_i_1 
       (.I0(result_27_sn_1),
        .I1(\result[27]_INST_0_i_3_n_0 ),
        .O(\result[27]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[27]_INST_0_i_3 
       (.I0(in1[27]),
        .I1(in2[27]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__5_n_4 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__5_n_4 ),
        .O(\result[27]_INST_0_i_3_n_0 ));
  CARRY4 \result[27]_INST_0_i_5 
       (.CI(\result[23]_INST_0_i_5_n_0 ),
        .CO({\result[27]_INST_0_i_5_n_0 ,\result[27]_INST_0_i_5_n_1 ,\result[27]_INST_0_i_5_n_2 ,\result[27]_INST_0_i_5_n_3 }),
        .CYINIT(1'b0),
        .DI(in1[27:24]),
        .O(\in1[27] ),
        .S({\result[27]_INST_0_i_6_n_0 ,\result[27]_INST_0_i_7_n_0 ,\result[27]_INST_0_i_8_n_0 ,\result[27]_INST_0_i_9_n_0 }));
  LUT2 #(
    .INIT(4'h6)) 
    \result[27]_INST_0_i_6 
       (.I0(in1[27]),
        .I1(in2[27]),
        .O(\result[27]_INST_0_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \result[27]_INST_0_i_7 
       (.I0(in1[26]),
        .I1(in2[26]),
        .O(\result[27]_INST_0_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \result[27]_INST_0_i_8 
       (.I0(in1[25]),
        .I1(in2[25]),
        .O(\result[27]_INST_0_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \result[27]_INST_0_i_9 
       (.I0(in1[24]),
        .I1(in2[24]),
        .O(\result[27]_INST_0_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[28]_INST_0 
       (.I0(in1[28]),
        .I1(in2[28]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[28]_INST_0_i_1_n_0 ),
        .O(result[28]));
  MUXF7 \result[28]_INST_0_i_1 
       (.I0(result_28_sn_1),
        .I1(\result[28]_INST_0_i_3_n_0 ),
        .O(\result[28]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[28]_INST_0_i_3 
       (.I0(in1[28]),
        .I1(in2[28]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__6_n_7 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__6_n_7 ),
        .O(\result[28]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[29]_INST_0 
       (.I0(in1[29]),
        .I1(in2[29]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[29]_INST_0_i_1_n_0 ),
        .O(result[29]));
  MUXF7 \result[29]_INST_0_i_1 
       (.I0(result_29_sn_1),
        .I1(\result[29]_INST_0_i_3_n_0 ),
        .O(\result[29]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[29]_INST_0_i_3 
       (.I0(in1[29]),
        .I1(in2[29]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__6_n_6 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__6_n_6 ),
        .O(\result[29]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[2]_INST_0 
       (.I0(in1[2]),
        .I1(in2[2]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[2]_INST_0_i_1_n_0 ),
        .O(result[2]));
  MUXF7 \result[2]_INST_0_i_1 
       (.I0(result_2_sn_1),
        .I1(\result[2]_INST_0_i_3_n_0 ),
        .O(\result[2]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[2]_INST_0_i_3 
       (.I0(in1[2]),
        .I1(in2[2]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry_n_5 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry_n_5 ),
        .O(\result[2]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[30]_INST_0 
       (.I0(in1[30]),
        .I1(in2[30]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[30]_INST_0_i_1_n_0 ),
        .O(result[30]));
  MUXF7 \result[30]_INST_0_i_1 
       (.I0(result_30_sn_1),
        .I1(\result[30]_INST_0_i_3_n_0 ),
        .O(\result[30]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[30]_INST_0_i_3 
       (.I0(in1[30]),
        .I1(in2[30]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__6_n_5 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__6_n_5 ),
        .O(\result[30]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[3]_INST_0 
       (.I0(in1[3]),
        .I1(in2[3]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[3]_INST_0_i_1_n_0 ),
        .O(result[3]));
  MUXF7 \result[3]_INST_0_i_1 
       (.I0(result_3_sn_1),
        .I1(\result[3]_INST_0_i_3_n_0 ),
        .O(\result[3]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT2 #(
    .INIT(4'h6)) 
    \result[3]_INST_0_i_10 
       (.I0(in1[0]),
        .I1(in2[0]),
        .O(\result[3]_INST_0_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[3]_INST_0_i_3 
       (.I0(in1[3]),
        .I1(in2[3]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry_n_4 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry_n_4 ),
        .O(\result[3]_INST_0_i_3_n_0 ));
  CARRY4 \result[3]_INST_0_i_5 
       (.CI(1'b0),
        .CO({\result[3]_INST_0_i_5_n_0 ,\result[3]_INST_0_i_5_n_1 ,\result[3]_INST_0_i_5_n_2 ,\result[3]_INST_0_i_5_n_3 }),
        .CYINIT(1'b0),
        .DI(in1[3:0]),
        .O(\in1[3] ),
        .S({\result[3]_INST_0_i_7_n_0 ,\result[3]_INST_0_i_8_n_0 ,\result[3]_INST_0_i_9_n_0 ,\result[3]_INST_0_i_10_n_0 }));
  LUT2 #(
    .INIT(4'h6)) 
    \result[3]_INST_0_i_7 
       (.I0(in1[3]),
        .I1(in2[3]),
        .O(\result[3]_INST_0_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \result[3]_INST_0_i_8 
       (.I0(in1[2]),
        .I1(in2[2]),
        .O(\result[3]_INST_0_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \result[3]_INST_0_i_9 
       (.I0(in1[1]),
        .I1(in2[1]),
        .O(\result[3]_INST_0_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[4]_INST_0 
       (.I0(in1[4]),
        .I1(in2[4]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[4]_INST_0_i_1_n_0 ),
        .O(result[4]));
  MUXF7 \result[4]_INST_0_i_1 
       (.I0(result_4_sn_1),
        .I1(\result[4]_INST_0_i_3_n_0 ),
        .O(\result[4]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[4]_INST_0_i_3 
       (.I0(in1[4]),
        .I1(in2[4]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__0_n_7 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__0_n_7 ),
        .O(\result[4]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[5]_INST_0 
       (.I0(in1[5]),
        .I1(in2[5]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[5]_INST_0_i_1_n_0 ),
        .O(result[5]));
  MUXF7 \result[5]_INST_0_i_1 
       (.I0(result_5_sn_1),
        .I1(\result[5]_INST_0_i_3_n_0 ),
        .O(\result[5]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[5]_INST_0_i_3 
       (.I0(in1[5]),
        .I1(in2[5]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__0_n_6 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__0_n_6 ),
        .O(\result[5]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[6]_INST_0 
       (.I0(in1[6]),
        .I1(in2[6]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[6]_INST_0_i_1_n_0 ),
        .O(result[6]));
  MUXF7 \result[6]_INST_0_i_1 
       (.I0(result_6_sn_1),
        .I1(\result[6]_INST_0_i_3_n_0 ),
        .O(\result[6]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[6]_INST_0_i_3 
       (.I0(in1[6]),
        .I1(in2[6]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__0_n_5 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__0_n_5 ),
        .O(\result[6]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[7]_INST_0 
       (.I0(in1[7]),
        .I1(in2[7]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[7]_INST_0_i_1_n_0 ),
        .O(result[7]));
  MUXF7 \result[7]_INST_0_i_1 
       (.I0(result_7_sn_1),
        .I1(\result[7]_INST_0_i_3_n_0 ),
        .O(\result[7]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[7]_INST_0_i_3 
       (.I0(in1[7]),
        .I1(in2[7]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__0_n_4 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__0_n_4 ),
        .O(\result[7]_INST_0_i_3_n_0 ));
  CARRY4 \result[7]_INST_0_i_5 
       (.CI(\result[3]_INST_0_i_5_n_0 ),
        .CO({\result[7]_INST_0_i_5_n_0 ,\result[7]_INST_0_i_5_n_1 ,\result[7]_INST_0_i_5_n_2 ,\result[7]_INST_0_i_5_n_3 }),
        .CYINIT(1'b0),
        .DI(in1[7:4]),
        .O(\in1[7] ),
        .S({\result[7]_INST_0_i_6_n_0 ,\result[7]_INST_0_i_7_n_0 ,\result[7]_INST_0_i_8_n_0 ,\result[7]_INST_0_i_9_n_0 }));
  LUT2 #(
    .INIT(4'h6)) 
    \result[7]_INST_0_i_6 
       (.I0(in1[7]),
        .I1(in2[7]),
        .O(\result[7]_INST_0_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \result[7]_INST_0_i_7 
       (.I0(in1[6]),
        .I1(in2[6]),
        .O(\result[7]_INST_0_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \result[7]_INST_0_i_8 
       (.I0(in1[5]),
        .I1(in2[5]),
        .O(\result[7]_INST_0_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \result[7]_INST_0_i_9 
       (.I0(in1[4]),
        .I1(in2[4]),
        .O(\result[7]_INST_0_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[8]_INST_0 
       (.I0(in1[8]),
        .I1(in2[8]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[8]_INST_0_i_1_n_0 ),
        .O(result[8]));
  MUXF7 \result[8]_INST_0_i_1 
       (.I0(result_8_sn_1),
        .I1(\result[8]_INST_0_i_3_n_0 ),
        .O(\result[8]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[8]_INST_0_i_3 
       (.I0(in1[8]),
        .I1(in2[8]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__1_n_7 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__1_n_7 ),
        .O(\result[8]_INST_0_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0036FFFF00360000)) 
    \result[9]_INST_0 
       (.I0(in1[9]),
        .I1(in2[9]),
        .I2(result_0_sn_1),
        .I3(\result[0]_0 ),
        .I4(ALU_op[3]),
        .I5(\result[9]_INST_0_i_1_n_0 ),
        .O(result[9]));
  MUXF7 \result[9]_INST_0_i_1 
       (.I0(result_9_sn_1),
        .I1(\result[9]_INST_0_i_3_n_0 ),
        .O(\result[9]_INST_0_i_1_n_0 ),
        .S(ALU_op[2]));
  LUT6 #(
    .INIT(64'hEFE08F8FEFE08080)) 
    \result[9]_INST_0_i_3 
       (.I0(in1[9]),
        .I1(in2[9]),
        .I2(ALU_op[1]),
        .I3(\result0_inferred__3/i__carry__1_n_6 ),
        .I4(ALU_op[0]),
        .I5(\result0_inferred__2/i__carry__1_n_6 ),
        .O(\result[9]_INST_0_i_3_n_0 ));
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
