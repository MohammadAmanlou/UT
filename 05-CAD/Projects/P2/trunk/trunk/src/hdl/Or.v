module Or (input a , b, output out);
	C1 C1_OR(.A0(a), .A1(1'b1), .SA(b), .B0(),
                    .B1(), .SB(), .S0(1'b0), .S1(1'b0), .F(out));
endmodule
