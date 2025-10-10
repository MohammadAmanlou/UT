-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun May 11 11:31:30 2025
-- Host        : Ariyan running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_2_CUMUX_0_0_stub.vhdl
-- Design      : design_2_CUMUX_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  Port ( 
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

end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture stub of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "sel,WB_EN,imm,MEM_R_EN,MEM_W_EN,B,EXE_CMD[3:0],S,WB_EN_out,imm_out,MEM_R_EN_out,MEM_W_EN_out,B_out,EXE_CMD_out[3:0],S_out";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "CUMUX,Vivado 2018.3";
begin
end;
