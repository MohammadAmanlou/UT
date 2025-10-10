module StatusReg(
    input clk,
    input rst,
    input s, //en
    input [3:0] status_bits,
    output reg [3:0] status_out //NZCV
);
    always @(negedge clk or posedge rst) begin
        
        if(rst)
            status_out <= 0;
        else if(s) begin
            status_out <= status_bits;
        end
    end

endmodule