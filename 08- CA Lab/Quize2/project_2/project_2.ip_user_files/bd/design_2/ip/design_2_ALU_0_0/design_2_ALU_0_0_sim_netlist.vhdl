-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun May 11 11:31:34 2025
-- Host        : Ariyan running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               C:/Users/ariya/OneDrive/Desktop/project_1/project_1/project_1.srcs/sources_1/bd/design_2/ip/design_2_ALU_0_0/design_2_ALU_0_0_sim_netlist.vhdl
-- Design      : design_2_ALU_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_2_ALU_0_0_ALU is
  port (
    NZCV : out STD_LOGIC_VECTOR ( 3 downto 0 );
    result : out STD_LOGIC_VECTOR ( 30 downto 0 );
    CO : out STD_LOGIC_VECTOR ( 0 to 0 );
    \in1[3]\ : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \in1[7]\ : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \in1[11]\ : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \in1[15]\ : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \in1[19]\ : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \in1[23]\ : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \in1[27]\ : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \in1[31]\ : out STD_LOGIC_VECTOR ( 3 downto 0 );
    in1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    NZCV13_out : in STD_LOGIC;
    NZCV_0_sp_1 : in STD_LOGIC;
    in2 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    \NZCV[2]_INST_0_i_5_0\ : in STD_LOGIC;
    ALU_op : in STD_LOGIC_VECTOR ( 3 downto 0 );
    \NZCV[2]_INST_0_i_5_1\ : in STD_LOGIC;
    result_0_sp_1 : in STD_LOGIC;
    \result[0]_0\ : in STD_LOGIC;
    \result[0]_1\ : in STD_LOGIC;
    result_1_sp_1 : in STD_LOGIC;
    \NZCV[2]_INST_0_i_5_2\ : in STD_LOGIC;
    \NZCV[2]_INST_0_i_5_3\ : in STD_LOGIC;
    result_2_sp_1 : in STD_LOGIC;
    result_3_sp_1 : in STD_LOGIC;
    result_4_sp_1 : in STD_LOGIC;
    result_5_sp_1 : in STD_LOGIC;
    result_6_sp_1 : in STD_LOGIC;
    result_7_sp_1 : in STD_LOGIC;
    \NZCV[2]_INST_0_i_6_0\ : in STD_LOGIC;
    \NZCV[2]_INST_0_i_6_1\ : in STD_LOGIC;
    result_8_sp_1 : in STD_LOGIC;
    result_9_sp_1 : in STD_LOGIC;
    \NZCV[2]_INST_0_i_6_2\ : in STD_LOGIC;
    \NZCV[2]_INST_0_i_6_3\ : in STD_LOGIC;
    result_10_sp_1 : in STD_LOGIC;
    result_11_sp_1 : in STD_LOGIC;
    result_12_sp_1 : in STD_LOGIC;
    result_13_sp_1 : in STD_LOGIC;
    result_14_sp_1 : in STD_LOGIC;
    result_15_sp_1 : in STD_LOGIC;
    result_16_sp_1 : in STD_LOGIC;
    result_17_sp_1 : in STD_LOGIC;
    result_18_sp_1 : in STD_LOGIC;
    result_19_sp_1 : in STD_LOGIC;
    result_20_sp_1 : in STD_LOGIC;
    result_21_sp_1 : in STD_LOGIC;
    result_22_sp_1 : in STD_LOGIC;
    result_23_sp_1 : in STD_LOGIC;
    result_24_sp_1 : in STD_LOGIC;
    result_25_sp_1 : in STD_LOGIC;
    result_26_sp_1 : in STD_LOGIC;
    result_27_sp_1 : in STD_LOGIC;
    result_28_sp_1 : in STD_LOGIC;
    result_29_sp_1 : in STD_LOGIC;
    result_30_sp_1 : in STD_LOGIC;
    \result[31]\ : in STD_LOGIC;
    O : in STD_LOGIC_VECTOR ( 0 to 0 );
    carry_in : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_2_ALU_0_0_ALU : entity is "ALU";
end design_2_ALU_0_0_ALU;

architecture STRUCTURE of design_2_ALU_0_0_ALU is
  signal \^co\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^nzcv\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NZCV[2]_INST_0_i_10_n_0\ : STD_LOGIC;
  signal \NZCV[2]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \NZCV[2]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \NZCV[2]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \NZCV[2]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \NZCV[2]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \NZCV[2]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \NZCV[2]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \NZCV[2]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \NZCV[2]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \NZCV[3]_INST_0_i_10_n_0\ : STD_LOGIC;
  signal \NZCV[3]_INST_0_i_11_n_0\ : STD_LOGIC;
  signal \NZCV[3]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \NZCV[3]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \NZCV[3]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \NZCV[3]_INST_0_i_7_n_1\ : STD_LOGIC;
  signal \NZCV[3]_INST_0_i_7_n_2\ : STD_LOGIC;
  signal \NZCV[3]_INST_0_i_7_n_3\ : STD_LOGIC;
  signal \NZCV[3]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \NZCV[3]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal NZCV_0_sn_1 : STD_LOGIC;
  signal data2 : STD_LOGIC;
  signal data3 : STD_LOGIC;
  signal \i__carry__0_i_1__0_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_1_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_2__0_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_2_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_3__0_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_3_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_4__0_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_4_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_1__0_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_1_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_2__0_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_2_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_3__0_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_3_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_4__0_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_4_n_0\ : STD_LOGIC;
  signal \i__carry__2_i_1__0_n_0\ : STD_LOGIC;
  signal \i__carry__2_i_1_n_0\ : STD_LOGIC;
  signal \i__carry__2_i_2__0_n_0\ : STD_LOGIC;
  signal \i__carry__2_i_2_n_0\ : STD_LOGIC;
  signal \i__carry__2_i_3__0_n_0\ : STD_LOGIC;
  signal \i__carry__2_i_3_n_0\ : STD_LOGIC;
  signal \i__carry__2_i_4__0_n_0\ : STD_LOGIC;
  signal \i__carry__2_i_4_n_0\ : STD_LOGIC;
  signal \i__carry__3_i_1__0_n_0\ : STD_LOGIC;
  signal \i__carry__3_i_1_n_0\ : STD_LOGIC;
  signal \i__carry__3_i_2__0_n_0\ : STD_LOGIC;
  signal \i__carry__3_i_2_n_0\ : STD_LOGIC;
  signal \i__carry__3_i_3__0_n_0\ : STD_LOGIC;
  signal \i__carry__3_i_3_n_0\ : STD_LOGIC;
  signal \i__carry__3_i_4__0_n_0\ : STD_LOGIC;
  signal \i__carry__3_i_4_n_0\ : STD_LOGIC;
  signal \i__carry__4_i_1__0_n_0\ : STD_LOGIC;
  signal \i__carry__4_i_1_n_0\ : STD_LOGIC;
  signal \i__carry__4_i_2__0_n_0\ : STD_LOGIC;
  signal \i__carry__4_i_2_n_0\ : STD_LOGIC;
  signal \i__carry__4_i_3__0_n_0\ : STD_LOGIC;
  signal \i__carry__4_i_3_n_0\ : STD_LOGIC;
  signal \i__carry__4_i_4__0_n_0\ : STD_LOGIC;
  signal \i__carry__4_i_4_n_0\ : STD_LOGIC;
  signal \i__carry__5_i_1__0_n_0\ : STD_LOGIC;
  signal \i__carry__5_i_1_n_0\ : STD_LOGIC;
  signal \i__carry__5_i_2__0_n_0\ : STD_LOGIC;
  signal \i__carry__5_i_2_n_0\ : STD_LOGIC;
  signal \i__carry__5_i_3__0_n_0\ : STD_LOGIC;
  signal \i__carry__5_i_3_n_0\ : STD_LOGIC;
  signal \i__carry__5_i_4__0_n_0\ : STD_LOGIC;
  signal \i__carry__5_i_4_n_0\ : STD_LOGIC;
  signal \i__carry__6_i_1__0_n_0\ : STD_LOGIC;
  signal \i__carry__6_i_1_n_0\ : STD_LOGIC;
  signal \i__carry__6_i_2__0_n_0\ : STD_LOGIC;
  signal \i__carry__6_i_2_n_0\ : STD_LOGIC;
  signal \i__carry__6_i_3__0_n_0\ : STD_LOGIC;
  signal \i__carry__6_i_3_n_0\ : STD_LOGIC;
  signal \i__carry__6_i_4__0_n_0\ : STD_LOGIC;
  signal \i__carry__6_i_4_n_0\ : STD_LOGIC;
  signal \i__carry_i_1__0_n_0\ : STD_LOGIC;
  signal \i__carry_i_2__0_n_0\ : STD_LOGIC;
  signal \i__carry_i_2_n_0\ : STD_LOGIC;
  signal \i__carry_i_3__0_n_0\ : STD_LOGIC;
  signal \i__carry_i_3_n_0\ : STD_LOGIC;
  signal \i__carry_i_4__0_n_0\ : STD_LOGIC;
  signal \i__carry_i_4_n_0\ : STD_LOGIC;
  signal \i__carry_i_5_n_0\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 0 to 0 );
  signal p_1_in : STD_LOGIC_VECTOR ( 1 to 1 );
  signal \^result\ : STD_LOGIC_VECTOR ( 30 downto 0 );
  signal \result0_inferred__2/i__carry__0_n_0\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__0_n_1\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__0_n_2\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__0_n_3\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__0_n_4\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__0_n_5\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__0_n_6\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__0_n_7\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__1_n_0\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__1_n_1\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__1_n_2\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__1_n_3\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__1_n_4\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__1_n_5\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__1_n_6\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__1_n_7\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__2_n_0\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__2_n_1\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__2_n_2\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__2_n_3\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__2_n_4\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__2_n_5\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__2_n_6\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__2_n_7\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__3_n_0\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__3_n_1\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__3_n_2\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__3_n_3\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__3_n_4\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__3_n_5\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__3_n_6\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__3_n_7\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__4_n_0\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__4_n_1\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__4_n_2\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__4_n_3\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__4_n_4\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__4_n_5\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__4_n_6\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__4_n_7\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__5_n_0\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__5_n_1\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__5_n_2\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__5_n_3\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__5_n_4\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__5_n_5\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__5_n_6\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__5_n_7\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__6_n_0\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__6_n_1\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__6_n_2\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__6_n_3\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__6_n_4\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__6_n_5\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__6_n_6\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry__6_n_7\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry_n_0\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry_n_1\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry_n_2\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry_n_3\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry_n_4\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry_n_5\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry_n_6\ : STD_LOGIC;
  signal \result0_inferred__2/i__carry_n_7\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__0_n_0\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__0_n_1\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__0_n_2\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__0_n_3\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__0_n_4\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__0_n_5\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__0_n_6\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__0_n_7\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__1_n_0\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__1_n_1\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__1_n_2\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__1_n_3\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__1_n_4\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__1_n_5\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__1_n_6\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__1_n_7\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__2_n_0\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__2_n_1\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__2_n_2\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__2_n_3\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__2_n_4\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__2_n_5\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__2_n_6\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__2_n_7\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__3_n_0\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__3_n_1\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__3_n_2\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__3_n_3\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__3_n_4\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__3_n_5\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__3_n_6\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__3_n_7\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__4_n_0\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__4_n_1\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__4_n_2\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__4_n_3\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__4_n_4\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__4_n_5\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__4_n_6\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__4_n_7\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__5_n_0\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__5_n_1\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__5_n_2\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__5_n_3\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__5_n_4\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__5_n_5\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__5_n_6\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__5_n_7\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__6_n_0\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__6_n_1\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__6_n_2\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__6_n_3\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__6_n_4\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__6_n_5\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__6_n_6\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry__6_n_7\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry_n_0\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry_n_1\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry_n_2\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry_n_3\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry_n_4\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry_n_5\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry_n_6\ : STD_LOGIC;
  signal \result0_inferred__3/i__carry_n_7\ : STD_LOGIC;
  signal \result[0]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[0]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[10]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[10]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[11]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[11]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[11]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \result[11]_INST_0_i_5_n_1\ : STD_LOGIC;
  signal \result[11]_INST_0_i_5_n_2\ : STD_LOGIC;
  signal \result[11]_INST_0_i_5_n_3\ : STD_LOGIC;
  signal \result[11]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \result[11]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \result[11]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \result[11]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \result[12]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[12]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[13]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[13]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[14]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[14]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[15]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[15]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[15]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \result[15]_INST_0_i_5_n_1\ : STD_LOGIC;
  signal \result[15]_INST_0_i_5_n_2\ : STD_LOGIC;
  signal \result[15]_INST_0_i_5_n_3\ : STD_LOGIC;
  signal \result[15]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \result[15]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \result[15]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \result[15]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \result[16]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[16]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[17]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[17]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[18]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[18]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[19]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[19]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[19]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \result[19]_INST_0_i_5_n_1\ : STD_LOGIC;
  signal \result[19]_INST_0_i_5_n_2\ : STD_LOGIC;
  signal \result[19]_INST_0_i_5_n_3\ : STD_LOGIC;
  signal \result[19]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \result[19]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \result[19]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \result[19]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \result[1]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[1]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[20]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[20]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[21]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[21]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[22]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[22]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[23]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[23]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[23]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \result[23]_INST_0_i_5_n_1\ : STD_LOGIC;
  signal \result[23]_INST_0_i_5_n_2\ : STD_LOGIC;
  signal \result[23]_INST_0_i_5_n_3\ : STD_LOGIC;
  signal \result[23]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \result[23]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \result[23]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \result[23]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \result[24]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[24]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[25]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[25]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[26]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[26]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[27]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[27]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[27]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \result[27]_INST_0_i_5_n_1\ : STD_LOGIC;
  signal \result[27]_INST_0_i_5_n_2\ : STD_LOGIC;
  signal \result[27]_INST_0_i_5_n_3\ : STD_LOGIC;
  signal \result[27]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \result[27]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \result[27]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \result[27]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \result[28]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[28]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[29]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[29]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[2]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[2]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[30]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[30]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[3]_INST_0_i_10_n_0\ : STD_LOGIC;
  signal \result[3]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[3]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[3]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \result[3]_INST_0_i_5_n_1\ : STD_LOGIC;
  signal \result[3]_INST_0_i_5_n_2\ : STD_LOGIC;
  signal \result[3]_INST_0_i_5_n_3\ : STD_LOGIC;
  signal \result[3]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \result[3]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \result[3]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \result[4]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[4]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[5]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[5]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[6]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[6]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[7]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[7]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[7]_INST_0_i_5_n_0\ : STD_LOGIC;
  signal \result[7]_INST_0_i_5_n_1\ : STD_LOGIC;
  signal \result[7]_INST_0_i_5_n_2\ : STD_LOGIC;
  signal \result[7]_INST_0_i_5_n_3\ : STD_LOGIC;
  signal \result[7]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \result[7]_INST_0_i_7_n_0\ : STD_LOGIC;
  signal \result[7]_INST_0_i_8_n_0\ : STD_LOGIC;
  signal \result[7]_INST_0_i_9_n_0\ : STD_LOGIC;
  signal \result[8]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[8]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal \result[9]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \result[9]_INST_0_i_3_n_0\ : STD_LOGIC;
  signal result_0_sn_1 : STD_LOGIC;
  signal result_10_sn_1 : STD_LOGIC;
  signal result_11_sn_1 : STD_LOGIC;
  signal result_12_sn_1 : STD_LOGIC;
  signal result_13_sn_1 : STD_LOGIC;
  signal result_14_sn_1 : STD_LOGIC;
  signal result_15_sn_1 : STD_LOGIC;
  signal result_16_sn_1 : STD_LOGIC;
  signal result_17_sn_1 : STD_LOGIC;
  signal result_18_sn_1 : STD_LOGIC;
  signal result_19_sn_1 : STD_LOGIC;
  signal result_1_sn_1 : STD_LOGIC;
  signal result_20_sn_1 : STD_LOGIC;
  signal result_21_sn_1 : STD_LOGIC;
  signal result_22_sn_1 : STD_LOGIC;
  signal result_23_sn_1 : STD_LOGIC;
  signal result_24_sn_1 : STD_LOGIC;
  signal result_25_sn_1 : STD_LOGIC;
  signal result_26_sn_1 : STD_LOGIC;
  signal result_27_sn_1 : STD_LOGIC;
  signal result_28_sn_1 : STD_LOGIC;
  signal result_29_sn_1 : STD_LOGIC;
  signal result_2_sn_1 : STD_LOGIC;
  signal result_30_sn_1 : STD_LOGIC;
  signal result_3_sn_1 : STD_LOGIC;
  signal result_4_sn_1 : STD_LOGIC;
  signal result_5_sn_1 : STD_LOGIC;
  signal result_6_sn_1 : STD_LOGIC;
  signal result_7_sn_1 : STD_LOGIC;
  signal result_8_sn_1 : STD_LOGIC;
  signal result_9_sn_1 : STD_LOGIC;
  signal \NLW_NZCV[1]_INST_0_i_3_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_NZCV[1]_INST_0_i_3_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_result0_inferred__2/i__carry__7_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_result0_inferred__2/i__carry__7_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_result0_inferred__3/i__carry__7_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_result0_inferred__3/i__carry__7_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
