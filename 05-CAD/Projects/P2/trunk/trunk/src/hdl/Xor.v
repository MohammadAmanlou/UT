module Xor(input a,b,output out);
    wire not_a,not_b;
    wire and1_out,and2_out;  
    Not NOT_A(a,not_a);
    Not NOT_B(b,not_b);

    And AND1(not_a,b,and1_out);
    And AND2(a,not_b,and2_out);

    Or OR(and1_out,and2_out,out);

endmodule
