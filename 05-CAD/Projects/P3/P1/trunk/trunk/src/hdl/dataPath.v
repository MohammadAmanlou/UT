module dataPath #(parameter N) (clk, sel,done, wr, shift, rst3,rst6,rst7,rst9,rst11,rst5,rst12,rst8, en3,en6,en7,en9,en11,en5,en12,en10,en8, X,Y,Z, en2,en1,en4, cout3,cout6,cout7,cout9,cout11,cout5,cout8);
	input clk, wr, shift, rst3,rst6,rst7,rst9,rst11,rst5,rst12,rst8, en3,en6,en7,en9,en11,en5,en12,en10,en8;
	input sel, done;
	input [6:0] X,Y,Z;
	wire [31:0] addY,addX,addZ;
	input [15:0] en2,en4;
	input [15:0] en1 [0:N-1];  
	wire [7:0] buffer16Out [0:15];
	wire [7:0] buffer4_2Out [0:15];
   	wire [31:0] sumX,sumY,sumZ;
	wire [3:0] counterOut;
	wire [7:0] mac2Input;
	output cout3,cout6,cout7,cout9,cout11,cout5,cout8;
	wire [3:0] index;
	wire [31:0] muxOut;
	wire [7:0] memOut[3:0];

	mux2to1		mux1(.sel(sel),.a(sumX),.b(sumY),.out(muxOut));
	memory		myMem(.clk(clk),.address(muxOut),.wrData(),.wr(),.rdData(memOut));
	counter4	myCounter(.clk(clk),.rst(rst11),.en(en11),.cout(cout11),.count());

	counter64	xCounter(.clk(clk),.rst(rst6),.en(en6),.cout(cout6),.count(addX));
	counter43	zCounter(.clk(clk),.rst(rst7),.en(en7),.cout(cout7),.count(addZ));
	kernelCounter #(4*N) yCounter(.clk(clk),.rst(rst9),.en(en9),.count(addY),.cout(cout9));

	counter16	myCounter3(.clk(clk),.rst(rst5),.en(en5),.cout(cout5),.count(counterOut));

	mux16to1	mux2(.sel(counterOut),.in(buffer4_2Out),.out(mac2Input));

	buffer4x16	bigBuff(.clk(clk),.shift(shift),.en(en2),.dataIn(memOut),.readIdx(index),.dataOut(buffer16Out));
	counter13	myCounter2(.clk(clk),.rst(rst3),.en(en3),.cout(cout3),.count(index));
	buffer4x4	smallBuff(.clk(clk),.dataIn(buffer16Out),.en(en4),.dataOut(buffer4_2Out));
	genvar i;
    generate
        for (i = 0; i < N; i = i + 1)
        begin
		PE pe(.clk(clk),.bufferInput(memOut),.en1(en1[i]),.sel(counterOut),.mac2Input(mac2Input),
	.en2(en12),.rst2(rst12),.en3(en10),.en4(en8),.rst4(rst8),.wr(wr),.addr(sumZ),.cout4(cout8),.done(done),.number(i));
        end
    endgenerate
	
	assign sumX=addX+X;
	assign sumY=addY+Y;
	assign sumZ=addZ+Z;
endmodule