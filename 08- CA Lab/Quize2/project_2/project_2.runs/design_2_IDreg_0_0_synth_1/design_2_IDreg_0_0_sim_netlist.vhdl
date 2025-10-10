-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun May 18 17:04:00 2025
-- Host        : Ariyan running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_2_IDreg_0_0_sim_netlist.vhdl
-- Design      : design_2_IDreg_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_IDreg is
  port (
    pcOut : out STD_LOGIC_VECTOR ( 31 downto 0 );
    WB_EN_out : out STD_LOGIC;
    MEM_R_EN_out : out STD_LOGIC;
    MEM_W_EN_out : out STD_LOGIC;
    EXE_CMD_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    B_out : out STD_LOGIC;
    S_out : out STD_LOGIC;
    Val_Rn_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    Val_Rm_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    imm_out : out STD_LOGIC;
    Shift_operand_out : out STD_LOGIC_VECTOR ( 11 downto 0 );
    Signed_imm_24_out : out STD_LOGIC_VECTOR ( 23 downto 0 );
    dest_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    status_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    src_1_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    src_2_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    src_2 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    flush : in STD_LOGIC;
    status : in STD_LOGIC_VECTOR ( 3 downto 0 );
    EXE_CMD : in STD_LOGIC_VECTOR ( 3 downto 0 );
    dest : in STD_LOGIC_VECTOR ( 3 downto 0 );
    src_1 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    imm : in STD_LOGIC;
    S : in STD_LOGIC;
    B : in STD_LOGIC;
    MEM_W_EN : in STD_LOGIC;
    MEM_R_EN : in STD_LOGIC;
    WB_EN : in STD_LOGIC;
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    pc : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Val_Rn : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Val_Rm : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Shift_operand : in STD_LOGIC_VECTOR ( 11 downto 0 );
    Signed_imm_24 : in STD_LOGIC_VECTOR ( 23 downto 0 )
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_IDreg;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_IDreg is
  signal B_out_i_1_n_0 : STD_LOGIC;
  signal \EXE_CMD_out[0]_i_1_n_0\ : STD_LOGIC;
  signal \EXE_CMD_out[1]_i_1_n_0\ : STD_LOGIC;
  signal \EXE_CMD_out[2]_i_1_n_0\ : STD_LOGIC;
  signal \EXE_CMD_out[3]_i_1_n_0\ : STD_LOGIC;
  signal MEM_R_EN_out_i_1_n_0 : STD_LOGIC;
  signal MEM_W_EN_out_i_1_n_0 : STD_LOGIC;
  signal S_out_i_1_n_0 : STD_LOGIC;
  signal \Shift_operand_out[0]_i_1_n_0\ : STD_LOGIC;
  signal \Shift_operand_out[10]_i_1_n_0\ : STD_LOGIC;
  signal \Shift_operand_out[11]_i_1_n_0\ : STD_LOGIC;
  signal \Shift_operand_out[1]_i_1_n_0\ : STD_LOGIC;
  signal \Shift_operand_out[2]_i_1_n_0\ : STD_LOGIC;
  signal \Shift_operand_out[3]_i_1_n_0\ : STD_LOGIC;
  signal \Shift_operand_out[4]_i_1_n_0\ : STD_LOGIC;
  signal \Shift_operand_out[5]_i_1_n_0\ : STD_LOGIC;
  signal \Shift_operand_out[6]_i_1_n_0\ : STD_LOGIC;
  signal \Shift_operand_out[7]_i_1_n_0\ : STD_LOGIC;
  signal \Shift_operand_out[8]_i_1_n_0\ : STD_LOGIC;
  signal \Shift_operand_out[9]_i_1_n_0\ : STD_LOGIC;
  signal \Signed_imm_24_out[0]_i_1_n_0\ : STD_LOGIC;
  signal \Signed_imm_24_out[10]_i_1_n_0\ : STD_LOGIC;
  signal \Signed_imm_24_out[11]_i_1_n_0\ : STD_LOGIC;
  signal \Signed_imm_24_out[12]_i_1_n_0\ : STD_LOGIC;
  signal \Signed_imm_24_out[13]_i_1_n_0\ : STD_LOGIC;
  signal \Signed_imm_24_out[14]_i_1_n_0\ : STD_LOGIC;
  signal \Signed_imm_24_out[15]_i_1_n_0\ : STD_LOGIC;
  signal \Signed_imm_24_out[16]_i_1_n_0\ : STD_LOGIC;
  signal \Signed_imm_24_out[17]_i_1_n_0\ : STD_LOGIC;
  signal \Signed_imm_24_out[18]_i_1_n_0\ : STD_LOGIC;
  signal \Signed_imm_24_out[19]_i_1_n_0\ : STD_LOGIC;
  signal \Signed_imm_24_out[1]_i_1_n_0\ : STD_LOGIC;
  signal \Signed_imm_24_out[20]_i_1_n_0\ : STD_LOGIC;
  signal \Signed_imm_24_out[21]_i_1_n_0\ : STD_LOGIC;
  signal \Signed_imm_24_out[22]_i_1_n_0\ : STD_LOGIC;
  signal \Signed_imm_24_out[23]_i_1_n_0\ : STD_LOGIC;
  signal \Signed_imm_24_out[2]_i_1_n_0\ : STD_LOGIC;
  signal \Signed_imm_24_out[3]_i_1_n_0\ : STD_LOGIC;
  signal \Signed_imm_24_out[4]_i_1_n_0\ : STD_LOGIC;
  signal \Signed_imm_24_out[5]_i_1_n_0\ : STD_LOGIC;
  signal \Signed_imm_24_out[6]_i_1_n_0\ : STD_LOGIC;
  signal \Signed_imm_24_out[7]_i_1_n_0\ : STD_LOGIC;
  signal \Signed_imm_24_out[8]_i_1_n_0\ : STD_LOGIC;
  signal \Signed_imm_24_out[9]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[0]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[10]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[11]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[12]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[13]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[14]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[15]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[16]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[17]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[18]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[19]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[1]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[20]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[21]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[22]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[23]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[24]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[25]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[26]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[27]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[28]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[29]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[2]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[30]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[31]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[3]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[4]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[5]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[6]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[7]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[8]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rm_out[9]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[0]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[10]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[11]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[12]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[13]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[14]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[15]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[16]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[17]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[18]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[19]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[1]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[20]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[21]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[22]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[23]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[24]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[25]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[26]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[27]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[28]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[29]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[2]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[30]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[31]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[3]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[4]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[5]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[6]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[7]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[8]_i_1_n_0\ : STD_LOGIC;
  signal \Val_Rn_out[9]_i_1_n_0\ : STD_LOGIC;
  signal WB_EN_out_i_1_n_0 : STD_LOGIC;
  signal \dest_out[0]_i_1_n_0\ : STD_LOGIC;
  signal \dest_out[1]_i_1_n_0\ : STD_LOGIC;
  signal \dest_out[2]_i_1_n_0\ : STD_LOGIC;
  signal \dest_out[3]_i_1_n_0\ : STD_LOGIC;
  signal imm_out_i_1_n_0 : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \src_1_out[0]_i_1_n_0\ : STD_LOGIC;
  signal \src_1_out[1]_i_1_n_0\ : STD_LOGIC;
  signal \src_1_out[2]_i_1_n_0\ : STD_LOGIC;
  signal \src_1_out[3]_i_1_n_0\ : STD_LOGIC;
  signal \src_2_out[0]_i_1_n_0\ : STD_LOGIC;
  signal \src_2_out[1]_i_1_n_0\ : STD_LOGIC;
  signal \src_2_out[2]_i_1_n_0\ : STD_LOGIC;
  signal \src_2_out[3]_i_1_n_0\ : STD_LOGIC;
  signal \status_out[0]_i_1_n_0\ : STD_LOGIC;
  signal \status_out[1]_i_1_n_0\ : STD_LOGIC;
  signal \status_out[2]_i_1_n_0\ : STD_LOGIC;
  signal \status_out[3]_i_1_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of B_out_i_1 : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of \EXE_CMD_out[0]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \EXE_CMD_out[1]_i_1\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \EXE_CMD_out[2]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \EXE_CMD_out[3]_i_1\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of MEM_R_EN_out_i_1 : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of MEM_W_EN_out_i_1 : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of S_out_i_1 : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \Shift_operand_out[0]_i_1\ : label is "soft_lutpair61";
  attribute SOFT_HLUTNM of \Shift_operand_out[10]_i_1\ : label is "soft_lutpair66";
  attribute SOFT_HLUTNM of \Shift_operand_out[11]_i_1\ : label is "soft_lutpair66";
  attribute SOFT_HLUTNM of \Shift_operand_out[1]_i_1\ : label is "soft_lutpair61";
  attribute SOFT_HLUTNM of \Shift_operand_out[2]_i_1\ : label is "soft_lutpair62";
  attribute SOFT_HLUTNM of \Shift_operand_out[3]_i_1\ : label is "soft_lutpair62";
  attribute SOFT_HLUTNM of \Shift_operand_out[4]_i_1\ : label is "soft_lutpair63";
  attribute SOFT_HLUTNM of \Shift_operand_out[5]_i_1\ : label is "soft_lutpair63";
  attribute SOFT_HLUTNM of \Shift_operand_out[6]_i_1\ : label is "soft_lutpair64";
  attribute SOFT_HLUTNM of \Shift_operand_out[7]_i_1\ : label is "soft_lutpair64";
  attribute SOFT_HLUTNM of \Shift_operand_out[8]_i_1\ : label is "soft_lutpair65";
  attribute SOFT_HLUTNM of \Shift_operand_out[9]_i_1\ : label is "soft_lutpair65";
  attribute SOFT_HLUTNM of \Signed_imm_24_out[0]_i_1\ : label is "soft_lutpair67";
  attribute SOFT_HLUTNM of \Signed_imm_24_out[10]_i_1\ : label is "soft_lutpair72";
  attribute SOFT_HLUTNM of \Signed_imm_24_out[11]_i_1\ : label is "soft_lutpair72";
  attribute SOFT_HLUTNM of \Signed_imm_24_out[12]_i_1\ : label is "soft_lutpair73";
  attribute SOFT_HLUTNM of \Signed_imm_24_out[13]_i_1\ : label is "soft_lutpair73";
  attribute SOFT_HLUTNM of \Signed_imm_24_out[14]_i_1\ : label is "soft_lutpair74";
  attribute SOFT_HLUTNM of \Signed_imm_24_out[15]_i_1\ : label is "soft_lutpair74";
  attribute SOFT_HLUTNM of \Signed_imm_24_out[16]_i_1\ : label is "soft_lutpair75";
  attribute SOFT_HLUTNM of \Signed_imm_24_out[17]_i_1\ : label is "soft_lutpair75";
  attribute SOFT_HLUTNM of \Signed_imm_24_out[18]_i_1\ : label is "soft_lutpair76";
  attribute SOFT_HLUTNM of \Signed_imm_24_out[19]_i_1\ : label is "soft_lutpair76";
  attribute SOFT_HLUTNM of \Signed_imm_24_out[1]_i_1\ : label is "soft_lutpair67";
  attribute SOFT_HLUTNM of \Signed_imm_24_out[20]_i_1\ : label is "soft_lutpair77";
  attribute SOFT_HLUTNM of \Signed_imm_24_out[21]_i_1\ : label is "soft_lutpair77";
  attribute SOFT_HLUTNM of \Signed_imm_24_out[22]_i_1\ : label is "soft_lutpair78";
  attribute SOFT_HLUTNM of \Signed_imm_24_out[23]_i_1\ : label is "soft_lutpair78";
  attribute SOFT_HLUTNM of \Signed_imm_24_out[2]_i_1\ : label is "soft_lutpair68";
  attribute SOFT_HLUTNM of \Signed_imm_24_out[3]_i_1\ : label is "soft_lutpair68";
  attribute SOFT_HLUTNM of \Signed_imm_24_out[4]_i_1\ : label is "soft_lutpair69";
  attribute SOFT_HLUTNM of \Signed_imm_24_out[5]_i_1\ : label is "soft_lutpair69";
  attribute SOFT_HLUTNM of \Signed_imm_24_out[6]_i_1\ : label is "soft_lutpair70";
  attribute SOFT_HLUTNM of \Signed_imm_24_out[7]_i_1\ : label is "soft_lutpair70";
  attribute SOFT_HLUTNM of \Signed_imm_24_out[8]_i_1\ : label is "soft_lutpair71";
  attribute SOFT_HLUTNM of \Signed_imm_24_out[9]_i_1\ : label is "soft_lutpair71";
  attribute SOFT_HLUTNM of \Val_Rm_out[0]_i_1\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \Val_Rm_out[10]_i_1\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \Val_Rm_out[11]_i_1\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \Val_Rm_out[12]_i_1\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \Val_Rm_out[13]_i_1\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \Val_Rm_out[14]_i_1\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \Val_Rm_out[15]_i_1\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \Val_Rm_out[16]_i_1\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \Val_Rm_out[17]_i_1\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \Val_Rm_out[18]_i_1\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \Val_Rm_out[19]_i_1\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \Val_Rm_out[1]_i_1\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \Val_Rm_out[20]_i_1\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \Val_Rm_out[21]_i_1\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \Val_Rm_out[22]_i_1\ : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \Val_Rm_out[23]_i_1\ : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \Val_Rm_out[24]_i_1\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \Val_Rm_out[25]_i_1\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \Val_Rm_out[26]_i_1\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \Val_Rm_out[27]_i_1\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \Val_Rm_out[28]_i_1\ : label is "soft_lutpair59";
  attribute SOFT_HLUTNM of \Val_Rm_out[29]_i_1\ : label is "soft_lutpair59";
  attribute SOFT_HLUTNM of \Val_Rm_out[2]_i_1\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \Val_Rm_out[30]_i_1\ : label is "soft_lutpair60";
  attribute SOFT_HLUTNM of \Val_Rm_out[31]_i_1\ : label is "soft_lutpair60";
  attribute SOFT_HLUTNM of \Val_Rm_out[3]_i_1\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \Val_Rm_out[4]_i_1\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \Val_Rm_out[5]_i_1\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \Val_Rm_out[6]_i_1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \Val_Rm_out[7]_i_1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \Val_Rm_out[8]_i_1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \Val_Rm_out[9]_i_1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \Val_Rn_out[0]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \Val_Rn_out[10]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \Val_Rn_out[11]_i_1\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \Val_Rn_out[12]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \Val_Rn_out[13]_i_1\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \Val_Rn_out[14]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \Val_Rn_out[15]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \Val_Rn_out[16]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \Val_Rn_out[17]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \Val_Rn_out[18]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \Val_Rn_out[19]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \Val_Rn_out[1]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \Val_Rn_out[20]_i_1\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \Val_Rn_out[21]_i_1\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \Val_Rn_out[22]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \Val_Rn_out[23]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \Val_Rn_out[24]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \Val_Rn_out[25]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \Val_Rn_out[26]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \Val_Rn_out[27]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \Val_Rn_out[28]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \Val_Rn_out[29]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \Val_Rn_out[2]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \Val_Rn_out[30]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \Val_Rn_out[31]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \Val_Rn_out[3]_i_1\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \Val_Rn_out[4]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \Val_Rn_out[5]_i_1\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \Val_Rn_out[6]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \Val_Rn_out[7]_i_1\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \Val_Rn_out[8]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \Val_Rn_out[9]_i_1\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of WB_EN_out_i_1 : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \dest_out[0]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \dest_out[1]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \dest_out[2]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \dest_out[3]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of imm_out_i_1 : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \pcOut[0]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \pcOut[10]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \pcOut[11]_i_1\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \pcOut[12]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \pcOut[13]_i_1\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \pcOut[14]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \pcOut[15]_i_1\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \pcOut[16]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \pcOut[17]_i_1\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \pcOut[18]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \pcOut[19]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \pcOut[1]_i_1\ : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of \pcOut[20]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \pcOut[21]_i_1\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \pcOut[22]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \pcOut[23]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \pcOut[24]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \pcOut[25]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \pcOut[26]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \pcOut[27]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \pcOut[28]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \pcOut[29]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \pcOut[2]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \pcOut[30]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \pcOut[31]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \pcOut[3]_i_1\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \pcOut[4]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \pcOut[5]_i_1\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \pcOut[6]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \pcOut[7]_i_1\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \pcOut[8]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \pcOut[9]_i_1\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \src_1_out[0]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \src_1_out[1]_i_1\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \src_1_out[2]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \src_1_out[3]_i_1\ : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of \src_2_out[0]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \src_2_out[1]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \src_2_out[2]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \src_2_out[3]_i_1\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \status_out[0]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \status_out[1]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \status_out[2]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \status_out[3]_i_1\ : label is "soft_lutpair3";
begin
B_out_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => B,
      I1 => flush,
      O => B_out_i_1_n_0
    );
