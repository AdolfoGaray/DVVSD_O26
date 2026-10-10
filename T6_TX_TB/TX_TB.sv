import parity_pkg::*;
import tester_pkg::*;

`timescale 1ns/1ps

`ifdef PARITY_TYPE
parameter parity = `PARITY_TYPE;
`else
parameter parity = PARITY_ODD;
`endif

module TX_TB;

logic clk=0;
parameter baudrate = 5;

UART_INTERFACE uart_itf(.clk(clk));
TESTER testeador;

TX_WRAPPER #(.baudrate(baudrate),.parity(parity)) tx_DUT(.uart_itf(uart_itf));

always #1 clk = ~clk;

initial begin
testeador = new(uart_itf);
testeador.INITIAL_CONDITIONS();
testeador.PREPARE_DATA(8'b01010101);
testeador.BUILD_EXPECTED_DATA();
#1;
testeador.SEND_BIT();
testeador.COLLECT_DATA();
testeador.CHECK_DATA();
end

    
endmodule