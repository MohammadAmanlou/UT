`define   S0      5'b00000
`define   S1      5'b00001
`define   S2      5'b00010
`define   S3      5'b00011
`define   S4      5'b00100
`define   S5      5'b00101
`define   S6      5'b00110
`define   S7      5'b00111
`define   S8      5'b01000
`define   S9      5'b01001
`define   S10     5'b01010
`define   S11     5'b01011
`define   S12     5'b01100
`define   S13     5'b01101
`define   S14     5'b01110
`define   S15     5'b01111
`define   S16     5'b10000
`define   S17     5'b10001
`define   S18     5'b10010


`define R_TYPE  6'b000000
`define SW      6'b101011
`define LW      6'b100011
`define ADDI    6'b001001
`define BEQ     6'b000100
`define J       6'b000010
`define JAL     6'b000011
`define SLTI    6'b001010
`define JR      6'b000110

module controller ( opcode, func, zero_out_alu, zero_in_pc,
                    reg_dst,mem_to_reg, reg_write,
                    mem_read, mem_write, pc_src,operation,
                    pc_write,pc_write_cond ,IorD, IRwrite,
                    alu_src_A, alu_src_B,
                    clk,rst,done
                  );

    input [5:0] opcode;
    input [5:0] func;
    input zero_out_alu;
    output zero_in_pc, reg_write;
    reg zero_in_pc, reg_write;
    input clk,rst;
    output pc_write_cond,pc_write, IRwrite, mem_write,mem_read,
         alu_src_A, IorD, done;  
     reg pc_write_cond,pc_write, IRwrite, mem_write,mem_read,
         alu_src_A, IorD, done;  
    output [2:0] operation;
    output [1:0] pc_src,alu_src_B;
    reg [1:0] alu_op,pc_src,alu_src_B;     
    output [1:0] reg_dst,mem_to_reg;
    reg [1:0] reg_dst,mem_to_reg;
    
   reg [4:0] ps,ns;


    alu_controller ALU_CTRL(alu_op, func, operation);
      
    always @(ps or opcode)
    begin  
    case (ps)
    `S0:  ns = `S1 ;
    `S1:   begin
           case(opcode)
           `LW     : ns = `S2; 
           `SW     : ns = `S2; 
           `BEQ    : ns = `S6; 
           `R_TYPE : ns = `S7; 
           `J      : ns = `S9;
           `JAL    : ns = `S10;
           `JR     : ns = `S11;
           `SLTI   : ns = `S12; 
           `ADDI   : ns = `S14; 
           endcase
           end
    `S2:  begin
          case(opcode)
           `SW   : ns = `S3; 
           `LW   : ns = `S4; 
          endcase
          end
    `S3:  ns = `S0;
    `S4:  ns = `S5;
    `S5:  ns = `S0;
    `S6:  ns = `S0;
    `S7:  ns = `S8;
    `S8:  ns = `S0;
    `S9:  ns = `S0;
    `S10: ns = `S0;
    `S11: ns = `S0;
    `S12: ns = `S13;
    `S13: ns = `S0;
    `S14: ns = `S15;
    `S15: ns = `S0;
    endcase
  end
  
   always @(ps)
    begin
    {reg_dst,reg_write,mem_read,mem_write,pc_src}=7'd0;
    {mem_to_reg,pc_write,pc_write_cond,IorD,IRwrite}=6'd0;
    {alu_src_A,alu_src_B,alu_op,done}=6'd0;
    case (ps)
      `S0:  {pc_write,IRwrite,alu_src_B,mem_read} = 5'b11011;
      `S1:  {alu_src_B} = 2'b11;
      `S2:  {alu_src_A,alu_src_B} = 3'b110;
      `S3:  {IorD,mem_write,done} = 3'b111;
      `S4:  {IorD,mem_read} = 2'b11;
      `S5:  {reg_write,mem_to_reg,done} = 4'b1011;
      `S6:  {pc_write_cond,alu_src_A,pc_src,alu_op,done} = 7'b1110011;
      `S7:  {alu_src_A,alu_op} = 3'b110;
      `S8:  {reg_dst,reg_write,done} = 4'b0111;
      `S9:  {pc_write,pc_src,done} = 4'b1011;
      `S10: {pc_write,reg_write,reg_dst,mem_to_reg,pc_src,done} = 8'b111010011;
      `S11: {pc_write,pc_src,done} = 4'b1111;
      `S12: {alu_op,alu_src_A,alu_src_B} = 5'b11110;
      `S13: {reg_write,done} = 2'b11;
      `S14: {alu_src_A,alu_src_B} = 3'b110;
      `S15: {reg_write,done} = 2'b11;
    endcase
  end

  assign zero_in_pc = zero_out_alu;

  always @(posedge clk)
    if (rst)
      ps <= `S0;
    else if (clk)
      ps <= ns;

endmodule