B_out_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => B_out_i_1_n_0,
      Q => B_out
    );
\EXE_CMD_out[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => EXE_CMD(0),
      I1 => flush,
      O => \EXE_CMD_out[0]_i_1_n_0\
    );
\EXE_CMD_out[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => EXE_CMD(1),
      I1 => flush,
      O => \EXE_CMD_out[1]_i_1_n_0\
    );
\EXE_CMD_out[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => EXE_CMD(2),
      I1 => flush,
      O => \EXE_CMD_out[2]_i_1_n_0\
    );
\EXE_CMD_out[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => EXE_CMD(3),
      I1 => flush,
      O => \EXE_CMD_out[3]_i_1_n_0\
    );
\EXE_CMD_out_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \EXE_CMD_out[0]_i_1_n_0\,
      Q => EXE_CMD_out(0)
    );
\EXE_CMD_out_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \EXE_CMD_out[1]_i_1_n_0\,
      Q => EXE_CMD_out(1)
    );
\EXE_CMD_out_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \EXE_CMD_out[2]_i_1_n_0\,
      Q => EXE_CMD_out(2)
    );
\EXE_CMD_out_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \EXE_CMD_out[3]_i_1_n_0\,
      Q => EXE_CMD_out(3)
    );
MEM_R_EN_out_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => MEM_R_EN,
      I1 => flush,
      O => MEM_R_EN_out_i_1_n_0
    );
