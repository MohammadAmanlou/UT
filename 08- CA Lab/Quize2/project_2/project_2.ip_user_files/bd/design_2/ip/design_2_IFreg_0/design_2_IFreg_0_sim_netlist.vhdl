-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun Apr  6 08:13:56 2025
-- Host        : Ariyan running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               C:/Users/ariya/ARM/ARM.srcs/sources_1/bd/design_2/ip/design_2_IFreg_0/design_2_IFreg_0_sim_netlist.vhdl
-- Design      : design_2_IFreg_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_2_IFreg_0_IFreg is
  port (
    pcOut : out STD_LOGIC_VECTOR ( 31 downto 0 );
    instructionOut : out STD_LOGIC_VECTOR ( 31 downto 0 );
    flush : in STD_LOGIC;
    freeze : in STD_LOGIC;
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    pc : in STD_LOGIC_VECTOR ( 31 downto 0 );
    instruction : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_2_IFreg_0_IFreg : entity is "IFreg";
end design_2_IFreg_0_IFreg;

architecture STRUCTURE of design_2_IFreg_0_IFreg is
  signal \instructionOut[0]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[10]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[11]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[12]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[13]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[14]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[15]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[16]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[17]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[18]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[19]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[1]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[20]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[21]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[22]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[23]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[24]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[25]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[26]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[27]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[28]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[29]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[2]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[30]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[31]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[3]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[4]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[5]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[6]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[7]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[8]_i_1_n_0\ : STD_LOGIC;
  signal \instructionOut[9]_i_1_n_0\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \pcOut[31]_i_1_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \instructionOut[0]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \instructionOut[10]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \instructionOut[11]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \instructionOut[12]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \instructionOut[13]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \instructionOut[14]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \instructionOut[15]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \instructionOut[16]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \instructionOut[17]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \instructionOut[18]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \instructionOut[19]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \instructionOut[1]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \instructionOut[20]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \instructionOut[21]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \instructionOut[22]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \instructionOut[23]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \instructionOut[24]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \instructionOut[25]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \instructionOut[26]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \instructionOut[27]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \instructionOut[28]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \instructionOut[29]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \instructionOut[2]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \instructionOut[30]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \instructionOut[31]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \instructionOut[3]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \instructionOut[4]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \instructionOut[5]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \instructionOut[6]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \instructionOut[7]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \instructionOut[8]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \instructionOut[9]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \pcOut[0]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \pcOut[10]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \pcOut[11]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \pcOut[12]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \pcOut[13]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \pcOut[14]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \pcOut[15]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \pcOut[16]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \pcOut[17]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \pcOut[18]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \pcOut[19]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \pcOut[1]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \pcOut[20]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \pcOut[21]_i_1\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \pcOut[22]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \pcOut[23]_i_1\ : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \pcOut[24]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \pcOut[25]_i_1\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \pcOut[26]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \pcOut[27]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \pcOut[28]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \pcOut[29]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \pcOut[2]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \pcOut[30]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \pcOut[31]_i_2\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \pcOut[3]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \pcOut[4]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \pcOut[5]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \pcOut[6]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \pcOut[7]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \pcOut[8]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \pcOut[9]_i_1\ : label is "soft_lutpair4";
begin
\instructionOut[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(0),
      I1 => flush,
      O => \instructionOut[0]_i_1_n_0\
    );
\instructionOut[10]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(10),
      I1 => flush,
      O => \instructionOut[10]_i_1_n_0\
    );
\instructionOut[11]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(11),
      I1 => flush,
      O => \instructionOut[11]_i_1_n_0\
    );
\instructionOut[12]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(12),
      I1 => flush,
      O => \instructionOut[12]_i_1_n_0\
    );
\instructionOut[13]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(13),
      I1 => flush,
      O => \instructionOut[13]_i_1_n_0\
    );
\instructionOut[14]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(14),
      I1 => flush,
      O => \instructionOut[14]_i_1_n_0\
    );
\instructionOut[15]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(15),
      I1 => flush,
      O => \instructionOut[15]_i_1_n_0\
    );
\instructionOut[16]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(16),
      I1 => flush,
      O => \instructionOut[16]_i_1_n_0\
    );
