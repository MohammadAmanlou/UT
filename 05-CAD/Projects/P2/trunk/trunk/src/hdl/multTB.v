`timescale 1ns / 1ps

module mult_testbench;

  // Testbench signals
  reg [4:0] D1;
  reg [4:0] D2;
  wire [9:0] out;
  
  // Instantiate the Device Under Test (DUT)
  mult dut(
    .D1(D1), 
    .D2(D2), 
    .out(out)
  );

  // Initial block starts only once at the very beginning of simulation
  initial begin
    // Initialize Inputs
    D1 = 0;
    D2 = 0;

    // Wait for global reset
    #100;
    
    // Apply some test vectors
    D1 = 5'b01000; D2 = 5'b10010; #100; // Test small numbers
    D1 = 5'b10010; D2 = 5'b01001; #100; // Test with some 1s and 0s
    D1 = 5'b11111; D2 = 5'b11111; #100; // Test all 1s
    D1 = 5'b10001; D2 = 5'b10001; #100; // Test edge values
    D1 = 5'b01111; D2 = 5'b00010; #100; // Test random values
    $stop;
    // Add more test cases as necessary
  end
  


endmodule