MEM_R_EN_out_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => MEM_R_EN_out_i_1_n_0,
      Q => MEM_R_EN_out
    );
MEM_W_EN_out_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => MEM_W_EN,
      I1 => flush,
      O => MEM_W_EN_out_i_1_n_0
    );
MEM_W_EN_out_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => MEM_W_EN_out_i_1_n_0,
      Q => MEM_W_EN_out
    );
S_out_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => S,
      I1 => flush,
      O => S_out_i_1_n_0
    );
S_out_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => S_out_i_1_n_0,
      Q => S_out
    );
\Shift_operand_out[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Shift_operand(0),
      I1 => flush,
      O => \Shift_operand_out[0]_i_1_n_0\
    );
\Shift_operand_out[10]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Shift_operand(10),
      I1 => flush,
      O => \Shift_operand_out[10]_i_1_n_0\
    );
\Shift_operand_out[11]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Shift_operand(11),
      I1 => flush,
      O => \Shift_operand_out[11]_i_1_n_0\
    );
\Shift_operand_out[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Shift_operand(1),
      I1 => flush,
      O => \Shift_operand_out[1]_i_1_n_0\
    );
\Shift_operand_out[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Shift_operand(2),
      I1 => flush,
      O => \Shift_operand_out[2]_i_1_n_0\
    );
\Shift_operand_out[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Shift_operand(3),
      I1 => flush,
      O => \Shift_operand_out[3]_i_1_n_0\
    );
\Shift_operand_out[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Shift_operand(4),
      I1 => flush,
      O => \Shift_operand_out[4]_i_1_n_0\
    );
\Shift_operand_out[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Shift_operand(5),
      I1 => flush,
      O => \Shift_operand_out[5]_i_1_n_0\
    );
\Shift_operand_out[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Shift_operand(6),
      I1 => flush,
      O => \Shift_operand_out[6]_i_1_n_0\
    );
\Shift_operand_out[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Shift_operand(7),
      I1 => flush,
      O => \Shift_operand_out[7]_i_1_n_0\
    );
\Shift_operand_out[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Shift_operand(8),
      I1 => flush,
      O => \Shift_operand_out[8]_i_1_n_0\
    );
\Shift_operand_out[9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Shift_operand(9),
      I1 => flush,
      O => \Shift_operand_out[9]_i_1_n_0\
    );
