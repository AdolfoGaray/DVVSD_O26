module Mediana(
	input logic [7:0] A,
	input logic [7:0] B,
	input logic [7:0] C,
	input logic [7:0] D,
	output logic [7:0] mediana
);

logic c1, c2, c3, c4, c5, c6;

Comparador Comp1(.m(A),.n(B),.greater(c1));
Comparador Comp2(.m(A),.n(C),.greater(c2));
Comparador Comp3(.m(A),.n(D),.greater(c3));
Comparador Comp4(.m(B),.n(C),.greater(c4));
Comparador Comp5(.m(B),.n(D),.greater(c5));
Comparador Comp6(.m(C),.n(D),.greater(c6));

logic [7:0] sum1, sum2, sum3;

always_comb begin
	sum1 = ((c1 & c2 & c3) ? A : '0) + ((~c1 & c4 & c5) ? B : '0);
	sum1 = ((~c2 & ~c4 & c5) ? C : '0) + ((~c3 & ~c5 & ~c6) ? D : '0);
	sum1 = sum2 + sum3;
	mediana = sum3 >> 1;
end

endmodule