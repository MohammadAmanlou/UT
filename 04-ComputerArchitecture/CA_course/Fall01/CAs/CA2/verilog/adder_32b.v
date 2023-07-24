module adder_32b (a , b, cin, cout, sum);
  input [31:0] a, b;
  input cin;
  output cout;
  output [31:0] sum;
  
  assign {cout, sum} = a + b + cin;
  
endmodule
