module CombShift (
    input [1:0] shift,
    input [17:0] data_in,
    output [20:0] data_out
);
    assign data_out = {3'b0, data_in} << shift;
endmodule