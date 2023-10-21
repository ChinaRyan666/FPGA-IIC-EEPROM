#时序约束
create_clock -period 20.000 -name sys_clk [get_ports sys_clk]

#IO管脚约束
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports sys_clk]
set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports sys_rst_n]
set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS33} [get_ports iic_scl]
set_property -dict {PACKAGE_PIN F17 IOSTANDARD LVCMOS33} [get_ports iic_sda]
set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports led]
