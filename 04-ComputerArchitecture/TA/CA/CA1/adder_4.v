`timescale 1ns/1ns
module adder_4(PC, PCPlus4);
    input [31:0] PC;
    output [31:0] PCPlus4;
    wire co;
    assign {co,PCPlus4} = PC + 32'd4;
endmodule