module mux_2_to_1 (i0, i1, sel , y);
  input [4:0] i0, i1;
  input sel;
  output [4:0] y;
  
  assign y = sel ? i1 : i0;
  
endmodule
