vlib work
vmap work work

vlog Assertions.sv
vlog Assertions_TB.sv

vsim -voptargs=+acc work.Assertions_TB

add wave sim:/Assertions_TB/*
run -all