\Shift_operand_out_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Shift_operand_out[0]_i_1_n_0\,
      Q => Shift_operand_out(0)
    );
\Shift_operand_out_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Shift_operand_out[10]_i_1_n_0\,
      Q => Shift_operand_out(10)
    );
\Shift_operand_out_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Shift_operand_out[11]_i_1_n_0\,
      Q => Shift_operand_out(11)
    );
\Shift_operand_out_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Shift_operand_out[1]_i_1_n_0\,
      Q => Shift_operand_out(1)
    );
\Shift_operand_out_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Shift_operand_out[2]_i_1_n_0\,
      Q => Shift_operand_out(2)
    );
\Shift_operand_out_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Shift_operand_out[3]_i_1_n_0\,
      Q => Shift_operand_out(3)
    );
\Shift_operand_out_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Shift_operand_out[4]_i_1_n_0\,
      Q => Shift_operand_out(4)
    );
\Shift_operand_out_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Shift_operand_out[5]_i_1_n_0\,
      Q => Shift_operand_out(5)
    );
\Shift_operand_out_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Shift_operand_out[6]_i_1_n_0\,
      Q => Shift_operand_out(6)
    );
\Shift_operand_out_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Shift_operand_out[7]_i_1_n_0\,
      Q => Shift_operand_out(7)
    );
\Shift_operand_out_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Shift_operand_out[8]_i_1_n_0\,
      Q => Shift_operand_out(8)
    );
\Shift_operand_out_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Shift_operand_out[9]_i_1_n_0\,
      Q => Shift_operand_out(9)
    );
\Signed_imm_24_out[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Signed_imm_24(0),
      I1 => flush,
      O => \Signed_imm_24_out[0]_i_1_n_0\
    );
\Signed_imm_24_out[10]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Signed_imm_24(10),
      I1 => flush,
      O => \Signed_imm_24_out[10]_i_1_n_0\
    );
\Signed_imm_24_out[11]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Signed_imm_24(11),
      I1 => flush,
      O => \Signed_imm_24_out[11]_i_1_n_0\
    );
\Signed_imm_24_out[12]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Signed_imm_24(12),
      I1 => flush,
      O => \Signed_imm_24_out[12]_i_1_n_0\
    );
\Signed_imm_24_out[13]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Signed_imm_24(13),
      I1 => flush,
      O => \Signed_imm_24_out[13]_i_1_n_0\
    );
\Signed_imm_24_out[14]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Signed_imm_24(14),
      I1 => flush,
      O => \Signed_imm_24_out[14]_i_1_n_0\
    );
\Signed_imm_24_out[15]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Signed_imm_24(15),
      I1 => flush,
      O => \Signed_imm_24_out[15]_i_1_n_0\
    );
\Signed_imm_24_out[16]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Signed_imm_24(16),
      I1 => flush,
      O => \Signed_imm_24_out[16]_i_1_n_0\
    );
\Signed_imm_24_out[17]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Signed_imm_24(17),
      I1 => flush,
      O => \Signed_imm_24_out[17]_i_1_n_0\
    );
\Signed_imm_24_out[18]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Signed_imm_24(18),
      I1 => flush,
      O => \Signed_imm_24_out[18]_i_1_n_0\
    );
\Signed_imm_24_out[19]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Signed_imm_24(19),
      I1 => flush,
      O => \Signed_imm_24_out[19]_i_1_n_0\
    );
\Signed_imm_24_out[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Signed_imm_24(1),
      I1 => flush,
      O => \Signed_imm_24_out[1]_i_1_n_0\
    );
\Signed_imm_24_out[20]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Signed_imm_24(20),
      I1 => flush,
      O => \Signed_imm_24_out[20]_i_1_n_0\
    );
\Signed_imm_24_out[21]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Signed_imm_24(21),
      I1 => flush,
      O => \Signed_imm_24_out[21]_i_1_n_0\
    );
\Signed_imm_24_out[22]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Signed_imm_24(22),
      I1 => flush,
      O => \Signed_imm_24_out[22]_i_1_n_0\
    );
\Signed_imm_24_out[23]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Signed_imm_24(23),
      I1 => flush,
      O => \Signed_imm_24_out[23]_i_1_n_0\
    );
\Signed_imm_24_out[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Signed_imm_24(2),
      I1 => flush,
      O => \Signed_imm_24_out[2]_i_1_n_0\
    );
\Signed_imm_24_out[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Signed_imm_24(3),
      I1 => flush,
      O => \Signed_imm_24_out[3]_i_1_n_0\
    );
\Signed_imm_24_out[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Signed_imm_24(4),
      I1 => flush,
      O => \Signed_imm_24_out[4]_i_1_n_0\
    );
\Signed_imm_24_out[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Signed_imm_24(5),
      I1 => flush,
      O => \Signed_imm_24_out[5]_i_1_n_0\
    );
\Signed_imm_24_out[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Signed_imm_24(6),
      I1 => flush,
      O => \Signed_imm_24_out[6]_i_1_n_0\
    );
\Signed_imm_24_out[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Signed_imm_24(7),
      I1 => flush,
      O => \Signed_imm_24_out[7]_i_1_n_0\
    );
\Signed_imm_24_out[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Signed_imm_24(8),
      I1 => flush,
      O => \Signed_imm_24_out[8]_i_1_n_0\
    );
\Signed_imm_24_out[9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Signed_imm_24(9),
      I1 => flush,
      O => \Signed_imm_24_out[9]_i_1_n_0\
    );
\Signed_imm_24_out_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Signed_imm_24_out[0]_i_1_n_0\,
      Q => Signed_imm_24_out(0)
    );
\Signed_imm_24_out_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Signed_imm_24_out[10]_i_1_n_0\,
      Q => Signed_imm_24_out(10)
    );
\Signed_imm_24_out_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Signed_imm_24_out[11]_i_1_n_0\,
      Q => Signed_imm_24_out(11)
    );
\Signed_imm_24_out_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Signed_imm_24_out[12]_i_1_n_0\,
      Q => Signed_imm_24_out(12)
    );
\Signed_imm_24_out_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Signed_imm_24_out[13]_i_1_n_0\,
      Q => Signed_imm_24_out(13)
    );
\Signed_imm_24_out_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Signed_imm_24_out[14]_i_1_n_0\,
      Q => Signed_imm_24_out(14)
    );
\Signed_imm_24_out_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Signed_imm_24_out[15]_i_1_n_0\,
      Q => Signed_imm_24_out(15)
    );
\Signed_imm_24_out_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Signed_imm_24_out[16]_i_1_n_0\,
      Q => Signed_imm_24_out(16)
    );
\Signed_imm_24_out_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Signed_imm_24_out[17]_i_1_n_0\,
      Q => Signed_imm_24_out(17)
    );
\Signed_imm_24_out_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Signed_imm_24_out[18]_i_1_n_0\,
      Q => Signed_imm_24_out(18)
    );