begin
  CO(0) <= \^co\(0);
  NZCV(3 downto 0) <= \^nzcv\(3 downto 0);
  NZCV_0_sn_1 <= NZCV_0_sp_1;
  result(30 downto 0) <= \^result\(30 downto 0);
  result_0_sn_1 <= result_0_sp_1;
  result_10_sn_1 <= result_10_sp_1;
  result_11_sn_1 <= result_11_sp_1;
  result_12_sn_1 <= result_12_sp_1;
  result_13_sn_1 <= result_13_sp_1;
  result_14_sn_1 <= result_14_sp_1;
  result_15_sn_1 <= result_15_sp_1;
  result_16_sn_1 <= result_16_sp_1;
  result_17_sn_1 <= result_17_sp_1;
  result_18_sn_1 <= result_18_sp_1;
  result_19_sn_1 <= result_19_sp_1;
  result_1_sn_1 <= result_1_sp_1;
  result_20_sn_1 <= result_20_sp_1;
  result_21_sn_1 <= result_21_sp_1;
  result_22_sn_1 <= result_22_sp_1;
  result_23_sn_1 <= result_23_sp_1;
  result_24_sn_1 <= result_24_sp_1;
  result_25_sn_1 <= result_25_sp_1;
  result_26_sn_1 <= result_26_sp_1;
  result_27_sn_1 <= result_27_sp_1;
  result_28_sn_1 <= result_28_sp_1;
  result_29_sn_1 <= result_29_sp_1;
  result_2_sn_1 <= result_2_sp_1;
  result_30_sn_1 <= result_30_sp_1;
  result_3_sn_1 <= result_3_sp_1;
  result_4_sn_1 <= result_4_sp_1;
  result_5_sn_1 <= result_5_sp_1;
  result_6_sn_1 <= result_6_sp_1;
  result_7_sn_1 <= result_7_sp_1;
  result_8_sn_1 <= result_8_sp_1;
  result_9_sn_1 <= result_9_sp_1;
\NZCV[0]_INST_0\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"04A00A00"
    )
        port map (
      I0 => NZCV13_out,
      I1 => NZCV_0_sn_1,
      I2 => in1(31),
      I3 => \^nzcv\(3),
      I4 => in2(31),
      O => \^nzcv\(0)
    );
\NZCV[1]_INST_0\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1200"
    )
        port map (
      I0 => ALU_op(1),
      I1 => ALU_op(3),
      I2 => ALU_op(2),
      I3 => p_1_in(1),
      O => \^nzcv\(1)
    );
\NZCV[1]_INST_0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFA0CFCFAFA0C0C0"
    )
        port map (
      I0 => data3,
      I1 => data2,
      I2 => ALU_op(2),
      I3 => O(0),
      I4 => ALU_op(0),
      I5 => \^co\(0),
      O => p_1_in(1)
    );
\NZCV[1]_INST_0_i_3\: unisim.vcomponents.CARRY4
     port map (
      CI => \NZCV[3]_INST_0_i_7_n_0\,
      CO(3 downto 1) => \NLW_NZCV[1]_INST_0_i_3_CO_UNCONNECTED\(3 downto 1),
      CO(0) => \^co\(0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => \NLW_NZCV[1]_INST_0_i_3_O_UNCONNECTED\(3 downto 0),
      S(3 downto 0) => B"0001"
    );
\NZCV[2]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => \NZCV[2]_INST_0_i_1_n_0\,
      I1 => \NZCV[2]_INST_0_i_2_n_0\,
      I2 => \NZCV[2]_INST_0_i_3_n_0\,
      I3 => \NZCV[2]_INST_0_i_4_n_0\,
      I4 => \NZCV[2]_INST_0_i_5_n_0\,
      I5 => \NZCV[2]_INST_0_i_6_n_0\,
      O => \^nzcv\(2)
    );
\NZCV[2]_INST_0_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \^result\(22),
      I1 => \^result\(23),
      I2 => \^result\(20),
      I3 => \^result\(21),
      O => \NZCV[2]_INST_0_i_1_n_0\
    );
\NZCV[2]_INST_0_i_10\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFACCFA"
    )
        port map (
      I0 => \result[11]_INST_0_i_1_n_0\,
      I1 => \NZCV[2]_INST_0_i_6_2\,
      I2 => \result[10]_INST_0_i_1_n_0\,
      I3 => ALU_op(3),
      I4 => \NZCV[2]_INST_0_i_6_3\,
      O => \NZCV[2]_INST_0_i_10_n_0\
    );
\NZCV[2]_INST_0_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \^result\(18),
      I1 => \^result\(19),
      I2 => \^result\(16),
      I3 => \^result\(17),
      O => \NZCV[2]_INST_0_i_2_n_0\
    );
\NZCV[2]_INST_0_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \^nzcv\(3),
      I1 => \^result\(30),
      I2 => \^result\(28),
      I3 => \^result\(29),
      O => \NZCV[2]_INST_0_i_3_n_0\
    );
\NZCV[2]_INST_0_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \^result\(26),
      I1 => \^result\(27),
      I2 => \^result\(24),
      I3 => \^result\(25),
      O => \NZCV[2]_INST_0_i_4_n_0\
    );
\NZCV[2]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \^result\(5),
      I1 => \^result\(4),
      I2 => \^result\(7),
      I3 => \^result\(6),
      I4 => \NZCV[2]_INST_0_i_7_n_0\,
      I5 => \NZCV[2]_INST_0_i_8_n_0\,
      O => \NZCV[2]_INST_0_i_5_n_0\
    );
\NZCV[2]_INST_0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \^result\(13),
      I1 => \^result\(12),
      I2 => \^result\(15),
      I3 => \^result\(14),
      I4 => \NZCV[2]_INST_0_i_9_n_0\,
      I5 => \NZCV[2]_INST_0_i_10_n_0\,
      O => \NZCV[2]_INST_0_i_6_n_0\
    );
\NZCV[2]_INST_0_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFACCFA"
    )
        port map (
      I0 => \result[1]_INST_0_i_1_n_0\,
      I1 => \NZCV[2]_INST_0_i_5_0\,
      I2 => \result[0]_INST_0_i_1_n_0\,
      I3 => ALU_op(3),
      I4 => \NZCV[2]_INST_0_i_5_1\,
      O => \NZCV[2]_INST_0_i_7_n_0\
    );
\NZCV[2]_INST_0_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFACCFA"
    )
        port map (
      I0 => \result[3]_INST_0_i_1_n_0\,
      I1 => \NZCV[2]_INST_0_i_5_2\,
      I2 => \result[2]_INST_0_i_1_n_0\,
      I3 => ALU_op(3),
      I4 => \NZCV[2]_INST_0_i_5_3\,
      O => \NZCV[2]_INST_0_i_8_n_0\
    );
\NZCV[2]_INST_0_i_9\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFACCFA"
    )
        port map (
      I0 => \result[9]_INST_0_i_1_n_0\,
      I1 => \NZCV[2]_INST_0_i_6_0\,
      I2 => \result[8]_INST_0_i_1_n_0\,
      I3 => ALU_op(3),
      I4 => \NZCV[2]_INST_0_i_6_1\,
      O => \NZCV[2]_INST_0_i_9_n_0\
    );
\NZCV[3]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(31),
      I1 => in2(31),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \NZCV[3]_INST_0_i_3_n_0\,
      O => \^nzcv\(3)
    );
\NZCV[3]_INST_0_i_10\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(29),
      I1 => in2(29),
      O => \NZCV[3]_INST_0_i_10_n_0\
    );
\NZCV[3]_INST_0_i_11\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(28),
      I1 => in2(28),
      O => \NZCV[3]_INST_0_i_11_n_0\
    );
\NZCV[3]_INST_0_i_3\: unisim.vcomponents.MUXF7
     port map (
      I0 => \result[31]\,
      I1 => \NZCV[3]_INST_0_i_5_n_0\,
      O => \NZCV[3]_INST_0_i_3_n_0\,
      S => ALU_op(2)
    );
\NZCV[3]_INST_0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(31),
      I1 => in2(31),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__6_n_4\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__6_n_4\,
      O => \NZCV[3]_INST_0_i_5_n_0\
    );
\NZCV[3]_INST_0_i_7\: unisim.vcomponents.CARRY4
     port map (
      CI => \result[27]_INST_0_i_5_n_0\,
      CO(3) => \NZCV[3]_INST_0_i_7_n_0\,
      CO(2) => \NZCV[3]_INST_0_i_7_n_1\,
      CO(1) => \NZCV[3]_INST_0_i_7_n_2\,
      CO(0) => \NZCV[3]_INST_0_i_7_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => in1(31 downto 28),
      O(3 downto 0) => \in1[31]\(3 downto 0),
      S(3) => \NZCV[3]_INST_0_i_8_n_0\,
      S(2) => \NZCV[3]_INST_0_i_9_n_0\,
      S(1) => \NZCV[3]_INST_0_i_10_n_0\,
      S(0) => \NZCV[3]_INST_0_i_11_n_0\
    );
