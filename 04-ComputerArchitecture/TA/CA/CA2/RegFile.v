`timescale 1ps/1ps  
module RegFile (
    readReg1, readReg2,
    writeReg,
    WE,
    data1, data2,
    dataWrite,
    clk,
    rst
);
integer c;
    reg [31:0] x[31:0];//x0 x1 ,... ,x31
    input [4:0] readReg1,readReg2,writeReg;
    input clk ,rst,WE;
    output reg[31:0]data1,data2;
    input [31:0]dataWrite;

    always @(readReg1, readReg2,x) begin
        data1 <= x[readReg1];
        data2 <=x[readReg2];
    end
    always @(negedge clk , posedge rst) begin
        if (rst) begin
                        for (c = 0; c <32; c=c+1) begin
                x[c] <=32'b0;
            end
        end
        else if(WE) begin
            if(writeReg!=0)begin
                x[writeReg] <= dataWrite;
        end
        end
        
    end

    
endmodule