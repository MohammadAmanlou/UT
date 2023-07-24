module Mux2To1(a0, a1, sel, out);
    parameter N = 16;

    input [N-1:0] a0, a1;
    input sel;
    output [N-1:0] out;

    assign out = sel ? a1 : a0;
endmodule

module Mux4To1(a00, a01, a10, a11, sel, out);
    parameter N = 16;

    input [N-1:0] a00, a01, a10, a11;
    input [1:0] sel;
    output [N-1:0] out;

    assign out = (sel == 2'b00) ? a00 :
                 (sel == 2'b01) ? a01 :
                 (sel == 2'b10) ? a10 :
                 (sel == 2'b11) ? a11 : 1'bx;
endmodule
