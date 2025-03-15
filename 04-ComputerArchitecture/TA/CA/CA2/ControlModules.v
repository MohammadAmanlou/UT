module decoder(input[6:0]Opcode,output reg RegWrite,MemWrite,ALUSrc,Branch,Jump,wass,output reg [2:0]ImmSrc,output reg [1:0] ResultSrc,ALUOp);
	always @(Opcode)begin
	RegWrite=1'b0;MemWrite=1'b0;ALUSrc=1'b0;Branch=1'b0;Jump=1'b0;ImmSrc=3'b0;ResultSrc=2'b0;ALUOp=2'b0;wass=1'b0;
		case(Opcode)
		3:begin RegWrite=1'b1;ImmSrc=3'b000;ALUSrc=1'b1;ResultSrc=2'b01;ALUOp=2'b00;end//lw
		35:begin MemWrite=1'b1;ImmSrc=3'b001;ALUSrc=1'b1;ALUOp=2'b00; end//sw
		51:begin RegWrite=1'b1;ALUSrc=1'b0;ResultSrc=2'b00;ALUOp=2'b10;end//R-type
		99:begin ImmSrc=3'b010;ALUSrc=1'b0;ALUOp=2'b01;Branch=1'b1;end//beq & bne
		19:begin RegWrite=1'b1;ImmSrc=3'b000;ALUSrc=1'b1;ResultSrc=2'b00;ALUOp=2'b10;end//I-type
		111:begin RegWrite=1'b1;ImmSrc=3'b011;ResultSrc=2'b10;Jump=1'b1;end//jal
		55:begin RegWrite=1'b1;ImmSrc=3'b100;ALUSrc=1'b1;ALUOp=2'b0;ResultSrc=2'b0;end//Lui
		103:begin RegWrite=1'b1;ImmSrc=3'b000;ALUSrc=1'b1;ALUOp=2'b0;ResultSrc=2'b10;wass=1'b1;end//jalr
		endcase
	end
endmodule

module ALUdecoder(input[2:0]funct3,input op5,funct75,input[1:0]ALUOp,output reg[2:0] ALUControl);
	always@(funct3,funct75,op5,ALUOp)begin
	ALUControl=3'b0;
		case(ALUOp)
		0:ALUControl=3'b0;
		1:ALUControl=3'b001;
		2:begin ALUControl=(funct3==3'b0 & {op5,funct75}!=2'b11)?3'b0:
			  ({funct3,op5,funct75}==5'b00011)?3'b001:
			  (funct3==3'b100)?3'b100:
			  (funct3==3'b010)?3'b101:
			  (funct3==3'b110)?3'b011:
			  (funct3==3'b111)?3'b010:3'b0;end
		endcase
	end
endmodule
module Controller(input[2:0] funct3,input[6:0] funct7,Opcode,output MemWrite,ALUSrc,RegWrite,Jump,Branch,Jalr,output [1:0] ResultSrc,output [2:0] ALUControl,ImmSrc);
wire [1:0]ALUOp;
decoder fdf(Opcode,RegWrite,MemWrite,ALUSrc,Branch,Jump,Jalr,ImmSrc,ResultSrc,ALUOp);
ALUdecoder fde(funct3,Opcode[5],funct7[5],ALUOp,ALUControl);
endmodule
module Decodereeee(input JalrE,JumpE,BranchE,ZeroE,input[2:0] func3,output[1:0] PCSrc);
	assign PCSrc={(JalrE),((JumpE)||(BranchE && (func3[0]^ZeroE)))};
endmodule