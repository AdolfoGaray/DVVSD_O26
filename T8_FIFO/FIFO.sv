module FIFO #(
    parameter DW = 8,
    parameter DEPTH = 16
)(
    input logic clk,
    input logic rst,
    input logic [DW-1:0] data_in,
    input logic push,
    input logic pop,

    output logic [DW-1:0] data_out,
    output logic full,
    output logic empty
);

logic [$clog2(DEPTH)-1:0] write_pointer, read_pointer;
logic [DW-1:0] ram [DEPTH:0];
logic last_operation;

assign full = ((write_pointer == read_pointer) & last_operation) ? 1 : 0;
assign empty = ((write_pointer == read_pointer) & !last_operation) ? 1 : 0;

always_ff @(posedge clk or negedge rst) begin
    if(!rst) begin
        write_pointer <= '0;
        read_pointer <= '0;
        data_out <= '0;
        last_operation <= 0;
    end
    else begin
        if(push & empty) begin //Si esta vacio y hay push, asigna la entrada a la salida
            ram[write_pointer] <= data_in;
            write_pointer <= write_pointer + 1;
            data_out <= data_in;
        end
        else if(push & !full) begin //Evitar pushes cuando esta lleno
            ram[write_pointer] <= data_in;
            write_pointer <= write_pointer + 1;
        end
        if(pop & !empty) begin //Evitar pulls si esta vacío
            data_out <= ram[read_pointer];
            read_pointer <= read_pointer + 1;
        end
        if(write_pointer == DEPTH) begin //Para que sea ciclico en caso de que la DEPTH no sea cuadrado de 2
            write_pointer <= '0;
        end
        if(read_pointer == DEPTH) begin
            read_pointer <= '0;
        end
        if(pop) begin //Para poder diferenciar cuando se alcanzaron los pointers
            last_operation <= 0;
        end
        else if(push) begin
            last_operation <= 1;
        end
        else begin
            last_operation <= last_operation;
        end
    end
end

endmodule