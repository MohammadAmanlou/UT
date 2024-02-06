module decoder(input [4:0]a0, a1, a2, a3, output [1:0] idx, output done);
wire idx0, idx1;
wire A0,A1,A2,A3;
  convert_5to1bit c1(.out(A0), .a(a0));
  convert_5to1bit c2(.out(A1), .a(a1));
  convert_5to1bit c3(.out(A2), .a(a2));
  convert_5to1bit c4(.out(A3), .a(a3));

wire not_a0, not_a1, not_a2, not_a3;

  Not u0(.out(not_a0), .a(A0));
  Not u1(.out(not_a1), .a(A1));
  Not u2(.out(not_a2), .a(A2));
  Not u3(.out(not_a3), .a(A3));



wire done_a0, done_a1, done_a2, done_a3;
wire nota0ANDnota1 , a3ANDnota2 , a2ANDnota3, nota2ANDnota3, a1ANDnota0, a0ANDnota1 ; 


And and1(.out(nota0ANDnota1) , .a(not_a0) , .b(not_a1));
And and2(.out(a3ANDnota2) , .a(A3) , .b(not_a2));
And main1 (.out(done_a3) , .a(nota0ANDnota1) , .b(a3ANDnota2));

And and3(.out(a2ANDnota3), .a(A2), .b(not_a3));
And main2(.out(done_a2), .a(nota0ANDnota1), .b(a2ANDnota3));

And and4(.out(nota2ANDnota3) , .a(not_a2) , .b(not_a3));
And and5(.out(a1ANDnota0), .a(A1), .b(not_a0));
And main3(.out(done_a1), .a(a1ANDnota0), .b(nota2ANDnota3));


And a6(.out(a0ANDnota1), .a(A0) , .b(not_a1));
And main4(.out(done_a0), .a(a0ANDnota1), .b(nota2ANDnota3));


wire done_a0ORa1 , done_a2ORa3;

Or o1(.out(done_a0ORa1), .a(done_a0) , .b(done_a1));
Or o2(.out(done_a2ORa3), .a(done_a2) , .b(done_a3));
Or OR_main(.out(done), .a(done_a0ORa1) , .b(done_a2ORa3));


Or u9(.out(idx0),.a(done_a1) ,.b( done_a3) ); 
Or u10(.out(idx1), .a(done_a2), .b(done_a3)); 

assign idx ={idx1,idx0};

endmodule

module  convert_5to1bit (input [4:0] a ,  output out);
  wire tmp1,tmp2,tmp3;
        Or t1(.out(tmp1), .a(a[0]), .b(a[1]));
  Or t2(.out(tmp2), .a(a[2]), .b(a[3]));
  Or t3(.out(tmp3), .a(tmp1), .b(tmp2));
  Or t4(.out(out), .a(tmp3), .b(a[4]));
endmodule
