`define 	R_Type	7'b0110011
`define 	I_Type	7'b0010011
`define		Lw	7'b0000011
`define 	Jalr	7'b1100111
`define		S_Type	7'b0100011
`define		J_Type	7'b1101111
`define 	B_Type	7'b1100011
`define		U_Type	7'b0110111


`define		Add	10'b0000_0000_00
`define 	Sub	10'b0100_0000_00
`define		And	10'b0000_0001_11
`define 	Or	10'b0000_0001_10
`define		Slt	10'b0000_0000_10


`define		lw	3'b010
`define 	addi	3'b000
`define		xori	3'b100
`define 	ori	3'b110
`define		slti	3'b010
`define		jalr	3'b000


`define		beq	3'b000
`define 	bne	3'b001
`define		blt	3'b100
`define 	bge	3'b101



module Controller(input[2:0] func3,input[6:0] func7,op,output reg MemWrite,ALUSrc,RegWrite,Jump,Branch,Jalr,output reg [1:0] ResultSrc,output reg [2:0] ALUControl,ImmSrc);
	wire[9:0] func;
	assign func={func7,func3};
	always@(func3,func7,op) begin
		{MemWrite,ALUSrc,RegWrite,Jump,Branch,Jalr,ResultSrc,ALUControl,ImmSrc}=14'b0000_0000_0000_00;
		case(op)
			`R_Type:begin
				RegWrite=1'b1;
				case(func)
					`Add:;
					`Sub:ALUControl=3'b001;
					`And:ALUControl=3'b010;
					`Or :ALUControl=3'b011;
					`Slt:ALUControl=3'b101;
				endcase
				end
			`Lw:	{RegWrite,ResultSrc,ALUSrc}=4'b1011;
			`I_Type:begin
				{ALUSrc,RegWrite}=2'b11;
				case(func3)					
					`addi:;
					`xori:ALUControl=3'b100;
					`ori :ALUControl=3'b011;
					`slti:ALUControl=3'b101;
				endcase
				end
			`Jalr:	{Jalr,ALUSrc,ResultSrc,RegWrite}=5'b11101;
			`S_Type:	{ImmSrc,ALUSrc,MemWrite}=5'b00111;
			`J_Type:	{ResultSrc,ImmSrc,RegWrite,Jump}=7'b1001011;
			`B_Type:begin 
				{Branch,ImmSrc}=4'b1011;
				case(func3)
					`beq:	ALUControl=3'b001;
					`bne:	ALUControl=3'b001;
					`blt:	ALUControl=3'b101;
					`bge:	ALUControl=3'b101;
				endcase
				end
			`U_Type:	{ResultSrc,ImmSrc,RegWrite}=6'b111001;
		endcase
	end
endmodule






module Controller2(input zero , sign , input[6:0] opcode , input[2:0] func3 , input[6:0] func7 ,
	output reg [1:0] PCSrc , output reg[1:0] ResultSrc , output reg MemWrite ,  output reg [2:0] ALUControl , output reg ALUSrc ,
	output reg[2:0] ImmSrc ,output reg RegWrite);
	reg branch ;
	always@(opcode,func3,func7)begin
		case(opcode)
			7'b0110011:begin 
				RegWrite<=1; ImmSrc<=3'b000; ALUSrc<=0; MemWrite<=0; ResultSrc<=2'b00; PCSrc<=2'b00;
				if(func7 == 7'b0000000 & func3 == 3'b000)begin ALUControl=3'b010; end //add
				else if(func7 == 7'b0100000 & func3 == 3'b000) begin ALUControl=3'b110; end //sub
				else if(func7 == 7'b0000000 & func3 == 3'b010) begin ALUControl=3'b111; end //slt
				else if(func7 == 7'b0000000 & func3 == 3'b110) begin ALUControl=3'b001; end //or
				else if(func7 == 7'b0000000 & func3 == 3'b111) begin ALUControl=3'b000; end //and
			 end
			7'b0000011:begin 
				RegWrite<=1; ImmSrc<=3'b000; ALUSrc<=1; MemWrite<=0; ResultSrc<=2'b01; PCSrc<=2'b00;
				if(func3 == 3'b010)begin ALUControl=3'b010; end //lw
			 end
			7'b0010011:begin
				RegWrite<=1; ImmSrc<=3'b000; ALUSrc<=1; MemWrite<=0; ResultSrc<=2'b00; PCSrc<=2'b00;
				if(func3 == 3'b000) begin ALUControl=3'b010; end //addi
				if(func3 == 3'b010) begin ALUControl=3'b111; end //slti
				if(func3 == 3'b100) begin ALUControl=3'b011; end //xori
				if(func3 == 3'b110) begin ALUControl=3'b001; end //ori
			end
			7'b1100111:begin
				RegWrite<=1; ImmSrc<=3'b000; ALUSrc<=1; MemWrite<=0; ResultSrc<=2'b10; PCSrc<=2'b10;
				if(func3 == 3'b000) begin ALUControl=3'b010; end //jalr
			end
			7'b0100011:begin
				RegWrite<=0; ImmSrc<=3'b001; ALUSrc<=1; MemWrite<=1; ResultSrc<=2'b00; PCSrc<=2'b00;
				if(func3 == 3'b010) begin ALUControl=3'b010; end //sw
			end
			7'b1101111:begin
				RegWrite<=1; ImmSrc<=3'b011; ALUSrc<=0; MemWrite<=0; ResultSrc<=2'b10; PCSrc<=2'b01;
				ALUControl=3'b010;//jal
			end
			7'b1100011:begin
				RegWrite<=0; ImmSrc<=3'b010; ALUSrc<=0; MemWrite<=0; ResultSrc<=2'b00;
				if(func3 == 3'b000)begin ALUControl=3'b110; if(zero == 1) PCSrc=1; else PCSrc=2'b00; end //beq
				if(func3 == 3'b001)begin ALUControl=3'b110; if(zero == 1) PCSrc=0; else PCSrc=2'b01; end //bne
				if(func3 == 3'b100)begin ALUControl=3'b110; if(sign == 1) PCSrc=1; else PCSrc=2'b00; end //blt
				if(func3 == 3'b101)begin ALUControl=3'b110; if(sign == 0 | zero ==1) PCSrc=1; else PCSrc=2'b00; end //bge
			end
			7'b0110111:begin
				RegWrite<=1; ImmSrc<=3'b100; ALUSrc<=1; MemWrite<=0; ResultSrc<=2'b11; PCSrc<=2'b00;
				ALUControl=3'b010;//lui
			end
		endcase
	end
endmodule
