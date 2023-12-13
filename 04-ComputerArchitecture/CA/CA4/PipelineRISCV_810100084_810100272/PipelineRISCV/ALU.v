module ALU (input signed[31:0]srcA, srcB, input[2:0] ALUControl,output reg[31:0] ALUResult,output zero);
    assign zero = ~|ALUResult;
    always @(srcA, srcB,ALUControl) begin
        case (ALUControl)
            3'b000:  ALUResult = srcA + srcB;
            3'b001:  ALUResult = srcA - srcB;
            3'b010:  ALUResult = srcA & srcB;
            3'b011:  ALUResult = srcA | srcB;
	    3'b100:  ALUResult = srcA ^ srcB;
            3'b101:  ALUResult = srcA < srcB ? 1 : 0;
            default: ALUResult = {32{1'b0}};
        endcase
    end
endmodule

