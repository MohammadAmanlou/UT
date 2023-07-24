module InstructionMemory (pc, inst);
    input [31:0] pc;
    output [31:0] inst;

    reg [7:0] instMem [0:$pow(2, 12)-1]; // A 4KB memory is used instead of a 4GB one

    wire [31:0] adr;
    assign adr = {pc[31:2], 2'b00}; // To align the address to the word boundary

    initial $readmemb("instructions_divided.mem", instMem);

    assign inst = {instMem[adr + 3], instMem[adr + 2], instMem[adr + 1], instMem[adr]};
endmodule
