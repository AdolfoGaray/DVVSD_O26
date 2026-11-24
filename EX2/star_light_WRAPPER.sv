module star_light_WRAPPER (star_light_itf star_itf);

star_light sl (.clk(star_itf.clk), .rst_n(star_itf.rst_n), .lights(star_itf.lights), .switch_0_i(star_itf.switch_0_i), .switch_1_i(star_itf.switch_1_i), .switch_2_i(star_itf.switch_2_i));

endmodule