
module top_level(input clk);
	wire PCWrite,AdrSrc,MemWrite,WDSrc,IRWrite,RegWrite;
	wire[1:0] ResultSrc,ALUSrcA,ALUSrcB;
	wire[2:0] ALUControl,ImmSrc;
	wire zero , sign;
	wire[6:0] func7;
	wire[2:0] func3;
	wire [6:0] opcode;
	Datapath dp(clk,PCWrite,AdrSrc,MemWrite,IRWrite,RegWrite ,ResultSrc,ALUSrcA,ALUSrcB ,ALUControl,ImmSrc,
		zero , sign , func7 ,func3,opcode);
	 Controller cl(clk,zero,sign,opcode,func7,
		func3,PCWrite,AdrSrc,MemWrite,IRWrite,RegWrite,ResultSrc,ALUSrcA,ALUSrcB,ALUControl,ImmSrc);
endmodule
	
	
	