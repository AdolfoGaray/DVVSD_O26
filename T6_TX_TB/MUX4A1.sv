import output_pkg::*;

module MUX4a1 (
    input logic data_bit,
    input logic parity_bit,
    input logic [1:0] output_selector,

    output logic data_out
);

always_comb begin
    case (output_selector)
        ONE_SEL: begin
            data_out = 1'b1;
        end
        ZERO_SEL: begin
            data_out = 1'b0;            
        end
        DATA_SEL: begin
            data_out = data_bit;
        end
        PARITY_SEL: begin
            data_out = parity_bit;
        end
    endcase
end

endmodule