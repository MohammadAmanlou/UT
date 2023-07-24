`define BITS(x) $rtoi($ceil($clog2(x)))

module Memory(adr, dataIn, write, clr, clk, rst, dataOut);
    parameter WordSize = 32;
    parameter WordCount = 128;

    input [`BITS(WordCount)-1:0] adr;
    input [WordSize-1:0] dataIn;
    input write, clr, clk, rst;
    output [WordSize-1:0] dataOut;
    reg [WordSize-1:0] dataOut;

    reg [WordSize-1:0] mem [0:WordCount-1];

    always @(posedge clk or posedge rst) begin
        if (rst) begin: ClrMem
            integer i;
            for (i = 0; i < WordCount; i = i + 1) begin
                mem[i] <= {WordSize{1'b0}};
            end
        end
        else if (clr)
            mem[adr] <= {WordSize{1'b0}};
        else if (write)
            mem[adr] <= dataIn;
    end

    always @(posedge clk) begin
        dataOut <= mem[adr];
    end
endmodule
