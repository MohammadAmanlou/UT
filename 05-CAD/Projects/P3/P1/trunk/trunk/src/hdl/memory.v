module memory(clk, address, wrData, wr, rdData);
	input clk;
	input[31:0] address;
	input[7:0] wrData[3:0];
	input wr;
	output[7:0] rdData[0:3];
	reg [31:0] mem[0:127];
	initial
	begin
		$readmemh("file/input.txt", mem);
	end
	
	

	assign rdData[0] = mem[address][31:24];
	assign rdData[1] = mem[address][23:16];
	assign rdData[2] = mem[address][15:8];
	assign rdData[3] = mem[address][7:0];

	always@(posedge clk)
	begin
		if(wr)
		begin
			mem[address][31:24] = wrData[0];
			mem[address][23:16] = wrData[1];
			mem[address][15:8] = wrData[2];
			mem[address][7:0] = wrData[3];
		end
	end
	
endmodule
