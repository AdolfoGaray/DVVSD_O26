interface star_lights_itf (input logic clk, input logic rst);
	logic switch_0_i, switch_1_i, switch_2_i, lights;

    modport MONITOR (
        input clk, rst_n, lights, switch_0_i, switch_1_i, switch_2_i
    );
	modport TESTER (
        input lights, clk, rst_n,
        output switch_0_i, switch_1_i, switch_2_i
    );
    modport LIGHTS (
        input switch_0_i, switch_1_i, switch_2_i, clk, rst_n,
        output lights
    );


endinterface