\Signed_imm_24_out_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Signed_imm_24_out[19]_i_1_n_0\,
      Q => Signed_imm_24_out(19)
    );
\Signed_imm_24_out_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Signed_imm_24_out[1]_i_1_n_0\,
      Q => Signed_imm_24_out(1)
    );
\Signed_imm_24_out_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Signed_imm_24_out[20]_i_1_n_0\,
      Q => Signed_imm_24_out(20)
    );
\Signed_imm_24_out_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Signed_imm_24_out[21]_i_1_n_0\,
      Q => Signed_imm_24_out(21)
    );
\Signed_imm_24_out_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Signed_imm_24_out[22]_i_1_n_0\,
      Q => Signed_imm_24_out(22)
    );
\Signed_imm_24_out_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Signed_imm_24_out[23]_i_1_n_0\,
      Q => Signed_imm_24_out(23)
    );
\Signed_imm_24_out_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Signed_imm_24_out[2]_i_1_n_0\,
      Q => Signed_imm_24_out(2)
    );
\Signed_imm_24_out_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Signed_imm_24_out[3]_i_1_n_0\,
      Q => Signed_imm_24_out(3)
    );
\Signed_imm_24_out_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Signed_imm_24_out[4]_i_1_n_0\,
      Q => Signed_imm_24_out(4)
    );
\Signed_imm_24_out_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Signed_imm_24_out[5]_i_1_n_0\,
      Q => Signed_imm_24_out(5)
    );
\Signed_imm_24_out_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Signed_imm_24_out[6]_i_1_n_0\,
      Q => Signed_imm_24_out(6)
    );
\Signed_imm_24_out_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Signed_imm_24_out[7]_i_1_n_0\,
      Q => Signed_imm_24_out(7)
    );
\Signed_imm_24_out_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Signed_imm_24_out[8]_i_1_n_0\,
      Q => Signed_imm_24_out(8)
    );
\Signed_imm_24_out_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Signed_imm_24_out[9]_i_1_n_0\,
      Q => Signed_imm_24_out(9)
    );
\Val_Rm_out[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(0),
      I1 => flush,
      O => \Val_Rm_out[0]_i_1_n_0\
    );
\Val_Rm_out[10]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(10),
      I1 => flush,
      O => \Val_Rm_out[10]_i_1_n_0\
    );
\Val_Rm_out[11]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(11),
      I1 => flush,
      O => \Val_Rm_out[11]_i_1_n_0\
    );
\Val_Rm_out[12]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(12),
      I1 => flush,
      O => \Val_Rm_out[12]_i_1_n_0\
    );
\Val_Rm_out[13]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(13),
      I1 => flush,
      O => \Val_Rm_out[13]_i_1_n_0\
    );
\Val_Rm_out[14]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(14),
      I1 => flush,
      O => \Val_Rm_out[14]_i_1_n_0\
    );
\Val_Rm_out[15]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(15),
      I1 => flush,
      O => \Val_Rm_out[15]_i_1_n_0\
    );
\Val_Rm_out[16]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(16),
      I1 => flush,
      O => \Val_Rm_out[16]_i_1_n_0\
    );
\Val_Rm_out[17]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(17),
      I1 => flush,
      O => \Val_Rm_out[17]_i_1_n_0\
    );
\Val_Rm_out[18]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(18),
      I1 => flush,
      O => \Val_Rm_out[18]_i_1_n_0\
    );
\Val_Rm_out[19]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(19),
      I1 => flush,
      O => \Val_Rm_out[19]_i_1_n_0\
    );
\Val_Rm_out[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(1),
      I1 => flush,
      O => \Val_Rm_out[1]_i_1_n_0\
    );
\Val_Rm_out[20]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(20),
      I1 => flush,
      O => \Val_Rm_out[20]_i_1_n_0\
    );
\Val_Rm_out[21]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(21),
      I1 => flush,
      O => \Val_Rm_out[21]_i_1_n_0\
    );
\Val_Rm_out[22]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(22),
      I1 => flush,
      O => \Val_Rm_out[22]_i_1_n_0\
    );
\Val_Rm_out[23]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(23),
      I1 => flush,
      O => \Val_Rm_out[23]_i_1_n_0\
    );
\Val_Rm_out[24]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(24),
      I1 => flush,
      O => \Val_Rm_out[24]_i_1_n_0\
    );
\Val_Rm_out[25]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(25),
      I1 => flush,
      O => \Val_Rm_out[25]_i_1_n_0\
    );
\Val_Rm_out[26]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(26),
      I1 => flush,
      O => \Val_Rm_out[26]_i_1_n_0\
    );
\Val_Rm_out[27]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(27),
      I1 => flush,
      O => \Val_Rm_out[27]_i_1_n_0\
    );
\Val_Rm_out[28]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(28),
      I1 => flush,
      O => \Val_Rm_out[28]_i_1_n_0\
    );
\Val_Rm_out[29]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(29),
      I1 => flush,
      O => \Val_Rm_out[29]_i_1_n_0\
    );
\Val_Rm_out[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(2),
      I1 => flush,
      O => \Val_Rm_out[2]_i_1_n_0\
    );
\Val_Rm_out[30]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(30),
      I1 => flush,
      O => \Val_Rm_out[30]_i_1_n_0\
    );
\Val_Rm_out[31]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(31),
      I1 => flush,
      O => \Val_Rm_out[31]_i_1_n_0\
    );
\Val_Rm_out[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(3),
      I1 => flush,
      O => \Val_Rm_out[3]_i_1_n_0\
    );
\Val_Rm_out[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(4),
      I1 => flush,
      O => \Val_Rm_out[4]_i_1_n_0\
    );
\Val_Rm_out[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(5),
      I1 => flush,
      O => \Val_Rm_out[5]_i_1_n_0\
    );
\Val_Rm_out[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(6),
      I1 => flush,
      O => \Val_Rm_out[6]_i_1_n_0\
    );
\Val_Rm_out[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(7),
      I1 => flush,
      O => \Val_Rm_out[7]_i_1_n_0\
    );
\Val_Rm_out[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(8),
      I1 => flush,
      O => \Val_Rm_out[8]_i_1_n_0\
    );
\Val_Rm_out[9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rm(9),
      I1 => flush,
      O => \Val_Rm_out[9]_i_1_n_0\
    );
\Val_Rm_out_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[0]_i_1_n_0\,
      Q => Val_Rm_out(0)
    );
\Val_Rm_out_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[10]_i_1_n_0\,
      Q => Val_Rm_out(10)
    );
\Val_Rm_out_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[11]_i_1_n_0\,
      Q => Val_Rm_out(11)
    );
\Val_Rm_out_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[12]_i_1_n_0\,
      Q => Val_Rm_out(12)
    );
\Val_Rm_out_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[13]_i_1_n_0\,
      Q => Val_Rm_out(13)
    );
\Val_Rm_out_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[14]_i_1_n_0\,
      Q => Val_Rm_out(14)
    );
