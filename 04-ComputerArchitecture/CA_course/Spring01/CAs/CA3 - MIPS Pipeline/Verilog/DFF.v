module DFF (in, ld, sclr, clk, rst, out);
    input in;
    input ld, sclr, clk, rst;
    output out;
    reg out;

    always @(posedge clk or posedge rst) begin
        if (rst)
            out <= 1'b0;
        else if (sclr)
            out <= 1'b0;
        else if (ld)
            out <= in;
    end
endmodule
