module mux4_1_9bit(
  input [8:0] in0,in1,in2,in3,
  input [1:0]sel,
  output reg [8:0]out
);

always @(*) begin
  case (sel)
    0: out <= in0;
    1: out <= in1;
    2: out <= in2;
    default: out <= 0;
  endcase
end
endmodule
