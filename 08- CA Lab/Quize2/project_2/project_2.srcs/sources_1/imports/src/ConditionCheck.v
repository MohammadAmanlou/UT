module ConditionCheck(
    input [3:0] opcode,
    input [3:0] status, //NZCV
    output reg condOut
);
    wire Z;
    wire C;
    wire N;
    wire V;
    assign V = status[0];
    assign C = status[1];
    assign Z = status[2];
    assign N = status[3];
    always @(*) begin
        case (opcode)
            4'd0:
                condOut = Z;
            4'd1:
                condOut = ~Z;
            4'd2:
                condOut = C;
            4'd3:
                condOut = ~C;
            4'd4:
                condOut = N;
            4'd5:
                condOut = ~N;
            4'd6:
                condOut = V;
            4'd7:
                condOut = ~V;
            4'd8:
                condOut = C & ~Z;
            4'd9:
                condOut = ~C | Z;
            4'd10:
                condOut = N == V;
            4'd11:
                condOut = N != V;
            4'd12:
                condOut = Z==0 & N==V;
            4'd13:
                condOut = Z == 1'b1 | N!=V;
            4'd14:
                condOut = 1'b1;
            4'd15:
                condOut = 1'b1;
            default: 
                condOut = 1'b1;
        endcase
    end
endmodule