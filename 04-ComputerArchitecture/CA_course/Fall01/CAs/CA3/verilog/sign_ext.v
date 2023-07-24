module sign_ext (d_in, d_out);
  input [15:0] d_in;
  output [31:0] d_out;
  
  assign d_out = {{16{d_in[15]}}, d_in};
  
endmodule