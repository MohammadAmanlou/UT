
################################################################
# This is a generated script based on design: design_1
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
# source design_1_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# Adder, IFreg, IFreg, IFreg, IFreg, Mux2to1, Register, debouncer

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
set design_name design_1

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
  
  # Create instance: FourConstant, and set properties
  set FourConstant [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 FourConstant ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {1} \
   CONFIG.CONST_WIDTH {32} \
 ] $FourConstant

  # Create instance: Freeze, and set properties
  set Freeze [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 Freeze ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $Freeze

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
  
  # Create instance: IFreg_0, and set properties
  set block_name IFreg
  set block_cell_name IFreg_0
  if { [catch {set IFreg_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $IFreg_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: IFreg_1, and set properties
  set block_name IFreg
  set block_cell_name IFreg_1
  if { [catch {set IFreg_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $IFreg_1 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: IFreg_2, and set properties
  set block_name IFreg
  set block_cell_name IFreg_2
  if { [catch {set IFreg_2 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $IFreg_2 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: InstructionMem, and set properties
  set InstructionMem [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 InstructionMem ]
  set_property -dict [ list \
   CONFIG.Byte_Size {9} \
   CONFIG.Coe_File {d:/CA_LAB/Computer-Architecture-Lab/src/output.coe} \
   CONFIG.EN_SAFETY_CKT {false} \
   CONFIG.Enable_32bit_Address {false} \
   CONFIG.Enable_A {Always_Enabled} \
   CONFIG.Load_Init_File {true} \
   CONFIG.Memory_Type {Single_Port_ROM} \
   CONFIG.Port_A_Write_Rate {0} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {true} \
   CONFIG.Use_Byte_Write_Enable {false} \
   CONFIG.Use_RSTA_Pin {false} \
   CONFIG.use_bram_block {Stand_Alone} \
 ] $InstructionMem

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
  
  # Create instance: branch_taken, and set properties
  set branch_taken [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 branch_taken ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $branch_taken

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
  
  # Create instance: flush, and set properties
  set flush [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 flush ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $flush

  # Create instance: ila_0, and set properties
  set ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.2 ila_0 ]
  set_property -dict [ list \
   CONFIG.C_ENABLE_ILA_AXI_MON {false} \
   CONFIG.C_MONITOR_TYPE {Native} \
   CONFIG.C_NUM_OF_PROBES {6} \
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
   CONFIG.C_PROBE5_TYPE {2} \
 ] $ila_0

  # Create instance: mux_second, and set properties
  set mux_second [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 mux_second ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {32} \
 ] $mux_second

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {12} \
   CONFIG.DOUT_WIDTH {13} \
 ] $xlslice_0

  # Create port connections
  connect_bd_net -net Adder_0_out [get_bd_pins Adder/out] [get_bd_pins IFreg/pc] [get_bd_pins Mux/a]
  connect_bd_net -net Freeze_dout [get_bd_pins Freeze/dout] [get_bd_pins IFreg/freeze] [get_bd_pins IFreg_0/freeze] [get_bd_pins IFreg_1/flush] [get_bd_pins IFreg_1/freeze] [get_bd_pins IFreg_2/freeze] [get_bd_pins PC/freeze]
  connect_bd_net -net IFreg_0_instructionOut [get_bd_pins IFreg_0/instructionOut] [get_bd_pins IFreg_1/instruction]
  connect_bd_net -net IFreg_0_pcOut [get_bd_pins IFreg_0/pcOut] [get_bd_pins IFreg_1/pc] [get_bd_pins ila_0/probe2]
  connect_bd_net -net IFreg_1_instructionOut [get_bd_pins IFreg_1/instructionOut] [get_bd_pins IFreg_2/instruction]
  connect_bd_net -net IFreg_1_pcOut [get_bd_pins IFreg_1/pcOut] [get_bd_pins IFreg_2/pc] [get_bd_pins ila_0/probe3]
  connect_bd_net -net IFreg_2_instructionOut [get_bd_pins IFreg_2/instructionOut] [get_bd_pins ila_0/probe0]
  connect_bd_net -net IFreg_2_pcOut [get_bd_pins IFreg_2/pcOut] [get_bd_pins ila_0/probe4]
  connect_bd_net -net IFreg_instructionOut [get_bd_pins IFreg/instructionOut] [get_bd_pins IFreg_0/instruction]
  connect_bd_net -net IFreg_pcOut [get_bd_pins IFreg/pcOut] [get_bd_pins IFreg_0/pc] [get_bd_pins ila_0/probe1]
  connect_bd_net -net InstructionMem_douta [get_bd_pins IFreg/instruction] [get_bd_pins InstructionMem/douta]
  connect_bd_net -net Mux2to1_0_out [get_bd_pins Mux/out0] [get_bd_pins PC/in]
  connect_bd_net -net PC_out [get_bd_pins Adder/b] [get_bd_pins PC/outReg] [get_bd_pins xlslice_0/Din]
  connect_bd_net -net branch_taken_dout [get_bd_pins Mux/select] [get_bd_pins branch_taken/dout]
  connect_bd_net -net clk_0_1 [get_bd_ports clk_0] [get_bd_pins IFreg/clk] [get_bd_pins IFreg_0/clk] [get_bd_pins IFreg_1/clk] [get_bd_pins IFreg_2/clk] [get_bd_pins InstructionMem/clka] [get_bd_pins PC/clk] [get_bd_pins debouncer_0/CLK_I] [get_bd_pins ila_0/clk]
  connect_bd_net -net debouncer_0_SIGNAL_O [get_bd_pins IFreg/rst] [get_bd_pins IFreg_0/rst] [get_bd_pins IFreg_1/rst] [get_bd_pins IFreg_2/rst] [get_bd_pins PC/rst] [get_bd_pins debouncer_0/SIGNAL_O] [get_bd_pins ila_0/probe5]
  connect_bd_net -net flush_dout [get_bd_pins IFreg/flush] [get_bd_pins IFreg_0/flush] [get_bd_pins IFreg_2/flush] [get_bd_pins flush/dout]
  connect_bd_net -net mux_second_dout [get_bd_pins Mux/b] [get_bd_pins mux_second/dout]
  connect_bd_net -net rst_0_1 [get_bd_ports rst_0] [get_bd_pins debouncer_0/SIGNAL_I]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins Adder/a] [get_bd_pins FourConstant/dout]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins InstructionMem/addra] [get_bd_pins xlslice_0/Dout]

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