\NZCV[3]_INST_0_i_8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(31),
      I1 => in2(31),
      O => \NZCV[3]_INST_0_i_8_n_0\
    );
\NZCV[3]_INST_0_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(30),
      I1 => in2(30),
      O => \NZCV[3]_INST_0_i_9_n_0\
    );
\i__carry__0_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(7),
      I1 => in2(7),
      O => \i__carry__0_i_1_n_0\
    );
\i__carry__0_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(7),
      I1 => in2(7),
      O => \i__carry__0_i_1__0_n_0\
    );
\i__carry__0_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(6),
      I1 => in2(6),
      O => \i__carry__0_i_2_n_0\
    );
\i__carry__0_i_2__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(6),
      I1 => in2(6),
      O => \i__carry__0_i_2__0_n_0\
    );
\i__carry__0_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(5),
      I1 => in2(5),
      O => \i__carry__0_i_3_n_0\
    );
\i__carry__0_i_3__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(5),
      I1 => in2(5),
      O => \i__carry__0_i_3__0_n_0\
    );
\i__carry__0_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(4),
      I1 => in2(4),
      O => \i__carry__0_i_4_n_0\
    );
\i__carry__0_i_4__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(4),
      I1 => in2(4),
      O => \i__carry__0_i_4__0_n_0\
    );
\i__carry__1_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(11),
      I1 => in2(11),
      O => \i__carry__1_i_1_n_0\
    );
\i__carry__1_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(11),
      I1 => in2(11),
      O => \i__carry__1_i_1__0_n_0\
    );
\i__carry__1_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(10),
      I1 => in2(10),
      O => \i__carry__1_i_2_n_0\
    );
\i__carry__1_i_2__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(10),
      I1 => in2(10),
      O => \i__carry__1_i_2__0_n_0\
    );
\i__carry__1_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(9),
      I1 => in2(9),
      O => \i__carry__1_i_3_n_0\
    );
\i__carry__1_i_3__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(9),
      I1 => in2(9),
      O => \i__carry__1_i_3__0_n_0\
    );
\i__carry__1_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(8),
      I1 => in2(8),
      O => \i__carry__1_i_4_n_0\
    );
\i__carry__1_i_4__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(8),
      I1 => in2(8),
      O => \i__carry__1_i_4__0_n_0\
    );
\i__carry__2_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(15),
      I1 => in2(15),
      O => \i__carry__2_i_1_n_0\
    );
\i__carry__2_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(15),
      I1 => in2(15),
      O => \i__carry__2_i_1__0_n_0\
    );
\i__carry__2_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(14),
      I1 => in2(14),
      O => \i__carry__2_i_2_n_0\
    );
\i__carry__2_i_2__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(14),
      I1 => in2(14),
      O => \i__carry__2_i_2__0_n_0\
    );
\i__carry__2_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(13),
      I1 => in2(13),
      O => \i__carry__2_i_3_n_0\
    );
\i__carry__2_i_3__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(13),
      I1 => in2(13),
      O => \i__carry__2_i_3__0_n_0\
    );
\i__carry__2_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(12),
      I1 => in2(12),
      O => \i__carry__2_i_4_n_0\
    );
\i__carry__2_i_4__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(12),
      I1 => in2(12),
      O => \i__carry__2_i_4__0_n_0\
    );
\i__carry__3_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(19),
      I1 => in2(19),
      O => \i__carry__3_i_1_n_0\
    );
\i__carry__3_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(19),
      I1 => in2(19),
      O => \i__carry__3_i_1__0_n_0\
    );
\i__carry__3_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(18),
      I1 => in2(18),
      O => \i__carry__3_i_2_n_0\
    );
\i__carry__3_i_2__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(18),
      I1 => in2(18),
      O => \i__carry__3_i_2__0_n_0\
    );
\i__carry__3_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(17),
      I1 => in2(17),
      O => \i__carry__3_i_3_n_0\
    );
\i__carry__3_i_3__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(17),
      I1 => in2(17),
      O => \i__carry__3_i_3__0_n_0\
    );
\i__carry__3_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(16),
      I1 => in2(16),
      O => \i__carry__3_i_4_n_0\
    );
\i__carry__3_i_4__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(16),
      I1 => in2(16),
      O => \i__carry__3_i_4__0_n_0\
    );
\i__carry__4_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(23),
      I1 => in2(23),
      O => \i__carry__4_i_1_n_0\
    );
\i__carry__4_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(23),
      I1 => in2(23),
      O => \i__carry__4_i_1__0_n_0\
    );
\i__carry__4_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(22),
      I1 => in2(22),
      O => \i__carry__4_i_2_n_0\
    );
\i__carry__4_i_2__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(22),
      I1 => in2(22),
      O => \i__carry__4_i_2__0_n_0\
    );
\i__carry__4_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(21),
      I1 => in2(21),
      O => \i__carry__4_i_3_n_0\
    );
\i__carry__4_i_3__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(21),
      I1 => in2(21),
      O => \i__carry__4_i_3__0_n_0\
    );
\i__carry__4_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(20),
      I1 => in2(20),
      O => \i__carry__4_i_4_n_0\
    );
\i__carry__4_i_4__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(20),
      I1 => in2(20),
      O => \i__carry__4_i_4__0_n_0\
    );
\i__carry__5_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(27),
      I1 => in2(27),
      O => \i__carry__5_i_1_n_0\
    );
\i__carry__5_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(27),
      I1 => in2(27),
      O => \i__carry__5_i_1__0_n_0\
    );
\i__carry__5_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(26),
      I1 => in2(26),
      O => \i__carry__5_i_2_n_0\
    );
\i__carry__5_i_2__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(26),
      I1 => in2(26),
      O => \i__carry__5_i_2__0_n_0\
    );
\i__carry__5_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(25),
      I1 => in2(25),
      O => \i__carry__5_i_3_n_0\
    );
\i__carry__5_i_3__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(25),
      I1 => in2(25),
      O => \i__carry__5_i_3__0_n_0\
    );
\i__carry__5_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(24),
      I1 => in2(24),
      O => \i__carry__5_i_4_n_0\
    );
\i__carry__5_i_4__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(24),
      I1 => in2(24),
      O => \i__carry__5_i_4__0_n_0\
    );
\i__carry__6_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(31),
      I1 => in2(31),
      O => \i__carry__6_i_1_n_0\
    );
\i__carry__6_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(31),
      I1 => in2(31),
      O => \i__carry__6_i_1__0_n_0\
    );
\i__carry__6_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(30),
      I1 => in2(30),
      O => \i__carry__6_i_2_n_0\
    );
\i__carry__6_i_2__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(30),
      I1 => in2(30),
      O => \i__carry__6_i_2__0_n_0\
    );
\i__carry__6_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(29),
      I1 => in2(29),
      O => \i__carry__6_i_3_n_0\
    );
\i__carry__6_i_3__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(29),
      I1 => in2(29),
      O => \i__carry__6_i_3__0_n_0\
    );
\i__carry__6_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(28),
      I1 => in2(28),
      O => \i__carry__6_i_4_n_0\
    );
\i__carry__6_i_4__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(28),
      I1 => in2(28),
      O => \i__carry__6_i_4__0_n_0\
    );
\i__carry_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => in2(0),
      O => p_0_in(0)
    );
\i__carry_i_1__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(3),
      I1 => in2(3),
      O => \i__carry_i_1__0_n_0\
    );
\i__carry_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(3),
      I1 => in2(3),
      O => \i__carry_i_2_n_0\
    );
\i__carry_i_2__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(2),
      I1 => in2(2),
      O => \i__carry_i_2__0_n_0\
    );
\i__carry_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(2),
      I1 => in2(2),
      O => \i__carry_i_3_n_0\
    );
\i__carry_i_3__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(1),
      I1 => in2(1),
      O => \i__carry_i_3__0_n_0\
    );
\i__carry_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(0),
      I1 => in2(0),
      O => \i__carry_i_4_n_0\
    );
\i__carry_i_4__0\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"9"
    )
        port map (
      I0 => in1(1),
      I1 => in2(1),
      O => \i__carry_i_4__0_n_0\
    );
\i__carry_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(0),
      I1 => carry_in,
      O => \i__carry_i_5_n_0\
    );
\result0_inferred__2/i__carry\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \result0_inferred__2/i__carry_n_0\,
      CO(2) => \result0_inferred__2/i__carry_n_1\,
      CO(1) => \result0_inferred__2/i__carry_n_2\,
      CO(0) => \result0_inferred__2/i__carry_n_3\,
      CYINIT => '1',
      DI(3 downto 0) => in1(3 downto 0),
      O(3) => \result0_inferred__2/i__carry_n_4\,
      O(2) => \result0_inferred__2/i__carry_n_5\,
      O(1) => \result0_inferred__2/i__carry_n_6\,
      O(0) => \result0_inferred__2/i__carry_n_7\,
      S(3) => \i__carry_i_1__0_n_0\,
      S(2) => \i__carry_i_2__0_n_0\,
      S(1) => \i__carry_i_3__0_n_0\,
      S(0) => \i__carry_i_4_n_0\
    );
\result0_inferred__2/i__carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => \result0_inferred__2/i__carry_n_0\,
      CO(3) => \result0_inferred__2/i__carry__0_n_0\,
      CO(2) => \result0_inferred__2/i__carry__0_n_1\,
      CO(1) => \result0_inferred__2/i__carry__0_n_2\,
      CO(0) => \result0_inferred__2/i__carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => in1(7 downto 4),
      O(3) => \result0_inferred__2/i__carry__0_n_4\,
      O(2) => \result0_inferred__2/i__carry__0_n_5\,
      O(1) => \result0_inferred__2/i__carry__0_n_6\,
      O(0) => \result0_inferred__2/i__carry__0_n_7\,
      S(3) => \i__carry__0_i_1__0_n_0\,
      S(2) => \i__carry__0_i_2__0_n_0\,
      S(1) => \i__carry__0_i_3__0_n_0\,
      S(0) => \i__carry__0_i_4__0_n_0\
    );
\result0_inferred__2/i__carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \result0_inferred__2/i__carry__0_n_0\,
      CO(3) => \result0_inferred__2/i__carry__1_n_0\,
      CO(2) => \result0_inferred__2/i__carry__1_n_1\,
      CO(1) => \result0_inferred__2/i__carry__1_n_2\,
      CO(0) => \result0_inferred__2/i__carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => in1(11 downto 8),
      O(3) => \result0_inferred__2/i__carry__1_n_4\,
      O(2) => \result0_inferred__2/i__carry__1_n_5\,
      O(1) => \result0_inferred__2/i__carry__1_n_6\,
      O(0) => \result0_inferred__2/i__carry__1_n_7\,
      S(3) => \i__carry__1_i_1__0_n_0\,
      S(2) => \i__carry__1_i_2__0_n_0\,
      S(1) => \i__carry__1_i_3__0_n_0\,
      S(0) => \i__carry__1_i_4__0_n_0\
    );
\result0_inferred__2/i__carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \result0_inferred__2/i__carry__1_n_0\,
      CO(3) => \result0_inferred__2/i__carry__2_n_0\,
      CO(2) => \result0_inferred__2/i__carry__2_n_1\,
      CO(1) => \result0_inferred__2/i__carry__2_n_2\,
      CO(0) => \result0_inferred__2/i__carry__2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => in1(15 downto 12),
      O(3) => \result0_inferred__2/i__carry__2_n_4\,
      O(2) => \result0_inferred__2/i__carry__2_n_5\,
      O(1) => \result0_inferred__2/i__carry__2_n_6\,
      O(0) => \result0_inferred__2/i__carry__2_n_7\,
      S(3) => \i__carry__2_i_1__0_n_0\,
      S(2) => \i__carry__2_i_2__0_n_0\,
      S(1) => \i__carry__2_i_3__0_n_0\,
      S(0) => \i__carry__2_i_4__0_n_0\
    );
\result0_inferred__2/i__carry__3\: unisim.vcomponents.CARRY4
     port map (
      CI => \result0_inferred__2/i__carry__2_n_0\,
      CO(3) => \result0_inferred__2/i__carry__3_n_0\,
      CO(2) => \result0_inferred__2/i__carry__3_n_1\,
      CO(1) => \result0_inferred__2/i__carry__3_n_2\,
      CO(0) => \result0_inferred__2/i__carry__3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => in1(19 downto 16),
      O(3) => \result0_inferred__2/i__carry__3_n_4\,
      O(2) => \result0_inferred__2/i__carry__3_n_5\,
      O(1) => \result0_inferred__2/i__carry__3_n_6\,
      O(0) => \result0_inferred__2/i__carry__3_n_7\,
      S(3) => \i__carry__3_i_1__0_n_0\,
      S(2) => \i__carry__3_i_2__0_n_0\,
      S(1) => \i__carry__3_i_3__0_n_0\,
      S(0) => \i__carry__3_i_4__0_n_0\
    );
