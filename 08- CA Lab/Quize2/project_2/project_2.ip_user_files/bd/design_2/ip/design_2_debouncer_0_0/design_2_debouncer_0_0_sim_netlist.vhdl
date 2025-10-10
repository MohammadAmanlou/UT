-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun Mar  9 10:59:20 2025
-- Host        : Ariyan running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/ariya/ARM/ARM.srcs/sources_1/bd/design_2/ip/design_2_debouncer_0_0/design_2_debouncer_0_0_sim_netlist.vhdl
-- Design      : design_2_debouncer_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_2_debouncer_0_0_debouncer is
  port (
    SIGNAL_O : out STD_LOGIC_VECTOR ( 0 to 0 );
    SIGNAL_I : in STD_LOGIC_VECTOR ( 0 to 0 );
    CLK_I : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_2_debouncer_0_0_debouncer : entity is "debouncer";
end design_2_debouncer_0_0_debouncer;

architecture STRUCTURE of design_2_debouncer_0_0_debouncer is
  signal \^signal_o\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \sig_cntrs_ary[0][0]_i_1_n_0\ : STD_LOGIC;
  signal \sig_cntrs_ary[0][0]_i_3_n_0\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][0]_i_2_n_0\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][0]_i_2_n_1\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][0]_i_2_n_2\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][0]_i_2_n_3\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][0]_i_2_n_4\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][0]_i_2_n_5\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][0]_i_2_n_6\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][0]_i_2_n_7\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][12]_i_1_n_1\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][12]_i_1_n_2\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][12]_i_1_n_3\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][12]_i_1_n_4\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][12]_i_1_n_5\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][12]_i_1_n_6\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][12]_i_1_n_7\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][4]_i_1_n_0\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][4]_i_1_n_1\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][4]_i_1_n_2\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][4]_i_1_n_3\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][4]_i_1_n_4\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][4]_i_1_n_5\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][4]_i_1_n_6\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][4]_i_1_n_7\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][8]_i_1_n_0\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][8]_i_1_n_1\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][8]_i_1_n_2\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][8]_i_1_n_3\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][8]_i_1_n_4\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][8]_i_1_n_5\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][8]_i_1_n_6\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0][8]_i_1_n_7\ : STD_LOGIC;
  signal \sig_cntrs_ary_reg[0]_0\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \sig_out_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \sig_out_reg[0]_i_2_n_0\ : STD_LOGIC;
  signal \sig_out_reg[0]_i_3_n_0\ : STD_LOGIC;
  signal \sig_out_reg[0]_i_4_n_0\ : STD_LOGIC;
  signal \sig_out_reg[0]_i_5_n_0\ : STD_LOGIC;
  signal \NLW_sig_cntrs_ary_reg[0][12]_i_1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
begin
  SIGNAL_O(0) <= \^signal_o\(0);
\sig_cntrs_ary[0][0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF00800080FFFF"
    )
        port map (
      I0 => \sig_out_reg[0]_i_2_n_0\,
      I1 => \sig_out_reg[0]_i_3_n_0\,
      I2 => \sig_out_reg[0]_i_4_n_0\,
      I3 => \sig_out_reg[0]_i_5_n_0\,
      I4 => \^signal_o\(0),
      I5 => SIGNAL_I(0),
      O => \sig_cntrs_ary[0][0]_i_1_n_0\
    );
\sig_cntrs_ary[0][0]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \sig_cntrs_ary_reg[0]_0\(0),
      O => \sig_cntrs_ary[0][0]_i_3_n_0\
    );
\sig_cntrs_ary_reg[0][0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_I,
      CE => '1',
      D => \sig_cntrs_ary_reg[0][0]_i_2_n_7\,
      Q => \sig_cntrs_ary_reg[0]_0\(0),
      R => \sig_cntrs_ary[0][0]_i_1_n_0\
    );
\sig_cntrs_ary_reg[0][0]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \sig_cntrs_ary_reg[0][0]_i_2_n_0\,
      CO(2) => \sig_cntrs_ary_reg[0][0]_i_2_n_1\,
      CO(1) => \sig_cntrs_ary_reg[0][0]_i_2_n_2\,
      CO(0) => \sig_cntrs_ary_reg[0][0]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0001",
      O(3) => \sig_cntrs_ary_reg[0][0]_i_2_n_4\,
      O(2) => \sig_cntrs_ary_reg[0][0]_i_2_n_5\,
      O(1) => \sig_cntrs_ary_reg[0][0]_i_2_n_6\,
      O(0) => \sig_cntrs_ary_reg[0][0]_i_2_n_7\,
      S(3 downto 1) => \sig_cntrs_ary_reg[0]_0\(3 downto 1),
      S(0) => \sig_cntrs_ary[0][0]_i_3_n_0\
    );
\sig_cntrs_ary_reg[0][10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_I,
      CE => '1',
      D => \sig_cntrs_ary_reg[0][8]_i_1_n_5\,
      Q => \sig_cntrs_ary_reg[0]_0\(10),
      R => \sig_cntrs_ary[0][0]_i_1_n_0\
    );
