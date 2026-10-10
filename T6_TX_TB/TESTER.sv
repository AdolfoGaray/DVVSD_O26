`timescale 1ns/1ps
package tester_pkg;
    import parity_pkg::*;
    class TESTER #(
        parameter baudrate = 5,
        parameter parity = PARITY_ODD
    );

    virtual UART_INTERFACE uart_itf;
    logic [11:0] data_recieved, data_expected;

    function new(virtual UART_INTERFACE uart_itf);
        this.uart_itf = uart_itf;
    endfunction

    task INITIAL_CONDITIONS();
        uart_itf.rst = '0;
        uart_itf.send_bit = '0;
        uart_itf.data_in = '0;
        #5;
        uart_itf.rst = '1;
    endtask

    task PREPARE_DATA(input logic [7:0] data);
        uart_itf.data_in = data;
        data_recieved = '0;
    endtask

    task SEND_BIT();
        uart_itf.send_bit = 1'b1;
        #1;
        uart_itf.send_bit = 1'b0;
    endtask

    task COLLECT_DATA();
        wait(uart_itf.data_out == 1'b0);
        #4;
        for (int i = 0; i < 12; i++) begin  
            data_recieved[11-i] = uart_itf.data_out;
            #(baudrate*2);
        end
    endtask

    task BUILD_EXPECTED_DATA();
        logic [2:0] ones;
        logic data_parity;
        logic [7:0] mirrored_data_in;
        ones = uart_itf.data_in[0] + uart_itf.data_in[1] + uart_itf.data_in[2] + uart_itf.data_in[3] + uart_itf.data_in[4] + uart_itf.data_in[5] + uart_itf.data_in[6] + uart_itf.data_in[7];
        mirrored_data_in = {uart_itf.data_in[0], uart_itf.data_in[1], uart_itf.data_in[2], uart_itf.data_in[3], uart_itf.data_in[4], uart_itf.data_in[5], uart_itf.data_in[6], uart_itf.data_in[7]};
        case (parity)
            PARITY_NONE: begin
                data_expected = {1'b0, mirrored_data_in, 3'b111};
            end
            PARITY_ODD: begin
                data_parity = (ones[0]) ? 1'b0 : 1'b1; 
                data_expected = {1'b0, mirrored_data_in, data_parity, 2'b11};
            end
            PARITY_EVEN: begin
                data_parity = (ones[0]) ? 1'b1 : 1'b0; 
                data_expected = {1'b0, mirrored_data_in, data_parity, 2'b11};
            end
            default: data_expected = {1'b0, mirrored_data_in, 3'b111};
        endcase
    endtask

    task CHECK_DATA();
        if(data_expected == data_recieved) $display("[PASS] expected='%b %b %b' got='%b %b %b'  :)", data_expected[11], data_expected[10:3], data_expected[2:0], data_recieved[11], data_recieved[10:3], data_recieved[2:0]);
        else $display("[FAIL] expected='%b %b %b' got='%b %b %b'  :(", data_expected[11], data_expected[10:3], data_expected[2:0], data_recieved[11], data_recieved[10:3], data_recieved[2:0]);
    endtask

    task DISPLAY_PARITY();
        case (parity)
            PARITY_ODD: $display("--- PARITY ODD ---");
            PARITY_EVEN: $display("--- PARITY EVEN ---");
            PARITY_NONE: $display("--- PARITY NONE ---");
        endcase
    endtask

    endclass

endpackage