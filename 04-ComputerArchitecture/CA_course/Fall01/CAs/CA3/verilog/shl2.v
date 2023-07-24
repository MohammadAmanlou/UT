module shl2 (d_in, d_out);
  input [31:0] d_in;
  output [31:0] d_out;
  
  assign d_out = d_in << 2;
  
endmodule
