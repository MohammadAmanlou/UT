module Register(load, ldData, clr, clk, rst, out);
    parameter N = 32;

    input load, clr, clk, rst;
    input [N-1:0] ldData;
    output [N-1:0] out;
    reg [N-1:0] out;

    always @(posedge clk or posedge rst) begin
        if (rst)
            out <= {N{1'b0}};
		else if (clr)
            out <= {N{1'b0}};
        else if (load)
            out <= ldData;
    end
endmodule
