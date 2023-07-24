module mips_single_cycle (rst, clk, inst_adr, inst, data_adr, data_in, data_out, mem_read, mem_write);
  input rst, clk;
  output [31:0] inst_adr;
  input  [31:0] inst;
  output [31:0] data_adr;
  input  [31:0] data_in;
  output [31:0] data_out;
  output mem_read, mem_write;

  wire reg_dst, mem_to_reg, alu_src, pc_src, reg_write, zero;
  wire [2:0] alu_ctrl;
  
  //new
  wire [1:0] pc_src2;
  wire  mem_to_reg_2, reg_dst_2;


  
  datapath DP(  clk, rst, inst_adr, inst, data_adr, data_out, data_in, 
                reg_dst, mem_to_reg, alu_src, pc_src, alu_ctrl, reg_write, zero
                , pc_src2, mem_to_reg_2, reg_dst_2
            );
            
  controller CU(  inst[31:26], inst[5:0], zero, reg_dst, mem_to_reg, reg_write, 
                  alu_src, mem_read, mem_write, pc_src, alu_ctrl ,
                  pc_src2, mem_to_reg_2, reg_dst_2
                );
  
endmodule
