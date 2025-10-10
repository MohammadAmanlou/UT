onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+design_2 -L xil_defaultlib -L xpm -L xlconstant_v1_1_5 -L xlslice_v1_0_1 -L util_vector_logic_v2_0_1 -L dist_mem_gen_v8_0_12 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.design_2 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {design_2.udo}

run -all

endsim

quit -force
