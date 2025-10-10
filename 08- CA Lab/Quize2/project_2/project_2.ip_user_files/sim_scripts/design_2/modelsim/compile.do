vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/xlconstant_v1_1_5
vlib modelsim_lib/msim/xlslice_v1_0_1
vlib modelsim_lib/msim/util_vector_logic_v2_0_1
vlib modelsim_lib/msim/dist_mem_gen_v8_0_12

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap xpm modelsim_lib/msim/xpm
vmap xlconstant_v1_1_5 modelsim_lib/msim/xlconstant_v1_1_5
vmap xlslice_v1_0_1 modelsim_lib/msim/xlslice_v1_0_1
vmap util_vector_logic_v2_0_1 modelsim_lib/msim/util_vector_logic_v2_0_1
vmap dist_mem_gen_v8_0_12 modelsim_lib/msim/dist_mem_gen_v8_0_12

vlog -work xil_defaultlib -64 -incr -sv "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/1b7e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/122e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/7d3c/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/c45e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/46fd/hdl" \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"D:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/1b7e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/122e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/7d3c/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/c45e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/46fd/hdl" \
"../../../bd/design_2/ip/design_2_Adder_0/sim/design_2_Adder_0.v" \

vlog -work xlconstant_v1_1_5 -64 -incr "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/1b7e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/122e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/7d3c/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/c45e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/46fd/hdl" \
"../../../../project_1.srcs/sources_1/bd/design_2/ipshared/4649/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/1b7e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/122e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/7d3c/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/c45e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/46fd/hdl" \
"../../../bd/design_2/ip/design_2_FourConstant_0/sim/design_2_FourConstant_0.v" \
"../../../bd/design_2/ip/design_2_IFreg_0/sim/design_2_IFreg_0.v" \
"../../../bd/design_2/ip/design_2_Mux_0/sim/design_2_Mux_0.v" \
"../../../bd/design_2/ip/design_2_PC_0/sim/design_2_PC_0.v" \
"../../../bd/design_2/ip/design_2_debouncer_0_0/sim/design_2_debouncer_0_0.v" \
"../../../bd/design_2/ip/design_2_ila_0_0/sim/design_2_ila_0_0.v" \

vlog -work xlslice_v1_0_1 -64 -incr "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/1b7e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/122e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/7d3c/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/c45e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/46fd/hdl" \
"../../../../project_1.srcs/sources_1/bd/design_2/ipshared/f3db/hdl/xlslice_v1_0_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/1b7e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/122e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/7d3c/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/c45e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/46fd/hdl" \
"../../../bd/design_2/ip/design_2_xlslice_0_0/sim/design_2_xlslice_0_0.v" \
"../../../bd/design_2/sim/design_2.v" \
"../../../bd/design_2/ip/design_2_CUMUX_0_0/sim/design_2_CUMUX_0_0.v" \
"../../../bd/design_2/ip/design_2_ConditionCheck_0_0/sim/design_2_ConditionCheck_0_0.v" \
"../../../bd/design_2/ip/design_2_ControlUnit_0_0/sim/design_2_ControlUnit_0_0.v" \
"../../../bd/design_2/ip/design_2_RegMux_0_0/sim/design_2_RegMux_0_0.v" \
"../../../bd/design_2/ip/design_2_RegisterFile_0_0/sim/design_2_RegisterFile_0_0.v" \
"../../../bd/design_2/ip/design_2_xlslice_1_0/sim/design_2_xlslice_1_0.v" \
"../../../bd/design_2/ip/design_2_xlslice_2_0/sim/design_2_xlslice_2_0.v" \
"../../../bd/design_2/ip/design_2_xlslice_3_0/sim/design_2_xlslice_3_0.v" \
"../../../bd/design_2/ip/design_2_xlslice_2_2/sim/design_2_xlslice_2_2.v" \

