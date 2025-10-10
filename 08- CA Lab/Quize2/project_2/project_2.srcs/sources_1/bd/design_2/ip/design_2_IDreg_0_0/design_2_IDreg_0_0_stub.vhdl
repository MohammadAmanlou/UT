-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun May 18 17:04:00 2025
-- Host        : Ariyan running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               C:/Users/ariya/OneDrive/Desktop/project_1/project_1/project_1.srcs/sources_1/bd/design_2/ip/design_2_IDreg_0_0/design_2_IDreg_0_0_stub.vhdl
-- Design      : design_2_IDreg_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_2_IDreg_0_0 is
  Port ( 
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

end design_2_IDreg_0_0;

architecture stub of design_2_IDreg_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,rst,flush,pc[31:0],WB_EN,MEM_R_EN,MEM_W_EN,EXE_CMD[3:0],B,S,Val_Rn[31:0],Val_Rm[31:0],imm,Shift_operand[11:0],Signed_imm_24[23:0],dest[3:0],status[3:0],src_1[3:0],src_2[3:0],pcOut[31:0],WB_EN_out,MEM_R_EN_out,MEM_W_EN_out,EXE_CMD_out[3:0],B_out,S_out,Val_Rn_out[31:0],Val_Rm_out[31:0],imm_out,Shift_operand_out[11:0],Signed_imm_24_out[23:0],dest_out[3:0],status_out[3:0],src_1_out[3:0],src_2_out[3:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "IDreg,Vivado 2018.3";
begin
end;
