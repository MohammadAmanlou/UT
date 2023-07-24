module Register (in, ld, sclr, clk, rst, out);
    parameter N = 32;
    parameter [N-1:0] Init = {N{1'b0}};

    input [N-1:0] in;
    input ld, sclr, clk, rst;
    output [N-1:0] out;
    reg [N-1:0] out;

    always @(posedge clk or posedge rst) begin
        if (rst)
            out <= Init;
        else if (sclr)
            out <= Init;
        else if (ld)
            out <= in;
    end
endmodule
