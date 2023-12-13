module Buffer_16x4_tb;

reg clk;
reg we;
reg shift_up;
reg [5:0] address;
reg [31:0] data_in;
wire [127:0] data_out;

Buffer_16x4 dut (
  .data_in(data_in),
  .we(we),
  .clk(clk),
  .shift_up(shift_up),
  .address(address),
  .data_out(data_out)
);

initial begin
  clk = 0;
  forever #5 clk = ~clk;
end

initial begin
  we = 0;
  shift_up = 0;
  address = 0;
  data_in = 0;

  #10 we = 1;
  data_in = 32'h12345678;
  address = 0;
  #10 we = 0;

  #10 we = 1;
  data_in = 32'h87654321;
  address = 2;
  #10 we = 0;

  #10 shift_up = 1;
  #10 shift_up = 0;

  #10 address = 1;
  #10 address = 3;
end

endmodule