\sig_cntrs_ary_reg[0][11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_I,
      CE => '1',
      D => \sig_cntrs_ary_reg[0][8]_i_1_n_4\,
      Q => \sig_cntrs_ary_reg[0]_0\(11),
      R => \sig_cntrs_ary[0][0]_i_1_n_0\
    );
\sig_cntrs_ary_reg[0][12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_I,
      CE => '1',
      D => \sig_cntrs_ary_reg[0][12]_i_1_n_7\,
      Q => \sig_cntrs_ary_reg[0]_0\(12),
      R => \sig_cntrs_ary[0][0]_i_1_n_0\
    );
\sig_cntrs_ary_reg[0][12]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \sig_cntrs_ary_reg[0][8]_i_1_n_0\,
      CO(3) => \NLW_sig_cntrs_ary_reg[0][12]_i_1_CO_UNCONNECTED\(3),
      CO(2) => \sig_cntrs_ary_reg[0][12]_i_1_n_1\,
      CO(1) => \sig_cntrs_ary_reg[0][12]_i_1_n_2\,
      CO(0) => \sig_cntrs_ary_reg[0][12]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \sig_cntrs_ary_reg[0][12]_i_1_n_4\,
      O(2) => \sig_cntrs_ary_reg[0][12]_i_1_n_5\,
      O(1) => \sig_cntrs_ary_reg[0][12]_i_1_n_6\,
      O(0) => \sig_cntrs_ary_reg[0][12]_i_1_n_7\,
      S(3 downto 0) => \sig_cntrs_ary_reg[0]_0\(15 downto 12)
    );
\sig_cntrs_ary_reg[0][13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_I,
      CE => '1',
      D => \sig_cntrs_ary_reg[0][12]_i_1_n_6\,
      Q => \sig_cntrs_ary_reg[0]_0\(13),
      R => \sig_cntrs_ary[0][0]_i_1_n_0\
    );
\sig_cntrs_ary_reg[0][14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_I,
      CE => '1',
      D => \sig_cntrs_ary_reg[0][12]_i_1_n_5\,
      Q => \sig_cntrs_ary_reg[0]_0\(14),
      R => \sig_cntrs_ary[0][0]_i_1_n_0\
    );
\sig_cntrs_ary_reg[0][15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_I,
      CE => '1',
      D => \sig_cntrs_ary_reg[0][12]_i_1_n_4\,
      Q => \sig_cntrs_ary_reg[0]_0\(15),
      R => \sig_cntrs_ary[0][0]_i_1_n_0\
    );
\sig_cntrs_ary_reg[0][1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_I,
      CE => '1',
      D => \sig_cntrs_ary_reg[0][0]_i_2_n_6\,
      Q => \sig_cntrs_ary_reg[0]_0\(1),
      R => \sig_cntrs_ary[0][0]_i_1_n_0\
    );
\sig_cntrs_ary_reg[0][2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_I,
      CE => '1',
      D => \sig_cntrs_ary_reg[0][0]_i_2_n_5\,
      Q => \sig_cntrs_ary_reg[0]_0\(2),
      R => \sig_cntrs_ary[0][0]_i_1_n_0\
    );
\sig_cntrs_ary_reg[0][3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_I,
      CE => '1',
      D => \sig_cntrs_ary_reg[0][0]_i_2_n_4\,
      Q => \sig_cntrs_ary_reg[0]_0\(3),
      R => \sig_cntrs_ary[0][0]_i_1_n_0\
    );
\sig_cntrs_ary_reg[0][4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_I,
      CE => '1',
      D => \sig_cntrs_ary_reg[0][4]_i_1_n_7\,
      Q => \sig_cntrs_ary_reg[0]_0\(4),
      R => \sig_cntrs_ary[0][0]_i_1_n_0\
    );
\sig_cntrs_ary_reg[0][4]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \sig_cntrs_ary_reg[0][0]_i_2_n_0\,
      CO(3) => \sig_cntrs_ary_reg[0][4]_i_1_n_0\,
      CO(2) => \sig_cntrs_ary_reg[0][4]_i_1_n_1\,
      CO(1) => \sig_cntrs_ary_reg[0][4]_i_1_n_2\,
      CO(0) => \sig_cntrs_ary_reg[0][4]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \sig_cntrs_ary_reg[0][4]_i_1_n_4\,
      O(2) => \sig_cntrs_ary_reg[0][4]_i_1_n_5\,
      O(1) => \sig_cntrs_ary_reg[0][4]_i_1_n_6\,
      O(0) => \sig_cntrs_ary_reg[0][4]_i_1_n_7\,
      S(3 downto 0) => \sig_cntrs_ary_reg[0]_0\(7 downto 4)
    );
\sig_cntrs_ary_reg[0][5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_I,
      CE => '1',
      D => \sig_cntrs_ary_reg[0][4]_i_1_n_6\,
      Q => \sig_cntrs_ary_reg[0]_0\(5),
      R => \sig_cntrs_ary[0][0]_i_1_n_0\
    );
