/*
This module must set 1 shot, ONLY when 5 clock cycles in high are found in input.
inputs:
 c is clock of the system
 r is reset of the system (active low)
 i is the signal input.
output:
 o generates a pulse of one clock cycle when i was high during 5 clock cycles
*/

module SS_oneshot_five_cycles (
	input logic clk, //mala práctica los malos nombres de variables
	input logic rst, 
	input logic in,
	output logic out
);

reg f1,f2,f3,f4,f5,f6;

always_ff @(posedge clk, negedge rst) begin //needs to be always_ff for the flipflops que guardaran la duracion
	if(!rst) begin //Como es negedge r, debe ser reset en 0
		f1 <= 1'b0;
		f2 <= 1'b0;
		f3 <= 1'b0;
		f4 <= 1'b0;
		f5 <= 1'b0;
		f6 <= 1'b0;
	end
	else begin
		if (f1 & f2 & f3 & f4 & f5 & !in) begin //se necesita resetearlos cuando se cumple la condición y el input para
			f1 <= 1'b0;
			f2 <= 1'b0;
			f3 <= 1'b0;
			f4 <= 1'b0;
			f5 <= 1'b0;
			f6 <= 1'b0;
		end
		else begin
			f1 <= in; //Asignaciones no bloqueantes porque sino se propaga el 1 del input instantaneamente
			f2 <= f1;
			f3 <= f2;
			f4 <= f3;
			f5 <= f4;
			f6 <= f5;
		end
	end
end

assign out = f1 & f2 & f3 & f4 & f5 & !in; // checar f6 es innecesario porque solo necesitamos 5 ciclos guardados, y que se prenda cuando pare el input


endmodule
