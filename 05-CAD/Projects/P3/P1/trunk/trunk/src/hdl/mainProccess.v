module mainProccess #(parameter N) (clk,start,X,Y,Z,doneOut);
	input clk,start;
	input [6:0] X,Y,Z;	
	wire done;
	output doneOut;
	assign doneOut = done;

	wire rst3,rst5,rst6,rst7,rst8,rst9,rst11,rst12, en3,en5,en6,en7,en8,en9,en10,en11,en12, cout3,cout5,cout6,cout7,cout8,cout9,cout11, wr, shift;
	wire sel;
	wire [15:0] en2,en4;

	wire [15:0] en1 [0:N-1];  //////////////////

	controller #N myController(.clk(clk),.start(start),.cout3(cout3), .cout5(cout5), .cout6(cout6), .cout7(cout7), .cout8(cout8), .cout9(cout9),
	.cout11(cout11), .en1(en1), .en2(en2), .en3(en3), .en4(en4), .en5(en5), .en6(en6),.en7(en7),.en8(en8),.en9(en9), .en10(en10),
	.en11(en11), .en12(en12), .rst3(rst3),.rst5(rst5), .rst6(rst6), .rst7(rst7), .rst8(rst8), .rst9(rst9), .rst11(rst11), .rst12(rst12),
	.sel(sel), .shift(shift), .wr(wr), .done(done));

	dataPath #N myDataPath(.clk(clk),.rst6(rst6),.rst7(rst7),.rst9(rst9),.en6(en6),.en7(en7),.en9(en9),.cout6(cout6),.cout7(cout7),.cout9(cout9),
	.sel(sel),.done(done),.wr(wr),.rst11(rst11),.en11(en11),.cout11(cout11),.shift(shift),.en1(en1),.en2(en2),.en3(en3),.rst3(rst3),.cout3(cout3),
	.en4(en4),.rst5(rst5),.en5(en5),.cout5(cout5),.rst12(rst12),.en12(en12),.en10(en10),.rst8(rst8),.en8(en8), .cout8(cout8),.X(X),.Y(Y),.Z(Z));
endmodule
