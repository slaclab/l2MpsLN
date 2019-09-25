#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:FEES:MP01
#

< envPaths

epicsEnvSet("SLOT_ID", "2")
epicsEnvSet("FPGA_IP","10.0.1.10${SLOT_ID}")

# DEV TEST
epicsEnvSet("SLOT_ID", "6") # This is later used to set the LN card IP address
epicsEnvSet("FPGA_IP","10.0.1.10${SLOT_ID}")
# DEV TEST

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/link_node.cmd
