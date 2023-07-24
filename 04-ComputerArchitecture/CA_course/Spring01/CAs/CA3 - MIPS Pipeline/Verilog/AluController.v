module AluController (op, func, aluOp);
    input [1:0] op;
    input [5:0] func;
    output [2:0] aluOp;
    reg [2:0] aluOp;

    always @(op, func) begin
        aluOp = 3'b000;

        case (op)
            2'b00: aluOp = 3'b010; // +
            2'b01: aluOp = 3'b110; // -
            2'b10: aluOp = 3'b111; // slt
            2'b11:
                case (func)
                    6'b100000: aluOp = 3'b010; // +
                    6'b100010: aluOp = 3'b110; // -
                    6'b100100: aluOp = 3'b000; // &
                    6'b100101: aluOp = 3'b001; // |
                    6'b101010: aluOp = 3'b111; // slt
                    default:   aluOp = 3'b010; // +
                endcase
            default: aluOp = 3'b010;
        endcase
    end
endmodule
