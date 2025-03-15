`timescale 1ps/1ps
module pc (
    clk,
    next,
    present,
    rst
);
    output reg [31:0] present;
    input clk;
    input [31:0] next;
    input rst;
    always @(posedge clk,posedge rst) begin
        if (rst)begin
            present<=32'b0;
            
        end
        else begin
            present <= next;
        end
    end

endmodule