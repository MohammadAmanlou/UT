
module mips_tb_j;
  
  wire [31:0] inst_adr, inst, data_adr, data_in, data_out;
  wire mem_read, mem_write;
  reg clk, rst;
  
  mips_single_cycle CPU(rst, clk, inst_adr, inst, data_adr, data_out, data_in, mem_read, mem_write);
  
  instmem_j j(inst_adr, inst);
  
  datamem2 DM2 (data_adr, data_in, mem_read, mem_write, clk, data_out);
  
  
  initial
  begin
    rst = 1'b1;
    clk = 1'b0;
    #20 rst = 1'b0;
    #5000 $stop;
  end
  
  always
  begin
    #8 clk = ~clk;
  end
  
endmodule