\instructionOut[17]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(17),
      I1 => flush,
      O => \instructionOut[17]_i_1_n_0\
    );
\instructionOut[18]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(18),
      I1 => flush,
      O => \instructionOut[18]_i_1_n_0\
    );
\instructionOut[19]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(19),
      I1 => flush,
      O => \instructionOut[19]_i_1_n_0\
    );
\instructionOut[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(1),
      I1 => flush,
      O => \instructionOut[1]_i_1_n_0\
    );
\instructionOut[20]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(20),
      I1 => flush,
      O => \instructionOut[20]_i_1_n_0\
    );
\instructionOut[21]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(21),
      I1 => flush,
      O => \instructionOut[21]_i_1_n_0\
    );
\instructionOut[22]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(22),
      I1 => flush,
      O => \instructionOut[22]_i_1_n_0\
    );
\instructionOut[23]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(23),
      I1 => flush,
      O => \instructionOut[23]_i_1_n_0\
    );
\instructionOut[24]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(24),
      I1 => flush,
      O => \instructionOut[24]_i_1_n_0\
    );
\instructionOut[25]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(25),
      I1 => flush,
      O => \instructionOut[25]_i_1_n_0\
    );
\instructionOut[26]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(26),
      I1 => flush,
      O => \instructionOut[26]_i_1_n_0\
    );
\instructionOut[27]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(27),
      I1 => flush,
      O => \instructionOut[27]_i_1_n_0\
    );
\instructionOut[28]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(28),
      I1 => flush,
      O => \instructionOut[28]_i_1_n_0\
    );
\instructionOut[29]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(29),
      I1 => flush,
      O => \instructionOut[29]_i_1_n_0\
    );
\instructionOut[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(2),
      I1 => flush,
      O => \instructionOut[2]_i_1_n_0\
    );
\instructionOut[30]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(30),
      I1 => flush,
      O => \instructionOut[30]_i_1_n_0\
    );
\instructionOut[31]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(31),
      I1 => flush,
      O => \instructionOut[31]_i_1_n_0\
    );
\instructionOut[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(3),
      I1 => flush,
      O => \instructionOut[3]_i_1_n_0\
    );
\instructionOut[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(4),
      I1 => flush,
      O => \instructionOut[4]_i_1_n_0\
    );
\instructionOut[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(5),
      I1 => flush,
      O => \instructionOut[5]_i_1_n_0\
    );
\instructionOut[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(6),
      I1 => flush,
      O => \instructionOut[6]_i_1_n_0\
    );
\instructionOut[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(7),
      I1 => flush,
      O => \instructionOut[7]_i_1_n_0\
    );
\instructionOut[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(8),
      I1 => flush,
      O => \instructionOut[8]_i_1_n_0\
    );
\instructionOut[9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => instruction(9),
      I1 => flush,
      O => \instructionOut[9]_i_1_n_0\
    );
\instructionOut_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[0]_i_1_n_0\,
      Q => instructionOut(0)
    );
\instructionOut_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[10]_i_1_n_0\,
      Q => instructionOut(10)
    );
\instructionOut_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[11]_i_1_n_0\,
      Q => instructionOut(11)
    );
\instructionOut_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[12]_i_1_n_0\,
      Q => instructionOut(12)
    );
\instructionOut_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[13]_i_1_n_0\,
      Q => instructionOut(13)
    );
\instructionOut_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[14]_i_1_n_0\,
      Q => instructionOut(14)
    );
\instructionOut_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[15]_i_1_n_0\,
      Q => instructionOut(15)
    );
\instructionOut_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[16]_i_1_n_0\,
      Q => instructionOut(16)
    );
\instructionOut_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[17]_i_1_n_0\,
      Q => instructionOut(17)
    );
\instructionOut_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[18]_i_1_n_0\,
      Q => instructionOut(18)
    );
\instructionOut_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[19]_i_1_n_0\,
      Q => instructionOut(19)
    );
\instructionOut_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[1]_i_1_n_0\,
      Q => instructionOut(1)
    );
\instructionOut_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[20]_i_1_n_0\,
      Q => instructionOut(20)
    );
\instructionOut_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[21]_i_1_n_0\,
      Q => instructionOut(21)
    );
