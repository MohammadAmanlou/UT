module MEM_Stage_Reg(
    input clk,
    input rst,
    input WB_EN,
    input MEM_R_EN,
    input [31:0] ALU_Res,
    input [31:0] data_mem,
    input [3:0] dest,

    output reg WB_EN_out,
    output reg MEM_R_EN_out,
    output reg [31:0] ALU_Res_out,
    output reg [31:0] data_mem_out,
    output reg [3:0] dest_out
);

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            WB_EN_out <= 0;
            MEM_R_EN_out <= 0;
            ALU_Res_out <= 0;
            data_mem_out <= 0;
            dest_out <= 0;
        end
        else begin
            WB_EN_out <= WB_EN;
            MEM_R_EN_out <= MEM_R_EN;
            ALU_Res_out <= ALU_Res;
            data_mem_out <= data_mem;
            dest_out <= dest;
        end
    end

endmodule