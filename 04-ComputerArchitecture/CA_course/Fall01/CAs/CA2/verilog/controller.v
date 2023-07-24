module controller ( opcode, func, zero, reg_dst, mem_to_reg, reg_write, 
                    alu_src, mem_read, mem_write, pc_src, operation,
                    pc_src2, mem_to_reg_2, reg_dst_2
                  );
                    

    input [5:0] opcode;
    input [5:0] func;
    input zero;
    output  reg_dst, mem_to_reg, reg_write, alu_src, 
            mem_read, mem_write, pc_src ,mem_to_reg_2, reg_dst_2;


    output [1:0] pc_src2;

    reg     reg_dst, mem_to_reg, reg_write, 
            alu_src, mem_read, mem_write  ,mem_to_reg_2, reg_dst_2; 
    reg    [1:0]  pc_src2;

    output [2:0] operation;
    

    //local variable        
    reg [1:0] alu_op;     
    reg branch;   
    
    alu_controller ALU_CTRL(alu_op, func, operation);
    
    always @(opcode)

    begin

        {reg_dst, pc_src2, mem_to_reg_2, reg_dst_2, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, alu_op} = 13'd0;
      case (opcode)
        // RType instructions
        6'b000000 : {reg_dst, reg_write, alu_op} = 4'b1110;   
        // Load Word (lw) instruction           
        6'b100011 : {alu_src, mem_to_reg, reg_write, mem_read} = 4'b1111; 
        // Store Word (sw) instruction
        6'b101011 : {alu_src, mem_write} = 2'b11;                                 
        // Branch on equal (beq) instruction
        6'b000100 : {branch, alu_op} = 3'b101; 
        // Add immediate (addi) instruction
        6'b001001: {reg_write, alu_src} = 2'b11;
        //new orders
        // jump instruction (j)
        6'b000010: {pc_src2} = 2'd1;
        // jump and save register instruction (jr) 
        6'b000110: {pc_src2} = 2'd2;               
        // set less than integer instruction (slti)
        6'b001010: {alu_op , reg_write, alu_src} = 4'b1111;
        // jump and save next pc in R31 instruction (jal) 
        6'b000011: {mem_to_reg_2, reg_write, reg_dst_2,pc_src2} = 5'b11101;

      endcase
    end
  

    assign pc_src = branch & zero;
  
endmodule
