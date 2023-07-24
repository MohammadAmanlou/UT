module Memory (memAdr, writeData, memRead, memWrite, clk, readData);
    input [15:0] writeData;
    input [11:0] memAdr;
    input memRead, memWrite, clk;
    output [15:0] readData;
    reg [15:0] readData;

    reg [15:0] mem [0:$pow(2, 12)-1]; // A 4K*16Bit memory

    initial $readmemb("data.mem", mem);

    always @(posedge clk) begin
        if (memWrite)
            mem[memAdr] <= writeData;
    end

    always @(memRead or memAdr) begin
        if (memRead)
            readData = mem[memAdr];
    end
endmodule
