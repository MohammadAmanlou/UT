`timescale 1ns/1ns
module adder_imm(PC, immediate_data, PCTarget);
    input [31:0] PC;
    input [31:0] immediate_data;
    output [31:0] PCTarget;
    wire co;
    assign {co,PCTarget} = PC+immediate_data;
endmodule