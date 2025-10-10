module RegisterFile(
    input clk,
    input rst,
    input [3:0] rn, //comes from sub instruction
    input [3:0] rm, //comes from mux
    input [3:0] WB_Dest, //write back
    input [31:0] WB_Value,
    input WB_WB_EN,
    output [31:0] Val_Rn,
    output [31:0] Val_Rm,
    output [31:0] R0,
    output [31:0] R1,
    output [31:0] R2,
    output [31:0] R3,
    output [31:0] R4,
    output [31:0] R5,
    output [31:0] R6
);

    reg [31:0] data[0:15];
    integer i;
    always @(negedge clk or posedge rst) begin
        if(rst) begin
            for(i = 0;i<16;i=i+1) begin
                data[i] <= 0;
            end

        end else if (WB_WB_EN) begin
            data[WB_Dest] <= WB_Value;
        end
    end

    assign Val_Rn = data[rn];
    assign Val_Rm = data[rm];
    assign R0 = data[0];
    assign R1 = data[1];
    assign R2 = data[2];
    assign R3 = data[3];
    assign R4 = data[4];
    assign R5 = data[5];
    assign R6 = data[6];
    

endmodule