`define BITS(x) $rtoi($ceil($clog2(x)))

module RegisterFile (readAdr, writeAdr, writeData, regWrite, sclr, clk, rst, readData0, readData1);
    parameter WordLen = 16;
    parameter WordCount = 8;

    input [`BITS(WordCount)-1:0] readAdr, writeAdr;
    input [WordLen-1:0] writeData;
    input regWrite, sclr, clk, rst;
    output [WordLen-1:0] readData0, readData1;

    reg [WordLen-1:0] regFile [0:WordCount-1];

    assign readData0 = regFile[0];
    assign readData1 = regFile[readAdr];

    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst)
            for (i = 0; i < WordCount; i = i + 1)
                regFile[i] <= {WordLen{1'b0}};
        else if (sclr)
            regFile[writeAdr] <= {WordLen{1'b0}};
        else if (regWrite)
            regFile[writeAdr] <= writeData;
    end
endmodule
