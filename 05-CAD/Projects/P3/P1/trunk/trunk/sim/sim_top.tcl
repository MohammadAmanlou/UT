	alias clc ".main clear"
	
	clc
	exec vlib work
	vmap work work
	
	set TB					"testBench"
	set hdl_path			"../src/hdl"
	set inc_path			"../src/inc"
	
	set run_time			"1 us"
#	set run_time			"-all"

#============================ Add verilog files  ===============================
# Pleas add other module here	
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/buffer4x4.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/buffer4x16.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/controller.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/counter3.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/counter4.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/counter13.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/counter16.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/counter43.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/counter64.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/dataPath.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/filterBuffer.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/kernelCounter.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mac.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mainProccess.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/memory.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mux2to1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mux3to1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/mux16to1.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/ofm.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/pe.v
	vlog 	+acc -incr -source  +define+SIM 	$hdl_path/shiftRegister.v

	vlog 	+acc -incr -source  +incdir+$inc_path +define+SIM 	./tb/$TB.v
	onerror {break}

#================================ simulation ====================================

	vsim	-voptargs=+acc -debugDB $TB


#======================= adding signals to wave window ==========================


	add wave -hex -group 	 	{TB}				sim:/$TB/*
	add wave -hex -group 	 	{top}				sim:/$TB/uut/*	
	add wave -hex -group -r		{all}				sim:/$TB/*

#=========================== Configure wave signals =============================
	
	configure wave -signalnamewidth 2
    

#====================================== run =====================================

	run $run_time 
	run -all