
module PC(input [31:0] in, input clk , en , output reg [31:0]out = 32'b0);
	
    always @(posedge clk) begin
	if(en)
            out <= in;
    end
endmodule


