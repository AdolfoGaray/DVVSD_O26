module i2c_tb;

    wire sda;

    logic devA_drive_low;
    logic devB_drive_low;

    // Weak pull-up
    assign (pull1, highz0) sda = 1'b1;

    // Two open-drain devices
    assign (strong0, highz1) sda =
        devA_drive_low ? 1'b0 : 1'bz;

    assign (strong0, highz1) sda =
        devB_drive_low ? 1'b0 : 1'bz;

    initial begin
        devA_drive_low = 0;
        devB_drive_low = 0;
        #10;

        devA_drive_low = 1;
        #10;

        devA_drive_low = 0;
        devB_drive_low = 1;
        #10;

        devA_drive_low = 1;
        devB_drive_low = 1;
        #10;

        devA_drive_low = 0;
        devB_drive_low = 0;
        #10;

        $finish;
    end

endmodule