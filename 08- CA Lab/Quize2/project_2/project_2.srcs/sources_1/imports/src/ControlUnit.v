module ControlUnit(
    input  [31:0] instruction,
    output reg    WB_EN,
    output reg    imm,
    output reg    MEM_R_EN,
    output reg    MEM_W_EN,
    output reg    B,
    output reg [3:0] EXE_CMD,
    output    S
);

    wire [1:0] mode   = instruction[27:26];
    wire       I      = instruction[25];
    wire [3:0] opcode = instruction[24:21];
    assign S = instruction[20];    
    always @(*) begin
        WB_EN   = 0;
        imm     = 0;
        MEM_R_EN = 0;
        MEM_W_EN = 0;
        B       = 0;
        EXE_CMD = 4'b0000;
        
        if(instruction[27:25] == 3'b101) begin
            B = 1;
	    imm = 1;
        end
        else if(mode == 2'b00) begin
            imm = I;
            case(opcode)
                4'b1101: begin
                    EXE_CMD = 4'b0001;
                    WB_EN   = 1;
                end
                4'b1111: begin
                    EXE_CMD = 4'b1001;
                    WB_EN   = 1;
                end
                4'b0100: begin
                    EXE_CMD = 4'b0010;
                    WB_EN   = 1;
                end
                4'b0101: begin
                    EXE_CMD = 4'b0011;
                    WB_EN   = 1;
                end
                4'b0010: begin
                    EXE_CMD = 4'b0100;
                    WB_EN   = 1;
                end
                4'b0110: begin
                    EXE_CMD = 4'b0101;
                    WB_EN   = 1;
                end
                4'b0000: begin
                    EXE_CMD = 4'b0110;
                    WB_EN   = 1;
                end
                4'b1100: begin
                    EXE_CMD = 4'b0111;
                    WB_EN   = 1;
                end
                4'b0001: begin
                    EXE_CMD = 4'b1000;
                    WB_EN   = 1;
                end
                4'b1010: begin
                    EXE_CMD = 4'b0100;
                    WB_EN   = 0;
                end
                4'b1000: begin
                    EXE_CMD = 4'b0110;
                    WB_EN   = 0;
                end
                4'b0011: begin
                    WB_EN    = 1;
                    EXE_CMD   = 4'b1111;
                end
                default: begin
                    EXE_CMD = 4'b0000;
                    WB_EN   = 0;
                end
            endcase
        end
        else if(mode == 2'b01) begin
            EXE_CMD = 4'b0010;
            if(instruction[20] == 1) begin
                MEM_R_EN = 1;
                WB_EN = 1;
            end else begin
                MEM_W_EN = 1;
            end
        end
        else begin
            WB_EN   = 0;
            imm     = 0;
            MEM_R_EN = 0;
            MEM_W_EN = 0;
            EXE_CMD = 4'b0000;
            B       = 0;
        end
    end

endmodule

