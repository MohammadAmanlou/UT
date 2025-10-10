-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun May 18 17:51:03 2025
-- Host        : Ariyan running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_2_RegisterFile_0_0_stub.vhdl
-- Design      : design_2_RegisterFile_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  Port ( 
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    rn : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rm : in STD_LOGIC_VECTOR ( 3 downto 0 );
    WB_Dest : in STD_LOGIC_VECTOR ( 3 downto 0 );
    WB_Value : in STD_LOGIC_VECTOR ( 31 downto 0 );
    WB_WB_EN : in STD_LOGIC;
    Val_Rn : out STD_LOGIC_VECTOR ( 31 downto 0 );
    Val_Rm : out STD_LOGIC_VECTOR ( 31 downto 0 );
    R0 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    R1 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    R2 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    R3 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    R4 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    R5 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    R6 : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture stub of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,rst,rn[3:0],rm[3:0],WB_Dest[3:0],WB_Value[31:0],WB_WB_EN,Val_Rn[31:0],Val_Rm[31:0],R0[31:0],R1[31:0],R2[31:0],R3[31:0],R4[31:0],R5[31:0],R6[31:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "RegisterFile,Vivado 2018.3";
begin
end;
