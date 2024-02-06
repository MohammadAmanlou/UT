module counter #(parameter N = 0, M = 1) (
  input wire clk,
  input wire rst,
  input wire en,
  output wire cout,
  output reg [M-1:0] count
);

always @(posedge clk or posedge rst)
begin
  if (rst)
    count <= {{M{1'b0}}};
  else if (en)
    count <= (count == N-1) ? {{M{1'b0}}} : (count + 1'b1);
end

assign cout = (count == N-1) ? 1'b1 : 1'b0;

endmodule
