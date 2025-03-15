`timescale 1ns/1ns
module datapath(clk, rst, RegWrite, MemWrite, ResultSrc, PCSrc, ALUSrc2, ALUControl,ImmSrc, lt ,bge, zero, opcode, func3, func7);
    input clk, rst, RegWrite, MemWrite;
    input[1:0] ResultSrc, PCSrc, ALUSrc2;
    input[2:0] ALUControl, ImmSrc;
    output [6:0] opcode;
    output lt, bge, zero;
    output[2:0] func3;
    output[6:0] func7;
    wire[31:0] ALUResult, PCPlus4, PCTarget, PCNext, PC, instr, Result, WD, RD1, RD2, ImmExt;
    wire[31:0] SrcB, ReadData;
    wire [4:0] A1, A2, A3;

    assign A1 = instr[19:15];
    assign A2 = instr[24:20];
    assign A3 = instr[11:7];
    assign WD = Result;
    assign opcode = instr[6:0];
    assign func3 = instr[14:12];
    assign func7 = instr[31:25];


    mux3 pc_selector(PCSrc, PCPlus4, PCTarget, Result, PCNext);
    FlipFlop pc_generator(clk, rst, PCNext, PC);
    InstructionMemory inst_mem(PC, instr);
    regfile register_file(clk,rst, RegWrite, A1, A2, A3, WD, RD1, RD2);
    // mux2 src2_abs_selector(AbsSrc, RD2, ImmExt, Src2Abs);
    // ABS abss_calc(RD1, Src2Abs, RD1Abs, RD2Abs);
    // mux2 src1_alu_selector(ALUSrc1, RD1Abs, RD1, SrcA);
    mux2 src1_alu_selector(ALUSrc2, RD2,ImmExt, SrcB);
    // mux3 src2_alu_selector(ALUSrc2, RD2, ImmExt, RD2Abs, SrcB);
    ALU alu_comp(RD1, SrcB, ALUControl, ALUResult, zero, bge, lt);
    DataMemory data_mem(ALUResult, RD2, MemWrite, clk, ReadData);
    mux4 result_selector(ResultSrc, ALUResult, ReadData, PCPlus4, ImmExt, Result);
    adder_4 pc_updator(PC, PCPlus4);
    extension_unit extnd(instr, ImmSrc, ImmExt);
    adder_imm pc_target_counter(PC, ImmExt, PCTarget);
endmodule