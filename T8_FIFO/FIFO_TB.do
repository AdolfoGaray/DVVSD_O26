vlib work
vmap work work

vlog FIFO.sv
vlog FIFO_TB.sv

vsim -voptargs=+acc work.FIFO_TB

add wave sim:/FIFO_TB/*
run 1200ns