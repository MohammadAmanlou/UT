module IRReg(input[31:0] PC , Inst , input clk , IRWrite , output reg [31:0] OldPC , Instr);
	
	always @(posedge clk) begin
		if(IRWrite) begin
			Instr = Inst;
			OldPC = PC;
		end
    	end
endmodule