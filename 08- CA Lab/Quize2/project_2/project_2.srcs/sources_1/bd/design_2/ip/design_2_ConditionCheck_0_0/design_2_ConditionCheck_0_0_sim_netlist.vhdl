-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun May 11 11:31:34 2025
-- Host        : Ariyan running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               C:/Users/ariya/OneDrive/Desktop/project_1/project_1/project_1.srcs/sources_1/bd/design_2/ip/design_2_ConditionCheck_0_0/design_2_ConditionCheck_0_0_sim_netlist.vhdl
-- Design      : design_2_ConditionCheck_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_2_ConditionCheck_0_0 is
  port (
    opcode : in STD_LOGIC_VECTOR ( 3 downto 0 );
    status : in STD_LOGIC_VECTOR ( 3 downto 0 );
    condOut : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_2_ConditionCheck_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_2_ConditionCheck_0_0 : entity is "design_2_ConditionCheck_0_0,ConditionCheck,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_2_ConditionCheck_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_2_ConditionCheck_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_2_ConditionCheck_0_0 : entity is "ConditionCheck,Vivado 2018.3";
end design_2_ConditionCheck_0_0;

architecture STRUCTURE of design_2_ConditionCheck_0_0 is
  signal condOut_INST_0_i_1_n_0 : STD_LOGIC;
  signal condOut_INST_0_i_2_n_0 : STD_LOGIC;
  signal condOut_INST_0_i_3_n_0 : STD_LOGIC;
  signal condOut_INST_0_i_4_n_0 : STD_LOGIC;
  signal condOut_INST_0_i_5_n_0 : STD_LOGIC;
  signal condOut_INST_0_i_6_n_0 : STD_LOGIC;
begin
condOut_INST_0: unisim.vcomponents.MUXF8
     port map (
      I0 => condOut_INST_0_i_1_n_0,
      I1 => condOut_INST_0_i_2_n_0,
      O => condOut,
      S => opcode(3)
    );
condOut_INST_0_i_1: unisim.vcomponents.MUXF7
     port map (
      I0 => condOut_INST_0_i_3_n_0,
      I1 => condOut_INST_0_i_4_n_0,
      O => condOut_INST_0_i_1_n_0,
      S => opcode(2)
    );
condOut_INST_0_i_2: unisim.vcomponents.MUXF7
     port map (
      I0 => condOut_INST_0_i_5_n_0,
      I1 => condOut_INST_0_i_6_n_0,
      O => condOut_INST_0_i_2_n_0,
      S => opcode(2)
    );
condOut_INST_0_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4B78"
    )
        port map (
      I0 => status(1),
      I1 => opcode(1),
      I2 => opcode(0),
      I3 => status(2),
      O => condOut_INST_0_i_3_n_0
    );
condOut_INST_0_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4B78"
    )
        port map (
      I0 => status(0),
      I1 => opcode(1),
      I2 => opcode(0),
      I3 => status(3),
      O => condOut_INST_0_i_4_n_0
    );
condOut_INST_0_i_5: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6F90609F6F906F90"
    )
        port map (
      I0 => status(0),
      I1 => status(3),
      I2 => opcode(1),
      I3 => opcode(0),
      I4 => status(2),
      I5 => status(1),
      O => condOut_INST_0_i_5_n_0
    );
condOut_INST_0_i_6: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFBE41"
    )
        port map (
      I0 => status(2),
      I1 => status(3),
      I2 => status(0),
      I3 => opcode(0),
      I4 => opcode(1),
      O => condOut_INST_0_i_6_n_0
    );
end STRUCTURE;
