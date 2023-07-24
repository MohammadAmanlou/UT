`timescale 1ns/1ns

`include "MIPS.v"

module MIPS_TB ();
    reg clk = 1'b0, rst = 1'b0;

    MIPS mips(clk, rst);

    always #5 clk = ~clk;

    initial begin
        #1 rst = 1'b1;
        #3 rst = 1'b0;
        #4200 $stop;
    end
endmodule