\result0_inferred__2/i__carry__4\: unisim.vcomponents.CARRY4
     port map (
      CI => \result0_inferred__2/i__carry__3_n_0\,
      CO(3) => \result0_inferred__2/i__carry__4_n_0\,
      CO(2) => \result0_inferred__2/i__carry__4_n_1\,
      CO(1) => \result0_inferred__2/i__carry__4_n_2\,
      CO(0) => \result0_inferred__2/i__carry__4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => in1(23 downto 20),
      O(3) => \result0_inferred__2/i__carry__4_n_4\,
      O(2) => \result0_inferred__2/i__carry__4_n_5\,
      O(1) => \result0_inferred__2/i__carry__4_n_6\,
      O(0) => \result0_inferred__2/i__carry__4_n_7\,
      S(3) => \i__carry__4_i_1__0_n_0\,
      S(2) => \i__carry__4_i_2__0_n_0\,
      S(1) => \i__carry__4_i_3__0_n_0\,
      S(0) => \i__carry__4_i_4__0_n_0\
    );
\result0_inferred__2/i__carry__5\: unisim.vcomponents.CARRY4
     port map (
      CI => \result0_inferred__2/i__carry__4_n_0\,
      CO(3) => \result0_inferred__2/i__carry__5_n_0\,
      CO(2) => \result0_inferred__2/i__carry__5_n_1\,
      CO(1) => \result0_inferred__2/i__carry__5_n_2\,
      CO(0) => \result0_inferred__2/i__carry__5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => in1(27 downto 24),
      O(3) => \result0_inferred__2/i__carry__5_n_4\,
      O(2) => \result0_inferred__2/i__carry__5_n_5\,
      O(1) => \result0_inferred__2/i__carry__5_n_6\,
      O(0) => \result0_inferred__2/i__carry__5_n_7\,
      S(3) => \i__carry__5_i_1__0_n_0\,
      S(2) => \i__carry__5_i_2__0_n_0\,
      S(1) => \i__carry__5_i_3__0_n_0\,
      S(0) => \i__carry__5_i_4__0_n_0\
    );
\result0_inferred__2/i__carry__6\: unisim.vcomponents.CARRY4
     port map (
      CI => \result0_inferred__2/i__carry__5_n_0\,
      CO(3) => \result0_inferred__2/i__carry__6_n_0\,
      CO(2) => \result0_inferred__2/i__carry__6_n_1\,
      CO(1) => \result0_inferred__2/i__carry__6_n_2\,
      CO(0) => \result0_inferred__2/i__carry__6_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => in1(31 downto 28),
      O(3) => \result0_inferred__2/i__carry__6_n_4\,
      O(2) => \result0_inferred__2/i__carry__6_n_5\,
      O(1) => \result0_inferred__2/i__carry__6_n_6\,
      O(0) => \result0_inferred__2/i__carry__6_n_7\,
      S(3) => \i__carry__6_i_1__0_n_0\,
      S(2) => \i__carry__6_i_2__0_n_0\,
      S(1) => \i__carry__6_i_3__0_n_0\,
      S(0) => \i__carry__6_i_4__0_n_0\
    );
\result0_inferred__2/i__carry__7\: unisim.vcomponents.CARRY4
     port map (
      CI => \result0_inferred__2/i__carry__6_n_0\,
      CO(3 downto 0) => \NLW_result0_inferred__2/i__carry__7_CO_UNCONNECTED\(3 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 1) => \NLW_result0_inferred__2/i__carry__7_O_UNCONNECTED\(3 downto 1),
      O(0) => data2,
      S(3 downto 0) => B"0001"
    );
\result0_inferred__3/i__carry\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \result0_inferred__3/i__carry_n_0\,
      CO(2) => \result0_inferred__3/i__carry_n_1\,
      CO(1) => \result0_inferred__3/i__carry_n_2\,
      CO(0) => \result0_inferred__3/i__carry_n_3\,
      CYINIT => p_0_in(0),
      DI(3 downto 0) => in1(3 downto 0),
      O(3) => \result0_inferred__3/i__carry_n_4\,
      O(2) => \result0_inferred__3/i__carry_n_5\,
      O(1) => \result0_inferred__3/i__carry_n_6\,
      O(0) => \result0_inferred__3/i__carry_n_7\,
      S(3) => \i__carry_i_2_n_0\,
      S(2) => \i__carry_i_3_n_0\,
      S(1) => \i__carry_i_4__0_n_0\,
      S(0) => \i__carry_i_5_n_0\
    );
\result0_inferred__3/i__carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => \result0_inferred__3/i__carry_n_0\,
      CO(3) => \result0_inferred__3/i__carry__0_n_0\,
      CO(2) => \result0_inferred__3/i__carry__0_n_1\,
      CO(1) => \result0_inferred__3/i__carry__0_n_2\,
      CO(0) => \result0_inferred__3/i__carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => in1(7 downto 4),
      O(3) => \result0_inferred__3/i__carry__0_n_4\,
      O(2) => \result0_inferred__3/i__carry__0_n_5\,
      O(1) => \result0_inferred__3/i__carry__0_n_6\,
      O(0) => \result0_inferred__3/i__carry__0_n_7\,
      S(3) => \i__carry__0_i_1_n_0\,
      S(2) => \i__carry__0_i_2_n_0\,
      S(1) => \i__carry__0_i_3_n_0\,
      S(0) => \i__carry__0_i_4_n_0\
    );
\result0_inferred__3/i__carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \result0_inferred__3/i__carry__0_n_0\,
      CO(3) => \result0_inferred__3/i__carry__1_n_0\,
      CO(2) => \result0_inferred__3/i__carry__1_n_1\,
      CO(1) => \result0_inferred__3/i__carry__1_n_2\,
      CO(0) => \result0_inferred__3/i__carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => in1(11 downto 8),
      O(3) => \result0_inferred__3/i__carry__1_n_4\,
      O(2) => \result0_inferred__3/i__carry__1_n_5\,
      O(1) => \result0_inferred__3/i__carry__1_n_6\,
      O(0) => \result0_inferred__3/i__carry__1_n_7\,
      S(3) => \i__carry__1_i_1_n_0\,
      S(2) => \i__carry__1_i_2_n_0\,
      S(1) => \i__carry__1_i_3_n_0\,
      S(0) => \i__carry__1_i_4_n_0\
    );
\result0_inferred__3/i__carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \result0_inferred__3/i__carry__1_n_0\,
      CO(3) => \result0_inferred__3/i__carry__2_n_0\,
      CO(2) => \result0_inferred__3/i__carry__2_n_1\,
      CO(1) => \result0_inferred__3/i__carry__2_n_2\,
      CO(0) => \result0_inferred__3/i__carry__2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => in1(15 downto 12),
      O(3) => \result0_inferred__3/i__carry__2_n_4\,
      O(2) => \result0_inferred__3/i__carry__2_n_5\,
      O(1) => \result0_inferred__3/i__carry__2_n_6\,
      O(0) => \result0_inferred__3/i__carry__2_n_7\,
      S(3) => \i__carry__2_i_1_n_0\,
      S(2) => \i__carry__2_i_2_n_0\,
      S(1) => \i__carry__2_i_3_n_0\,
      S(0) => \i__carry__2_i_4_n_0\
    );
\result0_inferred__3/i__carry__3\: unisim.vcomponents.CARRY4
     port map (
      CI => \result0_inferred__3/i__carry__2_n_0\,
      CO(3) => \result0_inferred__3/i__carry__3_n_0\,
      CO(2) => \result0_inferred__3/i__carry__3_n_1\,
      CO(1) => \result0_inferred__3/i__carry__3_n_2\,
      CO(0) => \result0_inferred__3/i__carry__3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => in1(19 downto 16),
      O(3) => \result0_inferred__3/i__carry__3_n_4\,
      O(2) => \result0_inferred__3/i__carry__3_n_5\,
      O(1) => \result0_inferred__3/i__carry__3_n_6\,
      O(0) => \result0_inferred__3/i__carry__3_n_7\,
      S(3) => \i__carry__3_i_1_n_0\,
      S(2) => \i__carry__3_i_2_n_0\,
      S(1) => \i__carry__3_i_3_n_0\,
      S(0) => \i__carry__3_i_4_n_0\
    );
\result0_inferred__3/i__carry__4\: unisim.vcomponents.CARRY4
     port map (
      CI => \result0_inferred__3/i__carry__3_n_0\,
      CO(3) => \result0_inferred__3/i__carry__4_n_0\,
      CO(2) => \result0_inferred__3/i__carry__4_n_1\,
      CO(1) => \result0_inferred__3/i__carry__4_n_2\,
      CO(0) => \result0_inferred__3/i__carry__4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => in1(23 downto 20),
      O(3) => \result0_inferred__3/i__carry__4_n_4\,
      O(2) => \result0_inferred__3/i__carry__4_n_5\,
      O(1) => \result0_inferred__3/i__carry__4_n_6\,
      O(0) => \result0_inferred__3/i__carry__4_n_7\,
      S(3) => \i__carry__4_i_1_n_0\,
      S(2) => \i__carry__4_i_2_n_0\,
      S(1) => \i__carry__4_i_3_n_0\,
      S(0) => \i__carry__4_i_4_n_0\
    );
\result0_inferred__3/i__carry__5\: unisim.vcomponents.CARRY4
     port map (
      CI => \result0_inferred__3/i__carry__4_n_0\,
      CO(3) => \result0_inferred__3/i__carry__5_n_0\,
      CO(2) => \result0_inferred__3/i__carry__5_n_1\,
      CO(1) => \result0_inferred__3/i__carry__5_n_2\,
      CO(0) => \result0_inferred__3/i__carry__5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => in1(27 downto 24),
      O(3) => \result0_inferred__3/i__carry__5_n_4\,
      O(2) => \result0_inferred__3/i__carry__5_n_5\,
      O(1) => \result0_inferred__3/i__carry__5_n_6\,
      O(0) => \result0_inferred__3/i__carry__5_n_7\,
      S(3) => \i__carry__5_i_1_n_0\,
      S(2) => \i__carry__5_i_2_n_0\,
      S(1) => \i__carry__5_i_3_n_0\,
      S(0) => \i__carry__5_i_4_n_0\
    );
\result0_inferred__3/i__carry__6\: unisim.vcomponents.CARRY4
     port map (
      CI => \result0_inferred__3/i__carry__5_n_0\,
      CO(3) => \result0_inferred__3/i__carry__6_n_0\,
      CO(2) => \result0_inferred__3/i__carry__6_n_1\,
      CO(1) => \result0_inferred__3/i__carry__6_n_2\,
      CO(0) => \result0_inferred__3/i__carry__6_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => in1(31 downto 28),
      O(3) => \result0_inferred__3/i__carry__6_n_4\,
      O(2) => \result0_inferred__3/i__carry__6_n_5\,
      O(1) => \result0_inferred__3/i__carry__6_n_6\,
      O(0) => \result0_inferred__3/i__carry__6_n_7\,
      S(3) => \i__carry__6_i_1_n_0\,
      S(2) => \i__carry__6_i_2_n_0\,
      S(1) => \i__carry__6_i_3_n_0\,
      S(0) => \i__carry__6_i_4_n_0\
    );
\result0_inferred__3/i__carry__7\: unisim.vcomponents.CARRY4
     port map (
      CI => \result0_inferred__3/i__carry__6_n_0\,
      CO(3 downto 0) => \NLW_result0_inferred__3/i__carry__7_CO_UNCONNECTED\(3 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 1) => \NLW_result0_inferred__3/i__carry__7_O_UNCONNECTED\(3 downto 1),
      O(0) => data3,
      S(3 downto 0) => B"0001"
    );
\result[0]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(0),
      I1 => in2(0),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[0]_INST_0_i_1_n_0\,
      O => \^result\(0)
    );
\result[0]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => \result[0]_1\,
      I1 => \result[0]_INST_0_i_3_n_0\,
      O => \result[0]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[0]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(0),
      I1 => in2(0),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry_n_7\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry_n_7\,
      O => \result[0]_INST_0_i_3_n_0\
    );
\result[10]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(10),
      I1 => in2(10),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[10]_INST_0_i_1_n_0\,
      O => \^result\(10)
    );
\result[10]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_10_sn_1,
      I1 => \result[10]_INST_0_i_3_n_0\,
      O => \result[10]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[10]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(10),
      I1 => in2(10),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__1_n_5\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__1_n_5\,
      O => \result[10]_INST_0_i_3_n_0\
    );
\result[11]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(11),
      I1 => in2(11),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[11]_INST_0_i_1_n_0\,
      O => \^result\(11)
    );
\result[11]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_11_sn_1,
      I1 => \result[11]_INST_0_i_3_n_0\,
      O => \result[11]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[11]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(11),
      I1 => in2(11),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__1_n_4\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__1_n_4\,
      O => \result[11]_INST_0_i_3_n_0\
    );
