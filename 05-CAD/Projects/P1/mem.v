module Mem4(input [31:0] X1,X2,X3,X4 , input clk , en , output reg [31:0] Xo1,Xo2,Xo3,Xo4 );
reg [31:0] mem [0:3];
always @(posedge clk ) begin
    if (en) begin
	mem[0] <= X1;
	mem[1] <= X2;
	mem[2] <= X3;
	mem[3] <= X4;
    end
end
assign Xo1 = mem[0];
assign Xo2 = mem[1];
assign Xo3 = mem[2];
assign Xo4 = mem[3];
endmodule
