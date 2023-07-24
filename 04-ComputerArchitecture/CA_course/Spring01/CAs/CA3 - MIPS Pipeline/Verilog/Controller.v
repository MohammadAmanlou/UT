`include "AluController.v"

module Controller (opc, func, equal, clk, rst, PcSrc, IFIDFlush, ALUSrc,
                      RegDst, MemRead, MemWrite, RegData, RegWrite, ALUOpc);
    input [5:0] opc, func;
    input equal;
    input clk, rst;
    output reg [1:0] PcSrc, RegDst, RegData;
    output reg IFIDFlush, ALUSrc, MemRead, MemWrite, RegWrite;
    output [2:0] ALUOpc;

    reg [1:0] AluCtrlOp;

    AluController aluCtrl(.op(AluCtrlOp), .func(func), .aluOp(ALUOpc));

    always @(opc, equal) begin
        {PcSrc, RegDst, RegData} = 6'd0;
        {IFIDFlush, ALUSrc, MemRead, MemWrite, RegWrite} = 5'd0;
        AluCtrlOp = 2'd0;

        case (opc)
            6'b000000: begin // R-Type
                AluCtrlOp = 2'b11; // Func
                PcSrc = 2'b00;
                RegDst = 2'b01;
                RegData = 2'b00;
                {IFIDFlush, ALUSrc, MemRead, MemWrite, RegWrite}= 5'b00001;
            end
            6'b001000: begin // addi
                AluCtrlOp = 2'b00; // +
                PcSrc = 2'b00;
                RegDst = 2'b00;
                RegData = 2'b00;
                {IFIDFlush, ALUSrc, MemRead, MemWrite, RegWrite}= 5'b01001;
            end
            6'b001010: begin // slti
                AluCtrlOp = 2'b10; // slt
                PcSrc = 2'b00;
                RegDst = 2'b00;
                RegData = 2'b00;
                {IFIDFlush, ALUSrc, MemRead, MemWrite, RegWrite}= 5'b01001;
            end
            6'b100011: begin // lw
                AluCtrlOp = 2'b00; // +
                PcSrc = 2'b00;
                RegDst = 2'b00;
                RegData = 2'b01;
                {IFIDFlush, ALUSrc, MemRead, MemWrite, RegWrite}= 5'b01101;
            end
            6'b101011: begin // sw
                AluCtrlOp = 2'b00; // +
                PcSrc = 2'b00;
                {IFIDFlush, ALUSrc, MemRead, MemWrite, RegWrite}= 5'b01010;
            end
            6'b000010: begin // j
                PcSrc = 2'b10;
                {IFIDFlush, MemRead, MemWrite, RegWrite}= 4'b1000;
            end
            6'b000011: begin // jal
                PcSrc = 2'b10;
                RegDst = 2'b10;
                RegData = 2'b10;
                {IFIDFlush, MemRead, MemWrite, RegWrite}= 4'b1001;
            end
            6'b111111: begin // jr
                PcSrc = 2'b11;
                {IFIDFlush, MemRead, MemWrite, RegWrite}= 4'b1000;
            end
            6'b000100: begin // beq
                if (equal) begin
                    PcSrc = 2'b01;
                    IFIDFlush = 1'b1;
                end
                else begin
                    PcSrc = 2'b00;
                    IFIDFlush = 1'b0;
                end
                {MemRead, MemWrite, RegWrite}= 3'b000;
            end
        endcase
    end
endmodule
