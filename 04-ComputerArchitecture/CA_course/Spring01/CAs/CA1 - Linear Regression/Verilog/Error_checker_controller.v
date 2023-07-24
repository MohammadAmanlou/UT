`include "Counter_modN.v"

`define Idle  3'b000
`define Init  3'b001
`define Load  3'b010
`define Count 3'b011
`define Wait  3'b100

module Error_checker_controller(start, clk, rst, ready, ldErr);
    input start, clk, rst;
    output ready, ldErr;
    reg ready, ldErr;

    reg [2:0] ps, ns;
    reg cntEn, cntClr;
    wire cntCo;
    wire [7:0] cnt;

    Counter_modN #(150) counter(cntEn, cntClr, clk, rst, cntCo, cnt);

    always @(posedge clk) begin
        if (rst)
            ps <= 3'd0;
        else
            ps <= ns;
    end

    always @(ps or start or cntCo) begin
        case (ps)
            `Idle:  ns = start ? `Init : `Idle;
            `Init:  ns = `Load;
            `Load:  ns = `Count;
            `Count: ns = cntCo ? `Idle : `Wait;
            `Wait:  ns = `Load;
            default: ns = `Idle;
        endcase
    end

    always @(ps) begin
        {ready, ldErr, cntEn, cntClr} = 4'd0;
        case (ps)
            `Idle:;
            `Init: {ready, cntClr} = 2'b11;
            `Load: ldErr = 1'b1;
            `Count: cntEn = 1'b1;
            `Wait:;
            default:;
        endcase
    end
endmodule
