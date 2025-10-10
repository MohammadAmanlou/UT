-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun May 11 11:31:32 2025
-- Host        : Ariyan running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_2_RedAdder_0_0_sim_netlist.vhdl
-- Design      : design_2_RedAdder_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_RedAdder is
  port (
    \out\ : out STD_LOGIC_VECTOR ( 31 downto 0 );
    b : in STD_LOGIC_VECTOR ( 31 downto 0 );
    a : in STD_LOGIC_VECTOR ( 23 downto 0 )
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_RedAdder;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_RedAdder is
  signal \out[0]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \out[0]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \out[0]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \out[0]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \out[0]_INST_0_n_0\ : STD_LOGIC;
  signal \out[0]_INST_0_n_1\ : STD_LOGIC;
  signal \out[0]_INST_0_n_2\ : STD_LOGIC;
  signal \out[0]_INST_0_n_3\ : STD_LOGIC;
  signal \out[12]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \out[12]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \out[12]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \out[12]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \out[12]_INST_0_n_0\ : STD_LOGIC;
  signal \out[12]_INST_0_n_1\ : STD_LOGIC;
  signal \out[12]_INST_0_n_2\ : STD_LOGIC;
  signal \out[12]_INST_0_n_3\ : STD_LOGIC;
  signal \out[16]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \out[16]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \out[16]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \out[16]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \out[16]_INST_0_n_0\ : STD_LOGIC;
  signal \out[16]_INST_0_n_1\ : STD_LOGIC;
  signal \out[16]_INST_0_n_2\ : STD_LOGIC;
  signal \out[16]_INST_0_n_3\ : STD_LOGIC;
  signal \out[20]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \out[20]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \out[20]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \out[20]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \out[20]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \out[20]_INST_0_n_0\ : STD_LOGIC;
  signal \out[20]_INST_0_n_1\ : STD_LOGIC;
  signal \out[20]_INST_0_n_2\ : STD_LOGIC;
  signal \out[20]_INST_0_n_3\ : STD_LOGIC;
  signal \out[24]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \out[24]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \out[24]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \out[24]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \out[24]_INST_0_n_0\ : STD_LOGIC;
  signal \out[24]_INST_0_n_1\ : STD_LOGIC;
  signal \out[24]_INST_0_n_2\ : STD_LOGIC;
  signal \out[24]_INST_0_n_3\ : STD_LOGIC;
  signal \out[28]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \out[28]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \out[28]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \out[28]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \out[28]_INST_0_n_1\ : STD_LOGIC;
  signal \out[28]_INST_0_n_2\ : STD_LOGIC;
  signal \out[28]_INST_0_n_3\ : STD_LOGIC;
  signal \out[4]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \out[4]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \out[4]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \out[4]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \out[4]_INST_0_n_0\ : STD_LOGIC;
  signal \out[4]_INST_0_n_1\ : STD_LOGIC;
  signal \out[4]_INST_0_n_2\ : STD_LOGIC;
  signal \out[4]_INST_0_n_3\ : STD_LOGIC;
  signal \out[8]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \out[8]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \out[8]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \out[8]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \out[8]_INST_0_n_0\ : STD_LOGIC;
  signal \out[8]_INST_0_n_1\ : STD_LOGIC;
  signal \out[8]_INST_0_n_2\ : STD_LOGIC;
  signal \out[8]_INST_0_n_3\ : STD_LOGIC;
  signal \NLW_out[28]_INST_0_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
begin
\out[0]_INST_0\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \out[0]_INST_0_n_0\,
      CO(2) => \out[0]_INST_0_n_1\,
      CO(1) => \out[0]_INST_0_n_2\,
      CO(0) => \out[0]_INST_0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => a(3 downto 0),
      O(3 downto 0) => \out\(3 downto 0),
      S(3) => \out[0]_INST_0_i_1_n_0\,
      S(2) => \out[0]_INST_0_i_2_n_0\,
      S(1) => \out[0]_INST_0_i_3_n_0\,
      S(0) => \out[0]_INST_0_i_4_n_0\
    );
\out[0]_INST_0_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a(3),
      I1 => b(3),
      O => \out[0]_INST_0_i_1_n_0\
    );
\out[0]_INST_0_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a(2),
      I1 => b(2),
      O => \out[0]_INST_0_i_2_n_0\
    );
\out[0]_INST_0_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a(1),
      I1 => b(1),
      O => \out[0]_INST_0_i_3_n_0\
    );
\out[0]_INST_0_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a(0),
      I1 => b(0),
      O => \out[0]_INST_0_i_4_n_0\
    );
