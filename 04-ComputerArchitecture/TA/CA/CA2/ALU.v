`timescale 1ps/1ps
module ALU (
    oporand1,
    oporand2,
    f,
    result,
    Zero

);
    input [31:0] oporand1;
    input [31:0] oporand2;
    input [2:0]f;
    output reg [31:0]result;
    output reg Zero;

    always @(oporand1,oporand2,f) begin
        case (f)
            3'b001: begin result=oporand1-oporand2;Zero = (result == 32'b0)? 1'b1:1'b0 ;end
            3'b010: begin result=oporand1&oporand2;Zero = (result == 32'b0)? 1'b1:1'b0 ;end
            3'b011: begin result=oporand1|oporand2;Zero = (result == 32'b0)? 1'b1:1'b0 ;end
            3'b101: begin result=(oporand1[31]==0 & oporand2[31]==0)?{31'b0,(oporand1<oporand2)}:
						  (oporand1[31]==1&oporand2[31]==0)?{31'b0,1'b1}:
					      (oporand1[31]==0&oporand2[31]==1)?{31'b0,1'b0}:
						  (oporand1[31]==1 & oporand2[31]==1)?{31'b0,(oporand1>oporand2)}:32'b0;Zero = (result == 32'b0)? 1'b1:1'b0 ;end
            3'b000: begin result=oporand1+oporand2;Zero = (result == 32'b0)? 1'b1:1'b0 ;end
			3'b100: begin result=oporand1^oporand2;Zero = (result == 32'b0)? 1'b1:1'b0 ;end
            default: begin result = 32'b0;Zero=1'b0;end
        endcase
    end
    
endmodule