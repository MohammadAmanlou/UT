module PWMTB();

reg [7:0] in;
reg clk = 0;
wire out;

pwm p(in , clk, out);
always #1 clk = ~clk;
initial begin

    in = 8'b00001000;


    #1000;
    in = 8'b10100100;
    #1000;
    $stop;
end
endmodule
