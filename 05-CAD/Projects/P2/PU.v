module PU(input [4:0] a1 , a2 , a3 , a4 , output [4:0] a_new , input clk , input en1 , en2 );
	wire [9:0] mult_out1 ,mult_out2, mult_out3, mult_out4 ;
	wire [9:0]  Xo1 , Xo2 , Xo3 , Xo4 ;
	mult m1(.D1(a1) , .D2(5'b01000) , .out(mult_out1));
	mult m2(.D1(a2) , .D2(5'b11110) , .out(mult_out2));
	mult m3(.D1(a3) , .D2(5'b11110) , .out(mult_out3));
	mult m4(.D1(a4) , .D2(5'b11110) , .out(mult_out4));
	memory10 mem1(.clk(clk), .rst(), .en(en1),.In0(mult_out1), .In1(mult_out2), .In2(mult_out3), .In3(mult_out4), .Out0(Xo1), .Out1(Xo2), .Out2(Xo3), .Out3(Xo4));
	wire [10:0] add10_res , add11_res;
	wire [9:0] add10_res_temp , add11_res_temp;
	wire add10_res_temp_cout , add11_res_temp_cout , add2_res_temp_cout;
	wire [10:0] add2_res_temp;
	wire [11:0]add2_res;
	wire exception1 , exception2 , exception3;
	Adder #11 add1(.a({Xo1[9],Xo1}), .b({Xo2[9],Xo2}), .cin(1'b0), .s(add10_res), .cout(add10_res_temp_cout));
	Adder #11 add11(.a({Xo3[9] , Xo3}), .b({Xo4[9],Xo4}), .cin(1'b0), .s(add11_res), .cout(add11_res_temp_cout));
	Adder #12 add2(.a({add10_res[10], add10_res}), .b({add11_res[10],add11_res}), .cin(1'b0), .s(add2_res), .cout(add2_res_temp_cout));
	wire [11:0] out;
	Mux2To1 #12 m21(.in0(add2_res), .in1(12'd0),.sel(add2_res[11]),.out(out));
	assign a_new = {out[11],out[6],out[5] , out[4] , out[3]};


endmodule
