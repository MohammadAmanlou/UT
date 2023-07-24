module multiplier_tb;
  reg [4:0] data_in;
  reg rst, start, clk;
  wire [4:0] data_out;
  wire done;
  
  multiplier DUT(data_in, rst, start, clk, data_out, done);
  
  initial
  begin
  start = 1'b0;
  rst = 1'b0;
  clk = 1'b0;
  #13 rst = 1'b1;
  #20 rst = 1'b0;
  #13 start = 1'b1;
  #20 start = 1'b0;
  data_in = 5'b10001;
  #20 data_in = 5'b01001;
  #400 ;

  start = 1'b0;
  rst = 1'b0;
  clk = 1'b0;
  #13 rst = 1'b1;
  #20 rst = 1'b0;
  #13 start = 1'b1;
  #20 start = 1'b0;
  data_in = 5'b01001;
  #20 data_in = 5'b10001;
  #400 ;

    repeat (5)
      begin
         start = 1'b0;
         rst = 1'b0;
         clk = 1'b0;
         #13 rst = 1'b1;
         #20 rst = 1'b0;
         #13 start = 1'b1;
         #20 start = 1'b0;
         data_in = $random % 16;
         #20 data_in = $random % 16;
         #400 ;
      end
      #300 $finish;
  end
  
  always
  begin
    #10 clk = ~clk;
  end
  
  
endmodule
