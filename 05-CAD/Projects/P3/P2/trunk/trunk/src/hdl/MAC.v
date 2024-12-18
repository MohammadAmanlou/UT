module mac(
    input [7:0] a,
    input [7:0] b,
    input en,
    input rst,
    input clk,
    output reg [7:0] out
);
    wire [15:0] mult = a * b;
    reg [12:0] accumulator;

    always @(posedge clk ) begin
        if (rst)
            accumulator = 0;
        else if (en)
            accumulator = accumulator + mult[15:8];
    end
    
    // Assign the upper-mid 8 bits of the 16-bit result to 'out'
    // This is effectively the MSB byte of the accumulated sums of 'a' multiplied by 'b'.
    always @(*) begin
        out = accumulator[11:4];
    end
endmodule


module mac2(
    input [7:0] a,
    input [7:0] b,
    input en,
    input rst,
    input clk,
    output reg [12:0] out
);
    wire [15:0] mult = a * b;
    reg [12:0] accumulator;

    always @(posedge clk ) begin
        if (rst)
            accumulator = 0;
        else if (en)
            accumulator = accumulator + mult[15:8];
    end
    
    // Assign the upper-mid 8 bits of the 16-bit result to 'out'
    // This is effectively the MSB byte of the accumulated sums of 'a' multiplied by 'b'.
    always @(*) begin
        out = accumulator[12:0];
    end
endmodule

////everything is OK!
