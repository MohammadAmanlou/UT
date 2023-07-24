module reg_5b(d, ld, clk, q);
  input [4:0] d;
  input ld, clk;
  output [4:0] q;
  reg [4:0] q;
  
  always @(posedge clk)
    if (ld)
      q <= d;
  
endmodule
