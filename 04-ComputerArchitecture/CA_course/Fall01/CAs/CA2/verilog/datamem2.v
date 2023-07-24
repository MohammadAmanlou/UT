module datamem2 (adr, d_in, mrd, mwr, clk, d_out);

  input [31:0] adr;
  input [31:0] d_in;
  input mrd, mwr, clk;
  output [31:0] d_out;
  

  reg signed [7:0] mem[0:65535];

  initial

  begin



    //{mem[3], mem[2], mem[1], mem[0]} =  32'd2;    
    //{mem[7], mem[6], mem[5], mem[4]} = -32'd64;     
    //{mem[11], mem[10], mem[9], mem[8]} = -32'd679;   
    //{mem[15], mem[14], mem[13], mem[12]} = 32'd1779;    
    //{mem[19], mem[18], mem[17], mem[16]} = 32'd69;        
    ////...
    //{mem[1003], mem[1002], mem[1001], mem[1000]} =  32'd19;     //A[0]  //start
    //{mem[1007], mem[1006], mem[1005], mem[1004]} = -32'd64;     //A[1]
    //{mem[1011], mem[1010], mem[1009], mem[1008]} = -32'd679;    //A[2]
    //{mem[1015], mem[1014], mem[1013], mem[1012]} = 32'd1779;    //A[3]
    //{mem[1019], mem[1018], mem[1017], mem[1016]} = 32'd69;      //A[4]   
    //{mem[1023], mem[1022], mem[1021], mem[1020]} = -32'd1595;   //A[5]
    //{mem[1027], mem[1026], mem[1025], mem[1024]} = 32'd1678;    //A[6]
    //{mem[1031], mem[1030], mem[1029], mem[1028]} = 32'd1884;    //A[7]
    //{mem[1035], mem[1034], mem[1033], mem[1032]} = -32'd649;    //A[8]
    //{mem[1039], mem[1038], mem[1037], mem[1036]} = 32'd18;      //A[9]
    //{mem[1043], mem[1042], mem[1041], mem[1040]} = 32'd337;     //A[10]
    //{mem[1047], mem[1046], mem[1045], mem[1044]} = -32'd1764;   //A[11]
    //{mem[1051], mem[1050], mem[1049], mem[1048]} = 32'd1725;    //A[12]
    //{mem[1055], mem[1054], mem[1053], mem[1052]} = 32'd919;     //A[13]
    //{mem[1059], mem[1058], mem[1057], mem[1056]} = 32'd758;     //A[14]
    //{mem[1063], mem[1062], mem[1061], mem[1060]} = -32'd584;    //A[15]
    //{mem[1067], mem[1066], mem[1065], mem[1064]} = 32'd82;      //A[16]
    //{mem[1071], mem[1070], mem[1069], mem[1068]} = -32'd1972;   //A[17]
    //{mem[1075], mem[1074], mem[1073], mem[1072]} = -32'd1375;   //A[18]
    //{mem[1079], mem[1078], mem[1077], mem[1076]} = 32'd683;     //A[19]
    //{mem[1083], mem[1082], mem[1081], mem[1080]} = 32'd1470;    //A[20] //end of reading
    //{mem[1087], mem[1086], mem[1085], mem[1084]} = 32'd1595;    //A[21]
    //{mem[1091], mem[1090], mem[1089], mem[1088]} = -32'd971;    //A[22]


    $readmemb("bits.txt",mem,1000);
  end
  
  always @(posedge clk)
    if (mwr==1'b1)
      {mem[adr+3], mem[adr+2], mem[adr+1], mem[adr]} = d_in;
  
  assign d_out = (mrd==1'b1) ? {mem[adr+3], mem[adr+2], mem[adr+1], mem[adr]} : 32'd0;
  
endmodule   
