`define BITS(x) $rtoi($ceil($clog2(x)))

module RegisterFile (readRegister1, readRegister2, writeRegister, writeData, regWrite, sclr, clk, rst,
                     readData1, readData2);
    parameter WordLen = 32;
    parameter WordCount = 32;

    input [`BITS(WordCount)-1:0] readRegister1, readRegister2, writeRegister;
    input [WordLen-1:0] writeData;
    input regWrite, sclr, clk, rst;
    output [WordLen-1:0] readData1, readData2;

    reg [WordLen-1:0] regFile [0:WordCount-1];

    assign readData1 = regFile[readRegister1];
    assign readData2 = regFile[readRegister2];

    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst)
            for (i = 0; i < WordCount; i = i + 1)
                regFile[i] <= {WordLen{1'b0}};
        else if (sclr)
            regFile[writeRegister] <= {WordLen{1'b0}};
        else if (regWrite)
            if (writeRegister != {WordLen{1'b0}}) // Forbid writing to R0
                regFile[writeRegister] <= writeData;
    end
endmodule
