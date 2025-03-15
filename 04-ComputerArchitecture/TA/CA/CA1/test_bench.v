`timescale 1ns/1ns
module bench_test();
    reg rst = 1'b1 , clk = 1'b0 ;
    always #30 clk=~clk;
    risc_v CUT(clk ,rst);

    initial begin
        #10 rst=1'b0;
        // #120 PCNext=32'd25;
        // #120 PCNext=32'd58;
        // #120 PCNext=32'd98;
        // #120 PCNext=32'd125;
        // #120 PCNext=32'd1002;
        #5000 $stop;
    end
endmodule