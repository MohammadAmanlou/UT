-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
-- Date        : Sun Apr 20 17:26:21 2025
-- Host        : Ariyan running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/ariya/ARM/ARM.srcs/sources_1/bd/design_2/ip/design_2_ExeReg_0_0/design_2_ExeReg_0_0_sim_netlist.vhdl
-- Design      : design_2_ExeReg_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z010clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_2_ExeReg_0_0_ExeReg is
  port (
    WB_EN_out : out STD_LOGIC;
    MEM_R_EN_out : out STD_LOGIC;
    MEM_W_EN_out : out STD_LOGIC;
    ALU_Res_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    Val_Rm_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    dest_out : out STD_LOGIC_VECTOR ( 3 downto 0 );
    WB_EN : in STD_LOGIC;
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    MEM_R_EN : in STD_LOGIC;
    MEM_W_EN : in STD_LOGIC;
    ALU_Res : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Val_Rm : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dest : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_2_ExeReg_0_0_ExeReg : entity is "ExeReg";
end design_2_ExeReg_0_0_ExeReg;

architecture STRUCTURE of design_2_ExeReg_0_0_ExeReg is
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
MEM_W_EN_out_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => MEM_W_EN,
      Q => MEM_W_EN_out
    );
\Val_Rm_out_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(0),
      Q => Val_Rm_out(0)
    );
\Val_Rm_out_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(10),
      Q => Val_Rm_out(10)
    );
\Val_Rm_out_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(11),
      Q => Val_Rm_out(11)
    );
\Val_Rm_out_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(12),
      Q => Val_Rm_out(12)
    );
\Val_Rm_out_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(13),
      Q => Val_Rm_out(13)
    );
\Val_Rm_out_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(14),
      Q => Val_Rm_out(14)
    );
\Val_Rm_out_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(15),
      Q => Val_Rm_out(15)
    );
\Val_Rm_out_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(16),
      Q => Val_Rm_out(16)
    );
\Val_Rm_out_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(17),
      Q => Val_Rm_out(17)
    );
\Val_Rm_out_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(18),
      Q => Val_Rm_out(18)
    );
\Val_Rm_out_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(19),
      Q => Val_Rm_out(19)
    );
\Val_Rm_out_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(1),
      Q => Val_Rm_out(1)
    );
\Val_Rm_out_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(20),
      Q => Val_Rm_out(20)
    );
\Val_Rm_out_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(21),
      Q => Val_Rm_out(21)
    );
\Val_Rm_out_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(22),
      Q => Val_Rm_out(22)
    );
\Val_Rm_out_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(23),
      Q => Val_Rm_out(23)
    );
\Val_Rm_out_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(24),
      Q => Val_Rm_out(24)
    );
\Val_Rm_out_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(25),
      Q => Val_Rm_out(25)
    );
\Val_Rm_out_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(26),
      Q => Val_Rm_out(26)
    );
\Val_Rm_out_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(27),
      Q => Val_Rm_out(27)
    );
\Val_Rm_out_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(28),
      Q => Val_Rm_out(28)
    );
\Val_Rm_out_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(29),
      Q => Val_Rm_out(29)
    );
\Val_Rm_out_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(2),
      Q => Val_Rm_out(2)
    );
\Val_Rm_out_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(30),
      Q => Val_Rm_out(30)
    );
\Val_Rm_out_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(31),
      Q => Val_Rm_out(31)
    );
\Val_Rm_out_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(3),
      Q => Val_Rm_out(3)
    );
\Val_Rm_out_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(4),
      Q => Val_Rm_out(4)
    );
\Val_Rm_out_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(5),
      Q => Val_Rm_out(5)
    );
\Val_Rm_out_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(6),
      Q => Val_Rm_out(6)
    );
\Val_Rm_out_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(7),
      Q => Val_Rm_out(7)
    );
\Val_Rm_out_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(8),
      Q => Val_Rm_out(8)
    );
\Val_Rm_out_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => Val_Rm(9),
      Q => Val_Rm_out(9)
    );
WB_EN_out_reg: unisim.vcomponents.FDCE
     port map (
      C => clk,
      CE => '1',
      CLR => rst,
      D => WB_EN,
      Q => WB_EN_out
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
entity design_2_ExeReg_0_0 is
  port (
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    WB_EN : in STD_LOGIC;
    MEM_R_EN : in STD_LOGIC;
    MEM_W_EN : in STD_LOGIC;
    ALU_Res : in STD_LOGIC_VECTOR ( 31 downto 0 );
    Val_Rm : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dest : in STD_LOGIC_VECTOR ( 3 downto 0 );
    WB_EN_out : out STD_LOGIC;
    MEM_R_EN_out : out STD_LOGIC;
    MEM_W_EN_out : out STD_LOGIC;
    ALU_Res_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    Val_Rm_out : out STD_LOGIC_VECTOR ( 31 downto 0 );
    dest_out : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_2_ExeReg_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_2_ExeReg_0_0 : entity is "design_2_ExeReg_0_0,ExeReg,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_2_ExeReg_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_2_ExeReg_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_2_ExeReg_0_0 : entity is "ExeReg,Vivado 2018.3";
end design_2_ExeReg_0_0;

architecture STRUCTURE of design_2_ExeReg_0_0 is
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN design_2_clk_0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of rst : signal is "xilinx.com:signal:reset:1.0 rst RST";
  attribute X_INTERFACE_PARAMETER of rst : signal is "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0";
begin
inst: entity work.design_2_ExeReg_0_0_ExeReg
     port map (
      ALU_Res(31 downto 0) => ALU_Res(31 downto 0),
      ALU_Res_out(31 downto 0) => ALU_Res_out(31 downto 0),
      MEM_R_EN => MEM_R_EN,
      MEM_R_EN_out => MEM_R_EN_out,
      MEM_W_EN => MEM_W_EN,
      MEM_W_EN_out => MEM_W_EN_out,
      Val_Rm(31 downto 0) => Val_Rm(31 downto 0),
      Val_Rm_out(31 downto 0) => Val_Rm_out(31 downto 0),
      WB_EN => WB_EN,
      WB_EN_out => WB_EN_out,
      clk => clk,
      dest(3 downto 0) => dest(3 downto 0),
      dest_out(3 downto 0) => dest_out(3 downto 0),
      rst => rst
    );
end STRUCTURE;
