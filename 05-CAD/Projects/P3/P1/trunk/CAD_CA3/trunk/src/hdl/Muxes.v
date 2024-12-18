module mux_16to1 (
  input [127:0] data_inputs,
  input [3:0] select,
  output reg [7:0]out
);

  always @* begin
    case (select)
      4'b0000: out = data_inputs[7 : 0];
      4'b0001: out = data_inputs[15 : 8];
      4'b0010: out = data_inputs[23 : 16];
      4'b0011: out = data_inputs[31 : 24];
      4'b0100: out = data_inputs[39 : 32];
      4'b0101: out = data_inputs[47 : 40];
      4'b0110: out = data_inputs[55 : 48];
      4'b0111: out = data_inputs[63 : 56];
      4'b1000: out = data_inputs[71 : 64];
      4'b1001: out = data_inputs[79 : 72];
      4'b1010: out = data_inputs[87 : 80];
      4'b1011: out = data_inputs[95 : 88];
      4'b1100: out = data_inputs[103 : 96];
      4'b1101: out = data_inputs[111 : 104];
      4'b1110: out = data_inputs[119 : 112];
      4'b1111: out = data_inputs[127 : 120];
      default: out = 1'b0; 
    endcase
  end

endmodule


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


