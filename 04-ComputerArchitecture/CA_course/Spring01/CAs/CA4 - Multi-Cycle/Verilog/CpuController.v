`include "AluController.v"

`define IF        4'b0000
`define ID        4'b0001
`define Branch    4'b0010
`define CtyCalc   4'b0011
`define CtyWrite  4'b0100
`define Jump      4'b0101
`define Store     4'b0110
`define Load      4'b0111
`define LoadWrite 4'b1000
`define Addi      4'b1001
`define Subi      4'b1010
`define Andi      4'b1011
`define Ori       4'b1100
`define ImmWrite  4'b1101

module CpuController (opcode, func, clk, rst,
                     memWrite, memRead, IorD, IRWrite, regDst, dataFromMem, regWrite, aluSrcA, aluSrcB, aluOpc, PcSrc, PcWrite, branch,
                     noOp, moveTo);
    input [3:0] opcode;
    input [8:0] func;
    input clk, rst;
    output memWrite, memRead, IorD, IRWrite, regDst, dataFromMem, regWrite, aluSrcA, PcWrite, branch;
    reg memWrite, memRead, IorD, IRWrite, regDst, dataFromMem, regWrite, aluSrcA, PcWrite, branch;
    output noOp, moveTo;
    output [2:0] aluOpc;
    output [1:0] aluSrcB;
    output [1:0] PcSrc;
    reg [1:0] aluSrcB;
    reg [1:0] PcSrc;

    reg [3:0] ps, ns;
    reg [2:0] aluOp;

    AluController aluController(aluOp, func, aluOpc, noOp, moveTo);

    always @(posedge clk or posedge rst) begin
        if (rst) ps <= 4'd0;
        else ps <= ns;
    end

    always @(ps or opcode) begin
        case (ps)
            `IF: ns = `ID;
            `ID: begin
                case (opcode)
                    4'b0100: ns = `Branch;  // branch
                    4'b1000: ns = `CtyCalc; // ctype
                    4'b0010: ns = `Jump;    // jump
                    4'b0001: ns = `Store;   // store
                    4'b0000: ns = `Load;    // load
                    4'b1100: ns = `Addi;    // addi
                    4'b1101: ns = `Subi;    // subi
                    4'b1110: ns = `Andi;    // andi
                    4'b1111: ns = `Ori;     // ori
                endcase
            end
            `Branch:    ns = `IF;
            `CtyCalc:   ns = `CtyWrite;
            `CtyWrite:  ns = `IF;
            `Jump:      ns = `IF;
            `Store:     ns = `IF;
            `Load:      ns = `LoadWrite;
            `LoadWrite: ns = `IF;
            `Addi:      ns = `ImmWrite;
            `Subi:      ns = `ImmWrite;
            `Andi:      ns = `ImmWrite;
            `Ori:       ns = `ImmWrite;
            `ImmWrite:  ns = `IF;
            default: ns = `IF;
        endcase
    end

    always @(ps) begin
        {memWrite, memRead, IorD, IRWrite, regDst, dataFromMem, regWrite, aluSrcA, aluSrcB, PcWrite, branch} = 11'd0;
        aluOp = 3'd0;
        PcSrc = 2'd0;

        case (ps)
            `IF: begin
                {memWrite, memRead, IorD, IRWrite, regWrite, aluSrcA, PcWrite, branch} = 8'b01010110;
                aluSrcB = 2'b01;
                aluOp = 3'b000;
                PcSrc = 2'b00;
            end
            `ID: {memWrite, memRead, IRWrite, regWrite, PcWrite, branch} = 6'b000000;
            `Branch: begin
                {memWrite, memRead, IRWrite, regWrite, aluSrcA, branch} = 7'b000001;
                aluSrcB = 2'b00;
                aluOp = 3'b100;
                PcSrc = 2'b01;
            end
            `CtyCalc: begin
                {memWrite, memRead, IRWrite, regWrite, aluSrcA, PcWrite, branch} = 7'b0000000;
                aluSrcB = 2'b00;
                aluOp = 3'b100;
            end
            `CtyWrite: begin
                {memWrite, memRead, IRWrite, regDst, dataFromMem, regWrite, PcWrite, branch} = 8'b00000100;
                aluOp = 3'b100;
            end
            `Jump: begin
                {memWrite, memRead, IRWrite, regWrite, PcWrite, branch} = 6'b000010;
                PcSrc = 2'b10;
            end
            `Store: {memWrite, memRead, IorD, IRWrite, regWrite, PcWrite, branch} = 7'b1010000;
            `Load: {memWrite, memRead, IorD, IRWrite, regWrite, PcWrite, branch} = 7'b0110000;
            `LoadWrite: {memWrite, memRead, IRWrite, regDst, dataFromMem, regWrite, PcWrite, branch} = 8'b00001100;
            `Addi: begin
                {memWrite, memRead, IRWrite, regWrite, aluSrcA, PcWrite, branch} = 7'b0000000;
                aluSrcB = 2'b10;
                aluOp = 3'b000;
            end
            `Subi: begin
                {memWrite, memRead, IRWrite, regWrite, aluSrcA, PcWrite, branch} = 7'b0000000;
                aluSrcB = 2'b10;
                aluOp = 3'b001;
            end
            `Andi: begin
                {memWrite, memRead, IRWrite, regWrite, aluSrcA, PcWrite, branch} = 7'b0000000;
                aluSrcB = 2'b10;
                aluOp = 3'b010;
            end
            `Ori: begin
                {memWrite, memRead, IRWrite, regWrite, aluSrcA, PcWrite, branch} = 7'b0000000;
                aluSrcB = 2'b10;
                aluOp = 3'b011;
            end
            `ImmWrite: {memWrite, memRead, IRWrite, regDst, dataFromMem, regWrite, PcWrite, branch} = 8'b00000100;
            default:;
        endcase
    end
endmodule
