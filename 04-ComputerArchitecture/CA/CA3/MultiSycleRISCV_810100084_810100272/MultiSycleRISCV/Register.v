module Reg(input [31:0] in, input clk  , output reg [31:0]out);

    always @(posedge clk) begin
            out <= in;
    end
endmodule
