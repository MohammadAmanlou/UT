`timescale 1ns/1ns
module FlipFlop(clk,rst,PCNext,PC);
    input [31:0] PCNext;
    output [31:0] PC;
    reg [31:0] PC;
    input clk,rst;
    always @(posedge clk or posedge rst) begin
        if(rst)
            PC<=32'd0;
        else
            PC <= PCNext;
    end

    
endmodule