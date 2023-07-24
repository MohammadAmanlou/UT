module data_mem (adr, d_in, mrd, mwr, clk, d_out);
  input [31:0] adr;
  input [31:0] d_in;
  input mrd, mwr, clk;
  output [31:0] d_out;
  
    reg [7:0] mem[0:65535];
  
  wire [31:0] min;
  wire [31:0] index;
  initial
  begin
    //fill memory from text file
    $readmemb("memdatab.txt",mem,1000);
    $readmemb("meminstb.txt",mem,0);
    //{mem[3], mem[2], mem[1], mem[0]}     = {6'h23, 5'd0, 5'd1, 16'd1000};   //0
    //{mem[7], mem[6], mem[5], mem[4]}     = {6'h09, 5'd0, 5'd2, 16'd0};      //4         
    //{mem[11], mem[10], mem[9], mem[8]}   = {6'h09, 5'd0, 5'd3, 16'd0};      //8
    //{mem[15], mem[14], mem[13], mem[12]} = {6'h09, 5'd0, 5'd12, 16'd0};     //12
    //{mem[19], mem[18], mem[17], mem[16]} = {6'h09, 5'd0, 5'd15, 16'd80};    //16      
    //{mem[23], mem[22], mem[21], mem[20]} = {6'h04, 5'd3, 5'd15, 16'd8};     //20
    //{mem[27], mem[26], mem[25], mem[24]} ={6'h09, 5'd12, 5'd12, 16'd1};     //24
    //{mem[31], mem[30], mem[29], mem[28]}  = {6'h09, 5'd3, 5'd3, 16'd4};      //28        
    //{mem[35], mem[34], mem[33], mem[32]} = {6'h23, 5'd3, 5'd10, 16'd1000};  //32             
    //{mem[39], mem[38], mem[37], mem[36]} = {6'h00, 5'd10, 5'd1, 5'd4, 5'd0,6'b101010};    //36       
    //{mem[43], mem[42], mem[41], mem[40]} = {6'h04, 5'd4, 5'd0, -16'd6};                      //40    
    //{mem[47], mem[46], mem[45], mem[44]} = {6'h00, 5'd10, 5'd0, 5'd1, 5'd0, 6'h20};          //44
    //{mem[51], mem[50], mem[49], mem[48]} = {6'h09, 5'd12, 5'd2, 16'd0};                       //48            
    //{mem[55], mem[54], mem[53], mem[52]} = {6'h04, 5'd0, 5'd0, -16'd9};                      //52
    //{mem[59], mem[58], mem[57], mem[56]} = {6'h2B, 5'd0, 5'd1, 16'd2000};                    //56
    //{mem[63], mem[62], mem[61], mem[60]} = {6'h09, 5'd0, 5'd11, 16'd4};                      //60
    //{mem[67], mem[66], mem[65], mem[64]} = {6'h2B, 5'd11, 5'd2, 16'd2000};                   //64
       
    //{mem[1003], mem[1002], mem[1001], mem[1000]} = 32'd110; //A[0]
    //{mem[1007], mem[1006], mem[1005], mem[1004]} = 32'd111; //A[1]
    //{mem[1011], mem[1010], mem[1009], mem[1008]} = 32'd112; //A[2]
    //{mem[1015], mem[1014], mem[1013], mem[1012]} = 32'd113; //A[3]
    //{mem[1019], mem[1018], mem[1017], mem[1016]} = 32'd114; //A[4]   
    //{mem[1023], mem[1022], mem[1021], mem[1020]} = 32'd115; //A[5]
    //{mem[1027], mem[1026], mem[1025], mem[1024]} = 32'd16;  //A[6]
    //{mem[1031], mem[1030], mem[1029], mem[1028]} = 32'd7;   //A[7]
    //{mem[1035], mem[1034], mem[1033], mem[1032]} = 32'd8;   //A[8]
    //{mem[1039], mem[1038], mem[1037], mem[1036]} = 32'd1;   //A[9]
    //{mem[1043], mem[1042], mem[1041], mem[1040]} = 32'd10;  //A[10]
    //{mem[1047], mem[1046], mem[1045], mem[1044]} = 32'd11;  //A[11]
    //{mem[1051], mem[1050], mem[1049], mem[1048]} = 32'd12;  //A[12]
    //{mem[1055], mem[1054], mem[1053], mem[1052]} = 32'd13;  //A[13]
    //{mem[1059], mem[1058], mem[1057], mem[1056]} = 32'd14;  //A[14]
    //{mem[1063], mem[1062], mem[1061], mem[1060]} = -32'd4;  //A[15]
    //{mem[1067], mem[1066], mem[1065], mem[1064]} = 32'd2;   //A[16]
    //{mem[1071], mem[1070], mem[1069], mem[1068]} = -32'd5;   //A[17]
    //{mem[1075], mem[1074], mem[1073], mem[1072]} = -32'd6;   //A[18]
    //{mem[1079], mem[1078], mem[1077], mem[1076]} = 32'd12;  //A[19]
  end 
  always @(posedge clk)
    if (mwr==1'b1)
      {mem[adr+3], mem[adr+2], mem[adr+1], mem[adr]} = d_in;
  
  assign d_out = (mrd==1'b1) ? {mem[adr+3], mem[adr+2], mem[adr+1], mem[adr]} : 32'd0;
  
endmodule   