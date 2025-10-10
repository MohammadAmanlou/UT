-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun Apr 13 17:26:25 2025
-- Host        : Ariyan running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               C:/Users/ariya/ARM/ARM.srcs/sources_1/bd/design_2/ip/design_2_RegMux_0_0/design_2_RegMux_0_0_sim_netlist.vhdl
-- Design      : design_2_RegMux_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_2_RegMux_0_0_RegMux is
  port (
    mOut : out STD_LOGIC_VECTOR ( 3 downto 0 );
    in1 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    MEM_W_EN : in STD_LOGIC;
    in0 : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_2_RegMux_0_0_RegMux : entity is "RegMux";
end design_2_RegMux_0_0_RegMux;

architecture STRUCTURE of design_2_RegMux_0_0_RegMux is
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \mOut[0]_INST_0\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \mOut[1]_INST_0\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \mOut[2]_INST_0\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \mOut[3]_INST_0\ : label is "soft_lutpair1";
begin
\mOut[0]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => in1(0),
      I1 => MEM_W_EN,
      I2 => in0(0),
      O => mOut(0)
    );
\mOut[1]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => in1(1),
      I1 => MEM_W_EN,
      I2 => in0(1),
      O => mOut(1)
    );
\mOut[2]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => in1(2),
      I1 => MEM_W_EN,
      I2 => in0(2),
      O => mOut(2)
    );
\mOut[3]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => in1(3),
      I1 => MEM_W_EN,
      I2 => in0(3),
      O => mOut(3)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_2_RegMux_0_0 is
  port (
    MEM_W_EN : in STD_LOGIC;
    in0 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    in1 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    mOut : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_2_RegMux_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_2_RegMux_0_0 : entity is "design_2_RegMux_0_0,RegMux,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_2_RegMux_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_2_RegMux_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_2_RegMux_0_0 : entity is "RegMux,Vivado 2018.3";
end design_2_RegMux_0_0;

architecture STRUCTURE of design_2_RegMux_0_0 is
begin
inst: entity work.design_2_RegMux_0_0_RegMux
     port map (
      MEM_W_EN => MEM_W_EN,
      in0(3 downto 0) => in0(3 downto 0),
      in1(3 downto 0) => in1(3 downto 0),
      mOut(3 downto 0) => mOut(3 downto 0)
    );
end STRUCTURE;
