-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun May 18 17:04:00 2025
-- Host        : Ariyan running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/ariya/OneDrive/Desktop/project_1/project_1/project_1.srcs/sources_1/bd/design_2/ip/design_2_Exe_Mux_0_0/design_2_Exe_Mux_0_0_stub.vhdl
-- Design      : design_2_Exe_Mux_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_2_Exe_Mux_0_0 is
  Port ( 
    sel : in STD_LOGIC_VECTOR ( 1 downto 0 );
    val : in STD_LOGIC_VECTOR ( 31 downto 0 );
    ALU_res : in STD_LOGIC_VECTOR ( 31 downto 0 );
    WB_value : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \out\ : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end design_2_Exe_Mux_0_0;

architecture stub of design_2_Exe_Mux_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "sel[1:0],val[31:0],ALU_res[31:0],WB_value[31:0],\out\[31:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "Exe_Mux,Vivado 2018.3";
begin
end;
