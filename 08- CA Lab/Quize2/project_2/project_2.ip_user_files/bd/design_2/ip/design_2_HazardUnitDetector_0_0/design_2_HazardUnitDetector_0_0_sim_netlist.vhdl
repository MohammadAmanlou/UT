-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun May 25 17:54:05 2025
-- Host        : Ariyan running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               C:/Users/ariya/OneDrive/Desktop/project_1/project_1/project_1.srcs/sources_1/bd/design_2/ip/design_2_HazardUnitDetector_0_0/design_2_HazardUnitDetector_0_0_sim_netlist.vhdl
-- Design      : design_2_HazardUnitDetector_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_2_HazardUnitDetector_0_0 is
  port (
    rn : in STD_LOGIC_VECTOR ( 3 downto 0 );
    register_file_mux_out : in STD_LOGIC_VECTOR ( 3 downto 0 );
    Exe_Dest : in STD_LOGIC_VECTOR ( 3 downto 0 );
    Exe_WB_EN : in STD_LOGIC;
    Exe_MEM_R_EN : in STD_LOGIC;
    Mem_Dest : in STD_LOGIC_VECTOR ( 3 downto 0 );
    Mem_WB_EN : in STD_LOGIC;
    is_two_source : in STD_LOGIC;
    has_forwarding_unit : in STD_LOGIC;
    hazard_detected : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_2_HazardUnitDetector_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_2_HazardUnitDetector_0_0 : entity is "design_2_HazardUnitDetector_0_0,HazardUnitDetector,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_2_HazardUnitDetector_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_2_HazardUnitDetector_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_2_HazardUnitDetector_0_0 : entity is "HazardUnitDetector,Vivado 2018.3";
end design_2_HazardUnitDetector_0_0;

architecture STRUCTURE of design_2_HazardUnitDetector_0_0 is
  signal hazard_detected_INST_0_i_2_n_0 : STD_LOGIC;
  signal hazard_detected_INST_0_i_3_n_0 : STD_LOGIC;
  signal hazard_detected_INST_0_i_4_n_0 : STD_LOGIC;
  signal hazard_detected_INST_0_i_5_n_0 : STD_LOGIC;
  signal hazard_detected_INST_0_i_6_n_0 : STD_LOGIC;
  signal \inst/hazard_detected1__1\ : STD_LOGIC;
begin
hazard_detected_INST_0: unisim.vcomponents.LUT6
    generic map(
      INIT => X"D5D5D080D080D080"
    )
        port map (
      I0 => has_forwarding_unit,
      I1 => Exe_MEM_R_EN,
      I2 => \inst/hazard_detected1__1\,
      I3 => Exe_WB_EN,
      I4 => Mem_WB_EN,
      I5 => hazard_detected_INST_0_i_2_n_0,
      O => hazard_detected
    );
hazard_detected_INST_0_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F82F882288228822"
    )
        port map (
      I0 => hazard_detected_INST_0_i_3_n_0,
      I1 => rn(3),
      I2 => register_file_mux_out(3),
      I3 => Exe_Dest(3),
      I4 => hazard_detected_INST_0_i_4_n_0,
      I5 => is_two_source,
      O => \inst/hazard_detected1__1\
    );
hazard_detected_INST_0_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F82F882288228822"
    )
        port map (
      I0 => hazard_detected_INST_0_i_5_n_0,
      I1 => rn(3),
      I2 => register_file_mux_out(3),
      I3 => Mem_Dest(3),
      I4 => hazard_detected_INST_0_i_6_n_0,
      I5 => is_two_source,
      O => hazard_detected_INST_0_i_2_n_0
    );
hazard_detected_INST_0_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => rn(0),
      I1 => Exe_Dest(0),
      I2 => Exe_Dest(2),
      I3 => rn(2),
      I4 => Exe_Dest(1),
      I5 => rn(1),
      O => hazard_detected_INST_0_i_3_n_0
    );
hazard_detected_INST_0_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => register_file_mux_out(0),
      I1 => Exe_Dest(0),
      I2 => Exe_Dest(2),
      I3 => register_file_mux_out(2),
      I4 => Exe_Dest(1),
      I5 => register_file_mux_out(1),
      O => hazard_detected_INST_0_i_4_n_0
    );
hazard_detected_INST_0_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => rn(0),
      I1 => Mem_Dest(0),
      I2 => Mem_Dest(2),
      I3 => rn(2),
      I4 => Mem_Dest(1),
      I5 => rn(1),
      O => hazard_detected_INST_0_i_5_n_0
    );
hazard_detected_INST_0_i_6: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => register_file_mux_out(0),
      I1 => Mem_Dest(0),
      I2 => Mem_Dest(2),
      I3 => register_file_mux_out(2),
      I4 => Mem_Dest(1),
      I5 => register_file_mux_out(1),
      O => hazard_detected_INST_0_i_6_n_0
    );
end STRUCTURE;
