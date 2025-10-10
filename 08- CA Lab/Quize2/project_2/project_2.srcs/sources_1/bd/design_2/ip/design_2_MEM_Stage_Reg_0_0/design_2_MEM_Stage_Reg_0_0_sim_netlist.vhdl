-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun Apr 20 17:59:04 2025
-- Host        : Ariyan running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/ariya/ARM/ARM.srcs/sources_1/bd/design_2/ip/design_2_MEM_Stage_Reg_0_0/design_2_MEM_Stage_Reg_0_0_sim_netlist.vhdl
-- Design      : design_2_MEM_Stage_Reg_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_2_MEM_Stage_Reg_0_0_MEM_Stage_Reg is
  port (
    WB_EN_out : out STD_LOGIC;
    MEM_R_EN_out : out STD_LOGIC;
    ALU_Res_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    data_mem_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    dest_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    WB_EN : in STD_LOGIC;
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    MEM_R_EN : in STD_LOGIC;
    ALU_Res : in STD_LOGIC_VECTOR ( 31 downto 0 );
    data_mem : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dest : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_2_MEM_Stage_Reg_0_0_MEM_Stage_Reg : entity is "MEM_Stage_Reg";
end design_2_MEM_Stage_Reg_0_0_MEM_Stage_Reg;

architecture STRUCTURE of design_2_MEM_Stage_Reg_0_0_MEM_Stage_Reg is
begin
\ALU_Res_out_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(0),
      Q => ALU_Res_out(0)
    );
\ALU_Res_out_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(10),
      Q => ALU_Res_out(10)
    );
\ALU_Res_out_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(11),
      Q => ALU_Res_out(11)
    );
\ALU_Res_out_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(12),
      Q => ALU_Res_out(12)
    );
\ALU_Res_out_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(13),
      Q => ALU_Res_out(13)
    );
\ALU_Res_out_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(14),
      Q => ALU_Res_out(14)
    );
\ALU_Res_out_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(15),
      Q => ALU_Res_out(15)
    );
\ALU_Res_out_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(16),
      Q => ALU_Res_out(16)
    );
\ALU_Res_out_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(17),
      Q => ALU_Res_out(17)
    );
\ALU_Res_out_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(18),
      Q => ALU_Res_out(18)
    );
\ALU_Res_out_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(19),
      Q => ALU_Res_out(19)
    );
\ALU_Res_out_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(1),
      Q => ALU_Res_out(1)
    );
\ALU_Res_out_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(20),
      Q => ALU_Res_out(20)
    );
\ALU_Res_out_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(21),
      Q => ALU_Res_out(21)
    );
\ALU_Res_out_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(22),
      Q => ALU_Res_out(22)
    );
\ALU_Res_out_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(23),
      Q => ALU_Res_out(23)
    );
\ALU_Res_out_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(24),
      Q => ALU_Res_out(24)
    );
\ALU_Res_out_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(25),
      Q => ALU_Res_out(25)
    );
\ALU_Res_out_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(26),
      Q => ALU_Res_out(26)
    );
\ALU_Res_out_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(27),
      Q => ALU_Res_out(27)
    );
\ALU_Res_out_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(28),
      Q => ALU_Res_out(28)
    );
\ALU_Res_out_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(29),
      Q => ALU_Res_out(29)
    );
\ALU_Res_out_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(2),
      Q => ALU_Res_out(2)
    );
\ALU_Res_out_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(30),
      Q => ALU_Res_out(30)
    );
\ALU_Res_out_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(31),
      Q => ALU_Res_out(31)
    );
\ALU_Res_out_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(3),
      Q => ALU_Res_out(3)
    );
\ALU_Res_out_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(4),
      Q => ALU_Res_out(4)
    );
\ALU_Res_out_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(5),
      Q => ALU_Res_out(5)
    );
\ALU_Res_out_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(6),
      Q => ALU_Res_out(6)
    );
\ALU_Res_out_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(7),
      Q => ALU_Res_out(7)
    );
\ALU_Res_out_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(8),
      Q => ALU_Res_out(8)
    );
\ALU_Res_out_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => ALU_Res(9),
      Q => ALU_Res_out(9)
    );
MEM_R_EN_out_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => MEM_R_EN,
      Q => MEM_R_EN_out
    );
WB_EN_out_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => WB_EN,
      Q => WB_EN_out
    );
