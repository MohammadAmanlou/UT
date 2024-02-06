
`timescale 1ns / 1ps
module TB();

parameter P = 4; // example parameter, adjust as needed
parameter CLOCK_PERIOD = 2; // Clock period in ns

reg clk;
reg start;
reg [8:0] X, Y, Z;
wire done;

// Instantiate the top-level module
top_level #(
    .P(P)
) uut (
    .clk(clk),
    .start(start),
    .X(X),
    .Y(Y),
    .Z(Z),
    .done(done)
);

// Clock generation
initial begin
    clk = 0;
    forever #(CLOCK_PERIOD/2) clk = ~clk;
end

// Test sequence
initial begin
    // Initialize inputs
    start = 0;
    X = 16;
    Y = 0;
    Z = 0;

    // Reset sequence
    start = 1'b1;
    #(CLOCK_PERIOD * 10); // Wait a time before de-asserting to simulate reset time
    start = 1'b0;

    
    // Check that the device finishes an operation
    wait (done == 1'b1);
    $display("Operation finished at time %t", $time);

    // Check output
    // Here we should add checking conditions for 'done' and 'ofm_write'.

    // End simulation
    #(CLOCK_PERIOD * 20); // Run simulation for a bit after finish
    $stop;
end

endmodule