module Comparador(
	input logic [7:0] m,
	input logic [7:0] n,
	output logic greater
);

assign greater = m > n;

endmodule