\data_mem_out_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(0),
      Q => data_mem_out(0)
    );
\data_mem_out_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(10),
      Q => data_mem_out(10)
    );
\data_mem_out_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(11),
      Q => data_mem_out(11)
    );
\data_mem_out_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(12),
      Q => data_mem_out(12)
    );
\data_mem_out_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(13),
      Q => data_mem_out(13)
    );
\data_mem_out_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(14),
      Q => data_mem_out(14)
    );
\data_mem_out_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(15),
      Q => data_mem_out(15)
    );
\data_mem_out_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(16),
      Q => data_mem_out(16)
    );
\data_mem_out_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(17),
      Q => data_mem_out(17)
    );
\data_mem_out_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(18),
      Q => data_mem_out(18)
    );
\data_mem_out_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(19),
      Q => data_mem_out(19)
    );
\data_mem_out_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(1),
      Q => data_mem_out(1)
    );
\data_mem_out_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(20),
      Q => data_mem_out(20)
    );
\data_mem_out_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(21),
      Q => data_mem_out(21)
    );
\data_mem_out_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(22),
      Q => data_mem_out(22)
    );
\data_mem_out_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(23),
      Q => data_mem_out(23)
    );
\data_mem_out_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(24),
      Q => data_mem_out(24)
    );
\data_mem_out_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(25),
      Q => data_mem_out(25)
    );
\data_mem_out_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(26),
      Q => data_mem_out(26)
    );
\data_mem_out_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(27),
      Q => data_mem_out(27)
    );
\data_mem_out_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(28),
      Q => data_mem_out(28)
    );
\data_mem_out_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(29),
      Q => data_mem_out(29)
    );
\data_mem_out_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(2),
      Q => data_mem_out(2)
    );
\data_mem_out_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(30),
      Q => data_mem_out(30)
    );
\data_mem_out_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(31),
      Q => data_mem_out(31)
    );
\data_mem_out_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(3),
      Q => data_mem_out(3)
    );
\data_mem_out_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(4),
      Q => data_mem_out(4)
    );
\data_mem_out_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(5),
      Q => data_mem_out(5)
    );
\data_mem_out_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(6),
      Q => data_mem_out(6)
    );
\data_mem_out_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(7),
      Q => data_mem_out(7)
    );
\data_mem_out_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(8),
      Q => data_mem_out(8)
    );
\data_mem_out_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => data_mem(9),
      Q => data_mem_out(9)
    );
\dest_out_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => dest(0),
      Q => dest_out(0)
    );
\dest_out_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => dest(1),
      Q => dest_out(1)
    );
\dest_out_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => dest(2),
      Q => dest_out(2)
    );
\dest_out_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => dest(3),
      Q => dest_out(3)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_2_MEM_Stage_Reg_0_0 is
  port (
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
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_2_MEM_Stage_Reg_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_2_MEM_Stage_Reg_0_0 : entity is "design_2_MEM_Stage_Reg_0_0,MEM_Stage_Reg,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_2_MEM_Stage_Reg_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_2_MEM_Stage_Reg_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_2_MEM_Stage_Reg_0_0 : entity is "MEM_Stage_Reg,Vivado 2018.3";
end design_2_MEM_Stage_Reg_0_0;

architecture STRUCTURE of design_2_MEM_Stage_Reg_0_0 is
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN design_2_clk_0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of rst : signal is "xilinx.com:signal:reset:1.0 rst RST";
  attribute X_INTERFACE_PARAMETER of rst : signal is "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0";
begin
inst: entity work.design_2_MEM_Stage_Reg_0_0_MEM_Stage_Reg
     port map (
      ALU_Res(31 downto 0) => ALU_Res(31 downto 0),
      ALU_Res_out(31 downto 0) => ALU_Res_out(31 downto 0),
      MEM_R_EN => MEM_R_EN,
      MEM_R_EN_out => MEM_R_EN_out,
      WB_EN => WB_EN,
      WB_EN_out => WB_EN_out,
      clk => clk,
      data_mem(31 downto 0) => data_mem(31 downto 0),
      data_mem_out(31 downto 0) => data_mem_out(31 downto 0),
      dest(3 downto 0) => dest(3 downto 0),
      dest_out(3 downto 0) => dest_out(3 downto 0),
      rst => rst
    );
end STRUCTURE;
