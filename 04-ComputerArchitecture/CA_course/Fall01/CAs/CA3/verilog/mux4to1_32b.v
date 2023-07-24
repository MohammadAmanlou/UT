module mux4to1_32b (i0, i1, i2, i3,sel, y);
  input [31:0] i0, i1, i2,i3;
  input [1:0]sel;
  output [31:0] y;
  
  assign y = (sel==2'b11) ? i3 :
             (sel==2'b10) ? i2 :
             (sel==2'b01) ? i1 :
             (sel==2'b00) ? i0 :  31'd0;
             
  
endmodule



