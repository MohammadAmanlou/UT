module ALU (a, b, opc, res, zero);
    parameter N = 16;

    input signed [N-1:0] a, b;
    input [2:0] opc;
    output [N-1:0] res;
    reg [N-1:0] res;
    output zero;

    assign zero = ~|res;

    always @(a, b, opc) begin
        case (opc)
            3'b000: res = a + b;
            3'b001: res = a - b;
            3'b010: res = a & b;
            3'b011: res = a | b;
            3'b100: res = ~a;
            3'b101: res = a;
            3'b110: res = b;
            default: res = {N{1'b0}};
        endcase
    end
endmodule
