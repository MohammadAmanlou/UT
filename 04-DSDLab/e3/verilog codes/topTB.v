`timescale 1ns/1ns
module TopTB();


reg [1:0]amp_sel = 2'b00;
reg [2:0] MSB=3'b010;
reg [2:0] func =3'b100;

reg clk = 0;
reg rst , phase , ld_init;
wire out;


top t(clk , rst , phase , ld_init , amp_sel,  MSB ,func , out);
always #1 clk = ~clk;
initial begin
rst=1;
    ld_init=1;

    #100;
    rst=0;
ld_init=1;
    #100;
    ld_init=0;
	#10000
    $stop;
end
endmodule
