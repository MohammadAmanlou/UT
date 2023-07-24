module ALU (a, b, opc, res);
    parameter N = 32;

    input signed [N-1:0] a, b;
    input [2:0] opc;
    output [N-1:0] res;
    reg [N-1:0] res;

    always @(a, b, opc) begin
        case (opc)
            3'b000:  res = a & b;
            3'b001:  res = a | b;
            3'b010:  res = a + b;
            3'b110:  res = a - b;
            3'b111:  res = a < b ? 'd1 : 'd0;
            default: res = {N{1'b0}};
        endcase
    end
endmodule
