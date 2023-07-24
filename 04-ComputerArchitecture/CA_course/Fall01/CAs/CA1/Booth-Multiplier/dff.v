module dff (d, sclr, ld, clk, q);
  input d, sclr, ld, clk;
  output q;
  reg q;
  
  always @(posedge clk)
    if (sclr)
      q <= 1'b0;
    else if (ld)
      q <= d;
      
endmodule
