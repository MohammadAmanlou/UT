module multiplier (data_in, rst, start, clk, data_out, done);
  input [4:0] data_in;
  input rst, start, clk;
  output [4:0] data_out;
  output done;
  
  wire ldY, clrE, ldE, clrA, ldA, shA, ldX, shX, sel, x0, x1, addsub;

  datapath   dp(data_in, addsub, ldY, clrE, ldE, clrA, ldA, shA, ldX, shX, sel, clk, x0, x1, data_out);

  controller cu(start, x0, x1 ,rst, clk, ldY, ldE, clrE, clrA, ldA, shA, ldX, shX, sel, done, addsub);
  
endmodule

