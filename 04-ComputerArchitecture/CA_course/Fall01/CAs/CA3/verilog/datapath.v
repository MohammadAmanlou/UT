module datapath ( clk, rst, inst_adr,inst,
                  data_out, data_in, 
                  reg_dst, mem_to_reg, pc_src, alu_ctrl, reg_write,
                  zero_out_alu,zero_in_PC,
                  IRwrite,pc_write_cond,pc_write,IorD,
                  alu_srcA,alu_srcB
                 );


  input  clk, rst;
  output [31:0] inst_adr;
  output [31:0] inst;
  output [31:0] data_out;
  input  [31:0] data_in;
  input  reg_write,IRwrite,pc_write_cond,pc_write,IorD,alu_srcA;
  input  [1:0] alu_srcB, pc_src;
  input  [2:0] alu_ctrl;
  input  zero_in_PC;
  output zero_out_alu;
  input [1:0] reg_dst, mem_to_reg;

  wire [31:0] pc_out;
  wire [31:0] IorD_o;
  wire [31:0] Alu_reg_out;
  wire [31:0] PC_src_o;
  wire [31:0] IR_o;
  wire [31:0] MDR_o;
  wire [31:0] reg_dst_o,mem_to_reg_o;
  wire [31:0] read_data1, read_data2,A_o,B_o;
  wire [31:0] alu_srcA_o,sgn_ext_out,alu_srcB_o,shl2_b_out;
  wire [31:0] alu_out,j_addr;


  reg_32b PC(PC_src_o, rst, ((zero_in_PC && pc_write_cond) || pc_write), clk, pc_out);

  mux2to1_32b MUX_IorD(pc_out, Alu_reg_out , IorD, IorD_o);

  reg_32b IR(data_in, rst, IRwrite, clk, IR_o);

  reg_32b MDR(data_in, rst, 1'b1, clk, MDR_o);


  mux3to1_5b MUX_reg_dst(IR_o[20:16], IR_o[15:11], 5'b11111, reg_dst, reg_dst_o);
  

  mux3to1_32b MUX_mem_to_reg1(Alu_reg_out, MDR_o, pc_out, mem_to_reg, mem_to_reg_o);


  reg_file  RF(mem_to_reg_o, IR_o[25:21], IR_o[20:16], reg_dst_o, reg_write, rst, clk, read_data1, read_data2);//REGISTER

  reg_32b A(read_data1, rst, 1'b1, clk, A_o);
  
  mux2to1_32b MUX_A(pc_out, A_o, alu_srcA, alu_srcA_o);

  reg_32b B(read_data2, rst, 1'b1, clk, B_o);

  sign_ext SGN_EXT(IR_o[15:0], sgn_ext_out);//SIGN EXT
  
  shl2 SHIFT_LEFT_2b(sgn_ext_out, shl2_b_out);

  mux4to1_32b MUX_B(B_o, 32'd4, sgn_ext_out, shl2_b_out, alu_srcB, alu_srcB_o);
  
  alu ALU(alu_srcB_o, alu_srcA_o, alu_ctrl, alu_out, zero_out_alu);



  reg_32b ALU_out_reg(alu_out, rst, 1'b1, clk, Alu_reg_out);
  
  shl2 J_ADRS({2'b00,pc_out[31:28],IR_o[25:0]}, j_addr);
  
  mux4to1_32b MUX_pcsrc(alu_out, j_addr, Alu_reg_out, A_o, pc_src, PC_src_o);

  assign data_out = B_o;
  assign inst = IR_o;
  assign inst_adr = IorD_o;

  
endmodule  
