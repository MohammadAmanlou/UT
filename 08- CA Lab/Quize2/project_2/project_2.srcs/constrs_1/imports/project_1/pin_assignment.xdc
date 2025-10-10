# Clock signals
#set_property PACKAGE_PIN E7                 [get_ports CLK_33MHz]
#set_property IOSTANDARD LVCMOS33            [get_ports CLK_33MHz]
#create_clock -period 30.000 -name CLK_33MHz [get_ports CLK_33MHz]

set_property PACKAGE_PIN U18                [get_ports clk_0]
set_property IOSTANDARD LVCMOS33            [get_ports clk_0]
create_clock -period 20.000 -name CLK_50MHz [get_ports clk_0]

# Buttons

set_property PACKAGE_PIN J15                [get_ports rst_0]
set_property IOSTANDARD LVCMOS33            [get_ports rst_0]
