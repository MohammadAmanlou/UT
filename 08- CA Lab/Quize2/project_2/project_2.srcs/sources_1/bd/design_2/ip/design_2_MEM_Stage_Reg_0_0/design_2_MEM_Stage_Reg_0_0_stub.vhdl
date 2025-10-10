-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun Apr 20 17:59:04 2025
-- Host        : Ariyan running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/ariya/ARM/ARM.srcs/sources_1/bd/design_2/ip/design_2_MEM_Stage_Reg_0_0/design_2_MEM_Stage_Reg_0_0_stub.vhdl
-- Design      : design_2_MEM_Stage_Reg_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_2_MEM_Stage_Reg_0_0 is
  Port ( 
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    WB_EN : in STD_LOGIC;
    MEM_R_EN : in STD_LOGIC;
    ALU_Res : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data_mem : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dest : in STD_LOGIC_VECTOR ( 3 downto 0 );
    WB_EN_out : out STD_LOGIC;
    MEM_R_EN_out : out STD_LOGIC;
    ALU_Res_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    data_mem_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    dest_out : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );

end design_2_MEM_Stage_Reg_0_0;

architecture stub of design_2_MEM_Stage_Reg_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,rst,WB_EN,MEM_R_EN,ALU_Res[31:0],data_mem[31:0],dest[3:0],WB_EN_out,MEM_R_EN_out,ALU_Res_out[31:0],data_mem_out[31:0],dest_out[3:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "MEM_Stage_Reg,Vivado 2018.3";
begin
end;
