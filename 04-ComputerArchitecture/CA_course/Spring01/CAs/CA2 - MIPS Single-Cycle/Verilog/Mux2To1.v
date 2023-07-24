module Mux2To1 (a0, a1, sel, out);
    parameter N = 32;

    input [N-1:0] a0, a1;
    input sel;
    output [N-1:0] out;

    assign out = sel ? a1 : a0;
endmodule
