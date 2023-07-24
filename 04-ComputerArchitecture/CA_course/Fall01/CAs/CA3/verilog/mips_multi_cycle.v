module mips_multi_cycle (rst, clk, inst_adrs, data_in, data_out, mem_read, mem_write,done);
  input rst, clk;
  output [31:0] inst_adrs;
  input  [31:0] data_in;
  output [31:0] data_out;
  output mem_read, mem_write,done;
  
  wire  alu_srcA, reg_write,zero_out_alu, zero_in_pc,IorD,IRwrite,pc_write_cond,pc_write;
  wire [2:0] alu_ctrl;
  wire [1:0] pc_src,alu_srcB;
  wire [1:0] reg_dst,mem_to_reg;
  wire [31:0] inst;

  datapath DP( clk, rst, inst_adrs,inst, data_out,data_in,
                   reg_dst, mem_to_reg, pc_src, alu_ctrl, reg_write,
                   zero_out_alu,zero_in_pc,
                   IRwrite,pc_write_cond,pc_write, IorD,
                   alu_srcA, alu_srcB
                 );

   controller CU(  inst[31:26], inst[5:0], zero_out_alu,zero_in_pc, reg_dst, mem_to_reg, reg_write, 
                  mem_read, mem_write, pc_src, alu_ctrl,
                 pc_write,pc_write_cond,IorD,IRwrite,
                 alu_srcA,alu_srcB,
                 clk,rst,done
               );
  
endmodule