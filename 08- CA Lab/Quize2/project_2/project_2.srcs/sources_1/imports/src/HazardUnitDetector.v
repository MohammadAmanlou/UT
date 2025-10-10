module HazardUnitDetector(
    input [3:0] rn,
    input [3:0] register_file_mux_out,
    input [3:0] Exe_Dest,
    input       Exe_WB_EN,
    input       Exe_MEM_R_EN,
    input [3:0] Mem_Dest,
    input       Mem_WB_EN,
    input       is_two_source,
    input       has_forwarding_unit,
    output reg  hazard_detected
);

always @(*) begin
    hazard_detected = 0;
    if (!has_forwarding_unit) begin
        if (Exe_WB_EN) begin
            if (rn == Exe_Dest || (is_two_source && register_file_mux_out == Exe_Dest))
                hazard_detected = 1;
        end
        if (Mem_WB_EN) begin
            if (rn == Mem_Dest || (is_two_source && register_file_mux_out == Mem_Dest))
                hazard_detected = 1;
        end
    end
    if (has_forwarding_unit && Exe_MEM_R_EN) begin
        if (rn == Exe_Dest || (is_two_source && register_file_mux_out == Exe_Dest))
            hazard_detected = 1;
    end
end
endmodule