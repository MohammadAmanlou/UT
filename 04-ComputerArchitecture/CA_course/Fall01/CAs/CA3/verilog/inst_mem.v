module inst_mem (adr, d_out);
  input [31:0] adr;
  output [31:0] d_out;
  
  reg [7:0] mem[0:65535];
  
  initial
  begin
    //         add    R10, R0, R0
    //         addi   R1,  R0, 20
    // Loop:   beq    R1,  R0, END
    //         lw     R11, 100(R1)
    //    	    add    R10, R10, R11
    //         addi   R1, R1, -4
    //         beq    R0, R0, Loop
    // END:    sw     R10, 200(R0)
    
    {mem[3], mem[2], mem[1], mem[0]}     = {6'h00, 5'd0, 5'd0, 5'd10, 5'd0, 6'h20};   
    {mem[7], mem[6], mem[5], mem[4]}     = {6'h09, 5'd0, 5'd1, 16'd20};               
    {mem[11], mem[10], mem[9], mem[8]}   = {6'h04, 5'd1, 5'd0, 16'd4};                
    {mem[15], mem[14], mem[13], mem[12]} = {6'h23, 5'd1, 5'd11, 16'd100};           
    {mem[19], mem[18], mem[17], mem[16]} = {6'h00, 5'd10, 5'd11, 5'd10, 5'd0, 6'h20}; 
    {mem[23], mem[22], mem[21], mem[20]} = {6'h09, 5'd1, 5'd1, -16'd4};               
    {mem[27], mem[26], mem[25], mem[24]} = {6'h04, 5'd0, 5'd0, -16'd5};               
    {mem[31], mem[30], mem[29], mem[28]} = {6'h2B, 5'd0, 5'd10, 16'd200};           	 
    
  end
  
  assign d_out = {mem[adr[15:0]+3], mem[adr[15:0]+2], mem[adr[15:0]+1], mem[adr[15:0]]};
  
endmodule