\Val_Rm_out_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[15]_i_1_n_0\,
      Q => Val_Rm_out(15)
    );
\Val_Rm_out_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[16]_i_1_n_0\,
      Q => Val_Rm_out(16)
    );
\Val_Rm_out_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[17]_i_1_n_0\,
      Q => Val_Rm_out(17)
    );
\Val_Rm_out_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[18]_i_1_n_0\,
      Q => Val_Rm_out(18)
    );
\Val_Rm_out_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[19]_i_1_n_0\,
      Q => Val_Rm_out(19)
    );
\Val_Rm_out_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[1]_i_1_n_0\,
      Q => Val_Rm_out(1)
    );
\Val_Rm_out_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[20]_i_1_n_0\,
      Q => Val_Rm_out(20)
    );
\Val_Rm_out_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[21]_i_1_n_0\,
      Q => Val_Rm_out(21)
    );
\Val_Rm_out_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[22]_i_1_n_0\,
      Q => Val_Rm_out(22)
    );
\Val_Rm_out_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[23]_i_1_n_0\,
      Q => Val_Rm_out(23)
    );
\Val_Rm_out_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[24]_i_1_n_0\,
      Q => Val_Rm_out(24)
    );
\Val_Rm_out_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[25]_i_1_n_0\,
      Q => Val_Rm_out(25)
    );
\Val_Rm_out_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[26]_i_1_n_0\,
      Q => Val_Rm_out(26)
    );
\Val_Rm_out_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[27]_i_1_n_0\,
      Q => Val_Rm_out(27)
    );
\Val_Rm_out_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[28]_i_1_n_0\,
      Q => Val_Rm_out(28)
    );
\Val_Rm_out_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[29]_i_1_n_0\,
      Q => Val_Rm_out(29)
    );
\Val_Rm_out_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[2]_i_1_n_0\,
      Q => Val_Rm_out(2)
    );
\Val_Rm_out_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[30]_i_1_n_0\,
      Q => Val_Rm_out(30)
    );
\Val_Rm_out_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[31]_i_1_n_0\,
      Q => Val_Rm_out(31)
    );
\Val_Rm_out_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[3]_i_1_n_0\,
      Q => Val_Rm_out(3)
    );
\Val_Rm_out_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[4]_i_1_n_0\,
      Q => Val_Rm_out(4)
    );
\Val_Rm_out_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[5]_i_1_n_0\,
      Q => Val_Rm_out(5)
    );
\Val_Rm_out_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[6]_i_1_n_0\,
      Q => Val_Rm_out(6)
    );
\Val_Rm_out_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[7]_i_1_n_0\,
      Q => Val_Rm_out(7)
    );
\Val_Rm_out_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[8]_i_1_n_0\,
      Q => Val_Rm_out(8)
    );
\Val_Rm_out_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rm_out[9]_i_1_n_0\,
      Q => Val_Rm_out(9)
    );
\Val_Rn_out[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(0),
      I1 => flush,
      O => \Val_Rn_out[0]_i_1_n_0\
    );
\Val_Rn_out[10]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(10),
      I1 => flush,
      O => \Val_Rn_out[10]_i_1_n_0\
    );
\Val_Rn_out[11]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(11),
      I1 => flush,
      O => \Val_Rn_out[11]_i_1_n_0\
    );
\Val_Rn_out[12]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(12),
      I1 => flush,
      O => \Val_Rn_out[12]_i_1_n_0\
    );
\Val_Rn_out[13]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(13),
      I1 => flush,
      O => \Val_Rn_out[13]_i_1_n_0\
    );
\Val_Rn_out[14]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(14),
      I1 => flush,
      O => \Val_Rn_out[14]_i_1_n_0\
    );
\Val_Rn_out[15]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(15),
      I1 => flush,
      O => \Val_Rn_out[15]_i_1_n_0\
    );
\Val_Rn_out[16]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(16),
      I1 => flush,
      O => \Val_Rn_out[16]_i_1_n_0\
    );
\Val_Rn_out[17]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(17),
      I1 => flush,
      O => \Val_Rn_out[17]_i_1_n_0\
    );
\Val_Rn_out[18]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(18),
      I1 => flush,
      O => \Val_Rn_out[18]_i_1_n_0\
    );
\Val_Rn_out[19]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(19),
      I1 => flush,
      O => \Val_Rn_out[19]_i_1_n_0\
    );
\Val_Rn_out[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(1),
      I1 => flush,
      O => \Val_Rn_out[1]_i_1_n_0\
    );
\Val_Rn_out[20]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(20),
      I1 => flush,
      O => \Val_Rn_out[20]_i_1_n_0\
    );
\Val_Rn_out[21]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(21),
      I1 => flush,
      O => \Val_Rn_out[21]_i_1_n_0\
    );
\Val_Rn_out[22]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(22),
      I1 => flush,
      O => \Val_Rn_out[22]_i_1_n_0\
    );
\Val_Rn_out[23]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(23),
      I1 => flush,
      O => \Val_Rn_out[23]_i_1_n_0\
    );
\Val_Rn_out[24]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(24),
      I1 => flush,
      O => \Val_Rn_out[24]_i_1_n_0\
    );
\Val_Rn_out[25]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(25),
      I1 => flush,
      O => \Val_Rn_out[25]_i_1_n_0\
    );
\Val_Rn_out[26]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(26),
      I1 => flush,
      O => \Val_Rn_out[26]_i_1_n_0\
    );
\Val_Rn_out[27]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(27),
      I1 => flush,
      O => \Val_Rn_out[27]_i_1_n_0\
    );
\Val_Rn_out[28]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(28),
      I1 => flush,
      O => \Val_Rn_out[28]_i_1_n_0\
    );
\Val_Rn_out[29]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(29),
      I1 => flush,
      O => \Val_Rn_out[29]_i_1_n_0\
    );
\Val_Rn_out[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(2),
      I1 => flush,
      O => \Val_Rn_out[2]_i_1_n_0\
    );
\Val_Rn_out[30]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(30),
      I1 => flush,
      O => \Val_Rn_out[30]_i_1_n_0\
    );
\Val_Rn_out[31]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(31),
      I1 => flush,
      O => \Val_Rn_out[31]_i_1_n_0\
    );
\Val_Rn_out[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(3),
      I1 => flush,
      O => \Val_Rn_out[3]_i_1_n_0\
    );
\Val_Rn_out[4]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(4),
      I1 => flush,
      O => \Val_Rn_out[4]_i_1_n_0\
    );
\Val_Rn_out[5]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(5),
      I1 => flush,
      O => \Val_Rn_out[5]_i_1_n_0\
    );
\Val_Rn_out[6]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(6),
      I1 => flush,
      O => \Val_Rn_out[6]_i_1_n_0\
    );
\Val_Rn_out[7]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(7),
      I1 => flush,
      O => \Val_Rn_out[7]_i_1_n_0\
    );
\Val_Rn_out[8]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(8),
      I1 => flush,
      O => \Val_Rn_out[8]_i_1_n_0\
    );
