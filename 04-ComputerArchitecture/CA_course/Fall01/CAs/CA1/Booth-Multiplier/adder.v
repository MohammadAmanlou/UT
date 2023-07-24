module adder (a, b, ci, addsub ,co, s);
  input [4:0] a, b;
  input ci,addsub;
  output co;
  output [4:0] s;
  assign {co, s} = (addsub==1) ? a + b + ci: a - b + ci;
endmodule
