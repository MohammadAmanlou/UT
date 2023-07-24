module instmem_least_find (adr, d_out);
  input [31:0] adr;
  output [31:0] d_out;
  reg [7:0] mem[0:65535];
  initial

  begin

    // First:   lw     R1,1000(R0)            A[0]                                       0
    //         add   R2,  R0, R0              index                                      4 
    //         add   R3,  R0, R0              4(i)                                       8 
    //         addi   R5, R0,80              (20*4)                                     12
    //         add   R6, R0,R0               for loop variable 1(i)                     16
    // Loop:   beq    R3,  R5, END           check if the for loop is finished          20
    //         addi   R3,  R3,4              i += 4                    4(i)              24
    //         addi   R6, R6,1               index +=1             1(i)                 28
    //         lw     R10,1000(R3)           A[i+1]                                     32
    //         slt    R4,R10,R1              check which one is the least new or saved  36
    //         beq    R4,R0,LOOP             if smaller then new num back to loop       40
    //         add    R1, R0, R10            update new least num                       44
    //         add    R2, R0, R6             update new index                           48
    //         j      LOOP                   get back to the loop                       52
    // END:    sw     R1, 2000(R0)           save the least item                        56
    //         sw     R10, 2004(R0)          save the index of least                    60 
    //         j     R10, 2004(R0)           j First                                    64 

    //{mem[3], mem[2], mem[1], mem[0]}     = {6'h23, 5'd0, 5'd1, 16'd1000};              //0
    //{mem[7], mem[6], mem[5], mem[4]}     = {6'h00, 5'd0, 5'd0, 5'd2, 5'd0, 6'h20 };    //4        
    //{mem[11], mem[10], mem[9], mem[8]}   = {6'h00, 5'd0, 5'd0, 5'd3, 5'd0, 6'h20};     //8    
    //{mem[15], mem[14], mem[13], mem[12]} = {6'h00, 5'd0, 5'd0, 5'd6, 5'd0, 6'h20};     //12    
    //{mem[19], mem[18], mem[17], mem[16]} = {6'h09, 5'd0, 5'd5, 16'd80};                //16  
    //{mem[23], mem[22], mem[21], mem[20]} = {6'h04, 5'd3, 5'd5, 16'd8};                 //20
    //{mem[27], mem[26], mem[25], mem[24]} = {6'h09, 5'd6, 5'd6, 16'd1};                 //24
    //{mem[31], mem[30], mem[29], mem[28]} = {6'h09, 5'd3, 5'd3, 16'd4};                 //28     
    //{mem[35], mem[34], mem[33], mem[32]} = {6'h23, 5'd3, 5'd10, 16'd1000};             //32          
    //{mem[39], mem[38], mem[37], mem[36]} = {6'h00, 5'd10, 5'd1, 5'd4, 5'd0,6'b101010}; //36      
    //{mem[43], mem[42], mem[41], mem[40]} = {6'h04, 5'd4, 5'd0, -16'd6};                //40     
    //{mem[47], mem[46], mem[45], mem[44]} = {6'h00, 5'd0, 5'd10, 5'd1, 5'd0, 6'h20};    //44
    //{mem[51], mem[50], mem[49], mem[48]} = {6'h00, 5'd0,5'd6, 5'd2, 5'd0, 6'h20};      //48            
    //{mem[55], mem[54], mem[53], mem[52]} = {6'b000010, 26'd5};                         //52
    //{mem[59], mem[58], mem[57], mem[56]} = {6'h2B, 5'd0, 5'd1, 16'd2000};              //56
    //{mem[63], mem[62], mem[61], mem[60]} =  {6'h2B, 5'd0, 5'd2, 16'd2004};             //60
    //{mem[67], mem[66], mem[65], mem[64]} = {6'b000010, 26'd0};                         //64
    $readmemb("instmem.txt",mem,0);
  end
  
  assign d_out = {mem[adr[15:0]], mem[adr[15:0]+1], mem[adr[15:0]+2], mem[adr[15:0]+3]};
  
endmodule