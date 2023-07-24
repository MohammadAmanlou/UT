module AluController (aluOp, func, aluOpc, noOp, moveTo);
    input [2:0] aluOp;
    input [8:0] func;
    output noOp, moveTo;
    reg noOp, moveTo;
    output [2:0] aluOpc;
    reg [2:0] aluOpc;

    always @(aluOp, func) begin
        aluOpc = 3'b000;
        {noOp, moveTo} = 2'b00;

        case (aluOp)
            3'b000:
                aluOpc = 3'b000;
            3'b001:
                aluOpc = 3'b001;
            3'b010:
                aluOpc = 3'b010;
            3'b011:
                aluOpc = 3'b011;
            3'b100:
                case (func)
                    9'b000000100: aluOpc = 3'b000; // +
                    9'b000001000: aluOpc = 3'b001; // -
                    9'b000010000: aluOpc = 3'b010; // &
                    9'b000100000: aluOpc = 3'b011; // |
                    9'b001000000: aluOpc = 3'b100; // ~
                    9'b000000001: begin aluOpc = 3'b101; moveTo = 1'b1; end // pass1 R0
                    9'b000000010: aluOpc = 3'b110; // pass2 Ri
                    9'b010000000: begin aluOpc = 3'b111; noOp = 1'b1; end // pass
                    default: aluOpc = 3'b000;
                endcase
            default: aluOpc = 3'b000;
        endcase
    end
endmodule