\out[12]_INST_0\: unisim.vcomponents.CARRY4
     port map (
      CI => \out[8]_INST_0_n_0\,
      CO(3) => \out[12]_INST_0_n_0\,
      CO(2) => \out[12]_INST_0_n_1\,
      CO(1) => \out[12]_INST_0_n_2\,
      CO(0) => \out[12]_INST_0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => a(15 downto 12),
      O(3 downto 0) => \out\(15 downto 12),
      S(3) => \out[12]_INST_0_i_1_n_0\,
      S(2) => \out[12]_INST_0_i_2_n_0\,
      S(1) => \out[12]_INST_0_i_3_n_0\,
      S(0) => \out[12]_INST_0_i_4_n_0\
    );
\out[12]_INST_0_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a(15),
      I1 => b(15),
      O => \out[12]_INST_0_i_1_n_0\
    );
\out[12]_INST_0_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a(14),
      I1 => b(14),
      O => \out[12]_INST_0_i_2_n_0\
    );
\out[12]_INST_0_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a(13),
      I1 => b(13),
      O => \out[12]_INST_0_i_3_n_0\
    );
\out[12]_INST_0_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a(12),
      I1 => b(12),
      O => \out[12]_INST_0_i_4_n_0\
    );
\out[16]_INST_0\: unisim.vcomponents.CARRY4
     port map (
      CI => \out[12]_INST_0_n_0\,
      CO(3) => \out[16]_INST_0_n_0\,
      CO(2) => \out[16]_INST_0_n_1\,
      CO(1) => \out[16]_INST_0_n_2\,
      CO(0) => \out[16]_INST_0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => a(19 downto 16),
      O(3 downto 0) => \out\(19 downto 16),
      S(3) => \out[16]_INST_0_i_1_n_0\,
      S(2) => \out[16]_INST_0_i_2_n_0\,
      S(1) => \out[16]_INST_0_i_3_n_0\,
      S(0) => \out[16]_INST_0_i_4_n_0\
    );
\out[16]_INST_0_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a(19),
      I1 => b(19),
      O => \out[16]_INST_0_i_1_n_0\
    );
\out[16]_INST_0_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a(18),
      I1 => b(18),
      O => \out[16]_INST_0_i_2_n_0\
    );
\out[16]_INST_0_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a(17),
      I1 => b(17),
      O => \out[16]_INST_0_i_3_n_0\
    );
\out[16]_INST_0_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a(16),
      I1 => b(16),
      O => \out[16]_INST_0_i_4_n_0\
    );
\out[20]_INST_0\: unisim.vcomponents.CARRY4
     port map (
      CI => \out[16]_INST_0_n_0\,
      CO(3) => \out[20]_INST_0_n_0\,
      CO(2) => \out[20]_INST_0_n_1\,
      CO(1) => \out[20]_INST_0_n_2\,
      CO(0) => \out[20]_INST_0_n_3\,
      CYINIT => '0',
      DI(3) => \out[20]_INST_0_i_1_n_0\,
      DI(2 downto 0) => a(22 downto 20),
      O(3 downto 0) => \out\(23 downto 20),
      S(3) => \out[20]_INST_0_i_2_n_0\,
      S(2) => \out[20]_INST_0_i_3_n_0\,
      S(1) => \out[20]_INST_0_i_4_n_0\,
      S(0) => \out[20]_INST_0_i_5_n_0\
    );
\out[20]_INST_0_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => b(23),
      O => \out[20]_INST_0_i_1_n_0\
    );
\out[20]_INST_0_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => b(23),
      I1 => a(23),
      O => \out[20]_INST_0_i_2_n_0\
    );
\out[20]_INST_0_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a(22),
      I1 => b(22),
      O => \out[20]_INST_0_i_3_n_0\
    );
\out[20]_INST_0_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a(21),
      I1 => b(21),
      O => \out[20]_INST_0_i_4_n_0\
    );
\out[20]_INST_0_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a(20),
      I1 => b(20),
      O => \out[20]_INST_0_i_5_n_0\
    );
\out[24]_INST_0\: unisim.vcomponents.CARRY4
     port map (
      CI => \out[20]_INST_0_n_0\,
      CO(3) => \out[24]_INST_0_n_0\,
      CO(2) => \out[24]_INST_0_n_1\,
      CO(1) => \out[24]_INST_0_n_2\,
      CO(0) => \out[24]_INST_0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => b(26 downto 23),
      O(3 downto 0) => \out\(27 downto 24),
      S(3) => \out[24]_INST_0_i_1_n_0\,
      S(2) => \out[24]_INST_0_i_2_n_0\,
      S(1) => \out[24]_INST_0_i_3_n_0\,
      S(0) => \out[24]_INST_0_i_4_n_0\
    );
\out[24]_INST_0_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => b(26),
      I1 => b(27),
      O => \out[24]_INST_0_i_1_n_0\
    );
