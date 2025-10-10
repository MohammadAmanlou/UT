//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Sun May 25 18:04:44 2025
//Host        : Ariyan running 64-bit major release  (build 9200)
//Command     : generate_target design_2.bd
//Design      : design_2
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_2,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_2,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=43,numReposBlks=43,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=22,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_2.hwdef" *) 
module design_2
   (clk_0,
    rst_0);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_0, ASSOCIATED_RESET rst_0, CLK_DOMAIN design_2_clk_0, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000" *) input clk_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RST_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RST_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input rst_0;

  wire [3:0]ALU_0_NZCV;
  wire [31:0]ALU_0_result;
  wire [31:0]Adder_0_out;
  wire CUMUX_0_B_out;
  wire [3:0]CUMUX_0_EXE_CMD_out;
  wire CUMUX_0_MEM_R_EN_out;
  wire CUMUX_0_MEM_W_EN_out;
  wire CUMUX_0_S_out;
  wire CUMUX_0_WB_EN_out;
  wire ConditionCheck_0_condOut;
  wire ControlUnit_0_B;
  wire [3:0]ControlUnit_0_EXE_CMD;
  wire ControlUnit_0_MEM_R_EN;
  wire ControlUnit_0_MEM_W_EN;
  wire ControlUnit_0_S;
  wire ControlUnit_0_WB_EN;
  wire [31:0]ExeReg_0_ALU_Res_out;
  wire ExeReg_0_MEM_R_EN_out;
  wire ExeReg_0_MEM_W_EN_out;
  wire [31:0]ExeReg_0_Val_Rm_out;
  wire ExeReg_0_WB_EN_out;
  wire [3:0]ExeReg_0_dest_out;
  wire [31:0]Exe_Mux_1_out;
  wire [31:0]Exe_Mux_2_out;
  wire [1:0]ForwardingUnit_0_ForwardA;
  wire [1:0]ForwardingUnit_0_ForwardB;
  wire Freeze_dout;
  wire [3:0]IDreg_0_EXE_CMD_out;
  wire IDreg_0_MEM_R_EN_out;
  wire IDreg_0_MEM_W_EN_out;
  wire IDreg_0_S_out;
  wire [11:0]IDreg_0_Shift_operand_out;
  wire [23:0]IDreg_0_Signed_imm_24_out;
  wire [31:0]IDreg_0_Val_Rm_out;
  wire [31:0]IDreg_0_Val_Rn_out;
  wire IDreg_0_WB_EN_out;
  wire [3:0]IDreg_0_dest_out;
  wire IDreg_0_imm_out;
  wire [31:0]IDreg_0_pcOut;
  wire [3:0]IDreg_0_src_1_out;
  wire [3:0]IDreg_0_src_2_out;
  wire [3:0]IDreg_0_status_out;
  wire [31:0]IFreg_instructionOut;
  wire [31:0]IFreg_pcOut;
  wire [31:0]MEM_Stage_Reg_0_ALU_Res_out;
  wire MEM_Stage_Reg_0_MEM_R_EN_out;
  wire MEM_Stage_Reg_0_WB_EN_out;
  wire [31:0]MEM_Stage_Reg_0_data_mem_out;
  wire [3:0]MEM_Stage_Reg_0_dest_out;
  wire [31:0]Mux2to1_0_out;
  wire [31:0]Mux_cyan_out0;
  wire [7:0]OR_mod_Res;
  wire [31:0]PC_out;
  wire [3:0]RD_slice_Dout;
  wire [31:0]RedAdder_0_out;
  wire [3:0]RegMux_0_mOut;
  wire [31:0]RegisterFile_0_R0;
  wire [31:0]RegisterFile_0_R1;
  wire [31:0]RegisterFile_0_R2;
  wire [31:0]RegisterFile_0_R3;
  wire [31:0]RegisterFile_0_R4;
  wire [31:0]RegisterFile_0_R5;
  wire [31:0]RegisterFile_0_R6;
  wire [31:0]RegisterFile_0_Val_Rm;
  wire [31:0]RegisterFile_0_Val_Rn;
  wire [3:0]Rm_slice_Dout;
  wire [3:0]StatusReg_0_status_out;
  wire [31:0]Val2Gen_0_Val2;
  wire [0:0]carry_in_slice_Dout;
  wire clk_0_1;
  wire [0:0]cond_hazard_or_1_Res;
  wire [31:0]data_mem_spo;
  wire [0:0]debouncer_0_SIGNAL_O;
  wire [3:0]dest_slice_Dout;
  wire [31:0]dist_mem_gen_0_spo;
  wire flush_dout;
  wire [3:0]opcode_slice_Dout;
  wire rst_0_1;
  wire [11:0]shift_operand_slice_Dout;
  wire [23:0]signed_imm_24_slice_Dout;
  wire [0:0]two_src_or_Res;
  wire [0:0]util_vector_logic_0_Res;
  wire [0:0]util_vector_logic_0_Res1;
  wire [0:0]vio_forward_en_probe_out0;
  wire [31:0]xlconstant_0_dout;
  wire [12:0]xlslice_0_Dout;
  wire [0:0]xlslice_0_Dout1;
  wire [3:0]xlslice_1_Dout;

  assign clk_0_1 = clk_0;
  assign rst_0_1 = rst_0;
  design_2_ALU_0_0 ALU_0
       (.ALU_op(IDreg_0_EXE_CMD_out),
        .NZCV(ALU_0_NZCV),
        .carry_in(carry_in_slice_Dout),
        .in1(Exe_Mux_1_out),
        .in2(Val2Gen_0_Val2),
        .result(ALU_0_result));
  design_2_Adder_0 Adder
       (.a(xlconstant_0_dout),
        .b(PC_out),
        .out(Adder_0_out));
  design_2_CUMUX_0_0 CUMUX_0
       (.B(ControlUnit_0_B),
        .B_out(CUMUX_0_B_out),
        .EXE_CMD(ControlUnit_0_EXE_CMD),
        .EXE_CMD_out(CUMUX_0_EXE_CMD_out),
        .MEM_R_EN(ControlUnit_0_MEM_R_EN),
        .MEM_R_EN_out(CUMUX_0_MEM_R_EN_out),
        .MEM_W_EN(ControlUnit_0_MEM_W_EN),
        .MEM_W_EN_out(CUMUX_0_MEM_W_EN_out),
        .S(ControlUnit_0_S),
        .S_out(CUMUX_0_S_out),
        .WB_EN(ControlUnit_0_WB_EN),
        .WB_EN_out(CUMUX_0_WB_EN_out),
        .imm(1'b0),
        .sel(cond_hazard_or_1_Res));
  design_2_ConditionCheck_0_0 ConditionCheck_0
       (.condOut(ConditionCheck_0_condOut),
        .opcode(opcode_slice_Dout),
        .status(StatusReg_0_status_out));
  design_2_ControlUnit_0_0 ControlUnit_0
       (.B(ControlUnit_0_B),
        .EXE_CMD(ControlUnit_0_EXE_CMD),
        .MEM_R_EN(ControlUnit_0_MEM_R_EN),
        .MEM_W_EN(ControlUnit_0_MEM_W_EN),
        .S(ControlUnit_0_S),
        .WB_EN(ControlUnit_0_WB_EN),
        .instruction(IFreg_instructionOut));
  design_2_ExeReg_0_0 ExeReg_0
       (.ALU_Res(ALU_0_result),
        .ALU_Res_out(ExeReg_0_ALU_Res_out),
        .MEM_R_EN(IDreg_0_MEM_R_EN_out),
        .MEM_R_EN_out(ExeReg_0_MEM_R_EN_out),
        .MEM_W_EN(IDreg_0_MEM_W_EN_out),
        .MEM_W_EN_out(ExeReg_0_MEM_W_EN_out),
        .Val_Rm(Exe_Mux_2_out),
        .Val_Rm_out(ExeReg_0_Val_Rm_out),
        .WB_EN(IDreg_0_WB_EN_out),
        .WB_EN_out(ExeReg_0_WB_EN_out),
        .clk(clk_0_1),
        .dest(IDreg_0_dest_out),
        .dest_out(ExeReg_0_dest_out),
        .rst(debouncer_0_SIGNAL_O));
  design_2_Exe_Mux_0_0 Exe_Mux_1
       (.ALU_res(ExeReg_0_ALU_Res_out),
        .WB_value(Mux_cyan_out0),
        .out(Exe_Mux_1_out),
        .sel(ForwardingUnit_0_ForwardA),
        .val(IDreg_0_Val_Rn_out));
  design_2_Exe_Mux_0_1 Exe_Mux_2
       (.ALU_res(ExeReg_0_ALU_Res_out),
        .WB_value(Mux_cyan_out0),
        .out(Exe_Mux_2_out),
        .sel(ForwardingUnit_0_ForwardB),
        .val(IDreg_0_Val_Rm_out));
  design_2_ForwardingUnit_0_0 ForwardingUnit_0
       (.ForwardA(ForwardingUnit_0_ForwardA),
        .ForwardB(ForwardingUnit_0_ForwardB),
        .MEM_DEST(ExeReg_0_dest_out),
        .MEM_WB_EN(ExeReg_0_WB_EN_out),
        .WB_DEST(MEM_Stage_Reg_0_dest_out),
        .WB_WB_EN(MEM_Stage_Reg_0_WB_EN_out),
        .src1(IDreg_0_src_1_out),
        .src2(IDreg_0_src_2_out));
  design_2_FourConstant_0 FourConstant
       (.dout(xlconstant_0_dout));
  design_2_HazardUnitDetector_0_0 HazardUnitDetector_0
       (.Exe_Dest(IDreg_0_dest_out),
        .Exe_MEM_R_EN(IDreg_0_MEM_R_EN_out),
        .Exe_WB_EN(IDreg_0_WB_EN_out),
        .Mem_Dest(ExeReg_0_dest_out),
        .Mem_WB_EN(ExeReg_0_WB_EN_out),
        .has_forwarding_unit(vio_forward_en_probe_out0),
        .hazard_detected(Freeze_dout),
        .is_two_source(two_src_or_Res),
        .register_file_mux_out(RegMux_0_mOut),
        .rn(xlslice_1_Dout));
  design_2_IDreg_0_0 IDreg_0
       (.B(CUMUX_0_B_out),
        .B_out(flush_dout),
        .EXE_CMD(CUMUX_0_EXE_CMD_out),
        .EXE_CMD_out(IDreg_0_EXE_CMD_out),
        .MEM_R_EN(CUMUX_0_MEM_R_EN_out),
        .MEM_R_EN_out(IDreg_0_MEM_R_EN_out),
        .MEM_W_EN(CUMUX_0_MEM_W_EN_out),
        .MEM_W_EN_out(IDreg_0_MEM_W_EN_out),
        .S(CUMUX_0_S_out),
        .S_out(IDreg_0_S_out),
        .Shift_operand(shift_operand_slice_Dout),
        .Shift_operand_out(IDreg_0_Shift_operand_out),
        .Signed_imm_24(signed_imm_24_slice_Dout),
        .Signed_imm_24_out(IDreg_0_Signed_imm_24_out),
        .Val_Rm(RegisterFile_0_Val_Rm),
        .Val_Rm_out(IDreg_0_Val_Rm_out),
        .Val_Rn(RegisterFile_0_Val_Rn),
        .Val_Rn_out(IDreg_0_Val_Rn_out),
        .WB_EN(CUMUX_0_WB_EN_out),
        .WB_EN_out(IDreg_0_WB_EN_out),
        .clk(clk_0_1),
        .dest(dest_slice_Dout),
        .dest_out(IDreg_0_dest_out),
        .flush(flush_dout),
        .imm(xlslice_0_Dout1),
        .imm_out(IDreg_0_imm_out),
        .pc(IFreg_pcOut),
        .pcOut(IDreg_0_pcOut),
        .rst(debouncer_0_SIGNAL_O),
        .src_1(xlslice_1_Dout),
        .src_1_out(IDreg_0_src_1_out),
        .src_2(RegMux_0_mOut),
        .src_2_out(IDreg_0_src_2_out),
        .status(StatusReg_0_status_out),
        .status_out(IDreg_0_status_out));
  design_2_IFreg_0 IFreg
       (.clk(clk_0_1),
        .flush(flush_dout),
        .freeze(Freeze_dout),
        .instruction(dist_mem_gen_0_spo),
        .instructionOut(IFreg_instructionOut),
        .pc(Adder_0_out),
        .pcOut(IFreg_pcOut),
        .rst(debouncer_0_SIGNAL_O));
  design_2_MEM_Stage_Reg_0_0 MEM_Stage_Reg_0
       (.ALU_Res(ExeReg_0_ALU_Res_out),
        .ALU_Res_out(MEM_Stage_Reg_0_ALU_Res_out),
        .MEM_R_EN(ExeReg_0_MEM_R_EN_out),
        .MEM_R_EN_out(MEM_Stage_Reg_0_MEM_R_EN_out),
        .WB_EN(ExeReg_0_WB_EN_out),
        .WB_EN_out(MEM_Stage_Reg_0_WB_EN_out),
        .clk(clk_0_1),
        .data_mem(data_mem_spo),
        .data_mem_out(MEM_Stage_Reg_0_data_mem_out),
        .dest(ExeReg_0_dest_out),
        .dest_out(MEM_Stage_Reg_0_dest_out),
        .rst(debouncer_0_SIGNAL_O));
  design_2_Mux_0 Mux
       (.a(Adder_0_out),
        .b(RedAdder_0_out),
        .out0(Mux2to1_0_out),
        .select(flush_dout));
  design_2_Mux_1 Mux_cyan
       (.a(MEM_Stage_Reg_0_ALU_Res_out),
        .b(MEM_Stage_Reg_0_data_mem_out),
        .out0(Mux_cyan_out0),
        .select(MEM_Stage_Reg_0_MEM_R_EN_out));
  design_2_util_vector_logic_0_1 OR_mod
       (.Op1({IDreg_0_MEM_W_EN_out,IDreg_0_MEM_W_EN_out,IDreg_0_MEM_W_EN_out,IDreg_0_MEM_W_EN_out,IDreg_0_MEM_W_EN_out,IDreg_0_MEM_W_EN_out,IDreg_0_MEM_W_EN_out,IDreg_0_MEM_W_EN_out}),
        .Op2({IDreg_0_MEM_R_EN_out,IDreg_0_MEM_R_EN_out,IDreg_0_MEM_R_EN_out,IDreg_0_MEM_R_EN_out,IDreg_0_MEM_R_EN_out,IDreg_0_MEM_R_EN_out,IDreg_0_MEM_R_EN_out,IDreg_0_MEM_R_EN_out}),
        .Res(OR_mod_Res));
  design_2_PC_0 PC
       (.clk(clk_0_1),
        .freeze(Freeze_dout),
        .in(Mux2to1_0_out),
        .outReg(PC_out),
        .rst(debouncer_0_SIGNAL_O));
  design_2_xlslice_2_0 RD_slice
       (.Din(IFreg_instructionOut),
        .Dout(RD_slice_Dout));
  design_2_RedAdder_0_0 RedAdder_0
       (.a(IDreg_0_Signed_imm_24_out),
        .b(IDreg_0_pcOut),
        .out(RedAdder_0_out));
  design_2_RegMux_0_0 RegMux_0
       (.MEM_W_EN(ControlUnit_0_MEM_W_EN),
        .in0(Rm_slice_Dout),
        .in1(RD_slice_Dout),
        .mOut(RegMux_0_mOut));
  design_2_RegisterFile_0_0 RegisterFile_0
       (.R0(RegisterFile_0_R0),
        .R1(RegisterFile_0_R1),
        .R2(RegisterFile_0_R2),
        .R3(RegisterFile_0_R3),
        .R4(RegisterFile_0_R4),
        .R5(RegisterFile_0_R5),
        .R6(RegisterFile_0_R6),
        .Val_Rm(RegisterFile_0_Val_Rm),
        .Val_Rn(RegisterFile_0_Val_Rn),
        .WB_Dest(MEM_Stage_Reg_0_dest_out),
        .WB_Value(Mux_cyan_out0),
        .WB_WB_EN(MEM_Stage_Reg_0_WB_EN_out),
        .clk(clk_0_1),
        .rm(RegMux_0_mOut),
        .rn(xlslice_1_Dout),
        .rst(debouncer_0_SIGNAL_O));
  design_2_xlslice_3_0 Rm_slice
       (.Din(IFreg_instructionOut),
        .Dout(Rm_slice_Dout));
  design_2_StatusReg_0_0 StatusReg_0
       (.clk(clk_0_1),
        .rst(debouncer_0_SIGNAL_O),
        .s(IDreg_0_S_out),
        .status_bits(ALU_0_NZCV),
        .status_out(StatusReg_0_status_out));
  design_2_Val2Gen_0_0 Val2Gen_0
       (.I(IDreg_0_imm_out),
        .Shift_operand(IDreg_0_Shift_operand_out),
        .Shift_type(OR_mod_Res[0]),
        .Val2(Val2Gen_0_Val2),
        .Val_Rm(Exe_Mux_2_out));
  design_2_xlslice_0_1 carry_in_slice
       (.Din(IDreg_0_status_out),
        .Dout(carry_in_slice_Dout));
  design_2_util_vector_logic_1_0 cond_hazard_or_1
       (.Op1(util_vector_logic_0_Res),
        .Op2(Freeze_dout),
        .Res(cond_hazard_or_1_Res));
  design_2_util_vector_logic_0_0 cond_not
       (.Op1(ConditionCheck_0_condOut),
        .Res(util_vector_logic_0_Res));
  design_2_dist_mem_gen_1_0 data_mem
       (.a(ExeReg_0_ALU_Res_out[12:0]),
        .clk(clk_0_1),
        .d(ExeReg_0_Val_Rm_out),
        .spo(data_mem_spo),
        .we(ExeReg_0_MEM_W_EN_out));
  design_2_debouncer_0_0 debouncer_0
       (.CLK_I(clk_0_1),
        .SIGNAL_I(rst_0_1),
        .SIGNAL_O(debouncer_0_SIGNAL_O));
  design_2_xlslice_2_1 dest_slice
       (.Din(IFreg_instructionOut),
        .Dout(dest_slice_Dout));
  design_2_xlconstant_0_0 forward_en_0
       ();
  design_2_ila_0_0 ila_0
       (.clk(clk_0_1),
        .probe0(RegisterFile_0_R0),
        .probe1(RegisterFile_0_R1),
        .probe2(RegisterFile_0_R2),
        .probe3(RegisterFile_0_R3),
        .probe4(RegisterFile_0_R4),
        .probe5(RegisterFile_0_R5),
        .probe6(RegisterFile_0_R6),
        .probe7(debouncer_0_SIGNAL_O));
  design_2_dist_mem_gen_0_0 instruction_mem
       (.a(xlslice_0_Dout),
        .spo(dist_mem_gen_0_spo));
  design_2_xlslice_0_0 instruction_mem_address_slice
       (.Din(PC_out),
        .Dout(xlslice_0_Dout));
  design_2_xlslice_2_2 opcode_slice
       (.Din(IFreg_instructionOut),
        .Dout(opcode_slice_Dout));
  design_2_xlslice_1_0 rn_slice
       (.Din(IFreg_instructionOut),
        .Dout(xlslice_1_Dout));
  design_2_xlslice_4_0 shift_operand_slice
       (.Din(IFreg_instructionOut),
        .Dout(shift_operand_slice_Dout));
  design_2_xlslice_3_1 signed_imm_24_slice
       (.Din(IFreg_instructionOut),
        .Dout(signed_imm_24_slice_Dout));
  design_2_util_vector_logic_0_2 two_src_or
       (.Op1(util_vector_logic_0_Res1),
        .Op2(ControlUnit_0_MEM_W_EN),
        .Res(two_src_or_Res));
  design_2_util_vector_logic_0_3 util_vector_logic_0
       (.Op1(xlslice_0_Dout1),
        .Res(util_vector_logic_0_Res1));
  design_2_vio_0_0 vio_forward_en
       (.clk(clk_0_1),
        .probe_out0(vio_forward_en_probe_out0));
  design_2_xlslice_0_2 xlslice_0
       (.Din(IFreg_instructionOut),
        .Dout(xlslice_0_Dout1));
endmodule
