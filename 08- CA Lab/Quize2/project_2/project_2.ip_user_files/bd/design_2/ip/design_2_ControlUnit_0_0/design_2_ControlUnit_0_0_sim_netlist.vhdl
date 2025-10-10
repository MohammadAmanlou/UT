-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun May 11 11:31:32 2025
-- Host        : Ariyan running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               C:/Users/ariya/OneDrive/Desktop/project_1/project_1/project_1.srcs/sources_1/bd/design_2/ip/design_2_ControlUnit_0_0/design_2_ControlUnit_0_0_sim_netlist.vhdl
-- Design      : design_2_ControlUnit_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_2_ControlUnit_0_0 is
  port (
    instruction : in STD_LOGIC_VECTOR ( 31 downto 0 );
    WB_EN : out STD_LOGIC;
    imm : out STD_LOGIC;
    MEM_R_EN : out STD_LOGIC;
    MEM_W_EN : out STD_LOGIC;
    B : out STD_LOGIC;
    EXE_CMD : out STD_LOGIC_VECTOR ( 3 downto 0 );
    S : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_2_ControlUnit_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_2_ControlUnit_0_0 : entity is "design_2_ControlUnit_0_0,ControlUnit,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_2_ControlUnit_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_2_ControlUnit_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_2_ControlUnit_0_0 : entity is "ControlUnit,Vivado 2018.3";
end design_2_ControlUnit_0_0;

architecture STRUCTURE of design_2_ControlUnit_0_0 is
  signal WB_EN_INST_0_i_1_n_0 : STD_LOGIC;
  signal \^instruction\ : STD_LOGIC_VECTOR ( 31 downto 0 );
begin
  S <= \^instruction\(20);
  \^instruction\(27 downto 20) <= instruction(27 downto 20);
B_INST_0: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => \^instruction\(26),
      I1 => \^instruction\(25),
      I2 => \^instruction\(27),
      O => B
    );
\EXE_CMD[0]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000041540000"
    )
        port map (
      I0 => \^instruction\(26),
      I1 => \^instruction\(21),
      I2 => \^instruction\(24),
      I3 => \^instruction\(22),
      I4 => \^instruction\(23),
      I5 => \^instruction\(27),
      O => EXE_CMD(0)
    );
\EXE_CMD[1]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000AAAAAEFF"
    )
        port map (
      I0 => \^instruction\(26),
      I1 => \^instruction\(23),
      I2 => \^instruction\(24),
      I3 => \^instruction\(21),
      I4 => \^instruction\(22),
      I5 => \^instruction\(27),
      O => EXE_CMD(1)
    );
\EXE_CMD[2]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000001551"
    )
        port map (
      I0 => \^instruction\(26),
      I1 => \^instruction\(23),
      I2 => \^instruction\(22),
      I3 => \^instruction\(24),
      I4 => \^instruction\(21),
      I5 => \^instruction\(27),
      O => EXE_CMD(2)
    );
\EXE_CMD[3]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000040010000"
    )
        port map (
      I0 => \^instruction\(26),
      I1 => \^instruction\(23),
      I2 => \^instruction\(22),
      I3 => \^instruction\(24),
      I4 => \^instruction\(21),
      I5 => \^instruction\(27),
      O => EXE_CMD(3)
    );
MEM_R_EN_INST_0: unisim.vcomponents.LUT3
    generic map(
      INIT => X"08"
    )
        port map (
      I0 => \^instruction\(26),
      I1 => \^instruction\(20),
      I2 => \^instruction\(27),
      O => MEM_R_EN
    );
MEM_W_EN_INST_0: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => \^instruction\(20),
      I1 => \^instruction\(26),
      I2 => \^instruction\(27),
      O => MEM_W_EN
    );
WB_EN_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => WB_EN_INST_0_i_1_n_0,
      I1 => \^instruction\(27),
      O => WB_EN
    );
WB_EN_INST_0_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"B8BB88888BBB8BBB"
    )
        port map (
      I0 => \^instruction\(20),
      I1 => \^instruction\(26),
      I2 => \^instruction\(21),
      I3 => \^instruction\(22),
      I4 => \^instruction\(23),
      I5 => \^instruction\(24),
      O => WB_EN_INST_0_i_1_n_0
    );
imm_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \^instruction\(25),
      I1 => \^instruction\(26),
      O => imm
    );
end STRUCTURE;
