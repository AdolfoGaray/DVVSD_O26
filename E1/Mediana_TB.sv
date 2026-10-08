`timescale 1ns/1ps

module Mediana_tb;
initial begin
	A=10; B=20; C=30; D=40;
	if(mediana==25) $display("PASS :)");
	else $display("FAIL :(");
end
endmodule
