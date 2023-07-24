module reg_file (wr_data, rd_reg1, rd_reg2, wr_reg, reg_write, rst, clk, rd_data1, rd_data2);
  input [31:0] wr_data;
  input [4:0] rd_reg1, rd_reg2, wr_reg;
  input reg_write, rst, clk;
  output [31:0] rd_data1, rd_data2;
  
  reg [31:0] register_file [0:31];
  integer i;
  
  assign rd_data1 = (rd_reg1 == 5'b0) ? 32'd0 : register_file[rd_reg1];
  assign rd_data2 = (rd_reg2 == 5'b0) ? 32'd0 : register_file[rd_reg2];
  
  always @(posedge clk)
    if (rst == 1'b1)
      for (i=0; i<32 ; i=i+1 )
        register_file[i] <= 32'd0;
    else if (reg_write == 1'b1)
      if(wr_reg != 5'd0)
        register_file[wr_reg] <= wr_data;
      
endmodule