module kernelCounter #(parameter N) (clk,rst,en,count,cout);
    input clk,rst,en;
    output reg [31:0] count;
    output cout;
    always @(posedge clk) begin
        if (rst) 
            count <= 0;
        if(en)begin
            if (count == (N-1))
                count <= 0;
            else
                count <= count + 1'b1;
        end
    end
    assign cout = (count == (N-1)) ? 1'b1 : 1'b0;
endmodule