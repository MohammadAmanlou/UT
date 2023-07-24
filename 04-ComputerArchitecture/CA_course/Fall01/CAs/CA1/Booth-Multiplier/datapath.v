module datapath (data_in, addorsub, ldY, clrE, ldE, clrA, ldA, shA, ldX, shX, sel, clk, x0, x1, data_out);
  input [4:0] data_in;
  input ldY, clrE, ldE, clrA, ldA, shA, ldX, shX, sel, clk, addorsub;
  output x1,x0;
  output [4:0] data_out;
  
  wire [4:0] a_out, y_out, x_out, sum;
  wire cout;
  
  adder add_4b (a_out, y_out, 1'b0, addorsub , cout, sum);
  
  reg_5b Y(data_in, ldY, clk, y_out);
  
  dff E(x1 , clrE, ldE, clk, x0);
  
  shreg_5b A(sum, a_out[4], clrA, ldA, shA, clk, a_out);
  
  shreg_5b X(data_in, a_out[0], 1'b0, ldX, shX, clk, x_out);
  
  mux_2_to_1 mux(a_out, x_out, sel , data_out);
  
  assign x1 = x_out[0];
 
endmodule  

