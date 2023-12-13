module counter16 (
  input clk,
  input reset,
  input en,
  output reg cout,
  output reg [3:0] count
);

always @(posedge clk or posedge reset) begin
  if (reset) begin
    count <= 0;
    cout <= 0;
  end else if (en) begin
    count <= count + 1;
    cout <= &count;
  end
end

endmodule
