-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun Mar  9 10:01:39 2025
-- Host        : Ariyan running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               C:/Users/ariya/ARM/ARM.srcs/sources_1/bd/design_1/ip/design_1_Mux2to1_0_0/design_1_Mux2to1_0_0_sim_netlist.vhdl
-- Design      : design_1_Mux2to1_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_Mux2to1_0_0_Mux2to1 is
  port (
    out0 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    b : in STD_LOGIC_VECTOR ( 31 downto 0 );
    a : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \select\ : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_Mux2to1_0_0_Mux2to1 : entity is "Mux2to1";
end design_1_Mux2to1_0_0_Mux2to1;

architecture STRUCTURE of design_1_Mux2to1_0_0_Mux2to1 is
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \out0[0]_INST_0\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \out0[10]_INST_0\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \out0[11]_INST_0\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \out0[12]_INST_0\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \out0[13]_INST_0\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \out0[14]_INST_0\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \out0[15]_INST_0\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \out0[16]_INST_0\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \out0[17]_INST_0\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \out0[18]_INST_0\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \out0[19]_INST_0\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \out0[1]_INST_0\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \out0[20]_INST_0\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \out0[21]_INST_0\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \out0[22]_INST_0\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \out0[23]_INST_0\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \out0[24]_INST_0\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \out0[25]_INST_0\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \out0[26]_INST_0\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \out0[27]_INST_0\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \out0[28]_INST_0\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \out0[29]_INST_0\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \out0[2]_INST_0\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \out0[30]_INST_0\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \out0[31]_INST_0\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \out0[3]_INST_0\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \out0[4]_INST_0\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \out0[5]_INST_0\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \out0[6]_INST_0\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \out0[7]_INST_0\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \out0[8]_INST_0\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \out0[9]_INST_0\ : label is "soft_lutpair4";
begin
\out0[0]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(0),
      I1 => a(0),
      I2 => \select\,
      O => out0(0)
    );
\out0[10]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(10),
      I1 => a(10),
      I2 => \select\,
      O => out0(10)
    );
\out0[11]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(11),
      I1 => a(11),
      I2 => \select\,
      O => out0(11)
    );
\out0[12]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(12),
      I1 => a(12),
      I2 => \select\,
      O => out0(12)
    );
\out0[13]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(13),
      I1 => a(13),
      I2 => \select\,
      O => out0(13)
    );
\out0[14]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(14),
      I1 => a(14),
      I2 => \select\,
      O => out0(14)
    );
\out0[15]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(15),
      I1 => a(15),
      I2 => \select\,
      O => out0(15)
    );
\out0[16]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(16),
      I1 => a(16),
      I2 => \select\,
      O => out0(16)
    );
\out0[17]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(17),
      I1 => a(17),
      I2 => \select\,
      O => out0(17)
    );
\out0[18]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(18),
      I1 => a(18),
      I2 => \select\,
      O => out0(18)
    );
\out0[19]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(19),
      I1 => a(19),
      I2 => \select\,
      O => out0(19)
    );
\out0[1]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(1),
      I1 => a(1),
      I2 => \select\,
      O => out0(1)
    );
\out0[20]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(20),
      I1 => a(20),
      I2 => \select\,
      O => out0(20)
    );
\out0[21]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(21),
      I1 => a(21),
      I2 => \select\,
      O => out0(21)
    );
\out0[22]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(22),
      I1 => a(22),
      I2 => \select\,
      O => out0(22)
    );
\out0[23]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(23),
      I1 => a(23),
      I2 => \select\,
      O => out0(23)
    );
\out0[24]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(24),
      I1 => a(24),
      I2 => \select\,
      O => out0(24)
    );
\out0[25]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(25),
      I1 => a(25),
      I2 => \select\,
      O => out0(25)
    );
\out0[26]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(26),
      I1 => a(26),
      I2 => \select\,
      O => out0(26)
    );
\out0[27]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(27),
      I1 => a(27),
      I2 => \select\,
      O => out0(27)
    );
\out0[28]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(28),
      I1 => a(28),
      I2 => \select\,
      O => out0(28)
    );
\out0[29]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(29),
      I1 => a(29),
      I2 => \select\,
      O => out0(29)
    );
\out0[2]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(2),
      I1 => a(2),
      I2 => \select\,
      O => out0(2)
    );
\out0[30]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(30),
      I1 => a(30),
      I2 => \select\,
      O => out0(30)
    );
\out0[31]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(31),
      I1 => a(31),
      I2 => \select\,
      O => out0(31)
    );
\out0[3]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(3),
      I1 => a(3),
      I2 => \select\,
      O => out0(3)
    );
\out0[4]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(4),
      I1 => a(4),
      I2 => \select\,
      O => out0(4)
    );
\out0[5]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(5),
      I1 => a(5),
      I2 => \select\,
      O => out0(5)
    );
\out0[6]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(6),
      I1 => a(6),
      I2 => \select\,
      O => out0(6)
    );
\out0[7]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(7),
      I1 => a(7),
      I2 => \select\,
      O => out0(7)
    );
\out0[8]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(8),
      I1 => a(8),
      I2 => \select\,
      O => out0(8)
    );
\out0[9]_INST_0\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"AC"
    )
        port map (
      I0 => b(9),
      I1 => a(9),
      I2 => \select\,
      O => out0(9)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_Mux2to1_0_0 is
  port (
    \select\ : in STD_LOGIC;
    a : in STD_LOGIC_VECTOR ( 31 downto 0 );
    b : in STD_LOGIC_VECTOR ( 31 downto 0 );
    out0 : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_Mux2to1_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_Mux2to1_0_0 : entity is "design_1_Mux2to1_0_0,Mux2to1,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_1_Mux2to1_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_1_Mux2to1_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_1_Mux2to1_0_0 : entity is "Mux2to1,Vivado 2018.3";
end design_1_Mux2to1_0_0;

architecture STRUCTURE of design_1_Mux2to1_0_0 is
begin
inst: entity work.design_1_Mux2to1_0_0_Mux2to1
     port map (
      a(31 downto 0) => a(31 downto 0),
      b(31 downto 0) => b(31 downto 0),
      out0(31 downto 0) => out0(31 downto 0),
      \select\ => \select\
    );
end STRUCTURE;
