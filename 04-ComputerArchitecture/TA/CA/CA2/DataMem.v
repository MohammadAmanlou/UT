`timescale 1ps/1ps
module DataMemory (
    Adr, 
    WD,
    clk,
    rst,
    WE,
    ReadData
);

    input [31:0] Adr;
    input [31:0] WD;
    input clk;
    input rst;
    input WE;
    output reg [31:0]ReadData;



    reg[31:0] MyMemory [999:0];//32000b / 4KB
    always @(posedge clk , posedge rst ) begin
        if(rst)begin
            $readmemh("data.mem", MyMemory);
        end
        else begin
            if (WE) begin
                MyMemory[{2'b00,Adr[31:2]}] <=WD;
            end
            

        end
    end
    always @(Adr , MyMemory) begin
        ReadData<=MyMemory[{2'b00,Adr[31:2]}];
    end
endmodule