\instructionOut_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[22]_i_1_n_0\,
      Q => instructionOut(22)
    );
\instructionOut_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[23]_i_1_n_0\,
      Q => instructionOut(23)
    );
\instructionOut_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[24]_i_1_n_0\,
      Q => instructionOut(24)
    );
\instructionOut_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[25]_i_1_n_0\,
      Q => instructionOut(25)
    );
\instructionOut_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[26]_i_1_n_0\,
      Q => instructionOut(26)
    );
\instructionOut_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[27]_i_1_n_0\,
      Q => instructionOut(27)
    );
\instructionOut_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[28]_i_1_n_0\,
      Q => instructionOut(28)
    );
\instructionOut_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[29]_i_1_n_0\,
      Q => instructionOut(29)
    );
\instructionOut_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[2]_i_1_n_0\,
      Q => instructionOut(2)
    );
\instructionOut_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[30]_i_1_n_0\,
      Q => instructionOut(30)
    );
\instructionOut_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[31]_i_1_n_0\,
      Q => instructionOut(31)
    );
\instructionOut_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[3]_i_1_n_0\,
      Q => instructionOut(3)
    );
\instructionOut_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[4]_i_1_n_0\,
      Q => instructionOut(4)
    );
\instructionOut_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[5]_i_1_n_0\,
      Q => instructionOut(5)
    );
\instructionOut_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[6]_i_1_n_0\,
      Q => instructionOut(6)
    );
\instructionOut_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[7]_i_1_n_0\,
      Q => instructionOut(7)
    );
\instructionOut_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[8]_i_1_n_0\,
      Q => instructionOut(8)
    );
\instructionOut_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => \instructionOut[9]_i_1_n_0\,
      Q => instructionOut(9)
    );
\pcOut[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(0),
      I1 => flush,
      O => p_0_in(0)
    );
\pcOut[10]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(10),
      I1 => flush,
      O => p_0_in(10)
    );
\pcOut[11]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(11),
      I1 => flush,
      O => p_0_in(11)
    );
\pcOut[12]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(12),
      I1 => flush,
      O => p_0_in(12)
    );
\pcOut[13]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(13),
      I1 => flush,
      O => p_0_in(13)
    );
\pcOut[14]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(14),
      I1 => flush,
      O => p_0_in(14)
    );
\pcOut[15]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(15),
      I1 => flush,
      O => p_0_in(15)
    );
\pcOut[16]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(16),
      I1 => flush,
      O => p_0_in(16)
    );
\pcOut[17]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(17),
      I1 => flush,
      O => p_0_in(17)
    );
\pcOut[18]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(18),
      I1 => flush,
      O => p_0_in(18)
    );
\pcOut[19]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(19),
      I1 => flush,
      O => p_0_in(19)
    );
\pcOut[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(1),
      I1 => flush,
      O => p_0_in(1)
    );
\pcOut[20]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(20),
      I1 => flush,
      O => p_0_in(20)
    );
\pcOut[21]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(21),
      I1 => flush,
      O => p_0_in(21)
    );
\pcOut[22]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(22),
      I1 => flush,
      O => p_0_in(22)
    );
\pcOut[23]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(23),
      I1 => flush,
      O => p_0_in(23)
    );
\pcOut[24]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(24),
      I1 => flush,
      O => p_0_in(24)
    );
\pcOut[25]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(25),
      I1 => flush,
      O => p_0_in(25)
    );
\pcOut[26]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(26),
      I1 => flush,
      O => p_0_in(26)
    );
\pcOut[27]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(27),
      I1 => flush,
      O => p_0_in(27)
    );
\pcOut[28]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(28),
      I1 => flush,
      O => p_0_in(28)
    );
\pcOut[29]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(29),
      I1 => flush,
      O => p_0_in(29)
    );
\pcOut[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(2),
      I1 => flush,
      O => p_0_in(2)
    );
\pcOut[30]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(30),
      I1 => flush,
      O => p_0_in(30)
    );
\pcOut[31]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"B"
    )
        port map (
      I0 => flush,
      I1 => freeze,
      O => \pcOut[31]_i_1_n_0\
    );
\pcOut[31]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(31),
      I1 => flush,
      O => p_0_in(31)
    );