\sig_cntrs_ary_reg[0][6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_I,
      CE => '1',
      D => \sig_cntrs_ary_reg[0][4]_i_1_n_5\,
      Q => \sig_cntrs_ary_reg[0]_0\(6),
      R => \sig_cntrs_ary[0][0]_i_1_n_0\
    );
\sig_cntrs_ary_reg[0][7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_I,
      CE => '1',
      D => \sig_cntrs_ary_reg[0][4]_i_1_n_4\,
      Q => \sig_cntrs_ary_reg[0]_0\(7),
      R => \sig_cntrs_ary[0][0]_i_1_n_0\
    );
\sig_cntrs_ary_reg[0][8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_I,
      CE => '1',
      D => \sig_cntrs_ary_reg[0][8]_i_1_n_7\,
      Q => \sig_cntrs_ary_reg[0]_0\(8),
      R => \sig_cntrs_ary[0][0]_i_1_n_0\
    );
\sig_cntrs_ary_reg[0][8]_i_1\: unisim.vcomponents.CARRY4
     port map (
      CI => \sig_cntrs_ary_reg[0][4]_i_1_n_0\,
      CO(3) => \sig_cntrs_ary_reg[0][8]_i_1_n_0\,
      CO(2) => \sig_cntrs_ary_reg[0][8]_i_1_n_1\,
      CO(1) => \sig_cntrs_ary_reg[0][8]_i_1_n_2\,
      CO(0) => \sig_cntrs_ary_reg[0][8]_i_1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \sig_cntrs_ary_reg[0][8]_i_1_n_4\,
      O(2) => \sig_cntrs_ary_reg[0][8]_i_1_n_5\,
      O(1) => \sig_cntrs_ary_reg[0][8]_i_1_n_6\,
      O(0) => \sig_cntrs_ary_reg[0][8]_i_1_n_7\,
      S(3 downto 0) => \sig_cntrs_ary_reg[0]_0\(11 downto 8)
    );
\sig_cntrs_ary_reg[0][9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_I,
      CE => '1',
      D => \sig_cntrs_ary_reg[0][8]_i_1_n_6\,
      Q => \sig_cntrs_ary_reg[0]_0\(9),
      R => \sig_cntrs_ary[0][0]_i_1_n_0\
    );
\sig_out_reg[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FF7F0080"
    )
        port map (
      I0 => \sig_out_reg[0]_i_2_n_0\,
      I1 => \sig_out_reg[0]_i_3_n_0\,
      I2 => \sig_out_reg[0]_i_4_n_0\,
      I3 => \sig_out_reg[0]_i_5_n_0\,
      I4 => \^signal_o\(0),
      O => \sig_out_reg[0]_i_1_n_0\
    );
\sig_out_reg[0]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => \sig_cntrs_ary_reg[0]_0\(1),
      I1 => \sig_cntrs_ary_reg[0]_0\(0),
      I2 => \sig_cntrs_ary_reg[0]_0\(3),
      I3 => \sig_cntrs_ary_reg[0]_0\(2),
      O => \sig_out_reg[0]_i_2_n_0\
    );
\sig_out_reg[0]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => \sig_cntrs_ary_reg[0]_0\(5),
      I1 => \sig_cntrs_ary_reg[0]_0\(4),
      I2 => \sig_cntrs_ary_reg[0]_0\(7),
      I3 => \sig_cntrs_ary_reg[0]_0\(6),
      O => \sig_out_reg[0]_i_3_n_0\
    );
\sig_out_reg[0]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => \sig_cntrs_ary_reg[0]_0\(13),
      I1 => \sig_cntrs_ary_reg[0]_0\(12),
      I2 => \sig_cntrs_ary_reg[0]_0\(14),
      I3 => \sig_cntrs_ary_reg[0]_0\(15),
      O => \sig_out_reg[0]_i_4_n_0\
    );
\sig_out_reg[0]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => \sig_cntrs_ary_reg[0]_0\(9),
      I1 => \sig_cntrs_ary_reg[0]_0\(8),
      I2 => \sig_cntrs_ary_reg[0]_0\(11),
      I3 => \sig_cntrs_ary_reg[0]_0\(10),
      O => \sig_out_reg[0]_i_5_n_0\
    );
\sig_out_reg_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => CLK_I,
      CE => '1',
      D => \sig_out_reg[0]_i_1_n_0\,
      Q => \^signal_o\(0),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_2_debouncer_0_0 is
  port (
    SIGNAL_I : in STD_LOGIC_VECTOR ( 0 to 0 );
    CLK_I : in STD_LOGIC;
    SIGNAL_O : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_2_debouncer_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_2_debouncer_0_0 : entity is "design_2_debouncer_0_0,debouncer,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_2_debouncer_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_2_debouncer_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_2_debouncer_0_0 : entity is "debouncer,Vivado 2018.3";
end design_2_debouncer_0_0;

architecture STRUCTURE of design_2_debouncer_0_0 is
begin
inst: entity work.design_2_debouncer_0_0_debouncer
     port map (
      CLK_I => CLK_I,
      SIGNAL_I(0) => SIGNAL_I(0),
      SIGNAL_O(0) => SIGNAL_O(0)
    );
end STRUCTURE;
