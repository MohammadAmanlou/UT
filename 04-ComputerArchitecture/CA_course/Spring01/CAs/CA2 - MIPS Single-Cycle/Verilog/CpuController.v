`include "BranchController.v"
`include "AluController.v"

module CpuController (opc, func, zero, memRead, memWrite, pcOrMemAlu, regDst,
                      link, regWrite, aluSrc, pcSrc, jumpReg, jump, memToReg, aluOp);
    input [5:0] opc, func;
    input zero;
    output memRead, memWrite, pcOrMemAlu, regDst, link, regWrite, aluSrc, pcSrc, jumpReg, jump, memToReg;
    reg memRead, memWrite, pcOrMemAlu, regDst, link, regWrite, aluSrc, jumpReg, jump, memToReg;
    output [2:0] aluOp;

    reg [1:0] op;
    reg branch;


    AluController aluController(.op(op), .func(func), .aluOp(aluOp));
    BranchController branchController(.branch(branch), .zero(zero), .pcSrc(pcSrc));


    always @(opc) begin
        {memRead, memWrite, pcOrMemAlu, regDst, link, regWrite, aluSrc, jumpReg, jump, memToReg} = 10'd0;
        op = 2'b00;
        branch = 1'b0;

        case (opc)
            6'b000000: begin // R-type
                op = 2'b11;
                {regDst, pcOrMemAlu, regWrite} = 3'b111;
                {aluSrc, memToReg, link, memRead, memWrite, jump} = 6'd0;
            end
            6'b001000: begin // addi
                op = 2'b00;
                {aluSrc, pcOrMemAlu, regWrite} = 3'b111;
                {regDst, memToReg, link, memRead, memWrite, jump} = 6'd0;
            end
            6'b001010: begin // slti
                op = 2'b10;
                {aluSrc, regWrite, pcOrMemAlu} = 3'b111;
                {regDst, memToReg, link, memRead, memWrite, jump} = 6'd0;
            end
            6'b100011: begin // lw
                op = 2'b00;
                {aluSrc, pcOrMemAlu, regWrite, memRead, memToReg} = 5'b11111;
                {regDst, link, memWrite, jump} = 4'd0;
            end
            6'b101011: begin // sw
                op = 2'b00;
                {aluSrc, memWrite} = 2'b11;
                {regWrite, memRead, jump} = 3'd0;
            end
            6'b000010: begin // j
                {jump} = 1'b1;
                {regWrite, memRead, memWrite, jumpReg} = 4'd0;
            end
            6'b000011: begin // jal
                {regWrite, link, jump} = 3'b111;
                {pcOrMemAlu, memRead, memWrite, jumpReg} = 4'd0;
            end
            6'b111111: begin // jr
                {jump, jumpReg} = 2'b11;
                {regWrite, memRead, memWrite} = 3'd0;
            end
            6'b000100: begin // beq
                branch = 1'b1;
                {regWrite, aluSrc, memRead, memWrite, jump} = 5'd0;
            end
            default:;
        endcase
    end
endmodule
