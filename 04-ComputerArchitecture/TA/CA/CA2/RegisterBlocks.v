module IF_ID_Regs(input clk,sclr,en,input[31:0] InstrF,PCF,PCPlus4F,output[31:0] InstrD,PCD,PCPlus4D);
	Register	R33(clk,en,sclr,InstrF,InstrD);
	Register	R34(clk,en,sclr,PCF,PCD);
	Register	R35(clk,en,sclr,PCPlus4F,PCPlus4D);
endmodule


module ID_EX_Regs(input clk,sclr,RegWriteD,MemWriteD,ALUSrcD,JumpD,BranchD,JalrD,input[1:0] ResultSrcD,input [2:0] ALUControlD,func3D,input[4:0] Rs1D,
	Rs2D,RdD,input[31:0]  PCD,ExtImmD,PCPlus4D,RD1D,RD2D,output RegWriteE,MemWriteE,ALUSrcE,JumpE,BranchE,JalrE,output[1:0] ResultSrcE,
	output [2:0] ALUControlE,func3E,output[4:0] Rs1E,Rs2E,RdE,output[31:0]  PCE,ExtImmE,PCPlus4E,RD1E,RD2E);
	Register		R1(clk,1'b1,sclr,RegWriteD,RegWriteE);
	Register		R2(clk,1'b1,sclr,MemWriteD,MemWriteE);
	Register		R3(clk,1'b1,sclr,JumpD,JumpE);
	Register		R4(clk,1'b1,sclr,ALUSrcD,ALUSrcE);
	Register		R5(clk,1'b1,sclr,BranchD,BranchE);
	Register		R6(clk,1'b1,sclr,JalrD,JalrE);
	Register		R7 (clk,1'b1,sclr,ResultSrcD,ResultSrcE);
	Register		R8 (clk,1'b1,sclr,ALUControlD,ALUControlE);
	Register		R9 (clk,1'b1,sclr,func3D,func3E);
	Register		R10 (clk,1'b1,sclr,Rs1D,Rs1E);
	Register		R11 (clk,1'b1,sclr,Rs2D,Rs2E);
	Register		R12 (clk,1'b1,sclr,RdD,RdE);
	Register		R13 (clk,1'b1,sclr,PCD,PCE);
	Register		R14(clk,1'b1,sclr,ExtImmD,ExtImmE);
	Register		R15(clk,1'b1,sclr,PCPlus4D,PCPlus4E);
	Register		R16(clk,1'b1,sclr,RD1D,RD1E);
	Register		R17(clk,1'b1,sclr,RD2D,RD2E);
endmodule


module EX_Mem_Regs(input clk,RegWriteE,MemWriteE,input [1:0] ResultSrcE,input[4:0] RdE,input[31:0] ALUResultE,WriteDataE,ExtImmE,
	PCPlus4E,output RegWriteM,MemWriteM,output [1:0] ResultSrcM,output[4:0] RdM,output[31:0] ALUResultM,WriteDataM,ExtImmM,
	PCPlus4M);
	Register		R18(clk,1'b1,1'b0,RegWriteE,RegWriteM);
	Register		R19(clk,1'b1,1'b0,MemWriteE,MemWriteM);
	Register		R20 (clk,1'b1,1'b0,ResultSrcE,ResultSrcM);
	Register		R21 (clk,1'b1,1'b0,RdE,RdM);
	Register		R22 (clk,1'b1,1'b0,ALUResultE,ALUResultM);
	Register		R23 (clk,1'b1,1'b0,WriteDataE,WriteDataM);
	Register		R24 (clk,1'b1,1'b0,ExtImmE,ExtImmM);
	Register		R25 (clk,1'b1,1'b0,PCPlus4E,PCPlus4M);
endmodule


module Mem_WB_Regs(input clk,RegWriteM,input[1:0] ResultSrcM,input[4:0] RdM,input[31:0]	ALUResultM,ReadDataM,ExtImmM,PCPlus4M,
	output RegWriteW,output[1:0] ResultSrcW,input[4:0] RdW,output[31:0]	ALUResultW,ReadDataW,ExtImmW,PCPlus4W);
	Register		R26(clk,1'b1,1'b0,RegWriteM,RegWriteW);
	Register		R27 (clk,1'b1,1'b0,ResultSrcM,ResultSrcW);
	Register		R28 (clk,1'b1,1'b0,RdM,RdW);
	Register		R29 (clk,1'b1,1'b0,ALUResultM,ALUResultW);
	Register		R30 (clk,1'b1,1'b0,ReadDataM,ReadDataW);
	Register		R31 (clk,1'b1,1'b0,ExtImmM,ExtImmW);
	Register		R32 (clk,1'b1,1'b0,PCPlus4M,PCPlus4W);
endmodule

