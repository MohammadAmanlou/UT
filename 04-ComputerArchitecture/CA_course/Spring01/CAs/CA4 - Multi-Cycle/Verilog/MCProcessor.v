`include "Cpu.v"
`include "Memory.v"

module MCProcessor (clk, rst);
    input clk, rst;

    wire [15:0] memData, memWriteData;
    wire [11:0] memAdr;
    wire memRead, memWrite;

    Cpu cpu(memData, clk, rst, memAdr, memWriteData, memWrite, memRead);
    Memory memory(memAdr, memWriteData, memRead, memWrite, clk, memData);
endmodule
