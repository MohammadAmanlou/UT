`timescale 1ns/1ns
module int_ratTB ();
  reg clk=0,rst=0,start=0,run=0 ;
  wire done,fail;
  wire [1:0] move;
  always  #1 clk=~clk;
  //module one_pulser (  input clk,LP,output reg SP);
    int_rat ir(start,rst,clk,run,move,done,fail);
  initial begin
    #5 rst=1;
    #5 rst=0;
    #5 start=1;
    #10 start=0;
    #3000 run=1;
    #100 run=0;
    #10 $stop;
  end
endmodule
