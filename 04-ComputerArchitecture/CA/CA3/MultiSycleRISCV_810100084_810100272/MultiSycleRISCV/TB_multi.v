`timescale 1ns/1ns


module TB ();
    reg clk = 1'b0 , rst=1'b0;

    top_level risc(clk);

    always #1 clk = ~clk;
	initial begin
		#10
		rst = 1'b1;
		#10 rst=1'b0;
		#1000
    $stop;
	end

endmodule


