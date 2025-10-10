
################################################################
# This is a generated script based on design: design_2
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2018.3
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_2_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# ALU, Adder, CUMUX, ConditionCheck, ControlUnit, ExeReg, Exe_Mux, Exe_Mux, ForwardingUnit, HazardUnitDetector, IDreg, IFreg, MEM_Stage_Reg, Mux2to1, Mux2to1, Register, RedAdder, RegMux, RegisterFile, StatusReg, Val2Gen, debouncer

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7z010clg400-1
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_2

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set clk_0 [ create_bd_port -dir I -type clk clk_0 ]
  set rst_0 [ create_bd_port -dir I -type rst rst_0 ]

  # Create instance: ALU_0, and set properties
  set block_name ALU
  set block_cell_name ALU_0
  if { [catch {set ALU_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ALU_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Adder, and set properties
  set block_name Adder
  set block_cell_name Adder
  if { [catch {set Adder [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Adder eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: CUMUX_0, and set properties
  set block_name CUMUX
  set block_cell_name CUMUX_0
  if { [catch {set CUMUX_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $CUMUX_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: ConditionCheck_0, and set properties
  set block_name ConditionCheck
  set block_cell_name ConditionCheck_0
  if { [catch {set ConditionCheck_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ConditionCheck_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: ControlUnit_0, and set properties
  set block_name ControlUnit
  set block_cell_name ControlUnit_0
  if { [catch {set ControlUnit_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ControlUnit_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: ExeReg_0, and set properties
  set block_name ExeReg
  set block_cell_name ExeReg_0
  if { [catch {set ExeReg_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ExeReg_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Exe_Mux_1, and set properties
  set block_name Exe_Mux
  set block_cell_name Exe_Mux_1
  if { [catch {set Exe_Mux_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Exe_Mux_1 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Exe_Mux_2, and set properties
  set block_name Exe_Mux
  set block_cell_name Exe_Mux_2
  if { [catch {set Exe_Mux_2 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Exe_Mux_2 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: ForwardingUnit_0, and set properties
  set block_name ForwardingUnit
  set block_cell_name ForwardingUnit_0
  if { [catch {set ForwardingUnit_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ForwardingUnit_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: FourConstant, and set properties
  set FourConstant [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 FourConstant ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {1} \
   CONFIG.CONST_WIDTH {32} \
 ] $FourConstant

  # Create instance: HazardUnitDetector_0, and set properties
  set block_name HazardUnitDetector
  set block_cell_name HazardUnitDetector_0
  if { [catch {set HazardUnitDetector_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $HazardUnitDetector_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: IDreg_0, and set properties
  set block_name IDreg
  set block_cell_name IDreg_0
  if { [catch {set IDreg_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $IDreg_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: IFreg, and set properties
  set block_name IFreg
  set block_cell_name IFreg
  if { [catch {set IFreg [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $IFreg eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: MEM_Stage_Reg_0, and set properties
  set block_name MEM_Stage_Reg
  set block_cell_name MEM_Stage_Reg_0
  if { [catch {set MEM_Stage_Reg_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $MEM_Stage_Reg_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Mux, and set properties
  set block_name Mux2to1
  set block_cell_name Mux
  if { [catch {set Mux [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Mux eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Mux_cyan, and set properties
  set block_name Mux2to1
  set block_cell_name Mux_cyan
  if { [catch {set Mux_cyan [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Mux_cyan eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: OR_mod, and set properties
  set OR_mod [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 OR_mod ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {or} \
   CONFIG.LOGO_FILE {data/sym_orgate.png} \
 ] $OR_mod

  # Create instance: PC, and set properties
  set block_name Register
  set block_cell_name PC
  if { [catch {set PC [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $PC eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: RD_slice, and set properties
  set RD_slice [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 RD_slice ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {15} \
   CONFIG.DIN_TO {12} \
   CONFIG.DOUT_WIDTH {4} \
 ] $RD_slice

  # Create instance: RedAdder_0, and set properties
  set block_name RedAdder
  set block_cell_name RedAdder_0
  if { [catch {set RedAdder_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $RedAdder_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: RegMux_0, and set properties
  set block_name RegMux
  set block_cell_name RegMux_0
  if { [catch {set RegMux_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $RegMux_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: RegisterFile_0, and set properties
  set block_name RegisterFile
  set block_cell_name RegisterFile_0
  if { [catch {set RegisterFile_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $RegisterFile_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Rm_slice, and set properties
  set Rm_slice [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 Rm_slice ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {3} \
   CONFIG.DOUT_WIDTH {4} \
 ] $Rm_slice

  # Create instance: StatusReg_0, and set properties
  set block_name StatusReg
  set block_cell_name StatusReg_0
  if { [catch {set StatusReg_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $StatusReg_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Val2Gen_0, and set properties
  set block_name Val2Gen
  set block_cell_name Val2Gen_0
  if { [catch {set Val2Gen_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Val2Gen_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: carry_in_slice, and set properties
  set carry_in_slice [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 carry_in_slice ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {1} \
   CONFIG.DIN_TO {1} \
   CONFIG.DIN_WIDTH {4} \
   CONFIG.DOUT_WIDTH {1} \
 ] $carry_in_slice

  # Create instance: cond_hazard_or_1, and set properties
  set cond_hazard_or_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 cond_hazard_or_1 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {or} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_orgate.png} \
 ] $cond_hazard_or_1

  # Create instance: cond_not, and set properties
  set cond_not [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 cond_not ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $cond_not

  # Create instance: data_mem, and set properties
  set data_mem [ create_bd_cell -type ip -vlnv xilinx.com:ip:dist_mem_gen:8.0 data_mem ]
  set_property -dict [ list \
   CONFIG.data_width {32} \
   CONFIG.depth {8192} \
 ] $data_mem

  # Create instance: debouncer_0, and set properties
  set block_name debouncer
  set block_cell_name debouncer_0
  if { [catch {set debouncer_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $debouncer_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: dest_slice, and set properties
  set dest_slice [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 dest_slice ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {15} \
   CONFIG.DIN_TO {12} \
   CONFIG.DOUT_WIDTH {4} \
 ] $dest_slice

  # Create instance: forward_en_0, and set properties
  set forward_en_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 forward_en_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {1} \
 ] $forward_en_0

  # Create instance: ila_0, and set properties
  set ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.2 ila_0 ]
  set_property -dict [ list \
   CONFIG.C_ENABLE_ILA_AXI_MON {false} \
   CONFIG.C_MONITOR_TYPE {Native} \
   CONFIG.C_NUM_OF_PROBES {8} \
   CONFIG.C_PROBE0_TYPE {1} \
   CONFIG.C_PROBE0_WIDTH {32} \
   CONFIG.C_PROBE1_TYPE {1} \
   CONFIG.C_PROBE1_WIDTH {32} \
   CONFIG.C_PROBE2_TYPE {1} \
   CONFIG.C_PROBE2_WIDTH {32} \
   CONFIG.C_PROBE3_TYPE {1} \
   CONFIG.C_PROBE3_WIDTH {32} \
   CONFIG.C_PROBE4_TYPE {1} \
   CONFIG.C_PROBE4_WIDTH {32} \
   CONFIG.C_PROBE5_TYPE {1} \
   CONFIG.C_PROBE5_WIDTH {32} \
   CONFIG.C_PROBE6_TYPE {1} \
   CONFIG.C_PROBE6_WIDTH {32} \
   CONFIG.C_PROBE7_TYPE {2} \
   CONFIG.C_PROBE7_WIDTH {1} \
 ] $ila_0

  # Create instance: instruction_mem, and set properties
  set instruction_mem [ create_bd_cell -type ip -vlnv xilinx.com:ip:dist_mem_gen:8.0 instruction_mem ]
  set_property -dict [ list \
   CONFIG.coefficient_file {output.coe} \
   CONFIG.data_width {32} \
   CONFIG.depth {8192} \
   CONFIG.memory_type {rom} \
 ] $instruction_mem

  # Create instance: instruction_mem_address_slice, and set properties
  set instruction_mem_address_slice [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 instruction_mem_address_slice ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {12} \
   CONFIG.DOUT_WIDTH {13} \
 ] $instruction_mem_address_slice

  # Create instance: opcode_slice, and set properties
  set opcode_slice [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 opcode_slice ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {31} \
   CONFIG.DIN_TO {28} \
   CONFIG.DOUT_WIDTH {4} \
 ] $opcode_slice

  # Create instance: rn_slice, and set properties
  set rn_slice [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 rn_slice ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {19} \
   CONFIG.DIN_TO {16} \
   CONFIG.DOUT_WIDTH {4} \
 ] $rn_slice

  # Create instance: shift_operand_slice, and set properties
  set shift_operand_slice [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 shift_operand_slice ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {11} \
   CONFIG.DOUT_WIDTH {12} \
 ] $shift_operand_slice

  # Create instance: signed_imm_24_slice, and set properties
  set signed_imm_24_slice [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 signed_imm_24_slice ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {23} \
   CONFIG.DIN_TO {0} \
   CONFIG.DOUT_WIDTH {24} \
 ] $signed_imm_24_slice

  # Create instance: two_src_or, and set properties
  set two_src_or [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 two_src_or ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {or} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_orgate.png} \
 ] $two_src_or

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_0

  # Create instance: vio_forward_en, and set properties
  set vio_forward_en [ create_bd_cell -type ip -vlnv xilinx.com:ip:vio:3.0 vio_forward_en ]
  set_property -dict [ list \
   CONFIG.C_EN_PROBE_IN_ACTIVITY {0} \
   CONFIG.C_NUM_PROBE_IN {0} \
 ] $vio_forward_en

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {25} \
   CONFIG.DIN_TO {25} \
 ] $xlslice_0

  # Create port connections
  connect_bd_net -net ALU_0_NZCV [get_bd_pins ALU_0/NZCV] [get_bd_pins StatusReg_0/status_bits]
  connect_bd_net -net ALU_0_result [get_bd_pins ALU_0/result] [get_bd_pins ExeReg_0/ALU_Res]
  connect_bd_net -net Adder_0_out [get_bd_pins Adder/out] [get_bd_pins IFreg/pc] [get_bd_pins Mux/a]
  connect_bd_net -net CUMUX_0_B_out [get_bd_pins CUMUX_0/B_out] [get_bd_pins IDreg_0/B]
  connect_bd_net -net CUMUX_0_EXE_CMD_out [get_bd_pins CUMUX_0/EXE_CMD_out] [get_bd_pins IDreg_0/EXE_CMD]
  connect_bd_net -net CUMUX_0_MEM_R_EN_out [get_bd_pins CUMUX_0/MEM_R_EN_out] [get_bd_pins IDreg_0/MEM_R_EN]
  connect_bd_net -net CUMUX_0_MEM_W_EN_out [get_bd_pins CUMUX_0/MEM_W_EN_out] [get_bd_pins IDreg_0/MEM_W_EN]
  connect_bd_net -net CUMUX_0_S_out [get_bd_pins CUMUX_0/S_out] [get_bd_pins IDreg_0/S]
  connect_bd_net -net CUMUX_0_WB_EN_out [get_bd_pins CUMUX_0/WB_EN_out] [get_bd_pins IDreg_0/WB_EN]
  connect_bd_net -net ConditionCheck_0_condOut [get_bd_pins ConditionCheck_0/condOut] [get_bd_pins cond_not/Op1]
  connect_bd_net -net ControlUnit_0_B [get_bd_pins CUMUX_0/B] [get_bd_pins ControlUnit_0/B]
  connect_bd_net -net ControlUnit_0_EXE_CMD [get_bd_pins CUMUX_0/EXE_CMD] [get_bd_pins ControlUnit_0/EXE_CMD]
  connect_bd_net -net ControlUnit_0_MEM_R_EN [get_bd_pins CUMUX_0/MEM_R_EN] [get_bd_pins ControlUnit_0/MEM_R_EN]
  connect_bd_net -net ControlUnit_0_MEM_W_EN [get_bd_pins CUMUX_0/MEM_W_EN] [get_bd_pins ControlUnit_0/MEM_W_EN] [get_bd_pins RegMux_0/MEM_W_EN] [get_bd_pins two_src_or/Op2]
  connect_bd_net -net ControlUnit_0_S [get_bd_pins CUMUX_0/S] [get_bd_pins ControlUnit_0/S]
  connect_bd_net -net ControlUnit_0_WB_EN [get_bd_pins CUMUX_0/WB_EN] [get_bd_pins ControlUnit_0/WB_EN]
  connect_bd_net -net ExeReg_0_ALU_Res_out [get_bd_pins ExeReg_0/ALU_Res_out] [get_bd_pins Exe_Mux_1/ALU_res] [get_bd_pins Exe_Mux_2/ALU_res] [get_bd_pins MEM_Stage_Reg_0/ALU_Res] [get_bd_pins data_mem/a]
  connect_bd_net -net ExeReg_0_MEM_R_EN_out [get_bd_pins ExeReg_0/MEM_R_EN_out] [get_bd_pins MEM_Stage_Reg_0/MEM_R_EN]
  connect_bd_net -net ExeReg_0_MEM_W_EN_out [get_bd_pins ExeReg_0/MEM_W_EN_out] [get_bd_pins data_mem/we]
  connect_bd_net -net ExeReg_0_Val_Rm_out [get_bd_pins ExeReg_0/Val_Rm_out] [get_bd_pins data_mem/d]
  connect_bd_net -net ExeReg_0_WB_EN_out [get_bd_pins ExeReg_0/WB_EN_out] [get_bd_pins ForwardingUnit_0/MEM_WB_EN] [get_bd_pins HazardUnitDetector_0/Mem_WB_EN] [get_bd_pins MEM_Stage_Reg_0/WB_EN]
  connect_bd_net -net ExeReg_0_dest_out [get_bd_pins ExeReg_0/dest_out] [get_bd_pins ForwardingUnit_0/MEM_DEST] [get_bd_pins HazardUnitDetector_0/Mem_Dest] [get_bd_pins MEM_Stage_Reg_0/dest]
  connect_bd_net -net Exe_Mux_1_out [get_bd_pins ALU_0/in1] [get_bd_pins Exe_Mux_1/out]
  connect_bd_net -net Exe_Mux_2_out [get_bd_pins ExeReg_0/Val_Rm] [get_bd_pins Exe_Mux_2/out] [get_bd_pins Val2Gen_0/Val_Rm]
  connect_bd_net -net ForwardingUnit_0_ForwardA [get_bd_pins Exe_Mux_1/sel] [get_bd_pins ForwardingUnit_0/ForwardA]
  connect_bd_net -net ForwardingUnit_0_ForwardB [get_bd_pins Exe_Mux_2/sel] [get_bd_pins ForwardingUnit_0/ForwardB]
  connect_bd_net -net Freeze_dout [get_bd_pins HazardUnitDetector_0/hazard_detected] [get_bd_pins IFreg/freeze] [get_bd_pins PC/freeze] [get_bd_pins cond_hazard_or_1/Op2]
  connect_bd_net -net IDreg_0_EXE_CMD_out [get_bd_pins ALU_0/ALU_op] [get_bd_pins IDreg_0/EXE_CMD_out]
  connect_bd_net -net IDreg_0_MEM_R_EN_out [get_bd_pins ExeReg_0/MEM_R_EN] [get_bd_pins HazardUnitDetector_0/Exe_MEM_R_EN] [get_bd_pins IDreg_0/MEM_R_EN_out] [get_bd_pins OR_mod/Op2]
  connect_bd_net -net IDreg_0_MEM_W_EN_out [get_bd_pins ExeReg_0/MEM_W_EN] [get_bd_pins IDreg_0/MEM_W_EN_out] [get_bd_pins OR_mod/Op1]
  connect_bd_net -net IDreg_0_S_out [get_bd_pins IDreg_0/S_out] [get_bd_pins StatusReg_0/s]
  connect_bd_net -net IDreg_0_Shift_operand_out [get_bd_pins IDreg_0/Shift_operand_out] [get_bd_pins Val2Gen_0/Shift_operand]
  connect_bd_net -net IDreg_0_Signed_imm_24_out [get_bd_pins IDreg_0/Signed_imm_24_out] [get_bd_pins RedAdder_0/a]
  connect_bd_net -net IDreg_0_Val_Rm_out [get_bd_pins Exe_Mux_2/val] [get_bd_pins IDreg_0/Val_Rm_out]
  connect_bd_net -net IDreg_0_Val_Rn_out [get_bd_pins Exe_Mux_1/val] [get_bd_pins IDreg_0/Val_Rn_out]
  connect_bd_net -net IDreg_0_WB_EN_out [get_bd_pins ExeReg_0/WB_EN] [get_bd_pins HazardUnitDetector_0/Exe_WB_EN] [get_bd_pins IDreg_0/WB_EN_out]
  connect_bd_net -net IDreg_0_dest_out [get_bd_pins ExeReg_0/dest] [get_bd_pins HazardUnitDetector_0/Exe_Dest] [get_bd_pins IDreg_0/dest_out]
  connect_bd_net -net IDreg_0_imm_out [get_bd_pins IDreg_0/imm_out] [get_bd_pins Val2Gen_0/I]
  connect_bd_net -net IDreg_0_pcOut [get_bd_pins IDreg_0/pcOut] [get_bd_pins RedAdder_0/b]
  connect_bd_net -net IDreg_0_src_1_out [get_bd_pins ForwardingUnit_0/src1] [get_bd_pins IDreg_0/src_1_out]
  connect_bd_net -net IDreg_0_src_2_out [get_bd_pins ForwardingUnit_0/src2] [get_bd_pins IDreg_0/src_2_out]
  connect_bd_net -net IDreg_0_status_out [get_bd_pins IDreg_0/status_out] [get_bd_pins carry_in_slice/Din]
  connect_bd_net -net IFreg_instructionOut [get_bd_pins ControlUnit_0/instruction] [get_bd_pins IFreg/instructionOut] [get_bd_pins RD_slice/Din] [get_bd_pins Rm_slice/Din] [get_bd_pins dest_slice/Din] [get_bd_pins opcode_slice/Din] [get_bd_pins rn_slice/Din] [get_bd_pins shift_operand_slice/Din] [get_bd_pins signed_imm_24_slice/Din] [get_bd_pins xlslice_0/Din]
  connect_bd_net -net IFreg_pcOut [get_bd_pins IDreg_0/pc] [get_bd_pins IFreg/pcOut]
  connect_bd_net -net MEM_Stage_Reg_0_ALU_Res_out [get_bd_pins MEM_Stage_Reg_0/ALU_Res_out] [get_bd_pins Mux_cyan/a]
  connect_bd_net -net MEM_Stage_Reg_0_MEM_R_EN_out [get_bd_pins MEM_Stage_Reg_0/MEM_R_EN_out] [get_bd_pins Mux_cyan/select]
  connect_bd_net -net MEM_Stage_Reg_0_WB_EN_out [get_bd_pins ForwardingUnit_0/WB_WB_EN] [get_bd_pins MEM_Stage_Reg_0/WB_EN_out] [get_bd_pins RegisterFile_0/WB_WB_EN]
  connect_bd_net -net MEM_Stage_Reg_0_data_mem_out [get_bd_pins MEM_Stage_Reg_0/data_mem_out] [get_bd_pins Mux_cyan/b]
  connect_bd_net -net MEM_Stage_Reg_0_dest_out [get_bd_pins ForwardingUnit_0/WB_DEST] [get_bd_pins MEM_Stage_Reg_0/dest_out] [get_bd_pins RegisterFile_0/WB_Dest]
  connect_bd_net -net Mux2to1_0_out [get_bd_pins Mux/out0] [get_bd_pins PC/in]
  connect_bd_net -net Mux_cyan_out0 [get_bd_pins Exe_Mux_1/WB_value] [get_bd_pins Exe_Mux_2/WB_value] [get_bd_pins Mux_cyan/out0] [get_bd_pins RegisterFile_0/WB_Value]
  connect_bd_net -net OR_mod_Res [get_bd_pins OR_mod/Res] [get_bd_pins Val2Gen_0/Shift_type]
  connect_bd_net -net PC_out [get_bd_pins Adder/b] [get_bd_pins PC/outReg] [get_bd_pins instruction_mem_address_slice/Din]
  connect_bd_net -net RD_slice_Dout [get_bd_pins RD_slice/Dout] [get_bd_pins RegMux_0/in1]
  connect_bd_net -net RedAdder_0_out [get_bd_pins Mux/b] [get_bd_pins RedAdder_0/out]
  connect_bd_net -net RegMux_0_mOut [get_bd_pins HazardUnitDetector_0/register_file_mux_out] [get_bd_pins IDreg_0/src_2] [get_bd_pins RegMux_0/mOut] [get_bd_pins RegisterFile_0/rm]
  connect_bd_net -net RegisterFile_0_R0 [get_bd_pins RegisterFile_0/R0] [get_bd_pins ila_0/probe0]
  connect_bd_net -net RegisterFile_0_R1 [get_bd_pins RegisterFile_0/R1] [get_bd_pins ila_0/probe1]
  connect_bd_net -net RegisterFile_0_R2 [get_bd_pins RegisterFile_0/R2] [get_bd_pins ila_0/probe2]
  connect_bd_net -net RegisterFile_0_R3 [get_bd_pins RegisterFile_0/R3] [get_bd_pins ila_0/probe3]
  connect_bd_net -net RegisterFile_0_R4 [get_bd_pins RegisterFile_0/R4] [get_bd_pins ila_0/probe4]
  connect_bd_net -net RegisterFile_0_R5 [get_bd_pins RegisterFile_0/R5] [get_bd_pins ila_0/probe5]
  connect_bd_net -net RegisterFile_0_R6 [get_bd_pins RegisterFile_0/R6] [get_bd_pins ila_0/probe6]
  connect_bd_net -net RegisterFile_0_Val_Rm [get_bd_pins IDreg_0/Val_Rm] [get_bd_pins RegisterFile_0/Val_Rm]
  connect_bd_net -net RegisterFile_0_Val_Rn [get_bd_pins IDreg_0/Val_Rn] [get_bd_pins RegisterFile_0/Val_Rn]
  connect_bd_net -net Rm_slice_Dout [get_bd_pins RegMux_0/in0] [get_bd_pins Rm_slice/Dout]
  connect_bd_net -net StatusReg_0_status_out [get_bd_pins ConditionCheck_0/status] [get_bd_pins IDreg_0/status] [get_bd_pins StatusReg_0/status_out]
  connect_bd_net -net Val2Gen_0_Val2 [get_bd_pins ALU_0/in2] [get_bd_pins Val2Gen_0/Val2]
  connect_bd_net -net carry_in_slice_Dout [get_bd_pins ALU_0/carry_in] [get_bd_pins carry_in_slice/Dout]
  connect_bd_net -net clk_0_1 [get_bd_ports clk_0] [get_bd_pins ExeReg_0/clk] [get_bd_pins IDreg_0/clk] [get_bd_pins IFreg/clk] [get_bd_pins MEM_Stage_Reg_0/clk] [get_bd_pins PC/clk] [get_bd_pins RegisterFile_0/clk] [get_bd_pins StatusReg_0/clk] [get_bd_pins data_mem/clk] [get_bd_pins debouncer_0/CLK_I] [get_bd_pins ila_0/clk] [get_bd_pins vio_forward_en/clk]
  connect_bd_net -net cond_hazard_or_1_Res [get_bd_pins CUMUX_0/sel] [get_bd_pins cond_hazard_or_1/Res]
  connect_bd_net -net data_mem_spo [get_bd_pins MEM_Stage_Reg_0/data_mem] [get_bd_pins data_mem/spo]
  connect_bd_net -net debouncer_0_SIGNAL_O [get_bd_pins ExeReg_0/rst] [get_bd_pins IDreg_0/rst] [get_bd_pins IFreg/rst] [get_bd_pins MEM_Stage_Reg_0/rst] [get_bd_pins PC/rst] [get_bd_pins RegisterFile_0/rst] [get_bd_pins StatusReg_0/rst] [get_bd_pins debouncer_0/SIGNAL_O] [get_bd_pins ila_0/probe7]
  connect_bd_net -net dest_slice_Dout [get_bd_pins IDreg_0/dest] [get_bd_pins dest_slice/Dout]
  connect_bd_net -net dist_mem_gen_0_spo [get_bd_pins IFreg/instruction] [get_bd_pins instruction_mem/spo]
  connect_bd_net -net flush_dout [get_bd_pins IDreg_0/B_out] [get_bd_pins IDreg_0/flush] [get_bd_pins IFreg/flush] [get_bd_pins Mux/select]
  connect_bd_net -net opcode_slice_Dout [get_bd_pins ConditionCheck_0/opcode] [get_bd_pins opcode_slice/Dout]
  connect_bd_net -net rst_0_1 [get_bd_ports rst_0] [get_bd_pins debouncer_0/SIGNAL_I]
  connect_bd_net -net shift_operand_slice_Dout [get_bd_pins IDreg_0/Shift_operand] [get_bd_pins shift_operand_slice/Dout]
  connect_bd_net -net signed_imm_24_slice_Dout [get_bd_pins IDreg_0/Signed_imm_24] [get_bd_pins signed_imm_24_slice/Dout]
  connect_bd_net -net two_src_or_Res [get_bd_pins HazardUnitDetector_0/is_two_source] [get_bd_pins two_src_or/Res]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins cond_hazard_or_1/Op1] [get_bd_pins cond_not/Res]
  connect_bd_net -net util_vector_logic_0_Res1 [get_bd_pins two_src_or/Op1] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net vio_forward_en_probe_out0 [get_bd_pins HazardUnitDetector_0/has_forwarding_unit] [get_bd_pins vio_forward_en/probe_out0]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins Adder/a] [get_bd_pins FourConstant/dout]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins instruction_mem/a] [get_bd_pins instruction_mem_address_slice/Dout]
  connect_bd_net -net xlslice_0_Dout1 [get_bd_pins IDreg_0/imm] [get_bd_pins util_vector_logic_0/Op1] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_pins HazardUnitDetector_0/rn] [get_bd_pins IDreg_0/src_1] [get_bd_pins RegisterFile_0/rn] [get_bd_pins rn_slice/Dout]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