\result[11]_INST_0_i_5\: unisim.vcomponents.CARRY4
     port map (
      CI => \result[7]_INST_0_i_5_n_0\,
      CO(3) => \result[11]_INST_0_i_5_n_0\,
      CO(2) => \result[11]_INST_0_i_5_n_1\,
      CO(1) => \result[11]_INST_0_i_5_n_2\,
      CO(0) => \result[11]_INST_0_i_5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => in1(11 downto 8),
      O(3 downto 0) => \in1[11]\(3 downto 0),
      S(3) => \result[11]_INST_0_i_6_n_0\,
      S(2) => \result[11]_INST_0_i_7_n_0\,
      S(1) => \result[11]_INST_0_i_8_n_0\,
      S(0) => \result[11]_INST_0_i_9_n_0\
    );
\result[11]_INST_0_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(11),
      I1 => in2(11),
      O => \result[11]_INST_0_i_6_n_0\
    );
\result[11]_INST_0_i_7\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(10),
      I1 => in2(10),
      O => \result[11]_INST_0_i_7_n_0\
    );
\result[11]_INST_0_i_8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(9),
      I1 => in2(9),
      O => \result[11]_INST_0_i_8_n_0\
    );
\result[11]_INST_0_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(8),
      I1 => in2(8),
      O => \result[11]_INST_0_i_9_n_0\
    );
\result[12]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(12),
      I1 => in2(12),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[12]_INST_0_i_1_n_0\,
      O => \^result\(12)
    );
\result[12]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_12_sn_1,
      I1 => \result[12]_INST_0_i_3_n_0\,
      O => \result[12]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[12]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(12),
      I1 => in2(12),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__2_n_7\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__2_n_7\,
      O => \result[12]_INST_0_i_3_n_0\
    );
\result[13]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(13),
      I1 => in2(13),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[13]_INST_0_i_1_n_0\,
      O => \^result\(13)
    );
\result[13]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_13_sn_1,
      I1 => \result[13]_INST_0_i_3_n_0\,
      O => \result[13]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[13]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(13),
      I1 => in2(13),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__2_n_6\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__2_n_6\,
      O => \result[13]_INST_0_i_3_n_0\
    );
\result[14]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(14),
      I1 => in2(14),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[14]_INST_0_i_1_n_0\,
      O => \^result\(14)
    );
\result[14]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_14_sn_1,
      I1 => \result[14]_INST_0_i_3_n_0\,
      O => \result[14]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[14]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(14),
      I1 => in2(14),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__2_n_5\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__2_n_5\,
      O => \result[14]_INST_0_i_3_n_0\
    );
\result[15]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(15),
      I1 => in2(15),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[15]_INST_0_i_1_n_0\,
      O => \^result\(15)
    );
\result[15]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_15_sn_1,
      I1 => \result[15]_INST_0_i_3_n_0\,
      O => \result[15]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[15]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(15),
      I1 => in2(15),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__2_n_4\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__2_n_4\,
      O => \result[15]_INST_0_i_3_n_0\
    );
\result[15]_INST_0_i_5\: unisim.vcomponents.CARRY4
     port map (
      CI => \result[11]_INST_0_i_5_n_0\,
      CO(3) => \result[15]_INST_0_i_5_n_0\,
      CO(2) => \result[15]_INST_0_i_5_n_1\,
      CO(1) => \result[15]_INST_0_i_5_n_2\,
      CO(0) => \result[15]_INST_0_i_5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => in1(15 downto 12),
      O(3 downto 0) => \in1[15]\(3 downto 0),
      S(3) => \result[15]_INST_0_i_6_n_0\,
      S(2) => \result[15]_INST_0_i_7_n_0\,
      S(1) => \result[15]_INST_0_i_8_n_0\,
      S(0) => \result[15]_INST_0_i_9_n_0\
    );
\result[15]_INST_0_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(15),
      I1 => in2(15),
      O => \result[15]_INST_0_i_6_n_0\
    );
\result[15]_INST_0_i_7\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(14),
      I1 => in2(14),
      O => \result[15]_INST_0_i_7_n_0\
    );
\result[15]_INST_0_i_8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(13),
      I1 => in2(13),
      O => \result[15]_INST_0_i_8_n_0\
    );
\result[15]_INST_0_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(12),
      I1 => in2(12),
      O => \result[15]_INST_0_i_9_n_0\
    );
\result[16]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(16),
      I1 => in2(16),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[16]_INST_0_i_1_n_0\,
      O => \^result\(16)
    );
\result[16]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_16_sn_1,
      I1 => \result[16]_INST_0_i_3_n_0\,
      O => \result[16]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[16]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(16),
      I1 => in2(16),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__3_n_7\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__3_n_7\,
      O => \result[16]_INST_0_i_3_n_0\
    );
\result[17]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(17),
      I1 => in2(17),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[17]_INST_0_i_1_n_0\,
      O => \^result\(17)
    );
\result[17]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_17_sn_1,
      I1 => \result[17]_INST_0_i_3_n_0\,
      O => \result[17]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[17]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(17),
      I1 => in2(17),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__3_n_6\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__3_n_6\,
      O => \result[17]_INST_0_i_3_n_0\
    );
\result[18]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(18),
      I1 => in2(18),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[18]_INST_0_i_1_n_0\,
      O => \^result\(18)
    );
\result[18]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_18_sn_1,
      I1 => \result[18]_INST_0_i_3_n_0\,
      O => \result[18]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[18]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(18),
      I1 => in2(18),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__3_n_5\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__3_n_5\,
      O => \result[18]_INST_0_i_3_n_0\
    );
\result[19]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(19),
      I1 => in2(19),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[19]_INST_0_i_1_n_0\,
      O => \^result\(19)
    );
\result[19]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_19_sn_1,
      I1 => \result[19]_INST_0_i_3_n_0\,
      O => \result[19]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[19]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(19),
      I1 => in2(19),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__3_n_4\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__3_n_4\,
      O => \result[19]_INST_0_i_3_n_0\
    );
\result[19]_INST_0_i_5\: unisim.vcomponents.CARRY4
     port map (
      CI => \result[15]_INST_0_i_5_n_0\,
      CO(3) => \result[19]_INST_0_i_5_n_0\,
      CO(2) => \result[19]_INST_0_i_5_n_1\,
      CO(1) => \result[19]_INST_0_i_5_n_2\,
      CO(0) => \result[19]_INST_0_i_5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => in1(19 downto 16),
      O(3 downto 0) => \in1[19]\(3 downto 0),
      S(3) => \result[19]_INST_0_i_6_n_0\,
      S(2) => \result[19]_INST_0_i_7_n_0\,
      S(1) => \result[19]_INST_0_i_8_n_0\,
      S(0) => \result[19]_INST_0_i_9_n_0\
    );
\result[19]_INST_0_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(19),
      I1 => in2(19),
      O => \result[19]_INST_0_i_6_n_0\
    );
\result[19]_INST_0_i_7\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(18),
      I1 => in2(18),
      O => \result[19]_INST_0_i_7_n_0\
    );
\result[19]_INST_0_i_8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(17),
      I1 => in2(17),
      O => \result[19]_INST_0_i_8_n_0\
    );
\result[19]_INST_0_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(16),
      I1 => in2(16),
      O => \result[19]_INST_0_i_9_n_0\
    );
\result[1]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(1),
      I1 => in2(1),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[1]_INST_0_i_1_n_0\,
      O => \^result\(1)
    );
\result[1]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_1_sn_1,
      I1 => \result[1]_INST_0_i_3_n_0\,
      O => \result[1]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[1]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(1),
      I1 => in2(1),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry_n_6\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry_n_6\,
      O => \result[1]_INST_0_i_3_n_0\
    );
\result[20]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(20),
      I1 => in2(20),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[20]_INST_0_i_1_n_0\,
      O => \^result\(20)
    );
\result[20]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_20_sn_1,
      I1 => \result[20]_INST_0_i_3_n_0\,
      O => \result[20]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[20]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(20),
      I1 => in2(20),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__4_n_7\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__4_n_7\,
      O => \result[20]_INST_0_i_3_n_0\
    );
\result[21]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(21),
      I1 => in2(21),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[21]_INST_0_i_1_n_0\,
      O => \^result\(21)
    );
\result[21]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_21_sn_1,
      I1 => \result[21]_INST_0_i_3_n_0\,
      O => \result[21]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[21]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(21),
      I1 => in2(21),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__4_n_6\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__4_n_6\,
      O => \result[21]_INST_0_i_3_n_0\
    );
\result[22]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(22),
      I1 => in2(22),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[22]_INST_0_i_1_n_0\,
      O => \^result\(22)
    );
\result[22]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_22_sn_1,
      I1 => \result[22]_INST_0_i_3_n_0\,
      O => \result[22]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[22]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(22),
      I1 => in2(22),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__4_n_5\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__4_n_5\,
      O => \result[22]_INST_0_i_3_n_0\
    );
\result[23]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(23),
      I1 => in2(23),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[23]_INST_0_i_1_n_0\,
      O => \^result\(23)
    );
\result[23]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_23_sn_1,
      I1 => \result[23]_INST_0_i_3_n_0\,
      O => \result[23]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[23]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(23),
      I1 => in2(23),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__4_n_4\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__4_n_4\,
      O => \result[23]_INST_0_i_3_n_0\
    );
\result[23]_INST_0_i_5\: unisim.vcomponents.CARRY4
     port map (
      CI => \result[19]_INST_0_i_5_n_0\,
      CO(3) => \result[23]_INST_0_i_5_n_0\,
      CO(2) => \result[23]_INST_0_i_5_n_1\,
      CO(1) => \result[23]_INST_0_i_5_n_2\,
      CO(0) => \result[23]_INST_0_i_5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => in1(23 downto 20),
      O(3 downto 0) => \in1[23]\(3 downto 0),
      S(3) => \result[23]_INST_0_i_6_n_0\,
      S(2) => \result[23]_INST_0_i_7_n_0\,
      S(1) => \result[23]_INST_0_i_8_n_0\,
      S(0) => \result[23]_INST_0_i_9_n_0\
    );
\result[23]_INST_0_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(23),
      I1 => in2(23),
      O => \result[23]_INST_0_i_6_n_0\
    );
\result[23]_INST_0_i_7\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(22),
      I1 => in2(22),
      O => \result[23]_INST_0_i_7_n_0\
    );
\result[23]_INST_0_i_8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(21),
      I1 => in2(21),
      O => \result[23]_INST_0_i_8_n_0\
    );
\result[23]_INST_0_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(20),
      I1 => in2(20),
      O => \result[23]_INST_0_i_9_n_0\
    );
\result[24]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(24),
      I1 => in2(24),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[24]_INST_0_i_1_n_0\,
      O => \^result\(24)
    );
\result[24]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_24_sn_1,
      I1 => \result[24]_INST_0_i_3_n_0\,
      O => \result[24]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[24]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(24),
      I1 => in2(24),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__5_n_7\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__5_n_7\,
      O => \result[24]_INST_0_i_3_n_0\
    );
\result[25]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(25),
      I1 => in2(25),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[25]_INST_0_i_1_n_0\,
      O => \^result\(25)
    );
\result[25]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_25_sn_1,
      I1 => \result[25]_INST_0_i_3_n_0\,
      O => \result[25]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[25]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(25),
      I1 => in2(25),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__5_n_6\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__5_n_6\,
      O => \result[25]_INST_0_i_3_n_0\
    );
\result[26]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(26),
      I1 => in2(26),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[26]_INST_0_i_1_n_0\,
      O => \^result\(26)
    );
\result[26]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_26_sn_1,
      I1 => \result[26]_INST_0_i_3_n_0\,
      O => \result[26]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[26]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(26),
      I1 => in2(26),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__5_n_5\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__5_n_5\,
      O => \result[26]_INST_0_i_3_n_0\
    );
\result[27]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(27),
      I1 => in2(27),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[27]_INST_0_i_1_n_0\,
      O => \^result\(27)
    );
\result[27]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_27_sn_1,
      I1 => \result[27]_INST_0_i_3_n_0\,
      O => \result[27]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[27]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(27),
      I1 => in2(27),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__5_n_4\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__5_n_4\,
      O => \result[27]_INST_0_i_3_n_0\
    );
\result[27]_INST_0_i_5\: unisim.vcomponents.CARRY4
     port map (
      CI => \result[23]_INST_0_i_5_n_0\,
      CO(3) => \result[27]_INST_0_i_5_n_0\,
      CO(2) => \result[27]_INST_0_i_5_n_1\,
      CO(1) => \result[27]_INST_0_i_5_n_2\,
      CO(0) => \result[27]_INST_0_i_5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => in1(27 downto 24),
      O(3 downto 0) => \in1[27]\(3 downto 0),
      S(3) => \result[27]_INST_0_i_6_n_0\,
      S(2) => \result[27]_INST_0_i_7_n_0\,
      S(1) => \result[27]_INST_0_i_8_n_0\,
      S(0) => \result[27]_INST_0_i_9_n_0\
    );
\result[27]_INST_0_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(27),
      I1 => in2(27),
      O => \result[27]_INST_0_i_6_n_0\
    );
\result[27]_INST_0_i_7\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(26),
      I1 => in2(26),
      O => \result[27]_INST_0_i_7_n_0\
    );
