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


// IP VLNV: xilinx.com:module_ref:HazardUnitDetector:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_2_HazardUnitDetector_0_0 (
  rn,
  register_file_mux_out,
  Exe_Dest,
  Exe_WB_EN,
  Exe_MEM_R_EN,
  Mem_Dest,
  Mem_WB_EN,
  is_two_source,
  has_forwarding_unit,
  hazard_detected
);

input wire [3 : 0] rn;
input wire [3 : 0] register_file_mux_out;
input wire [3 : 0] Exe_Dest;
input wire Exe_WB_EN;
input wire Exe_MEM_R_EN;
input wire [3 : 0] Mem_Dest;
input wire Mem_WB_EN;
input wire is_two_source;
input wire has_forwarding_unit;
output wire hazard_detected;

  HazardUnitDetector inst (
    .rn(rn),
    .register_file_mux_out(register_file_mux_out),
    .Exe_Dest(Exe_Dest),
    .Exe_WB_EN(Exe_WB_EN),
    .Exe_MEM_R_EN(Exe_MEM_R_EN),
    .Mem_Dest(Mem_Dest),
    .Mem_WB_EN(Mem_WB_EN),
    .is_two_source(is_two_source),
    .has_forwarding_unit(has_forwarding_unit),
    .hazard_detected(hazard_detected)
  );
endmodule
