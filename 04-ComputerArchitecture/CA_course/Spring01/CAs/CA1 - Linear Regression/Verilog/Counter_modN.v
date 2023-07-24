`define BITS(x) $rtoi($ceil($clog2(x)))

module Counter_modN(en, clr, clk, rst, co, cnt);
    parameter N = 32;

    input en, clr, clk, rst;
    output co;
    output [`BITS(N)-1:0] cnt;
    reg [`BITS(N)-1:0] cnt;

    always @(posedge clk or posedge rst) begin
        if (rst)
            cnt <= {`BITS(N){1'b0}};
        else if (clr)
            cnt <= {`BITS(N){1'b0}};
        else if (en) begin
            if (co)
                cnt <= {`BITS(N){1'b0}};
            else
                cnt <= cnt + 1'b1;
        end
    end

    assign co = (cnt == N - 1);
endmodule