\pcOut[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(3),
      I1 => flush,
      O => p_0_in(3)
    );
\pcOut[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(4),
      I1 => flush,
      O => p_0_in(4)
    );
\pcOut[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(5),
      I1 => flush,
      O => p_0_in(5)
    );
\pcOut[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(6),
      I1 => flush,
      O => p_0_in(6)
    );
\pcOut[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(7),
      I1 => flush,
      O => p_0_in(7)
    );
\pcOut[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(8),
      I1 => flush,
      O => p_0_in(8)
    );
\pcOut[9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => pc(9),
      I1 => flush,
      O => p_0_in(9)
    );
\pcOut_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(0),
      Q => pcOut(0)
    );
\pcOut_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(10),
      Q => pcOut(10)
    );
\pcOut_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(11),
      Q => pcOut(11)
    );
\pcOut_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(12),
      Q => pcOut(12)
    );
\pcOut_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(13),
      Q => pcOut(13)
    );
\pcOut_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(14),
      Q => pcOut(14)
    );
\pcOut_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(15),
      Q => pcOut(15)
    );
\pcOut_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(16),
      Q => pcOut(16)
    );
\pcOut_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(17),
      Q => pcOut(17)
    );
\pcOut_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(18),
      Q => pcOut(18)
    );
\pcOut_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(19),
      Q => pcOut(19)
    );
\pcOut_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(1),
      Q => pcOut(1)
    );
\pcOut_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(20),
      Q => pcOut(20)
    );
\pcOut_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(21),
      Q => pcOut(21)
    );
\pcOut_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(22),
      Q => pcOut(22)
    );
\pcOut_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(23),
      Q => pcOut(23)
    );
\pcOut_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(24),
      Q => pcOut(24)
    );
\pcOut_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(25),
      Q => pcOut(25)
    );
\pcOut_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(26),
      Q => pcOut(26)
    );
\pcOut_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(27),
      Q => pcOut(27)
    );
\pcOut_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(28),
      Q => pcOut(28)
    );
\pcOut_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(29),
      Q => pcOut(29)
    );
\pcOut_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(2),
      Q => pcOut(2)
    );
\pcOut_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(30),
      Q => pcOut(30)
    );
\pcOut_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(31),
      Q => pcOut(31)
    );
\pcOut_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(3),
      Q => pcOut(3)
    );
\pcOut_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(4),
      Q => pcOut(4)
    );
\pcOut_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(5),
      Q => pcOut(5)
    );
\pcOut_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(6),
      Q => pcOut(6)
    );
\pcOut_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(7),
      Q => pcOut(7)
    );
\pcOut_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(8),
      Q => pcOut(8)
    );
\pcOut_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => \pcOut[31]_i_1_n_0\,
      CLR => rst,
      D => p_0_in(9),
      Q => pcOut(9)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_2_IFreg_0 is
  port (
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    flush : in STD_LOGIC;
    freeze : in STD_LOGIC;
    pc : in STD_LOGIC_VECTOR ( 31 downto 0 );
    instruction : in STD_LOGIC_VECTOR ( 31 downto 0 );
    pcOut : out STD_LOGIC_VECTOR ( 31 downto 0 );
    instructionOut : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_2_IFreg_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_2_IFreg_0 : entity is "design_2_IFreg_0,IFreg,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_2_IFreg_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_2_IFreg_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_2_IFreg_0 : entity is "IFreg,Vivado 2018.3";
end design_2_IFreg_0;

architecture STRUCTURE of design_2_IFreg_0 is
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN design_2_clk_0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of rst : signal is "xilinx.com:signal:reset:1.0 rst RST";
  attribute X_INTERFACE_PARAMETER of rst : signal is "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0";
begin
inst: entity work.design_2_IFreg_0_IFreg
     port map (
      clk => clk,
      flush => flush,
      freeze => freeze,
      instruction(31 downto 0) => instruction(31 downto 0),
      instructionOut(31 downto 0) => instructionOut(31 downto 0),
      pc(31 downto 0) => pc(31 downto 0),
      pcOut(31 downto 0) => pcOut(31 downto 0),
      rst => rst
    );
end STRUCTURE;
