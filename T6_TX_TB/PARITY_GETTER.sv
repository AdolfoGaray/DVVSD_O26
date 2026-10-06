import parity_pkg::*;

module PARITY_GETTER #(
    parameter parity = PARITY_ODD
)(
    input logic [7:0] data_in,

    output logic parity_enable,
    output logic parity_bit
);

logic [2:0] ones;

always_comb begin
    ones = data_in[7] + data_in[6] + data_in[5] + data_in[4] + data_in[3] + data_in[2] + data_in[1] + data_in[0];
    case (parity)
        PARITY_NONE: begin
            parity_enable = 1'b0;
            parity_bit = 1'b0;
        end
        PARITY_ODD: begin
            parity_enable = 1'b1;
            parity_bit = (ones[0]) ? 1'b0 : 1'b1;
        end
        PARITY_EVEN: begin
            parity_enable = 1'b1;
            parity_bit = (ones[0]) ? 1'b1 : 1'b0;
        end
    endcase
end

endmodule 