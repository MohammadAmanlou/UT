module Divider(a, b, out);
    parameter N = 32;

    input signed [N-1:0] a, b;
    output signed [N-1:0] out;

    assign out = a / b;
endmodule