\out[24]_INST_0_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => b(25),
      I1 => b(26),
      O => \out[24]_INST_0_i_2_n_0\
    );
\out[24]_INST_0_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => b(24),
      I1 => b(25),
      O => \out[24]_INST_0_i_3_n_0\
    );
\out[24]_INST_0_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => b(23),
      I1 => b(24),
      O => \out[24]_INST_0_i_4_n_0\
    );
\out[28]_INST_0\: unisim.vcomponents.CARRY4
     port map (
      CI => \out[24]_INST_0_n_0\,
      CO(3) => \NLW_out[28]_INST_0_CO_UNCONNECTED\(3),
      CO(2) => \out[28]_INST_0_n_1\,
      CO(1) => \out[28]_INST_0_n_2\,
      CO(0) => \out[28]_INST_0_n_3\,
      CYINIT => '0',
      DI(3) => '0',
      DI(2 downto 0) => b(29 downto 27),
      O(3 downto 0) => \out\(31 downto 28),
      S(3) => \out[28]_INST_0_i_1_n_0\,
      S(2) => \out[28]_INST_0_i_2_n_0\,
      S(1) => \out[28]_INST_0_i_3_n_0\,
      S(0) => \out[28]_INST_0_i_4_n_0\
    );
\out[28]_INST_0_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => b(30),
      I1 => b(31),
      O => \out[28]_INST_0_i_1_n_0\
    );
\out[28]_INST_0_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => b(29),
      I1 => b(30),
      O => \out[28]_INST_0_i_2_n_0\
    );
\out[28]_INST_0_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => b(28),
      I1 => b(29),
      O => \out[28]_INST_0_i_3_n_0\
    );
\out[28]_INST_0_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => b(27),
      I1 => b(28),
      O => \out[28]_INST_0_i_4_n_0\
    );
\out[4]_INST_0\: unisim.vcomponents.CARRY4
     port map (
      CI => \out[0]_INST_0_n_0\,
      CO(3) => \out[4]_INST_0_n_0\,
      CO(2) => \out[4]_INST_0_n_1\,
      CO(1) => \out[4]_INST_0_n_2\,
      CO(0) => \out[4]_INST_0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => a(7 downto 4),
      O(3 downto 0) => \out\(7 downto 4),
      S(3) => \out[4]_INST_0_i_1_n_0\,
      S(2) => \out[4]_INST_0_i_2_n_0\,
      S(1) => \out[4]_INST_0_i_3_n_0\,
      S(0) => \out[4]_INST_0_i_4_n_0\
    );
\out[4]_INST_0_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a(7),
      I1 => b(7),
      O => \out[4]_INST_0_i_1_n_0\
    );
\out[4]_INST_0_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a(6),
      I1 => b(6),
      O => \out[4]_INST_0_i_2_n_0\
    );
\out[4]_INST_0_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a(5),
      I1 => b(5),
      O => \out[4]_INST_0_i_3_n_0\
    );
\out[4]_INST_0_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a(4),
      I1 => b(4),
      O => \out[4]_INST_0_i_4_n_0\
    );
\out[8]_INST_0\: unisim.vcomponents.CARRY4
     port map (
      CI => \out[4]_INST_0_n_0\,
      CO(3) => \out[8]_INST_0_n_0\,
      CO(2) => \out[8]_INST_0_n_1\,
      CO(1) => \out[8]_INST_0_n_2\,
      CO(0) => \out[8]_INST_0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => a(11 downto 8),
      O(3 downto 0) => \out\(11 downto 8),
      S(3) => \out[8]_INST_0_i_1_n_0\,
      S(2) => \out[8]_INST_0_i_2_n_0\,
      S(1) => \out[8]_INST_0_i_3_n_0\,
      S(0) => \out[8]_INST_0_i_4_n_0\
    );
\out[8]_INST_0_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a(11),
      I1 => b(11),
      O => \out[8]_INST_0_i_1_n_0\
    );
\out[8]_INST_0_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a(10),
      I1 => b(10),
      O => \out[8]_INST_0_i_2_n_0\
    );
\out[8]_INST_0_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a(9),
      I1 => b(9),
      O => \out[8]_INST_0_i_3_n_0\
    );
\out[8]_INST_0_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => a(8),
      I1 => b(8),
      O => \out[8]_INST_0_i_4_n_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  port (
    a : in STD_LOGIC_VECTOR ( 23 downto 0 );
    b : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \out\ : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "design_2_RedAdder_0_0,RedAdder,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "RedAdder,Vivado 2018.3";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
begin
inst: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_RedAdder
     port map (
      a(23 downto 0) => a(23 downto 0),
      b(31 downto 0) => b(31 downto 0),
      \out\(31 downto 0) => \out\(31 downto 0)
    );
end STRUCTURE;
