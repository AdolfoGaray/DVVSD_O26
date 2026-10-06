import parity_pkg::*;
`timescale 1ns/1ps

`ifdef PARITY_TYPE
parameter parity = `PARITY_TYPE;
`else
parameter parity = PARITY_ODD;
`endif

module TX_TB;

parameter baudrate = 5;

UART_INTERFACE uart_itf(.clk(clk));
TESTER testeador;

initial begin
testeador = new(uart_itf);
testeador.INITIAL_CONDITIONS();
end

testeador.PREPARE_DATA(8'b01010101);
testeador.SEND_BIT();
testeador.COLLECT_DATA();
testeador.BUILD_EXPECTED_DATA();
    
endmodule