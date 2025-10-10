-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun May 18 17:03:59 2025
-- Host        : Ariyan running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_2_Exe_Mux_0_1_sim_netlist.vhdl
-- Design      : design_2_Exe_Mux_0_1
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Exe_Mux is
  port (
    \out\ : out STD_LOGIC_VECTOR ( 31 downto 0 );
    WB_value : in STD_LOGIC_VECTOR ( 31 downto 0 );
    sel : in STD_LOGIC_VECTOR ( 1 downto 0 );
    ALU_res : in STD_LOGIC_VECTOR ( 31 downto 0 );
    val : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Exe_Mux;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Exe_Mux is
begin
\out[0]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(0),
      I1 => sel(1),
      I2 => ALU_res(0),
      I3 => sel(0),
      I4 => val(0),
      O => \out\(0)
    );
\out[10]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(10),
      I1 => sel(1),
      I2 => ALU_res(10),
      I3 => sel(0),
      I4 => val(10),
      O => \out\(10)
    );
\out[11]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(11),
      I1 => sel(1),
      I2 => ALU_res(11),
      I3 => sel(0),
      I4 => val(11),
      O => \out\(11)
    );
\out[12]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(12),
      I1 => sel(1),
      I2 => ALU_res(12),
      I3 => sel(0),
      I4 => val(12),
      O => \out\(12)
    );
\out[13]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(13),
      I1 => sel(1),
      I2 => ALU_res(13),
      I3 => sel(0),
      I4 => val(13),
      O => \out\(13)
    );
\out[14]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(14),
      I1 => sel(1),
      I2 => ALU_res(14),
      I3 => sel(0),
      I4 => val(14),
      O => \out\(14)
    );
\out[15]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(15),
      I1 => sel(1),
      I2 => ALU_res(15),
      I3 => sel(0),
      I4 => val(15),
      O => \out\(15)
    );
\out[16]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(16),
      I1 => sel(1),
      I2 => ALU_res(16),
      I3 => sel(0),
      I4 => val(16),
      O => \out\(16)
    );
\out[17]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(17),
      I1 => sel(1),
      I2 => ALU_res(17),
      I3 => sel(0),
      I4 => val(17),
      O => \out\(17)
    );
\out[18]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(18),
      I1 => sel(1),
      I2 => ALU_res(18),
      I3 => sel(0),
      I4 => val(18),
      O => \out\(18)
    );
\out[19]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(19),
      I1 => sel(1),
      I2 => ALU_res(19),
      I3 => sel(0),
      I4 => val(19),
      O => \out\(19)
    );
\out[1]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(1),
      I1 => sel(1),
      I2 => ALU_res(1),
      I3 => sel(0),
      I4 => val(1),
      O => \out\(1)
    );
\out[20]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(20),
      I1 => sel(1),
      I2 => ALU_res(20),
      I3 => sel(0),
      I4 => val(20),
      O => \out\(20)
    );
\out[21]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(21),
      I1 => sel(1),
      I2 => ALU_res(21),
      I3 => sel(0),
      I4 => val(21),
      O => \out\(21)
    );
\out[22]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(22),
      I1 => sel(1),
      I2 => ALU_res(22),
      I3 => sel(0),
      I4 => val(22),
      O => \out\(22)
    );
\out[23]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(23),
      I1 => sel(1),
      I2 => ALU_res(23),
      I3 => sel(0),
      I4 => val(23),
      O => \out\(23)
    );
\out[24]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(24),
      I1 => sel(1),
      I2 => ALU_res(24),
      I3 => sel(0),
      I4 => val(24),
      O => \out\(24)
    );
\out[25]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(25),
      I1 => sel(1),
      I2 => ALU_res(25),
      I3 => sel(0),
      I4 => val(25),
      O => \out\(25)
    );
\out[26]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(26),
      I1 => sel(1),
      I2 => ALU_res(26),
      I3 => sel(0),
      I4 => val(26),
      O => \out\(26)
    );
\out[27]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(27),
      I1 => sel(1),
      I2 => ALU_res(27),
      I3 => sel(0),
      I4 => val(27),
      O => \out\(27)
    );
\out[28]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(28),
      I1 => sel(1),
      I2 => ALU_res(28),
      I3 => sel(0),
      I4 => val(28),
      O => \out\(28)
    );
\out[29]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(29),
      I1 => sel(1),
      I2 => ALU_res(29),
      I3 => sel(0),
      I4 => val(29),
      O => \out\(29)
    );
\out[2]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(2),
      I1 => sel(1),
      I2 => ALU_res(2),
      I3 => sel(0),
      I4 => val(2),
      O => \out\(2)
    );
\out[30]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(30),
      I1 => sel(1),
      I2 => ALU_res(30),
      I3 => sel(0),
      I4 => val(30),
      O => \out\(30)
    );
\out[31]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(31),
      I1 => sel(1),
      I2 => ALU_res(31),
      I3 => sel(0),
      I4 => val(31),
      O => \out\(31)
    );
\out[3]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(3),
      I1 => sel(1),
      I2 => ALU_res(3),
      I3 => sel(0),
      I4 => val(3),
      O => \out\(3)
    );
\out[4]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(4),
      I1 => sel(1),
      I2 => ALU_res(4),
      I3 => sel(0),
      I4 => val(4),
      O => \out\(4)
    );
\out[5]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(5),
      I1 => sel(1),
      I2 => ALU_res(5),
      I3 => sel(0),
      I4 => val(5),
      O => \out\(5)
    );
\out[6]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(6),
      I1 => sel(1),
      I2 => ALU_res(6),
      I3 => sel(0),
      I4 => val(6),
      O => \out\(6)
    );
\out[7]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(7),
      I1 => sel(1),
      I2 => ALU_res(7),
      I3 => sel(0),
      I4 => val(7),
      O => \out\(7)
    );
\out[8]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(8),
      I1 => sel(1),
      I2 => ALU_res(8),
      I3 => sel(0),
      I4 => val(8),
      O => \out\(8)
    );
\out[9]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8BBB888"
    )
        port map (
      I0 => WB_value(9),
      I1 => sel(1),
      I2 => ALU_res(9),
      I3 => sel(0),
      I4 => val(9),
      O => \out\(9)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  port (
    sel : in STD_LOGIC_VECTOR ( 1 downto 0 );
    val : in STD_LOGIC_VECTOR ( 31 downto 0 );
    ALU_res : in STD_LOGIC_VECTOR ( 31 downto 0 );
    WB_value : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \out\ : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "design_2_Exe_Mux_0_1,Exe_Mux,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "Exe_Mux,Vivado 2018.3";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
begin
inst: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_Exe_Mux
     port map (
      ALU_res(31 downto 0) => ALU_res(31 downto 0),
      WB_value(31 downto 0) => WB_value(31 downto 0),
      \out\(31 downto 0) => \out\(31 downto 0),
      sel(1 downto 0) => sel(1 downto 0),
      val(31 downto 0) => val(31 downto 0)
    );
end STRUCTURE;
