module Adder (a, b, res);
    parameter N = 32;

    input [N-1:0] a, b;
    output [N-1:0] res;

    assign res = a + b;
endmodule
