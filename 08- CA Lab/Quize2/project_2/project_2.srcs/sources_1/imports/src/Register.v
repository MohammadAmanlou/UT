module Register #(parameter N = 32)(
    input clk,
    input rst,
    input freeze,
    input [N-1:0] in,
    output reg [N-1:0] outReg
	);

    always @(posedge clk or posedge rst) begin
        if (rst)
            outReg <= 0;
        else if (!freeze)
            outReg <= in;
    end
endmodule
