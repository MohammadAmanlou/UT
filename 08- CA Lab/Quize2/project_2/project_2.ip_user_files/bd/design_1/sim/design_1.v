//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Sun Apr 13 17:36:07 2025
//Host        : Ariyan running 64-bit major release  (build 9200)
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=16,numReposBlks=16,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=8,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (clk_0,
    rst_0);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_0, CLK_DOMAIN design_1_clk_0, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000" *) input clk_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RST_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RST_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input rst_0;

  wire [31:0]Adder_0_out;
  wire [0:0]Freeze_dout;
  wire [31:0]IFreg_0_instructionOut;
  wire [31:0]IFreg_0_pcOut;
  wire [31:0]IFreg_1_instructionOut;
  wire [31:0]IFreg_1_pcOut;
  wire [31:0]IFreg_2_instructionOut;
  wire [31:0]IFreg_2_pcOut;
  wire [31:0]IFreg_instructionOut;
  wire [31:0]IFreg_pcOut;
  wire [31:0]InstructionMem_douta;
  wire [31:0]Mux2to1_0_out;
  wire [31:0]PC_out;
  wire [0:0]branch_taken_dout;
  wire clk_0_1;
  wire [0:0]debouncer_0_SIGNAL_O;
  wire [0:0]flush_dout;
  wire [31:0]mux_second_dout;
  wire rst_0_1;
  wire [31:0]xlconstant_0_dout;
  wire [12:0]xlslice_0_Dout;

  assign clk_0_1 = clk_0;
  assign rst_0_1 = rst_0;
  design_1_Adder_0_0 Adder
       (.a(xlconstant_0_dout),
        .b(PC_out),
        .out(Adder_0_out));
  design_1_xlconstant_0_0 FourConstant
       (.dout(xlconstant_0_dout));
  design_1_xlconstant_0_1 Freeze
       (.dout(Freeze_dout));
  design_1_IFreg_0_0 IFreg
       (.clk(clk_0_1),
        .flush(flush_dout),
        .freeze(Freeze_dout),
        .instruction(InstructionMem_douta),
        .instructionOut(IFreg_instructionOut),
        .pc(Adder_0_out),
        .pcOut(IFreg_pcOut),
        .rst(debouncer_0_SIGNAL_O));
  design_1_IFreg_0_1 IFreg_0
       (.clk(clk_0_1),
        .flush(flush_dout),
        .freeze(Freeze_dout),
        .instruction(IFreg_instructionOut),
        .instructionOut(IFreg_0_instructionOut),
        .pc(IFreg_pcOut),
        .pcOut(IFreg_0_pcOut),
        .rst(debouncer_0_SIGNAL_O));
  design_1_IFreg_1_0 IFreg_1
       (.clk(clk_0_1),
        .flush(Freeze_dout),
        .freeze(Freeze_dout),
        .instruction(IFreg_0_instructionOut),
        .instructionOut(IFreg_1_instructionOut),
        .pc(IFreg_0_pcOut),
        .pcOut(IFreg_1_pcOut),
        .rst(debouncer_0_SIGNAL_O));
  design_1_IFreg_2_0 IFreg_2
       (.clk(clk_0_1),
        .flush(flush_dout),
        .freeze(Freeze_dout),
        .instruction(IFreg_1_instructionOut),
        .instructionOut(IFreg_2_instructionOut),
        .pc(IFreg_1_pcOut),
        .pcOut(IFreg_2_pcOut),
        .rst(debouncer_0_SIGNAL_O));
  design_1_blk_mem_gen_0_0 InstructionMem
       (.addra(xlslice_0_Dout),
        .clka(clk_0_1),
        .douta(InstructionMem_douta));
  design_1_Mux2to1_0_0 Mux
       (.a(Adder_0_out),
        .b(mux_second_dout),
        .out0(Mux2to1_0_out),
        .select(branch_taken_dout));
  design_1_Register_0_0 PC
       (.clk(clk_0_1),
        .freeze(Freeze_dout),
        .in(Mux2to1_0_out),
        .outReg(PC_out),
        .rst(debouncer_0_SIGNAL_O));
  design_1_xlconstant_0_3 branch_taken
       (.dout(branch_taken_dout));
  design_1_debouncer_0_0 debouncer_0
       (.CLK_I(clk_0_1),
        .SIGNAL_I(rst_0_1),
        .SIGNAL_O(debouncer_0_SIGNAL_O));
  design_1_xlconstant_0_4 flush
       (.dout(flush_dout));
  design_1_ila_0_0 ila_0
       (.clk(clk_0_1),
        .probe0(IFreg_2_instructionOut),
        .probe1(IFreg_pcOut),
        .probe2(IFreg_0_pcOut),
        .probe3(IFreg_1_pcOut),
        .probe4(IFreg_2_pcOut),
        .probe5(debouncer_0_SIGNAL_O));
  design_1_xlconstant_0_2 mux_second
       (.dout(mux_second_dout));
  design_1_xlslice_0_0 xlslice_0
       (.Din(PC_out),
        .Dout(xlslice_0_Dout));
endmodule
