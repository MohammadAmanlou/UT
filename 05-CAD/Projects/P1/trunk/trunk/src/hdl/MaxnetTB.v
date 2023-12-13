`timescale 1ns/1ns
module MaxnetTB;

  reg [31:0] a0, a1, a2, a3;
  reg clk, start;
  wire [31:0] Result;

  Maxnet dut (
    .a0(a0),
    .a1(a1),
    .a2(a2),
    .a3(a3),
    .clk(clk),
    .start(start),
    .Result(Result)
  );

  initial begin
    clk = 0;
    start = 0;
    a0 = 32'h4153851f; // Float32 representation of 13.22
    a1 = 32'h41366666; // Float32 representation of 11.4
    a2 = 32'h40fccccd; // Float32 representation of 7.9
    a3 = 32'h40A00000; // Float32 representation of 5.0
    
    #10;
    start = 1'b1;
    #10; // Wait for 10 time units
    start = 1'b0;
    #100
    
    $stop; // End the simulation
  end

  always begin
    #2; 
    clk = ~clk;
  end

endmodule