\result[27]_INST_0_i_8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(25),
      I1 => in2(25),
      O => \result[27]_INST_0_i_8_n_0\
    );
\result[27]_INST_0_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(24),
      I1 => in2(24),
      O => \result[27]_INST_0_i_9_n_0\
    );
\result[28]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(28),
      I1 => in2(28),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[28]_INST_0_i_1_n_0\,
      O => \^result\(28)
    );
\result[28]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_28_sn_1,
      I1 => \result[28]_INST_0_i_3_n_0\,
      O => \result[28]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[28]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(28),
      I1 => in2(28),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__6_n_7\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__6_n_7\,
      O => \result[28]_INST_0_i_3_n_0\
    );
\result[29]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(29),
      I1 => in2(29),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[29]_INST_0_i_1_n_0\,
      O => \^result\(29)
    );
\result[29]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_29_sn_1,
      I1 => \result[29]_INST_0_i_3_n_0\,
      O => \result[29]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[29]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(29),
      I1 => in2(29),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__6_n_6\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__6_n_6\,
      O => \result[29]_INST_0_i_3_n_0\
    );
\result[2]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(2),
      I1 => in2(2),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[2]_INST_0_i_1_n_0\,
      O => \^result\(2)
    );
\result[2]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_2_sn_1,
      I1 => \result[2]_INST_0_i_3_n_0\,
      O => \result[2]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[2]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(2),
      I1 => in2(2),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry_n_5\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry_n_5\,
      O => \result[2]_INST_0_i_3_n_0\
    );
\result[30]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(30),
      I1 => in2(30),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[30]_INST_0_i_1_n_0\,
      O => \^result\(30)
    );
\result[30]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_30_sn_1,
      I1 => \result[30]_INST_0_i_3_n_0\,
      O => \result[30]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[30]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(30),
      I1 => in2(30),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__6_n_5\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__6_n_5\,
      O => \result[30]_INST_0_i_3_n_0\
    );
\result[3]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(3),
      I1 => in2(3),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[3]_INST_0_i_1_n_0\,
      O => \^result\(3)
    );
\result[3]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_3_sn_1,
      I1 => \result[3]_INST_0_i_3_n_0\,
      O => \result[3]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[3]_INST_0_i_10\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(0),
      I1 => in2(0),
      O => \result[3]_INST_0_i_10_n_0\
    );
\result[3]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(3),
      I1 => in2(3),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry_n_4\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry_n_4\,
      O => \result[3]_INST_0_i_3_n_0\
    );
\result[3]_INST_0_i_5\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \result[3]_INST_0_i_5_n_0\,
      CO(2) => \result[3]_INST_0_i_5_n_1\,
      CO(1) => \result[3]_INST_0_i_5_n_2\,
      CO(0) => \result[3]_INST_0_i_5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => in1(3 downto 0),
      O(3 downto 0) => \in1[3]\(3 downto 0),
      S(3) => \result[3]_INST_0_i_7_n_0\,
      S(2) => \result[3]_INST_0_i_8_n_0\,
      S(1) => \result[3]_INST_0_i_9_n_0\,
      S(0) => \result[3]_INST_0_i_10_n_0\
    );
\result[3]_INST_0_i_7\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(3),
      I1 => in2(3),
      O => \result[3]_INST_0_i_7_n_0\
    );
\result[3]_INST_0_i_8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(2),
      I1 => in2(2),
      O => \result[3]_INST_0_i_8_n_0\
    );
\result[3]_INST_0_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(1),
      I1 => in2(1),
      O => \result[3]_INST_0_i_9_n_0\
    );
\result[4]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(4),
      I1 => in2(4),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[4]_INST_0_i_1_n_0\,
      O => \^result\(4)
    );
\result[4]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_4_sn_1,
      I1 => \result[4]_INST_0_i_3_n_0\,
      O => \result[4]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[4]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(4),
      I1 => in2(4),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__0_n_7\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__0_n_7\,
      O => \result[4]_INST_0_i_3_n_0\
    );
\result[5]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(5),
      I1 => in2(5),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[5]_INST_0_i_1_n_0\,
      O => \^result\(5)
    );
\result[5]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_5_sn_1,
      I1 => \result[5]_INST_0_i_3_n_0\,
      O => \result[5]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[5]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(5),
      I1 => in2(5),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__0_n_6\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__0_n_6\,
      O => \result[5]_INST_0_i_3_n_0\
    );
\result[6]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(6),
      I1 => in2(6),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[6]_INST_0_i_1_n_0\,
      O => \^result\(6)
    );
\result[6]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_6_sn_1,
      I1 => \result[6]_INST_0_i_3_n_0\,
      O => \result[6]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[6]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(6),
      I1 => in2(6),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__0_n_5\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__0_n_5\,
      O => \result[6]_INST_0_i_3_n_0\
    );
\result[7]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(7),
      I1 => in2(7),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[7]_INST_0_i_1_n_0\,
      O => \^result\(7)
    );
\result[7]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_7_sn_1,
      I1 => \result[7]_INST_0_i_3_n_0\,
      O => \result[7]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[7]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(7),
      I1 => in2(7),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__0_n_4\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__0_n_4\,
      O => \result[7]_INST_0_i_3_n_0\
    );
\result[7]_INST_0_i_5\: unisim.vcomponents.CARRY4
     port map (
      CI => \result[3]_INST_0_i_5_n_0\,
      CO(3) => \result[7]_INST_0_i_5_n_0\,
      CO(2) => \result[7]_INST_0_i_5_n_1\,
      CO(1) => \result[7]_INST_0_i_5_n_2\,
      CO(0) => \result[7]_INST_0_i_5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => in1(7 downto 4),
      O(3 downto 0) => \in1[7]\(3 downto 0),
      S(3) => \result[7]_INST_0_i_6_n_0\,
      S(2) => \result[7]_INST_0_i_7_n_0\,
      S(1) => \result[7]_INST_0_i_8_n_0\,
      S(0) => \result[7]_INST_0_i_9_n_0\
    );
\result[7]_INST_0_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(7),
      I1 => in2(7),
      O => \result[7]_INST_0_i_6_n_0\
    );
\result[7]_INST_0_i_7\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(6),
      I1 => in2(6),
      O => \result[7]_INST_0_i_7_n_0\
    );
\result[7]_INST_0_i_8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(5),
      I1 => in2(5),
      O => \result[7]_INST_0_i_8_n_0\
    );
\result[7]_INST_0_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => in1(4),
      I1 => in2(4),
      O => \result[7]_INST_0_i_9_n_0\
    );
\result[8]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(8),
      I1 => in2(8),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[8]_INST_0_i_1_n_0\,
      O => \^result\(8)
    );
\result[8]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_8_sn_1,
      I1 => \result[8]_INST_0_i_3_n_0\,
      O => \result[8]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[8]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(8),
      I1 => in2(8),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__1_n_7\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__1_n_7\,
      O => \result[8]_INST_0_i_3_n_0\
    );
\result[9]_INST_0\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0036FFFF00360000"
    )
        port map (
      I0 => in1(9),
      I1 => in2(9),
      I2 => result_0_sn_1,
      I3 => \result[0]_0\,
      I4 => ALU_op(3),
      I5 => \result[9]_INST_0_i_1_n_0\,
      O => \^result\(9)
    );
\result[9]_INST_0_i_1\: unisim.vcomponents.MUXF7
     port map (
      I0 => result_9_sn_1,
      I1 => \result[9]_INST_0_i_3_n_0\,
      O => \result[9]_INST_0_i_1_n_0\,
      S => ALU_op(2)
    );
\result[9]_INST_0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"EFE08F8FEFE08080"
    )
        port map (
      I0 => in1(9),
      I1 => in2(9),
      I2 => ALU_op(1),
      I3 => \result0_inferred__3/i__carry__1_n_6\,
      I4 => ALU_op(0),
      I5 => \result0_inferred__2/i__carry__1_n_6\,
      O => \result[9]_INST_0_i_3_n_0\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_2_ALU_0_0 is
  port (
    in1 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    in2 : in STD_LOGIC_VECTOR ( 31 downto 0 );
    carry_in : in STD_LOGIC;
    ALU_op : in STD_LOGIC_VECTOR ( 3 downto 0 );
    result : out STD_LOGIC_VECTOR ( 31 downto 0 );
    NZCV : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_2_ALU_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_2_ALU_0_0 : entity is "design_2_ALU_0_0,ALU,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_2_ALU_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_2_ALU_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_2_ALU_0_0 : entity is "ALU,Vivado 2018.3";
end design_2_ALU_0_0;

architecture STRUCTURE of design_2_ALU_0_0 is
  signal \^nzcv\ : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NZCV13_out : STD_LOGIC;
  signal \NZCV[0]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \NZCV[2]_INST_0_i_11_n_0\ : STD_LOGIC;
  signal \NZCV[2]_INST_0_i_12_n_0\ : STD_LOGIC;
  signal \NZCV[2]_INST_0_i_13_n_0\ : STD_LOGIC;
  signal \NZCV[2]_INST_0_i_14_n_0\ : STD_LOGIC;
  signal \NZCV[2]_INST_0_i_15_n_0\ : STD_LOGIC;
  signal \NZCV[2]_INST_0_i_16_n_0\ : STD_LOGIC;
  signal \NZCV[2]_INST_0_i_17_n_0\ : STD_LOGIC;
  signal \NZCV[2]_INST_0_i_18_n_0\ : STD_LOGIC;
  signal \NZCV[3]_INST_0_i_1_n_0\ : STD_LOGIC;
  signal \NZCV[3]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \NZCV[3]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \NZCV[3]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \NZCV[3]_INST_0_i_6_n_1\ : STD_LOGIC;
  signal \NZCV[3]_INST_0_i_6_n_2\ : STD_LOGIC;
  signal \NZCV[3]_INST_0_i_6_n_3\ : STD_LOGIC;
  signal \NZCV[3]_INST_0_i_6_n_4\ : STD_LOGIC;
  signal \NZCV[3]_INST_0_i_6_n_5\ : STD_LOGIC;
  signal \NZCV[3]_INST_0_i_6_n_6\ : STD_LOGIC;
  signal \NZCV[3]_INST_0_i_6_n_7\ : STD_LOGIC;
  signal data0 : STD_LOGIC;
  signal data1 : STD_LOGIC;
  signal inst_n_36 : STD_LOGIC;
  signal inst_n_37 : STD_LOGIC;
  signal inst_n_38 : STD_LOGIC;
  signal inst_n_39 : STD_LOGIC;
  signal inst_n_40 : STD_LOGIC;
  signal inst_n_41 : STD_LOGIC;
  signal inst_n_42 : STD_LOGIC;
  signal inst_n_43 : STD_LOGIC;
  signal inst_n_44 : STD_LOGIC;
  signal inst_n_45 : STD_LOGIC;
  signal inst_n_46 : STD_LOGIC;
  signal inst_n_47 : STD_LOGIC;
  signal inst_n_48 : STD_LOGIC;
  signal inst_n_49 : STD_LOGIC;
  signal inst_n_50 : STD_LOGIC;
  signal inst_n_51 : STD_LOGIC;
  signal inst_n_52 : STD_LOGIC;
  signal inst_n_53 : STD_LOGIC;
  signal inst_n_54 : STD_LOGIC;
  signal inst_n_55 : STD_LOGIC;
  signal inst_n_56 : STD_LOGIC;
  signal inst_n_57 : STD_LOGIC;
  signal inst_n_58 : STD_LOGIC;
  signal inst_n_59 : STD_LOGIC;
  signal inst_n_60 : STD_LOGIC;
  signal inst_n_61 : STD_LOGIC;
  signal inst_n_62 : STD_LOGIC;
  signal inst_n_63 : STD_LOGIC;
  signal inst_n_64 : STD_LOGIC;
  signal inst_n_65 : STD_LOGIC;
  signal inst_n_66 : STD_LOGIC;
  signal inst_n_67 : STD_LOGIC;
  signal \^result\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \result[0]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[10]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[11]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[11]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \result[11]_INST_0_i_4_n_1\ : STD_LOGIC;
  signal \result[11]_INST_0_i_4_n_2\ : STD_LOGIC;
  signal \result[11]_INST_0_i_4_n_3\ : STD_LOGIC;
  signal \result[11]_INST_0_i_4_n_4\ : STD_LOGIC;
  signal \result[11]_INST_0_i_4_n_5\ : STD_LOGIC;
  signal \result[11]_INST_0_i_4_n_6\ : STD_LOGIC;
  signal \result[11]_INST_0_i_4_n_7\ : STD_LOGIC;
  signal \result[12]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[13]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[14]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[15]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[15]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \result[15]_INST_0_i_4_n_1\ : STD_LOGIC;
  signal \result[15]_INST_0_i_4_n_2\ : STD_LOGIC;
  signal \result[15]_INST_0_i_4_n_3\ : STD_LOGIC;
  signal \result[15]_INST_0_i_4_n_4\ : STD_LOGIC;
  signal \result[15]_INST_0_i_4_n_5\ : STD_LOGIC;
  signal \result[15]_INST_0_i_4_n_6\ : STD_LOGIC;
  signal \result[15]_INST_0_i_4_n_7\ : STD_LOGIC;
  signal \result[16]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[17]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[18]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[19]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[19]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \result[19]_INST_0_i_4_n_1\ : STD_LOGIC;
  signal \result[19]_INST_0_i_4_n_2\ : STD_LOGIC;
  signal \result[19]_INST_0_i_4_n_3\ : STD_LOGIC;
  signal \result[19]_INST_0_i_4_n_4\ : STD_LOGIC;
  signal \result[19]_INST_0_i_4_n_5\ : STD_LOGIC;
  signal \result[19]_INST_0_i_4_n_6\ : STD_LOGIC;
  signal \result[19]_INST_0_i_4_n_7\ : STD_LOGIC;
  signal \result[1]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[20]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[21]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[22]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[23]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[23]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \result[23]_INST_0_i_4_n_1\ : STD_LOGIC;
  signal \result[23]_INST_0_i_4_n_2\ : STD_LOGIC;
  signal \result[23]_INST_0_i_4_n_3\ : STD_LOGIC;
  signal \result[23]_INST_0_i_4_n_4\ : STD_LOGIC;
  signal \result[23]_INST_0_i_4_n_5\ : STD_LOGIC;
  signal \result[23]_INST_0_i_4_n_6\ : STD_LOGIC;
  signal \result[23]_INST_0_i_4_n_7\ : STD_LOGIC;
  signal \result[24]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[25]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[26]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[27]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[27]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \result[27]_INST_0_i_4_n_1\ : STD_LOGIC;
  signal \result[27]_INST_0_i_4_n_2\ : STD_LOGIC;
  signal \result[27]_INST_0_i_4_n_3\ : STD_LOGIC;
  signal \result[27]_INST_0_i_4_n_4\ : STD_LOGIC;
  signal \result[27]_INST_0_i_4_n_5\ : STD_LOGIC;
  signal \result[27]_INST_0_i_4_n_6\ : STD_LOGIC;
  signal \result[27]_INST_0_i_4_n_7\ : STD_LOGIC;
  signal \result[28]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[29]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[2]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[30]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[3]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[3]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \result[3]_INST_0_i_4_n_1\ : STD_LOGIC;
  signal \result[3]_INST_0_i_4_n_2\ : STD_LOGIC;
  signal \result[3]_INST_0_i_4_n_3\ : STD_LOGIC;
  signal \result[3]_INST_0_i_4_n_4\ : STD_LOGIC;
  signal \result[3]_INST_0_i_4_n_5\ : STD_LOGIC;
  signal \result[3]_INST_0_i_4_n_6\ : STD_LOGIC;
  signal \result[3]_INST_0_i_4_n_7\ : STD_LOGIC;
  signal \result[3]_INST_0_i_6_n_0\ : STD_LOGIC;
  signal \result[4]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[5]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[6]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[7]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[7]_INST_0_i_4_n_0\ : STD_LOGIC;
  signal \result[7]_INST_0_i_4_n_1\ : STD_LOGIC;
  signal \result[7]_INST_0_i_4_n_2\ : STD_LOGIC;
  signal \result[7]_INST_0_i_4_n_3\ : STD_LOGIC;
  signal \result[7]_INST_0_i_4_n_4\ : STD_LOGIC;
  signal \result[7]_INST_0_i_4_n_5\ : STD_LOGIC;
  signal \result[7]_INST_0_i_4_n_6\ : STD_LOGIC;
  signal \result[7]_INST_0_i_4_n_7\ : STD_LOGIC;
  signal \result[8]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \result[9]_INST_0_i_2_n_0\ : STD_LOGIC;
  signal \NLW_NZCV[1]_INST_0_i_2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_NZCV[1]_INST_0_i_2_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \NZCV[0]_INST_0_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \NZCV[0]_INST_0_i_2\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \NZCV[2]_INST_0_i_14\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \NZCV[2]_INST_0_i_17\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \NZCV[3]_INST_0_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \NZCV[3]_INST_0_i_2\ : label is "soft_lutpair1";
begin
  NZCV(3) <= \^result\(31);
  NZCV(2 downto 0) <= \^nzcv\(2 downto 0);
  result(31 downto 0) <= \^result\(31 downto 0);
\NZCV[0]_INST_0_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
        port map (
      I0 => ALU_op(1),
      I1 => ALU_op(3),
      I2 => ALU_op(2),
      O => NZCV13_out
    );
\NZCV[0]_INST_0_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
        port map (
      I0 => ALU_op(2),
      I1 => ALU_op(3),
      I2 => ALU_op(1),
      O => \NZCV[0]_INST_0_i_2_n_0\
    );
\NZCV[1]_INST_0_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \NZCV[3]_INST_0_i_6_n_0\,
      CO(3 downto 0) => \NLW_NZCV[1]_INST_0_i_2_CO_UNCONNECTED\(3 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 1) => \NLW_NZCV[1]_INST_0_i_2_O_UNCONNECTED\(3 downto 1),
      O(0) => data1,
      S(3 downto 1) => B"000",
      S(0) => data0
    );
\NZCV[2]_INST_0_i_11\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000036"
    )
        port map (
      I0 => in1(1),
      I1 => in2(1),
      I2 => ALU_op(0),
      I3 => ALU_op(2),
      I4 => ALU_op(1),
      O => \NZCV[2]_INST_0_i_11_n_0\
    );
