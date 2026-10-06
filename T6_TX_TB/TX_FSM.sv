import output_pkg::*;

module TX_FSM (
    input logic clk,
    input logic rst,
    input logic send_bit,
    input logic baudrate_enable,
    input logic parity_enable,

    output logic load_not_shift,
    output logic [1:0] output_selector,
    output logic ready
);

typedef enum logic [2:0] {
    IDLE = 3'b000,
    START = 3'B001,
    NEXT_DATA_BIT = 3'B010,
    PARITY = 3'b011,
    STOP1 = 3'b100,
    STOP2 = 3'b101
} tx_state;

tx_state tx_state_reg;
logic [2:0] counter_8;

always_ff @(posedge clk) begin
    if(rst) begin
        tx_state_reg <= IDLE;
        load_not_shift <= 1'b0;
        counter_8 <= 1'b0;
        output_selector <= ONE_SEL;
        ready <= 1'b1;
    end else begin
        if(send_bit) begin
            tx_state_reg <= START;
            load_not_shift <= 1'b1;
        end else if(baudrate_enable) begin
            case (tx_state_reg)
                START: begin
                    output_selector <= ZERO_SEL;
                    tx_state_reg <= NEXT_DATA_BIT;
                    load_not_shift <= 1'b0;
                end
                NEXT_DATA_BIT: begin
                    output_selector <= DATA_SEL;
                    if(counter_8 >= 8) begin
                        if(parity_enable) begin
                            tx_state_reg <= PARITY;
                        end else begin
                            tx_state_reg <= STOP1;
                        end
                        counter_8 <= 1'b0;
                    end else begin
                        counter_8 <= counter_8 + 1'b1;
                    end
                end
                PARITY: begin
                    output_selector <= PARITY_SEL;
                    tx_state_reg <= STOP1;
                end
                STOP1: begin
                    output_selector <= ONE_SEL;
                    tx_state_reg <= STOP2;                    
                end
                STOP2: begin
                    output_selector <= ONE_SEL;
                    tx_state_reg <= IDLE;                    
                end
                default: output_selector <= ONE_SEL;
            endcase
        end
    end
end

endmodule