#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:BSYS:MP03
#

< envPaths

epicsEnvSet("SLOT_ID", "2")
epicsEnvSet("SLOT_ID", "6") # This is later used to set the LN card IP address (testing it in slot 7)
epicsEnvSet("FPGA_IP","10.0.1.10${SLOT_ID}")

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/link_node.cmd