\NZCV[2]_INST_0_i_12\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000036"
    )
        port map (
      I0 => in1(0),
      I1 => in2(0),
      I2 => ALU_op(0),
      I3 => ALU_op(2),
      I4 => ALU_op(1),
      O => \NZCV[2]_INST_0_i_12_n_0\
    );
\NZCV[2]_INST_0_i_13\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000036"
    )
        port map (
      I0 => in1(3),
      I1 => in2(3),
      I2 => ALU_op(0),
      I3 => ALU_op(2),
      I4 => ALU_op(1),
      O => \NZCV[2]_INST_0_i_13_n_0\
    );
\NZCV[2]_INST_0_i_14\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000036"
    )
        port map (
      I0 => in1(2),
      I1 => in2(2),
      I2 => ALU_op(0),
      I3 => ALU_op(2),
      I4 => ALU_op(1),
      O => \NZCV[2]_INST_0_i_14_n_0\
    );
\NZCV[2]_INST_0_i_15\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000036"
    )
        port map (
      I0 => in1(9),
      I1 => in2(9),
      I2 => ALU_op(0),
      I3 => ALU_op(2),
      I4 => ALU_op(1),
      O => \NZCV[2]_INST_0_i_15_n_0\
    );
\NZCV[2]_INST_0_i_16\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000036"
    )
        port map (
      I0 => in1(8),
      I1 => in2(8),
      I2 => ALU_op(0),
      I3 => ALU_op(2),
      I4 => ALU_op(1),
      O => \NZCV[2]_INST_0_i_16_n_0\
    );
\NZCV[2]_INST_0_i_17\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000036"
    )
        port map (
      I0 => in1(11),
      I1 => in2(11),
      I2 => ALU_op(0),
      I3 => ALU_op(2),
      I4 => ALU_op(1),
      O => \NZCV[2]_INST_0_i_17_n_0\
    );
\NZCV[2]_INST_0_i_18\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000036"
    )
        port map (
      I0 => in1(10),
      I1 => in2(10),
      I2 => ALU_op(0),
      I3 => ALU_op(2),
      I4 => ALU_op(1),
      O => \NZCV[2]_INST_0_i_18_n_0\
    );
\NZCV[3]_INST_0_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BA"
    )
        port map (
      I0 => ALU_op(2),
      I1 => ALU_op(1),
      I2 => ALU_op(0),
      O => \NZCV[3]_INST_0_i_1_n_0\
    );
\NZCV[3]_INST_0_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => ALU_op(1),
      I1 => ALU_op(2),
      O => \NZCV[3]_INST_0_i_2_n_0\
    );
\NZCV[3]_INST_0_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \NZCV[3]_INST_0_i_6_n_4\,
      I1 => inst_n_64,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(31),
      O => \NZCV[3]_INST_0_i_4_n_0\
    );
\NZCV[3]_INST_0_i_6\: unisim.vcomponents.CARRY4
     port map (
      CI => \result[27]_INST_0_i_4_n_0\,
      CO(3) => \NZCV[3]_INST_0_i_6_n_0\,
      CO(2) => \NZCV[3]_INST_0_i_6_n_1\,
      CO(1) => \NZCV[3]_INST_0_i_6_n_2\,
      CO(0) => \NZCV[3]_INST_0_i_6_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NZCV[3]_INST_0_i_6_n_4\,
      O(2) => \NZCV[3]_INST_0_i_6_n_5\,
      O(1) => \NZCV[3]_INST_0_i_6_n_6\,
      O(0) => \NZCV[3]_INST_0_i_6_n_7\,
      S(3) => inst_n_64,
      S(2) => inst_n_65,
      S(1) => inst_n_66,
      S(0) => inst_n_67
    );
inst: entity work.design_2_ALU_0_0_ALU
     port map (
      ALU_op(3 downto 0) => ALU_op(3 downto 0),
      CO(0) => data0,
      NZCV(3) => \^result\(31),
      NZCV(2 downto 0) => \^nzcv\(2 downto 0),
      NZCV13_out => NZCV13_out,
      \NZCV[2]_INST_0_i_5_0\ => \NZCV[2]_INST_0_i_11_n_0\,
      \NZCV[2]_INST_0_i_5_1\ => \NZCV[2]_INST_0_i_12_n_0\,
      \NZCV[2]_INST_0_i_5_2\ => \NZCV[2]_INST_0_i_13_n_0\,
      \NZCV[2]_INST_0_i_5_3\ => \NZCV[2]_INST_0_i_14_n_0\,
      \NZCV[2]_INST_0_i_6_0\ => \NZCV[2]_INST_0_i_15_n_0\,
      \NZCV[2]_INST_0_i_6_1\ => \NZCV[2]_INST_0_i_16_n_0\,
      \NZCV[2]_INST_0_i_6_2\ => \NZCV[2]_INST_0_i_17_n_0\,
      \NZCV[2]_INST_0_i_6_3\ => \NZCV[2]_INST_0_i_18_n_0\,
      NZCV_0_sp_1 => \NZCV[0]_INST_0_i_2_n_0\,
      O(0) => data1,
      carry_in => carry_in,
      in1(31 downto 0) => in1(31 downto 0),
      \in1[11]\(3) => inst_n_44,
      \in1[11]\(2) => inst_n_45,
      \in1[11]\(1) => inst_n_46,
      \in1[11]\(0) => inst_n_47,
      \in1[15]\(3) => inst_n_48,
      \in1[15]\(2) => inst_n_49,
      \in1[15]\(1) => inst_n_50,
      \in1[15]\(0) => inst_n_51,
      \in1[19]\(3) => inst_n_52,
      \in1[19]\(2) => inst_n_53,
      \in1[19]\(1) => inst_n_54,
      \in1[19]\(0) => inst_n_55,
      \in1[23]\(3) => inst_n_56,
      \in1[23]\(2) => inst_n_57,
      \in1[23]\(1) => inst_n_58,
      \in1[23]\(0) => inst_n_59,
      \in1[27]\(3) => inst_n_60,
      \in1[27]\(2) => inst_n_61,
      \in1[27]\(1) => inst_n_62,
      \in1[27]\(0) => inst_n_63,
      \in1[31]\(3) => inst_n_64,
      \in1[31]\(2) => inst_n_65,
      \in1[31]\(1) => inst_n_66,
      \in1[31]\(0) => inst_n_67,
      \in1[3]\(3) => inst_n_36,
      \in1[3]\(2) => inst_n_37,
      \in1[3]\(1) => inst_n_38,
      \in1[3]\(0) => inst_n_39,
      \in1[7]\(3) => inst_n_40,
      \in1[7]\(2) => inst_n_41,
      \in1[7]\(1) => inst_n_42,
      \in1[7]\(0) => inst_n_43,
      in2(31 downto 0) => in2(31 downto 0),
      result(30 downto 0) => \^result\(30 downto 0),
      \result[0]_0\ => \NZCV[3]_INST_0_i_2_n_0\,
      \result[0]_1\ => \result[0]_INST_0_i_2_n_0\,
      \result[31]\ => \NZCV[3]_INST_0_i_4_n_0\,
      result_0_sp_1 => \NZCV[3]_INST_0_i_1_n_0\,
      result_10_sp_1 => \result[10]_INST_0_i_2_n_0\,
      result_11_sp_1 => \result[11]_INST_0_i_2_n_0\,
      result_12_sp_1 => \result[12]_INST_0_i_2_n_0\,
      result_13_sp_1 => \result[13]_INST_0_i_2_n_0\,
      result_14_sp_1 => \result[14]_INST_0_i_2_n_0\,
      result_15_sp_1 => \result[15]_INST_0_i_2_n_0\,
      result_16_sp_1 => \result[16]_INST_0_i_2_n_0\,
      result_17_sp_1 => \result[17]_INST_0_i_2_n_0\,
      result_18_sp_1 => \result[18]_INST_0_i_2_n_0\,
      result_19_sp_1 => \result[19]_INST_0_i_2_n_0\,
      result_1_sp_1 => \result[1]_INST_0_i_2_n_0\,
      result_20_sp_1 => \result[20]_INST_0_i_2_n_0\,
      result_21_sp_1 => \result[21]_INST_0_i_2_n_0\,
      result_22_sp_1 => \result[22]_INST_0_i_2_n_0\,
      result_23_sp_1 => \result[23]_INST_0_i_2_n_0\,
      result_24_sp_1 => \result[24]_INST_0_i_2_n_0\,
      result_25_sp_1 => \result[25]_INST_0_i_2_n_0\,
      result_26_sp_1 => \result[26]_INST_0_i_2_n_0\,
      result_27_sp_1 => \result[27]_INST_0_i_2_n_0\,
      result_28_sp_1 => \result[28]_INST_0_i_2_n_0\,
      result_29_sp_1 => \result[29]_INST_0_i_2_n_0\,
      result_2_sp_1 => \result[2]_INST_0_i_2_n_0\,
      result_30_sp_1 => \result[30]_INST_0_i_2_n_0\,
      result_3_sp_1 => \result[3]_INST_0_i_2_n_0\,
      result_4_sp_1 => \result[4]_INST_0_i_2_n_0\,
      result_5_sp_1 => \result[5]_INST_0_i_2_n_0\,
      result_6_sp_1 => \result[6]_INST_0_i_2_n_0\,
      result_7_sp_1 => \result[7]_INST_0_i_2_n_0\,
      result_8_sp_1 => \result[8]_INST_0_i_2_n_0\,
      result_9_sp_1 => \result[9]_INST_0_i_2_n_0\
    );
