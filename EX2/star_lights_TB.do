vlib work
vmap work work

vlog star_lights.sv
vlog star_ligths_itf.sv
vlog star_lights_WRAPPER.sv
vlog star_lights_monitor.sv
vlog star_lights_driver.sv
vlog star_lights_TB.sv

vsim -voptargs=+acc work.star_lights_TB

add wave sim:/star_lights_TB/*
run -all