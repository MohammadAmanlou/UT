`include "Adder.v"
`include "ALU.v"
`include "Mux2To1.v"
`include "Register.v"
`include "RegisterFile.v"

module CpuDatapath (inst, memReadData, pcOrMemAlu, regDst, link, regWrite,
                    aluSrc, pcSrc, jumpReg, jump, memToReg, aluOp, clk, rst,
                    zero, pc, memAdr, memWriteData);
    input [31:0] inst, memReadData;
    input pcOrMemAlu, regDst, link, regWrite, aluSrc, pcSrc, jumpReg, jump, memToReg;
    input [2:0] aluOp;
    input clk, rst;
    output zero;
    output [31:0] pc, memAdr, memWriteData;

    wire [31:0] pcValue, pcIncremented, newPc, beqPc, signExtendedInstLsbs, shiftedInstLsbs, beqOrIncrementedPc,
                jumpAdr, jOrJrAdr, regReadData1, regReadData2;

    assign signExtendedInstLsbs = {{16{inst[15]}}, inst[15:0]};
    assign shiftedInstLsbs = signExtendedInstLsbs << 2;
    assign jumpAdr = {pcIncremented[31:28], inst[25:0], 2'b00};

    Register #(32) pcReg(.in(newPc), .ld(1'b1), .sclr(1'b0), .clk(clk), .rst(rst), .out(pcValue));
    Adder    #(32) pcIncrementer(.a(pcValue), .b(32'd4), .res(pcIncremented));
    Adder    #(32) beqPcCalculator(.a(pcIncremented), .b(shiftedInstLsbs), .res(beqPc));
    Mux2To1  #(32) beqOrIncrementedPcMux(.a0(pcIncremented), .a1(beqPc), .sel(pcSrc), .out(beqOrIncrementedPc));
    Mux2To1  #(32) jOrJrAdrMux(.a0(jumpAdr), .a1(regReadData1), .sel(jumpReg), .out(jOrJrAdr));
    Mux2To1  #(32) finalPcMux(.a0(beqOrIncrementedPc), .a1(jOrJrAdr), .sel(jump), .out(newPc));

    wire [4:0] readReg1, readReg2, writeReg, regDstMuxOut;
    wire [31:0] regWriteData, memOrALUOut, aluOut;

    assign readReg1 = inst[25:21];
    assign readReg2 = inst[20:16];

    Mux2To1 #(5)  linkMux(.a0(regDstMuxOut), .a1(5'd31), .sel(link), .out(writeReg));
    Mux2To1 #(5)  regDstMux(.a0(inst[20:16]), .a1(inst[15:11]), .sel(regDst), .out(regDstMuxOut));
    Mux2To1 #(32) memOrALUOutMux(.a0(aluOut), .a1(memReadData), .sel(memToReg), .out(memOrALUOut));
    Mux2To1 #(32) regWriteDataMux(.a0(pcIncremented), .a1(memOrALUOut), .sel(pcOrMemAlu), .out(regWriteData));

    RegisterFile #(.WordCount(32), .WordLen(32)) regFile(.readRegister1(readReg1), .readRegister2(readReg2),
                                                         .writeRegister(writeReg), .writeData(regWriteData),
                                                         .regWrite(regWrite), .sclr(1'b0), .clk(clk), .rst(rst),
                                                         .readData1(regReadData1), .readData2(regReadData2));

    wire [31:0] aluSecondInput;

    Mux2To1 #(32) aluSecondInputMux(.a0(regReadData2), .a1(signExtendedInstLsbs), .sel(aluSrc), .out(aluSecondInput));
    ALU     #(32) alu(.a(regReadData1), .b(aluSecondInput), .opc(aluOp), .res(aluOut), .zero(zero));

    assign pc = pcValue;
    assign memWriteData = regReadData2;
    assign memAdr = aluOut;
endmodule
