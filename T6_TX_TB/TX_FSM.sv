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

tx_state tx_state_reg, next_tx_state_reg;
logic [3:0] counter_8;

always_ff @(posedge clk or negedge rst) begin
    if(!rst) begin
        tx_state_reg <= IDLE;
        load_not_shift <= 1'b0;
        counter_8 <= '0;
    end else begin
        load_not_shift <= (next_tx_state_reg == START) ? 1'b1 : 1'b0;
        counter_8 <= (baudrate_enable) ? ((next_tx_state_reg == NEXT_DATA_BIT) ? (counter_8 + 1'b1) : '0) : counter_8;
        tx_state_reg <= (baudrate_enable) ? next_tx_state_reg : tx_state_reg;
    end
end

always_comb begin
    if(!rst) begin
        next_tx_state_reg = IDLE;
        output_selector = ONE_SEL;
        ready = 1'b1;
    end
    else begin
        ready = (tx_state_reg == IDLE) ? 1'b1 : 1'b0;
        case (tx_state_reg)
            IDLE: begin
                output_selector = ONE_SEL;
            end
            START: begin
                next_tx_state_reg = NEXT_DATA_BIT;
                output_selector = ZERO_SEL;
            end
            NEXT_DATA_BIT: begin
                output_selector = DATA_SEL;
                if(counter_8 >= 8) begin
                    if(parity_enable) begin
                        next_tx_state_reg = PARITY;
                    end else begin
                        next_tx_state_reg = STOP1;
                    end
                end
            end
            PARITY: begin
                next_tx_state_reg = STOP1;
                output_selector = PARITY_SEL;
            end
            STOP1: begin
                next_tx_state_reg = STOP2;
                output_selector = ONE_SEL;              
            end
            STOP2: begin
                next_tx_state_reg = IDLE;
                output_selector = ONE_SEL;                
            end
            default: output_selector = ONE_SEL;
        endcase    
    end
    if(send_bit) begin
        next_tx_state_reg = START;
    end
end

endmodule