\Val_Rn_out[9]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => Val_Rn(9),
      I1 => flush,
      O => \Val_Rn_out[9]_i_1_n_0\
    );
\Val_Rn_out_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[0]_i_1_n_0\,
      Q => Val_Rn_out(0)
    );
\Val_Rn_out_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[10]_i_1_n_0\,
      Q => Val_Rn_out(10)
    );
\Val_Rn_out_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[11]_i_1_n_0\,
      Q => Val_Rn_out(11)
    );
\Val_Rn_out_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[12]_i_1_n_0\,
      Q => Val_Rn_out(12)
    );
\Val_Rn_out_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[13]_i_1_n_0\,
      Q => Val_Rn_out(13)
    );
\Val_Rn_out_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[14]_i_1_n_0\,
      Q => Val_Rn_out(14)
    );
\Val_Rn_out_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[15]_i_1_n_0\,
      Q => Val_Rn_out(15)
    );
\Val_Rn_out_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[16]_i_1_n_0\,
      Q => Val_Rn_out(16)
    );
\Val_Rn_out_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[17]_i_1_n_0\,
      Q => Val_Rn_out(17)
    );
\Val_Rn_out_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[18]_i_1_n_0\,
      Q => Val_Rn_out(18)
    );
\Val_Rn_out_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[19]_i_1_n_0\,
      Q => Val_Rn_out(19)
    );
\Val_Rn_out_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[1]_i_1_n_0\,
      Q => Val_Rn_out(1)
    );
\Val_Rn_out_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[20]_i_1_n_0\,
      Q => Val_Rn_out(20)
    );
\Val_Rn_out_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[21]_i_1_n_0\,
      Q => Val_Rn_out(21)
    );
\Val_Rn_out_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[22]_i_1_n_0\,
      Q => Val_Rn_out(22)
    );
\Val_Rn_out_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[23]_i_1_n_0\,
      Q => Val_Rn_out(23)
    );
\Val_Rn_out_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[24]_i_1_n_0\,
      Q => Val_Rn_out(24)
    );
\Val_Rn_out_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[25]_i_1_n_0\,
      Q => Val_Rn_out(25)
    );
\Val_Rn_out_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[26]_i_1_n_0\,
      Q => Val_Rn_out(26)
    );
\Val_Rn_out_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[27]_i_1_n_0\,
      Q => Val_Rn_out(27)
    );
\Val_Rn_out_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[28]_i_1_n_0\,
      Q => Val_Rn_out(28)
    );
\Val_Rn_out_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[29]_i_1_n_0\,
      Q => Val_Rn_out(29)
    );
\Val_Rn_out_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[2]_i_1_n_0\,
      Q => Val_Rn_out(2)
    );
\Val_Rn_out_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[30]_i_1_n_0\,
      Q => Val_Rn_out(30)
    );
\Val_Rn_out_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[31]_i_1_n_0\,
      Q => Val_Rn_out(31)
    );
\Val_Rn_out_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[3]_i_1_n_0\,
      Q => Val_Rn_out(3)
    );
\Val_Rn_out_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[4]_i_1_n_0\,
      Q => Val_Rn_out(4)
    );
\Val_Rn_out_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[5]_i_1_n_0\,
      Q => Val_Rn_out(5)
    );
\Val_Rn_out_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[6]_i_1_n_0\,
      Q => Val_Rn_out(6)
    );
\Val_Rn_out_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[7]_i_1_n_0\,
      Q => Val_Rn_out(7)
    );
\Val_Rn_out_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[8]_i_1_n_0\,
      Q => Val_Rn_out(8)
    );
\Val_Rn_out_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \Val_Rn_out[9]_i_1_n_0\,
      Q => Val_Rn_out(9)
    );
WB_EN_out_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => WB_EN,
      I1 => flush,
      O => WB_EN_out_i_1_n_0
    );
WB_EN_out_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => WB_EN_out_i_1_n_0,
      Q => WB_EN_out
    );
\dest_out[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => dest(0),
      I1 => flush,
      O => \dest_out[0]_i_1_n_0\
    );
\dest_out[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => dest(1),
      I1 => flush,
      O => \dest_out[1]_i_1_n_0\
    );
\dest_out[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => dest(2),
      I1 => flush,
      O => \dest_out[2]_i_1_n_0\
    );
\dest_out[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => dest(3),
      I1 => flush,
      O => \dest_out[3]_i_1_n_0\
    );
\dest_out_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \dest_out[0]_i_1_n_0\,
      Q => dest_out(0)
    );
\dest_out_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \dest_out[1]_i_1_n_0\,
      Q => dest_out(1)
    );
\dest_out_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \dest_out[2]_i_1_n_0\,
      Q => dest_out(2)
    );
\dest_out_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \dest_out[3]_i_1_n_0\,
      Q => dest_out(3)
    );
imm_out_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => imm,
      I1 => flush,
      O => imm_out_i_1_n_0
    );
imm_out_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => imm_out_i_1_n_0,
      Q => imm_out
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
      CE => '1',
      CLR => rst,
      D => p_0_in(0),
      Q => pcOut(0)
    );
\pcOut_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(10),
      Q => pcOut(10)
    );
\pcOut_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(11),
      Q => pcOut(11)
    );
\pcOut_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(12),
      Q => pcOut(12)
    );
\pcOut_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(13),
      Q => pcOut(13)
    );
\pcOut_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(14),
      Q => pcOut(14)
    );
\pcOut_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(15),
      Q => pcOut(15)
    );
\pcOut_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(16),
      Q => pcOut(16)
    );
\pcOut_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(17),
      Q => pcOut(17)
    );
\pcOut_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(18),
      Q => pcOut(18)
    );
\pcOut_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(19),
      Q => pcOut(19)
    );
\pcOut_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(1),
      Q => pcOut(1)
    );
\pcOut_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(20),
      Q => pcOut(20)
    );
\pcOut_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(21),
      Q => pcOut(21)
    );
\pcOut_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(22),
      Q => pcOut(22)
    );
\pcOut_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(23),
      Q => pcOut(23)
    );
\pcOut_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(24),
      Q => pcOut(24)
    );
\pcOut_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(25),
      Q => pcOut(25)
    );
\pcOut_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(26),
      Q => pcOut(26)
    );
\pcOut_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(27),
      Q => pcOut(27)
    );
\pcOut_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(28),
      Q => pcOut(28)
    );
\pcOut_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(29),
      Q => pcOut(29)
    );
\pcOut_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(2),
      Q => pcOut(2)
    );
\pcOut_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(30),
      Q => pcOut(30)
    );
\pcOut_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(31),
      Q => pcOut(31)
    );
\pcOut_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(3),
      Q => pcOut(3)
    );
\pcOut_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(4),
      Q => pcOut(4)
    );
\pcOut_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(5),
      Q => pcOut(5)
    );
\pcOut_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(6),
      Q => pcOut(6)
    );
