module star_light_TB;

logic clk = 0;
logic rst_n, lights, switch_0_i, switch_1_i, switch_2_i;

star_light_itf star_itf(.clk(clk),.rst_n(rst_n));
star_lights_WRAPPER star_DUT(.star_itf(star_ift.LIGHTS));

star_light_monitor monitor;
star_light_driver driver;
monitor = new(star_itf.MONITOR);
driver = new(star_itf.DRIVER);

initial begin
    driver.initial_conditions();
    monitor.save();
    driver.change1a();
    monitor.check();
    monitor.save();
    driver.change1b();
    monitor.check();
    monitor.save();
    driver.change1c();
    monitor.check();
    monitor.save();
    driver.change2a();
    monitor.check();
    monitor.save();
    driver.change2b();
    monitor.check();
    monitor.save();
    driver.change2c();
    monitor.check();
    monitor.save();
    driver.change3();
    monitor.check();
end


endmodule