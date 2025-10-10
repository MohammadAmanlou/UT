`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2025 09:14:15 AM
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb(

    );
    
    /*
    clk_0,
    instructionOut_0,
    pcOut_0,
    rst_0
    */
    reg clk;
    //wire [31:0] instruction;
    //wire [31:0] pc;
    reg rst;
    design_2_wrapper TopModule
           (.clk_0(clk),
            //.instructionOut_0(instruction),
            //.pcOut_0(pc),
            .rst_0(rst)
            //.has_forwarding_unit_0(1'b1)
            );
    
    always #5 clk = ~clk;

    initial begin
        clk=0;
        rst=0;
        #10 rst = 1;
        #20 rst = 0;
        #4000 $stop;
    end
endmodule
