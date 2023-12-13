`define 	Begin	3'b000
`define 	Init	3'b001
`define 	Mult	3'b010
`define 	Add	3'b011
`define 	Decode	3'b100
`define 	Done	3'b101


module Controller(input clk,done,start,output reg en1 , en2 , en3 , sel );
	
	reg[2:0] ps=3'b0,ns;
	always@(posedge clk)begin
		ps<=ns;
	end

	always@(ps ,start , done )begin 
		case(ps)
		`Begin:ns = (start) ? `Init : `Begin;
		`Init:ns = `Add ; 
		`Mult:ns=`Add;
		`Add :	ns=`Decode;
		`Decode :ns= (done) ? `Done : `Mult;
		`Done :	ns=`Begin;
		endcase
	end

	always@(ps)begin
		{sel , en3 , en2 , en1 }=4'b0000;
		case(ps)
		`Begin:{en3} = 1'b1;
		`Init :{sel , en1 }=2'b11;
		`Mult :{en1}=1'b1;
		`Add : en2 = 1'b1;
		`Done :{en3 }=1'b1;
		endcase
	end
endmodule




