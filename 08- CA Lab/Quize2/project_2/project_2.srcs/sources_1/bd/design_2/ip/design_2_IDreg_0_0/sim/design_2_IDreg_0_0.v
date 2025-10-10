// (c) Copyright 1995-2025 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:IDreg:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_2_IDreg_0_0 (
  clk,
  rst,
  flush,
  pc,
  WB_EN,
  MEM_R_EN,
  MEM_W_EN,
  EXE_CMD,
  B,
  S,
  Val_Rn,
  Val_Rm,
  imm,
  Shift_operand,
  Signed_imm_24,
  dest,
  status,
  src_1,
  src_2,
  pcOut,
  WB_EN_out,
  MEM_R_EN_out,
  MEM_W_EN_out,
  EXE_CMD_out,
  B_out,
  S_out,
  Val_Rn_out,
  Val_Rm_out,
  imm_out,
  Shift_operand_out,
  Signed_imm_24_out,
  dest_out,
  status_out,
  src_1_out,
  src_2_out
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN design_2_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *)
input wire rst;
input wire flush;
input wire [31 : 0] pc;
input wire WB_EN;
input wire MEM_R_EN;
input wire MEM_W_EN;
input wire [3 : 0] EXE_CMD;
input wire B;
input wire S;
input wire [31 : 0] Val_Rn;
input wire [31 : 0] Val_Rm;
input wire imm;
input wire [11 : 0] Shift_operand;
input wire [23 : 0] Signed_imm_24;
input wire [3 : 0] dest;
input wire [3 : 0] status;
input wire [3 : 0] src_1;
input wire [3 : 0] src_2;
output wire [31 : 0] pcOut;
output wire WB_EN_out;
output wire MEM_R_EN_out;
output wire MEM_W_EN_out;
output wire [3 : 0] EXE_CMD_out;
output wire B_out;
output wire S_out;
output wire [31 : 0] Val_Rn_out;
output wire [31 : 0] Val_Rm_out;
output wire imm_out;
output wire [11 : 0] Shift_operand_out;
output wire [23 : 0] Signed_imm_24_out;
output wire [3 : 0] dest_out;
output wire [3 : 0] status_out;
output wire [3 : 0] src_1_out;
output wire [3 : 0] src_2_out;

  IDreg #(
    .N(32)
  ) inst (
    .clk(clk),
    .rst(rst),
    .flush(flush),
    .pc(pc),
    .WB_EN(WB_EN),
    .MEM_R_EN(MEM_R_EN),
    .MEM_W_EN(MEM_W_EN),
    .EXE_CMD(EXE_CMD),
    .B(B),
    .S(S),
    .Val_Rn(Val_Rn),
    .Val_Rm(Val_Rm),
    .imm(imm),
    .Shift_operand(Shift_operand),
    .Signed_imm_24(Signed_imm_24),
    .dest(dest),
    .status(status),
    .src_1(src_1),
    .src_2(src_2),
    .pcOut(pcOut),
    .WB_EN_out(WB_EN_out),
    .MEM_R_EN_out(MEM_R_EN_out),
    .MEM_W_EN_out(MEM_W_EN_out),
    .EXE_CMD_out(EXE_CMD_out),
    .B_out(B_out),
    .S_out(S_out),
    .Val_Rn_out(Val_Rn_out),
    .Val_Rm_out(Val_Rm_out),
    .imm_out(imm_out),
    .Shift_operand_out(Shift_operand_out),
    .Signed_imm_24_out(Signed_imm_24_out),
    .dest_out(dest_out),
    .status_out(status_out),
    .src_1_out(src_1_out),
    .src_2_out(src_2_out)
  );
endmodule