\pcOut_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(7),
      Q => pcOut(7)
    );
\pcOut_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(8),
      Q => pcOut(8)
    );
\pcOut_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => p_0_in(9),
      Q => pcOut(9)
    );
\src_1_out[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => src_1(0),
      I1 => flush,
      O => \src_1_out[0]_i_1_n_0\
    );
\src_1_out[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => src_1(1),
      I1 => flush,
      O => \src_1_out[1]_i_1_n_0\
    );
\src_1_out[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => src_1(2),
      I1 => flush,
      O => \src_1_out[2]_i_1_n_0\
    );
\src_1_out[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => src_1(3),
      I1 => flush,
      O => \src_1_out[3]_i_1_n_0\
    );
\src_1_out_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \src_1_out[0]_i_1_n_0\,
      Q => src_1_out(0)
    );
\src_1_out_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \src_1_out[1]_i_1_n_0\,
      Q => src_1_out(1)
    );
\src_1_out_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \src_1_out[2]_i_1_n_0\,
      Q => src_1_out(2)
    );
\src_1_out_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \src_1_out[3]_i_1_n_0\,
      Q => src_1_out(3)
    );
\src_2_out[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => src_2(0),
      I1 => flush,
      O => \src_2_out[0]_i_1_n_0\
    );
\src_2_out[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => src_2(1),
      I1 => flush,
      O => \src_2_out[1]_i_1_n_0\
    );
\src_2_out[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => src_2(2),
      I1 => flush,
      O => \src_2_out[2]_i_1_n_0\
    );
\src_2_out[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => src_2(3),
      I1 => flush,
      O => \src_2_out[3]_i_1_n_0\
    );
\src_2_out_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \src_2_out[0]_i_1_n_0\,
      Q => src_2_out(0)
    );
\src_2_out_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \src_2_out[1]_i_1_n_0\,
      Q => src_2_out(1)
    );
\src_2_out_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \src_2_out[2]_i_1_n_0\,
      Q => src_2_out(2)
    );
\src_2_out_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \src_2_out[3]_i_1_n_0\,
      Q => src_2_out(3)
    );
\status_out[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => status(0),
      I1 => flush,
      O => \status_out[0]_i_1_n_0\
    );
\status_out[1]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => status(1),
      I1 => flush,
      O => \status_out[1]_i_1_n_0\
    );
\status_out[2]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => status(2),
      I1 => flush,
      O => \status_out[2]_i_1_n_0\
    );
\status_out[3]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => status(3),
      I1 => flush,
      O => \status_out[3]_i_1_n_0\
    );
\status_out_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \status_out[0]_i_1_n_0\,
      Q => status_out(0)
    );
\status_out_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \status_out[1]_i_1_n_0\,
      Q => status_out(1)
    );
\status_out_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \status_out[2]_i_1_n_0\,
      Q => status_out(2)
    );
\status_out_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => \status_out[3]_i_1_n_0\,
      Q => status_out(3)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  port (
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    flush : in STD_LOGIC;
    pc : in STD_LOGIC_VECTOR ( 31 downto 0 );
    WB_EN : in STD_LOGIC;
    MEM_R_EN : in STD_LOGIC;
    MEM_W_EN : in STD_LOGIC;
    EXE_CMD : in STD_LOGIC_VECTOR ( 3 downto 0 );
    B : in STD_LOGIC;
    S : in STD_LOGIC;
    Val_Rn : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Val_Rm : in STD_LOGIC_VECTOR ( 31 downto 0 );
    imm : in STD_LOGIC;
    Shift_operand : in STD_LOGIC_VECTOR ( 11 downto 0 );
    Signed_imm_24 : in STD_LOGIC_VECTOR ( 23 downto 0 );
    dest : in STD_LOGIC_VECTOR ( 3 downto 0 );
    status : in STD_LOGIC_VECTOR ( 3 downto 0 );
    src_1 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    src_2 : in STD_LOGIC_VECTOR ( 3 downto 0 );
    pcOut : out STD_LOGIC_VECTOR ( 31 downto 0 );
    WB_EN_out : out STD_LOGIC;
    MEM_R_EN_out : out STD_LOGIC;
    MEM_W_EN_out : out STD_LOGIC;
    EXE_CMD_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    B_out : out STD_LOGIC;
    S_out : out STD_LOGIC;
    Val_Rn_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    Val_Rm_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    imm_out : out STD_LOGIC;
    Shift_operand_out : out STD_LOGIC_VECTOR ( 11 downto 0 );
    Signed_imm_24_out : out STD_LOGIC_VECTOR ( 23 downto 0 );
    dest_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    status_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    src_1_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    src_2_out : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "design_2_IDreg_0_0,IDreg,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "IDreg,Vivado 2018.3";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN design_2_clk_0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of rst : signal is "xilinx.com:signal:reset:1.0 rst RST";
  attribute X_INTERFACE_PARAMETER of rst : signal is "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0";
begin
inst: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_IDreg
     port map (
      B => B,
      B_out => B_out,
      EXE_CMD(3 downto 0) => EXE_CMD(3 downto 0),
      EXE_CMD_out(3 downto 0) => EXE_CMD_out(3 downto 0),
      MEM_R_EN => MEM_R_EN,
      MEM_R_EN_out => MEM_R_EN_out,
      MEM_W_EN => MEM_W_EN,
      MEM_W_EN_out => MEM_W_EN_out,
      S => S,
      S_out => S_out,
      Shift_operand(11 downto 0) => Shift_operand(11 downto 0),
      Shift_operand_out(11 downto 0) => Shift_operand_out(11 downto 0),
      Signed_imm_24(23 downto 0) => Signed_imm_24(23 downto 0),
      Signed_imm_24_out(23 downto 0) => Signed_imm_24_out(23 downto 0),
      Val_Rm(31 downto 0) => Val_Rm(31 downto 0),
      Val_Rm_out(31 downto 0) => Val_Rm_out(31 downto 0),
      Val_Rn(31 downto 0) => Val_Rn(31 downto 0),
      Val_Rn_out(31 downto 0) => Val_Rn_out(31 downto 0),
      WB_EN => WB_EN,
      WB_EN_out => WB_EN_out,
      clk => clk,
      dest(3 downto 0) => dest(3 downto 0),
      dest_out(3 downto 0) => dest_out(3 downto 0),
      flush => flush,
      imm => imm,
      imm_out => imm_out,
      pc(31 downto 0) => pc(31 downto 0),
      pcOut(31 downto 0) => pcOut(31 downto 0),
      rst => rst,
      src_1(3 downto 0) => src_1(3 downto 0),
      src_1_out(3 downto 0) => src_1_out(3 downto 0),
      src_2(3 downto 0) => src_2(3 downto 0),
      src_2_out(3 downto 0) => src_2_out(3 downto 0),
      status(3 downto 0) => status(3 downto 0),
      status_out(3 downto 0) => status_out(3 downto 0)
    );
end STRUCTURE;
