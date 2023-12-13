module mux2_1_9bit(
  input [8:0] in0,in1,
  input sel,
  output reg [8:0]out
);

always @(*) begin
  case (sel)
    0: out <= in0;
    1: out <= in1;
    default: out <= 0;
  endcase
end

endmodule

module mux2_1_4bit(
  input [3:0] in0,in1,
  input sel,
  output reg [3:0]out
);

always @(*) begin
  case (sel)
    0: out <= in0;
    1: out <= in1;
    default: out <= 0;
  endcase
end

endmodule
