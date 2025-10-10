module IDreg #(parameter N = 32)(
    input clk,
    input rst,
    input flush,
    input [N-1:0] pc,
    input WB_EN,
    input MEM_R_EN,
    input MEM_W_EN,
    input [3:0] EXE_CMD,
    input B,
    input S,
    input [31:0] Val_Rn,
    input [31:0] Val_Rm,
    input imm,
    input [11:0] Shift_operand,
    input [23:0] Signed_imm_24,
    input [3:0] dest,
    input [3:0] status,
    input [3:0] src_1, //rn address
    input [3:0] src_2, //rm address

    output reg [N-1:0] pcOut,
    output reg WB_EN_out,
    output reg MEM_R_EN_out,
    output reg MEM_W_EN_out,
    output reg [3:0] EXE_CMD_out,
    output reg B_out,
    output reg S_out,
    output reg [31:0] Val_Rn_out,
    output reg [31:0] Val_Rm_out,
    output reg imm_out,
    output reg [11:0] Shift_operand_out,
    output reg [23:0] Signed_imm_24_out,
    output reg [3:0] dest_out,
    output reg [3:0] status_out,
    output reg [3:0] src_1_out, //rn address
    output reg [3:0] src_2_out //rm address
    );
    
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            pcOut <= 0;
            WB_EN_out <= 0;
            MEM_R_EN_out <= 0;
            MEM_W_EN_out <= 0;
            EXE_CMD_out <= 0;
            B_out <= 0;
            S_out <= 0;
            Val_Rn_out <= 0;
            Val_Rm_out <= 0;
            imm_out <= 0;
            Shift_operand_out <= 0;
            Signed_imm_24_out <= 0;
            dest_out <= 0;
            status_out <= 0;
            src_1_out <=0;
            src_2_out <=0;
        end
        else if (flush) begin
            pcOut <= 0;
            WB_EN_out <= 0;
            MEM_R_EN_out <= 0;
            MEM_W_EN_out <= 0;
            EXE_CMD_out <= 0;
            B_out <= 0;
            S_out <= 0;
            Val_Rn_out <= 0;
            Val_Rm_out <= 0;
            imm_out <= 0;
            Shift_operand_out <= 0;
            Signed_imm_24_out <= 0;
            dest_out <= 0;
            status_out <= 0;
            src_1_out <=0;
            src_2_out <=0;
        end
        else begin
            pcOut <=             pc;
            WB_EN_out <=         WB_EN;
            MEM_R_EN_out <=      MEM_R_EN;
            MEM_W_EN_out <=      MEM_W_EN;
            EXE_CMD_out <=       EXE_CMD;
            B_out <=             B;
            S_out <=             S;
            Val_Rn_out <=        Val_Rn;
            Val_Rm_out <=        Val_Rm;
            imm_out <=           imm;
            Shift_operand_out <= Shift_operand;
            Signed_imm_24_out <= Signed_imm_24;
            dest_out <=          dest;
            status_out <=        status;
            src_1_out <= src_1;
            src_2_out <= src_2;
        end
    end
endmodule