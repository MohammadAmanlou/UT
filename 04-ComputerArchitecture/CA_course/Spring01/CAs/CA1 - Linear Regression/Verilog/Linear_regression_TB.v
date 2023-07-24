`timescale 1ns/1ns

`include "Linear_regression.v"

module Linear_regression_TB();
    wire [19:0] b0, b1, err;
    wire ready, errDone;

    reg [19:0] x, y;
    reg start = 1'b0, clk = 1'b0, rst = 1'b0;

    reg [19:0] memX [0:149];
    reg [19:0] memY [0:149];
    reg [19:0] errs [0:149];

    integer i;
    integer xFile, errFile;

    Linear_regression linear_regression(x, y, start, clk, rst, b0, b1, err, ready, errDone);

    always #5 clk = ~clk;

    initial begin
        // xFile = $fopen("x_value.txt", "rb");
        // for (i = 0; i < 150; i = i + 1)
        //     $fscanf(xFile, "%b.%b", memX[i][19:10], memX[i][9:0]);
        // $fclose(xFile);
        $readmemb("x_value.txt", memX);
        $readmemb("y_value.txt", memY);

        #5 start = 1'b1;
        #10 while (~ready) #10; // Wait until module is ready
        start = 1'b0;

        for (i = 0; i < 150; i = i + 1) begin: SendData
            x = memX[i];
            y = memY[i];
            #20;
        end

        for (i = 0; i < 150; i = i + 1) begin: GetErrors
            while (~errDone) #10; // Wait until error is ready
            errs[i] = err;
            #10;
        end

        // $writememb("error_value.txt", errs);
        errFile = $fopen("error_value.txt", "wb");
        for (i = 0; i < 150; i = i + 1) begin: SaveErrors
            // $fdisplay(errFile, "%b_%b", errs[i][19:10], errs[i][9:0]);
            $fdisplayb(errFile, errs[i]);
        end
        $fclose(errFile);

        $finish;
    end
endmodule
