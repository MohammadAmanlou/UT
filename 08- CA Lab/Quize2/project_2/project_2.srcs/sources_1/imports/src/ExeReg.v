module ExeReg #(parameter N = 32)(
    input clk,
    input rst,
    input WB_EN,
    input MEM_R_EN,
    input MEM_W_EN,
    input [31:0] ALU_Res,
    input [31:0] Val_Rm,
    input [3:0] dest,

    output reg WB_EN_out,
    output reg MEM_R_EN_out,
    output reg MEM_W_EN_out,
    output reg [31:0] ALU_Res_out,
    output reg [31:0] Val_Rm_out,
    output reg [3:0] dest_out
    );
    
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            WB_EN_out <= 0;
            MEM_R_EN_out <= 0;
            MEM_W_EN_out <= 0;
            ALU_Res_out <= 0;
            Val_Rm_out <= 0;
            dest_out <= 0;
        end
        else begin
            WB_EN_out <=   WB_EN;
            MEM_R_EN_out <=MEM_R_EN;
            MEM_W_EN_out <=MEM_W_EN;
            ALU_Res_out <= ALU_Res;
            Val_Rm_out <=  Val_Rm;
            dest_out <=    dest;
        end
    end
endmodule