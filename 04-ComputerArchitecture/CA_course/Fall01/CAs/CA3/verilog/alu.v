module alu (a, b, ctrl, y, zero);
  input [31:0] a, b;
  input [2:0] ctrl;
  output [31:0] y;
  output zero;
  
  assign y =  (ctrl == 3'b000) ? (a & b) :
              (ctrl == 3'b001) ? (a | b) : 
              (ctrl == 3'b010) ? (a + b) :
              (ctrl == 3'b110) ? (a - b) : 
              ((a[31]==1&&b[31]==0)? 32'd0 : (a[31]==0&&b[31]==1) ? 32'd1 : (a>b) ? 32'd1 : 32'd0); //caculate signed number
  
  assign zero = (y == 32'd0) ? 1'b1 : 1'b0;
  
endmodule