\result[0]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[3]_INST_0_i_4_n_7\,
      I1 => inst_n_39,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(0),
      O => \result[0]_INST_0_i_2_n_0\
    );
\result[10]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[11]_INST_0_i_4_n_5\,
      I1 => inst_n_45,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(10),
      O => \result[10]_INST_0_i_2_n_0\
    );
\result[11]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[11]_INST_0_i_4_n_4\,
      I1 => inst_n_44,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(11),
      O => \result[11]_INST_0_i_2_n_0\
    );
\result[11]_INST_0_i_4\: unisim.vcomponents.CARRY4
     port map (
      CI => \result[7]_INST_0_i_4_n_0\,
      CO(3) => \result[11]_INST_0_i_4_n_0\,
      CO(2) => \result[11]_INST_0_i_4_n_1\,
      CO(1) => \result[11]_INST_0_i_4_n_2\,
      CO(0) => \result[11]_INST_0_i_4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \result[11]_INST_0_i_4_n_4\,
      O(2) => \result[11]_INST_0_i_4_n_5\,
      O(1) => \result[11]_INST_0_i_4_n_6\,
      O(0) => \result[11]_INST_0_i_4_n_7\,
      S(3) => inst_n_44,
      S(2) => inst_n_45,
      S(1) => inst_n_46,
      S(0) => inst_n_47
    );
\result[12]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[15]_INST_0_i_4_n_7\,
      I1 => inst_n_51,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(12),
      O => \result[12]_INST_0_i_2_n_0\
    );
\result[13]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[15]_INST_0_i_4_n_6\,
      I1 => inst_n_50,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(13),
      O => \result[13]_INST_0_i_2_n_0\
    );
\result[14]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[15]_INST_0_i_4_n_5\,
      I1 => inst_n_49,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(14),
      O => \result[14]_INST_0_i_2_n_0\
    );
\result[15]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[15]_INST_0_i_4_n_4\,
      I1 => inst_n_48,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(15),
      O => \result[15]_INST_0_i_2_n_0\
    );
\result[15]_INST_0_i_4\: unisim.vcomponents.CARRY4
     port map (
      CI => \result[11]_INST_0_i_4_n_0\,
      CO(3) => \result[15]_INST_0_i_4_n_0\,
      CO(2) => \result[15]_INST_0_i_4_n_1\,
      CO(1) => \result[15]_INST_0_i_4_n_2\,
      CO(0) => \result[15]_INST_0_i_4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \result[15]_INST_0_i_4_n_4\,
      O(2) => \result[15]_INST_0_i_4_n_5\,
      O(1) => \result[15]_INST_0_i_4_n_6\,
      O(0) => \result[15]_INST_0_i_4_n_7\,
      S(3) => inst_n_48,
      S(2) => inst_n_49,
      S(1) => inst_n_50,
      S(0) => inst_n_51
    );
\result[16]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[19]_INST_0_i_4_n_7\,
      I1 => inst_n_55,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(16),
      O => \result[16]_INST_0_i_2_n_0\
    );
\result[17]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[19]_INST_0_i_4_n_6\,
      I1 => inst_n_54,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(17),
      O => \result[17]_INST_0_i_2_n_0\
    );
\result[18]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[19]_INST_0_i_4_n_5\,
      I1 => inst_n_53,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(18),
      O => \result[18]_INST_0_i_2_n_0\
    );
\result[19]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[19]_INST_0_i_4_n_4\,
      I1 => inst_n_52,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(19),
      O => \result[19]_INST_0_i_2_n_0\
    );
\result[19]_INST_0_i_4\: unisim.vcomponents.CARRY4
     port map (
      CI => \result[15]_INST_0_i_4_n_0\,
      CO(3) => \result[19]_INST_0_i_4_n_0\,
      CO(2) => \result[19]_INST_0_i_4_n_1\,
      CO(1) => \result[19]_INST_0_i_4_n_2\,
      CO(0) => \result[19]_INST_0_i_4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \result[19]_INST_0_i_4_n_4\,
      O(2) => \result[19]_INST_0_i_4_n_5\,
      O(1) => \result[19]_INST_0_i_4_n_6\,
      O(0) => \result[19]_INST_0_i_4_n_7\,
      S(3) => inst_n_52,
      S(2) => inst_n_53,
      S(1) => inst_n_54,
      S(0) => inst_n_55
    );
\result[1]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[3]_INST_0_i_4_n_6\,
      I1 => inst_n_38,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(1),
      O => \result[1]_INST_0_i_2_n_0\
    );
\result[20]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[23]_INST_0_i_4_n_7\,
      I1 => inst_n_59,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(20),
      O => \result[20]_INST_0_i_2_n_0\
    );
\result[21]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[23]_INST_0_i_4_n_6\,
      I1 => inst_n_58,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(21),
      O => \result[21]_INST_0_i_2_n_0\
    );
\result[22]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[23]_INST_0_i_4_n_5\,
      I1 => inst_n_57,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(22),
      O => \result[22]_INST_0_i_2_n_0\
    );
\result[23]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[23]_INST_0_i_4_n_4\,
      I1 => inst_n_56,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(23),
      O => \result[23]_INST_0_i_2_n_0\
    );
\result[23]_INST_0_i_4\: unisim.vcomponents.CARRY4
     port map (
      CI => \result[19]_INST_0_i_4_n_0\,
      CO(3) => \result[23]_INST_0_i_4_n_0\,
      CO(2) => \result[23]_INST_0_i_4_n_1\,
      CO(1) => \result[23]_INST_0_i_4_n_2\,
      CO(0) => \result[23]_INST_0_i_4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \result[23]_INST_0_i_4_n_4\,
      O(2) => \result[23]_INST_0_i_4_n_5\,
      O(1) => \result[23]_INST_0_i_4_n_6\,
      O(0) => \result[23]_INST_0_i_4_n_7\,
      S(3) => inst_n_56,
      S(2) => inst_n_57,
      S(1) => inst_n_58,
      S(0) => inst_n_59
    );
\result[24]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[27]_INST_0_i_4_n_7\,
      I1 => inst_n_63,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(24),
      O => \result[24]_INST_0_i_2_n_0\
    );
\result[25]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[27]_INST_0_i_4_n_6\,
      I1 => inst_n_62,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(25),
      O => \result[25]_INST_0_i_2_n_0\
    );
\result[26]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[27]_INST_0_i_4_n_5\,
      I1 => inst_n_61,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(26),
      O => \result[26]_INST_0_i_2_n_0\
    );
\result[27]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[27]_INST_0_i_4_n_4\,
      I1 => inst_n_60,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(27),
      O => \result[27]_INST_0_i_2_n_0\
    );
\result[27]_INST_0_i_4\: unisim.vcomponents.CARRY4
     port map (
      CI => \result[23]_INST_0_i_4_n_0\,
      CO(3) => \result[27]_INST_0_i_4_n_0\,
      CO(2) => \result[27]_INST_0_i_4_n_1\,
      CO(1) => \result[27]_INST_0_i_4_n_2\,
      CO(0) => \result[27]_INST_0_i_4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \result[27]_INST_0_i_4_n_4\,
      O(2) => \result[27]_INST_0_i_4_n_5\,
      O(1) => \result[27]_INST_0_i_4_n_6\,
      O(0) => \result[27]_INST_0_i_4_n_7\,
      S(3) => inst_n_60,
      S(2) => inst_n_61,
      S(1) => inst_n_62,
      S(0) => inst_n_63
    );
\result[28]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \NZCV[3]_INST_0_i_6_n_7\,
      I1 => inst_n_67,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(28),
      O => \result[28]_INST_0_i_2_n_0\
    );
\result[29]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \NZCV[3]_INST_0_i_6_n_6\,
      I1 => inst_n_66,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(29),
      O => \result[29]_INST_0_i_2_n_0\
    );
\result[2]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[3]_INST_0_i_4_n_5\,
      I1 => inst_n_37,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(2),
      O => \result[2]_INST_0_i_2_n_0\
    );
\result[30]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \NZCV[3]_INST_0_i_6_n_5\,
      I1 => inst_n_65,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(30),
      O => \result[30]_INST_0_i_2_n_0\
    );
\result[3]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[3]_INST_0_i_4_n_4\,
      I1 => inst_n_36,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(3),
      O => \result[3]_INST_0_i_2_n_0\
    );
\result[3]_INST_0_i_4\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \result[3]_INST_0_i_4_n_0\,
      CO(2) => \result[3]_INST_0_i_4_n_1\,
      CO(1) => \result[3]_INST_0_i_4_n_2\,
      CO(0) => \result[3]_INST_0_i_4_n_3\,
      CYINIT => '0',
      DI(3 downto 1) => B"000",
      DI(0) => inst_n_39,
      O(3) => \result[3]_INST_0_i_4_n_4\,
      O(2) => \result[3]_INST_0_i_4_n_5\,
      O(1) => \result[3]_INST_0_i_4_n_6\,
      O(0) => \result[3]_INST_0_i_4_n_7\,
      S(3) => inst_n_36,
      S(2) => inst_n_37,
      S(1) => inst_n_38,
      S(0) => \result[3]_INST_0_i_6_n_0\
    );
\result[3]_INST_0_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => inst_n_39,
      I1 => carry_in,
      O => \result[3]_INST_0_i_6_n_0\
    );
\result[4]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[7]_INST_0_i_4_n_7\,
      I1 => inst_n_43,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(4),
      O => \result[4]_INST_0_i_2_n_0\
    );
\result[5]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[7]_INST_0_i_4_n_6\,
      I1 => inst_n_42,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(5),
      O => \result[5]_INST_0_i_2_n_0\
    );
\result[6]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[7]_INST_0_i_4_n_5\,
      I1 => inst_n_41,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(6),
      O => \result[6]_INST_0_i_2_n_0\
    );
\result[7]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[7]_INST_0_i_4_n_4\,
      I1 => inst_n_40,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(7),
      O => \result[7]_INST_0_i_2_n_0\
    );
\result[7]_INST_0_i_4\: unisim.vcomponents.CARRY4
     port map (
      CI => \result[3]_INST_0_i_4_n_0\,
      CO(3) => \result[7]_INST_0_i_4_n_0\,
      CO(2) => \result[7]_INST_0_i_4_n_1\,
      CO(1) => \result[7]_INST_0_i_4_n_2\,
      CO(0) => \result[7]_INST_0_i_4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \result[7]_INST_0_i_4_n_4\,
      O(2) => \result[7]_INST_0_i_4_n_5\,
      O(1) => \result[7]_INST_0_i_4_n_6\,
      O(0) => \result[7]_INST_0_i_4_n_7\,
      S(3) => inst_n_40,
      S(2) => inst_n_41,
      S(1) => inst_n_42,
      S(0) => inst_n_43
    );
\result[8]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[11]_INST_0_i_4_n_7\,
      I1 => inst_n_47,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(8),
      O => \result[8]_INST_0_i_2_n_0\
    );
\result[9]_INST_0_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AFC0A0C0"
    )
        port map (
      I0 => \result[11]_INST_0_i_4_n_6\,
      I1 => inst_n_46,
      I2 => ALU_op(1),
      I3 => ALU_op(0),
      I4 => in2(9),
      O => \result[9]_INST_0_i_2_n_0\
    );
end STRUCTURE;
