module mips_tb_least_find;
  wire [31:0] adrs, data_in, data_out;
  wire mem_read, mem_write,done;
  reg clk, rst;
  
  mips_multi_cycle CPU(rst, clk, adrs, data_out, data_in, mem_read, mem_write,done);
  
  datamem2 DM(adrs, data_in, mem_read, mem_write, clk, data_out);
  
  initial
  begin
    rst = 1'b1;
    clk = 1'b0;
    #12 rst = 1'b0;
     #10000 $stop;
  end
  
  always
  begin
    #8 clk = ~clk;
  end
  
endmodule
