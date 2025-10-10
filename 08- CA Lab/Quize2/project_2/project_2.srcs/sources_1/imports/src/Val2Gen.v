module Val2Gen (
    input [31:0] Val_Rm,           
    input [11:0] Shift_operand,  
    input Shift_type,              
    input I,                       
    output reg [31:0] Val2
);

wire [63:0] RegA = {24'b0,Shift_operand[7:0],24'b0,Shift_operand[7:0]};

always @(*) begin
    if (Shift_type == 1) begin
        Val2 = {20'b0,Shift_operand};
    end
    else if (I == 1) begin
            Val2 = RegA[31+(Shift_operand[11:8]<<1)-:32];
        end 
    else begin
            case (Shift_operand[6:5])
                2'b00: Val2 = Val_Rm << Shift_operand[11:7];  
                2'b01: Val2 = Val_Rm >> Shift_operand[11:7];
                2'b10: Val2 = $signed(Val_Rm) >>> Shift_operand[11:7];
                2'b11: Val2 = RegA[31+(Shift_operand[11:8])-:32];
            endcase
        end
end

endmodule

