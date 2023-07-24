module mux2to1_5b (i0, i1, sel, y);
  input [4:0] i0, i1;
  input sel;
  
  output [4:0] y;

  assign y = (sel==1'b1) ? i1 : i0;
  
endmodule
