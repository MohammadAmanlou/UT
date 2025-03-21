`timescale 1ns/1ns
module TB();

reg clk;
reg start;
reg [8:0] X, Y, Z;
wire done;

convolution conv (
  .clk(clk),
  .start(start),
  .X(X),
  .Y(Y),
  .Z(Z),
  .done(done)
);

initial begin
  clk = 0;
  start = 0;
  X = 9;
  Y = 76;
  Z = 82;
  #20 start = 1;
  #20 start = 0;
	#200000 ;
	$stop;
end

always begin
  #5 clk = ~clk;
end



endmodule