vlog -work util_vector_logic_v2_0_1 -64 -incr "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/1b7e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/122e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/7d3c/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/c45e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/46fd/hdl" \
"../../../../project_1.srcs/sources_1/bd/design_2/ipshared/2137/hdl/util_vector_logic_v2_0_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/1b7e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/122e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/7d3c/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/c45e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/46fd/hdl" \
"../../../bd/design_2/ip/design_2_util_vector_logic_0_0/sim/design_2_util_vector_logic_0_0.v" \
"../../../bd/design_2/ip/design_2_util_vector_logic_1_0/sim/design_2_util_vector_logic_1_0.v" \
"../../../bd/design_2/ip/design_2_IDreg_0_0/sim/design_2_IDreg_0_0.v" \
"../../../bd/design_2/ip/design_2_StatusReg_0_0/sim/design_2_StatusReg_0_0.v" \
"../../../bd/design_2/ip/design_2_xlslice_2_1/sim/design_2_xlslice_2_1.v" \
"../../../bd/design_2/ip/design_2_xlslice_3_1/sim/design_2_xlslice_3_1.v" \
"../../../bd/design_2/ip/design_2_xlslice_4_0/sim/design_2_xlslice_4_0.v" \

vlog -work dist_mem_gen_v8_0_12 -64 -incr "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/1b7e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/122e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/7d3c/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/c45e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/46fd/hdl" \
"../../../../project_1.srcs/sources_1/bd/design_2/ipshared/d46a/simulation/dist_mem_gen_v8_0.v" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/1b7e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/122e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/7d3c/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/c45e/hdl/verilog" "+incdir+../../../../project_1.srcs/sources_1/bd/design_2/ipshared/46fd/hdl" \
"../../../bd/design_2/ip/design_2_dist_mem_gen_0_0/sim/design_2_dist_mem_gen_0_0.v" \
"../../../bd/design_2/ip/design_2_dist_mem_gen_1_0/sim/design_2_dist_mem_gen_1_0.v" \
"../../../bd/design_2/ip/design_2_Val2Gen_0_0/sim/design_2_Val2Gen_0_0.v" \
"../../../bd/design_2/ip/design_2_ALU_0_0/sim/design_2_ALU_0_0.v" \
"../../../bd/design_2/ip/design_2_util_vector_logic_0_1/sim/design_2_util_vector_logic_0_1.v" \
"../../../bd/design_2/ip/design_2_xlslice_0_1/sim/design_2_xlslice_0_1.v" \
"../../../bd/design_2/ip/design_2_ExeReg_0_0/sim/design_2_ExeReg_0_0.v" \
"../../../bd/design_2/ip/design_2_Mux_1/sim/design_2_Mux_1.v" \
"../../../bd/design_2/ip/design_2_MEM_Stage_Reg_0_0/sim/design_2_MEM_Stage_Reg_0_0.v" \
"../../../bd/design_2/ip/design_2_HazardUnitDetector_0_0/sim/design_2_HazardUnitDetector_0_0.v" \
"../../../bd/design_2/ip/design_2_util_vector_logic_0_2/sim/design_2_util_vector_logic_0_2.v" \
"../../../bd/design_2/ip/design_2_util_vector_logic_0_3/sim/design_2_util_vector_logic_0_3.v" \
"../../../bd/design_2/ip/design_2_RedAdder_0_0/sim/design_2_RedAdder_0_0.v" \
"../../../bd/design_2/ip/design_2_xlslice_0_2/sim/design_2_xlslice_0_2.v" \
"../../../bd/design_2/ip/design_2_ForwardingUnit_0_0/sim/design_2_ForwardingUnit_0_0.v" \
"../../../bd/design_2/ip/design_2_Exe_Mux_0_0/sim/design_2_Exe_Mux_0_0.v" \
"../../../bd/design_2/ip/design_2_Exe_Mux_0_1/sim/design_2_Exe_Mux_0_1.v" \
"../../../bd/design_2/ip/design_2_vio_0_0/sim/design_2_vio_0_0.v" \
"../../../bd/design_2/ip/design_2_xlconstant_0_0/sim/design_2_xlconstant_0_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

