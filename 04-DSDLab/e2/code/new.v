module TopTB();


reg [1:0]amp_sel;
reg [2:0] MSB=3'b010;
reg [2:0] func =3'b110
reg [2:0] freq_sel = 3'b001;
reg clk = 0;
reg rst , phase , ld_init;
wire out;


top t(input clk , rst , phase , ld_init , amp_sel, MSB ,func , freq_sel, out);
always #1 clk = ~clk;
initial begin
	rst=1;
    ld_init=1;
	
    #100;
    rst=0;
ld_init=1;
    #100;
   rst=1;
    ld_init=0;
    #100;
    rst=0;
ld_init=0;
    $stop;
end
endmodule
