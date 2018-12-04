# TCL File Generated by Component Editor 13.0sp1
# Mon Mar 12 19:07:45 GMT 2018
# DO NOT MODIFY


# 
# SRAM_Controller "SRAM_Controller" v1.0
#  2018.03.12.19:07:45
# 
# 

# 
# request TCL package from ACDS 13.1
# 
package require -exact qsys 13.1


# 
# module SRAM_Controller
# 
set_module_property DESCRIPTION ""
set_module_property NAME SRAM_Controller
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP MT3TB4_14
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME SRAM_Controller
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL SRAM_Controller
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file SRAM_Controller.v VERILOG PATH SRAM_Controller.v TOP_LEVEL_FILE


# 
# parameters
# 


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset_n reset_n Input 1


# 
# connection point avalon_slave_0
# 
add_interface avalon_slave_0 avalon end
set_interface_property avalon_slave_0 addressUnits WORDS
set_interface_property avalon_slave_0 associatedClock clock
set_interface_property avalon_slave_0 associatedReset reset
set_interface_property avalon_slave_0 bitsPerSymbol 8
set_interface_property avalon_slave_0 burstOnBurstBoundariesOnly false
set_interface_property avalon_slave_0 burstcountUnits WORDS
set_interface_property avalon_slave_0 explicitAddressSpan 0
set_interface_property avalon_slave_0 holdTime 0
set_interface_property avalon_slave_0 linewrapBursts false
set_interface_property avalon_slave_0 maximumPendingReadTransactions 0
set_interface_property avalon_slave_0 readLatency 0
set_interface_property avalon_slave_0 readWaitTime 1
set_interface_property avalon_slave_0 setupTime 0
set_interface_property avalon_slave_0 timingUnits Cycles
set_interface_property avalon_slave_0 writeWaitTime 0
set_interface_property avalon_slave_0 ENABLED true
set_interface_property avalon_slave_0 EXPORT_OF ""
set_interface_property avalon_slave_0 PORT_NAME_MAP ""
set_interface_property avalon_slave_0 SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave_0 address address Input 18
add_interface_port avalon_slave_0 chipselect chipselect Input 1
add_interface_port avalon_slave_0 byte_enable byteenable Input 2
add_interface_port avalon_slave_0 read read Input 1
add_interface_port avalon_slave_0 write write Input 1
add_interface_port avalon_slave_0 write_data writedata Input 16
add_interface_port avalon_slave_0 read_data readdata Output 16
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point conduit_end
# 
add_interface conduit_end conduit end
set_interface_property conduit_end associatedClock clock
set_interface_property conduit_end associatedReset ""
set_interface_property conduit_end ENABLED true
set_interface_property conduit_end EXPORT_OF ""
set_interface_property conduit_end PORT_NAME_MAP ""
set_interface_property conduit_end SVD_ADDRESS_GROUP ""

add_interface_port conduit_end SRAM_DQ export Bidir 16


# 
# connection point conduit_end_1
# 
add_interface conduit_end_1 conduit end
set_interface_property conduit_end_1 associatedClock clock
set_interface_property conduit_end_1 associatedReset ""
set_interface_property conduit_end_1 ENABLED true
set_interface_property conduit_end_1 EXPORT_OF ""
set_interface_property conduit_end_1 PORT_NAME_MAP ""
set_interface_property conduit_end_1 SVD_ADDRESS_GROUP ""

add_interface_port conduit_end_1 SRAM_ADDR export Output 18


# 
# connection point conduit_end_2
# 
add_interface conduit_end_2 conduit end
set_interface_property conduit_end_2 associatedClock clock
set_interface_property conduit_end_2 associatedReset ""
set_interface_property conduit_end_2 ENABLED true
set_interface_property conduit_end_2 EXPORT_OF ""
set_interface_property conduit_end_2 PORT_NAME_MAP ""
set_interface_property conduit_end_2 SVD_ADDRESS_GROUP ""

add_interface_port conduit_end_2 SRAM_CE_N export Output 1


# 
# connection point conduit_end_3
# 
add_interface conduit_end_3 conduit end
set_interface_property conduit_end_3 associatedClock clock
set_interface_property conduit_end_3 associatedReset ""
set_interface_property conduit_end_3 ENABLED true
set_interface_property conduit_end_3 EXPORT_OF ""
set_interface_property conduit_end_3 PORT_NAME_MAP ""
set_interface_property conduit_end_3 SVD_ADDRESS_GROUP ""

add_interface_port conduit_end_3 SRAM_WE_N export Output 1


# 
# connection point conduit_end_4
# 
add_interface conduit_end_4 conduit end
set_interface_property conduit_end_4 associatedClock clock
set_interface_property conduit_end_4 associatedReset ""
set_interface_property conduit_end_4 ENABLED true
set_interface_property conduit_end_4 EXPORT_OF ""
set_interface_property conduit_end_4 PORT_NAME_MAP ""
set_interface_property conduit_end_4 SVD_ADDRESS_GROUP ""

add_interface_port conduit_end_4 SRAM_OE_N export Output 1


# 
# connection point conduit_end_5
# 
add_interface conduit_end_5 conduit end
set_interface_property conduit_end_5 associatedClock clock
set_interface_property conduit_end_5 associatedReset ""
set_interface_property conduit_end_5 ENABLED true
set_interface_property conduit_end_5 EXPORT_OF ""
set_interface_property conduit_end_5 PORT_NAME_MAP ""
set_interface_property conduit_end_5 SVD_ADDRESS_GROUP ""

add_interface_port conduit_end_5 SRAM_UB_N export Output 1


# 
# connection point conduit_end_6
# 
add_interface conduit_end_6 conduit end
set_interface_property conduit_end_6 associatedClock clock
set_interface_property conduit_end_6 associatedReset ""
set_interface_property conduit_end_6 ENABLED true
set_interface_property conduit_end_6 EXPORT_OF ""
set_interface_property conduit_end_6 PORT_NAME_MAP ""
set_interface_property conduit_end_6 SVD_ADDRESS_GROUP ""

add_interface_port conduit_end_6 SRAM_LB_N export Output 1

