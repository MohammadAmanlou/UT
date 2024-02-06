module register5 (clk, rst, en, in, out);
	input clk, rst, en;
	input [4:0] in;
	output wire [4:0] out;
    S2 #5 S2_REG(.D00(out), .D01(in), .D10(), .D11(), .A1(1'b0), .B1(1'b0), .A0(en), .B0(1'b1), .CLR(rst), .CLK(clk), .out(out));
endmodule

module register10 (input clk, rst, en, input[9:0] in,output wire[9:0] out);
    S2 #10 S2_REG(.D00(out), .D01(in), .D10(), .D11(), .A1(1'b0), .B1(1'b0), .A0(en), .B0(1'b1), .CLR(rst), .CLK(clk), .out(out));
endmodule

module register1 (input clk, rst, en, input in,output wire out);
    S2 #1 S2_REG(.D00(out), .D01(in), .D10(), .D11(), .A1(1'b0), .B1(1'b0), .A0(en), .B0(1'b1), .CLR(rst), .CLK(clk), .out(out));
endmodule



module  memory5 (input clk, rst, en,input [4:0] In0, In1, In2, In3, output wire [4:0] Out0, Out1, Out2, Out3);
    register5  REG_1(.clk(clk),.rst(rst),.en(en),.in(In0),.out(Out0));
    register5  REG_2(.clk(clk),.rst(rst),.en(en),.in(In1),.out(Out1));
    register5  REG_3(.clk(clk),.rst(rst),.en(en),.in(In2),.out(Out2));
    register5  REG_4(.clk(clk),.rst(rst),.en(en),.in(In3),.out(Out3));
endmodule

module  memory10 (input clk, rst, en,input [9:0] In0, In1, In2, In3, output wire [9:0] Out0, Out1, Out2, Out3);
    register10  REG_1(.clk(clk),.rst(rst),.en(en),.in(In0),.out(Out0));
    register10  REG_2(.clk(clk),.rst(rst),.en(en),.in(In1),.out(Out1));
    register10  REG_3(.clk(clk),.rst(rst),.en(en),.in(In2),.out(Out2));
    register10  REG_4(.clk(clk),.rst(rst),.en(en),.in(In3),.out(Out3));
endmodule
