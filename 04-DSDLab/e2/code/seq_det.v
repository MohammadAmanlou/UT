`define A 3'b000
`define B 3'b001
`define C 3'b010
`define D 3'b011
`define E 3'b100
`define F 3'b101
`define G 3'b110

module sequence_dec (input clk, rst, serIn , clkEn , Co , output serOut , serOutValid, rst_cnt , inc_cnt);
	reg [2:0] ps, ns ;
	always@(posedge clk, posedge rst)begin
		if(rst)	
			ps <= `A;
		else
			ps <= ns;
	end

	always@(posedge clk) begin
		if( clkEn) begin
			case (ps)
				`A :ns = serIn? `B : `A ;
				`B :ns = serIn? `C : `A ;
				`C : ns =serIn? `C : `D;
				`D: ns =serIn? `E : `A;
				`E : ns = serIn?`C : `F ;
				`F: ns = serIn? `G: `A ;
				`F: ns = serIn? `C: `A ;
				default ns = `A ;

			endcase
		end



	end

	

endmodule
