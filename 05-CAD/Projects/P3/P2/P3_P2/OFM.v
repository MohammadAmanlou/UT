module OFM(clk, adr, in, we, done, number);
	input clk, done;
	input[31:0] number;
	input[31:0] adr;
	input[31:0] in;
	input we;
	reg [31:0] mem[0:511];

	always@(posedge clk)
	begin
		if(we)
		begin
			mem[adr] = in;
		end
	end

	integer file, i;
	initial 
	begin
		wait(done);
		file = $fopen($sformatf("output%0d_L1.txt", number+1), "w"); // ../../sim/file/output%0d_L1.txt
		for (i = 0; i < 511; i=i+1)
		begin
			$fwrite(file, "%08x\n", mem[i]);
		end
		$fclose(file);
	end
endmodule

////everything is OK!

module OFM2(clk, adr, in, we, done, number);
	input clk, done;
	input[31:0] number;
	input[31:0] adr;
	input[31:0] in;
	input we;
	reg [31:0] mem[0:511];

	always@(posedge clk)
	begin
		if(we)
		begin
			mem[adr] = in;
		end
	end

	integer file, i;
	initial 
	begin
		wait(done);
		file = $fopen($sformatf("output%0d_L2.txt", number+1), "w"); //../../sim/file/output%0d_L2.txt
		for (i = 0; i < 511; i=i+1)
		begin
			$fwrite(file, "%08x\n", mem[i]);
		end
		$fclose(file);
	end
endmodule

////everything is OK!

