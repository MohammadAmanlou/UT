`timescale 1ns/1ns

`include "MIPS.v"

module MIPS_TB ();
    reg clk = 1'b0, rst = 1'b0;

    MIPS mips(clk, rst);

    always #10 clk = ~clk;

    initial begin
        #2 rst = 1'b1;
        #5 rst = 1'b0;
        #3500 $stop;
    end
endmodule
