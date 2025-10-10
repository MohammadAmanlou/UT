-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun May 18 17:20:27 2025
-- Host        : Ariyan running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/ariya/OneDrive/Desktop/project_1/project_1/project_1.srcs/sources_1/bd/design_2/ip/design_2_ForwardingUnit_0_0/design_2_ForwardingUnit_0_0_sim_netlist.vhdl
-- Design      : design_2_ForwardingUnit_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_2_ForwardingUnit_0_0 is
  port (
    MEM_DEST : in STD_LOGIC_VECTOR ( 3 downto 0 );
    WB_DEST : in STD_LOGIC_VECTOR ( 3 downto 0 );
    MEM_WB_EN : in STD_LOGIC;
    WB_WB_EN : in STD_LOGIC;
    src1 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    src2 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    ForwardA : out STD_LOGIC_VECTOR ( 1 downto 0 );
    ForwardB : out STD_LOGIC_VECTOR ( 1 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_2_ForwardingUnit_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_2_ForwardingUnit_0_0 : entity is "design_2_ForwardingUnit_0_0,ForwardingUnit,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_2_ForwardingUnit_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_2_ForwardingUnit_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_2_ForwardingUnit_0_0 : entity is "ForwardingUnit,Vivado 2018.3";
end design_2_ForwardingUnit_0_0;

architecture STRUCTURE of design_2_ForwardingUnit_0_0 is
  signal \ForwardA[1]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \ForwardA[1]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \ForwardA[1]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \ForwardB[1]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \ForwardB[1]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \ForwardB[1]_INST_0_i_3_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \ForwardA[1]_INST_0_i_2\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \ForwardB[1]_INST_0_i_2\ : label is "soft_lutpair0";
begin
\ForwardA[0]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8008"
    )
        port map (
      I0 => \ForwardA[1]_INST_0_i_3_n_0\,
      I1 => MEM_WB_EN,
      I2 => src1(1),
      I3 => MEM_DEST(1),
      O => ForwardA(0)
    );
\ForwardA[1]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000900090009000"
    )
        port map (
      I0 => WB_DEST(1),
      I1 => src1(1),
      I2 => WB_WB_EN,
      I3 => \ForwardA[1]_INST_0_i_1_n_0\,
      I4 => \ForwardA[1]_INST_0_i_2_n_0\,
      I5 => \ForwardA[1]_INST_0_i_3_n_0\,
      O => ForwardA(1)
    );
\ForwardA[1]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => src1(0),
      I1 => WB_DEST(0),
      I2 => src1(3),
      I3 => WB_DEST(3),
      I4 => src1(2),
      I5 => WB_DEST(2),
      O => \ForwardA[1]_INST_0_i_1_n_0\
    );
\ForwardA[1]_INST_0_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"90"
    )
        port map (
      I0 => MEM_DEST(1),
      I1 => src1(1),
      I2 => MEM_WB_EN,
      O => \ForwardA[1]_INST_0_i_2_n_0\
    );
\ForwardA[1]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => src1(0),
      I1 => MEM_DEST(0),
      I2 => src1(3),
      I3 => MEM_DEST(3),
      I4 => MEM_DEST(2),
      I5 => src1(2),
      O => \ForwardA[1]_INST_0_i_3_n_0\
    );
\ForwardB[0]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8008"
    )
        port map (
      I0 => \ForwardB[1]_INST_0_i_3_n_0\,
      I1 => MEM_WB_EN,
      I2 => src2(1),
      I3 => MEM_DEST(1),
      O => ForwardB(0)
    );
\ForwardB[1]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000900090009000"
    )
        port map (
      I0 => WB_DEST(1),
      I1 => src2(1),
      I2 => WB_WB_EN,
      I3 => \ForwardB[1]_INST_0_i_1_n_0\,
      I4 => \ForwardB[1]_INST_0_i_2_n_0\,
      I5 => \ForwardB[1]_INST_0_i_3_n_0\,
      O => ForwardB(1)
    );
\ForwardB[1]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => src2(0),
      I1 => WB_DEST(0),
      I2 => src2(3),
      I3 => WB_DEST(3),
      I4 => WB_DEST(2),
      I5 => src2(2),
      O => \ForwardB[1]_INST_0_i_1_n_0\
    );
\ForwardB[1]_INST_0_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"90"
    )
        port map (
      I0 => MEM_DEST(1),
      I1 => src2(1),
      I2 => MEM_WB_EN,
      O => \ForwardB[1]_INST_0_i_2_n_0\
    );
\ForwardB[1]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9009000000009009"
    )
        port map (
      I0 => src2(0),
      I1 => MEM_DEST(0),
      I2 => src2(3),
      I3 => MEM_DEST(3),
      I4 => MEM_DEST(2),
      I5 => src2(2),
      O => \ForwardB[1]_INST_0_i_3_n_0\
    );
end STRUCTURE;
