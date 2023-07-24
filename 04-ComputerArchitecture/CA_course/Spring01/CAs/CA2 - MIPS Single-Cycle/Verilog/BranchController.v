module BranchController (branch, zero, pcSrc);
    input branch, zero;
    output pcSrc;
    reg pcSrc;

    always @(branch or zero) begin
        pcSrc = 1'b0;

        if (branch & zero)
            pcSrc = 1'b1;
    end
endmodule
