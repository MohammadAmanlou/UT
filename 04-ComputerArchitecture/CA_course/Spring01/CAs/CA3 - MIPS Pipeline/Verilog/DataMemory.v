module DataMemory (memAdr, writeData, memRead, memWrite, clk, readData);
    input [31:0] memAdr, writeData;
    input memRead, memWrite, clk;
    output [31:0] readData;
    reg [31:0] readData;

    reg [7:0] dataMem [0:$pow(2, 12)-1]; // A 4KB memory is used instead of a 4GB one

    wire [31:0] adr;
    assign adr = {memAdr[31:2], 2'b00}; // To align the address to the word boundary

    // initial $readmemb("data.mem", dataMem);
    initial $readmemb("data.mem", dataMem, 1000);

    always @(posedge clk) begin
        if (memWrite)
            {dataMem[adr + 3], dataMem[adr + 2], dataMem[adr + 1], dataMem[adr]} <= writeData;
    end

    always @(memRead or adr) begin
        if (memRead)
            readData = {dataMem[adr + 3], dataMem[adr + 2], dataMem[adr + 1], dataMem[adr]};
    end
endmodule
