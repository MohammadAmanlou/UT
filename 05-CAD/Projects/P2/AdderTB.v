`timescale 1ns/1ps

module ParamAdder_tb;

parameter N = 5;

// Testbench uses same parameter N as the ParamAdder
reg [N-1:0] a;
reg [N-1:0] b;
reg cin;
wire [N-1:0] s;
wire cout;

ParamAdder #(N) uut ( .a(a), .b(b), .cin(cin), .s(s), .cout(cout) );

initial begin
    // Initialize all inputs
    a = 0; b = 0; cin = 0;

    // Wait for global reset to finish
    #100;

    // Add stimulus here
    a = 5'b10101; b = 5'b01010; cin = 0;
    #10; // Wait 10 time units; may need to be adjusted based on the operation speed

    a = 5'b11111; b = 5'b00001; cin = 1;
    #10;

    a = 5'b00100; b = 5'b00111; cin = 0;
    #10;
    
    // Continue for more test cases as needed

    $stop; // End simulation
end

// Optional: display results during simulation
initial begin
    $monitor("Time = %d, a=%b b=%b cin=%b : sum=%b cout=%b", $time, a, b, cin, s, cout);
end

endmodule
