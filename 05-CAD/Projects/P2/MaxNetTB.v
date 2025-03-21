`timescale 1ns/1ns
module MaxnetTB;

  reg [4:0] a0, a1, a2, a3;
  reg clk, start , rst;
  wire [4:0] Result;

  Maxnet dut (
    .a0(a0),
    .a1(a1),
    .a2(a2),
    .a3(a3),
    .clk(clk),
    .start(start),
    .rst(rst),
    .Result(Result)
  );

  initial begin
    clk = 0;
    start = 0;
    rst = 0;
    a0 = 5'b00011; 
    a1 = 5'b00100; 
    a2 = 5'b00110 ; 
    a3 = 5'b01000 ; 
    #5
    rst = 1;
    #5
    rst = 0;
    
    #10;
    start = 1'b1;
    #10; // Wait for 10 time units
    start = 1'b0;
    #10000
    
    $stop; // End the simulation
  end

  always begin
    #2; 
    clk = ~clk;
  end

endmodule

