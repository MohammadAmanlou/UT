-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun May 11 11:31:30 2025
-- Host        : Ariyan running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_2_CUMUX_0_0_sim_netlist.vhdl
-- Design      : design_2_CUMUX_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  port (
    sel : in STD_LOGIC;
    WB_EN : in STD_LOGIC;
    imm : in STD_LOGIC;
    MEM_R_EN : in STD_LOGIC;
    MEM_W_EN : in STD_LOGIC;
    B : in STD_LOGIC;
    EXE_CMD : in STD_LOGIC_VECTOR ( 3 downto 0 );
    S : in STD_LOGIC;
    WB_EN_out : out STD_LOGIC;
    imm_out : out STD_LOGIC;
    MEM_R_EN_out : out STD_LOGIC;
    MEM_W_EN_out : out STD_LOGIC;
    B_out : out STD_LOGIC;
    EXE_CMD_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    S_out : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "design_2_CUMUX_0_0,CUMUX,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "CUMUX,Vivado 2018.3";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
begin
B_out_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => B,
      I1 => sel,
      O => B_out
    );
\EXE_CMD_out[0]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => EXE_CMD(0),
      I1 => sel,
      O => EXE_CMD_out(0)
    );
\EXE_CMD_out[1]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => EXE_CMD(1),
      I1 => sel,
      O => EXE_CMD_out(1)
    );
\EXE_CMD_out[2]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => EXE_CMD(2),
      I1 => sel,
      O => EXE_CMD_out(2)
    );
\EXE_CMD_out[3]_INST_0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => EXE_CMD(3),
      I1 => sel,
      O => EXE_CMD_out(3)
    );
MEM_R_EN_out_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => MEM_R_EN,
      I1 => sel,
      O => MEM_R_EN_out
    );
MEM_W_EN_out_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => MEM_W_EN,
      I1 => sel,
      O => MEM_W_EN_out
    );
S_out_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => S,
      I1 => sel,
      O => S_out
    );
WB_EN_out_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => WB_EN,
      I1 => sel,
      O => WB_EN_out
    );
imm_out_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => imm,
      I1 => sel,
      O => imm_out
    );
end STRUCTURE;
