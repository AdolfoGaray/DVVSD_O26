import parity_pkg::*;

interface UART_INTERFACE (input logic clk);
    logic rst, send_bit, data_out, ready;
    logic [7:0] data_in;

    modport PARA_TX_TB (
        input clk, data_out, ready,
        output rst, send_bit,
        output [7:0] data_in
    );
    modport PARA_TX_WRAPPER (
        input clk, rst, send_bit,
        input [7:0] data_in,
        output data_out, ready
    );

endinterface