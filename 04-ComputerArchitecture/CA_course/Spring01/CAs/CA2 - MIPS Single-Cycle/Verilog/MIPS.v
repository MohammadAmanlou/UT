`include "Cpu.v"
`include "InstructionMemory.v"
`include "DataMemory.v"

module MIPS (clk, rst);
    input clk, rst;

    wire [31:0] pc, inst, memReadData, memAdr, memWriteData;
    wire memRead, memWrite;

    Cpu cpu(inst, memReadData, clk, rst, pc, memAdr, memWriteData, memRead, memWrite);
    InstructionMemory instMem(pc, inst);
    DataMemory dataMem(memAdr, memWriteData, memRead, memWrite, clk, memReadData);
endmodule
