#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:L0B:MP05
#

< envPaths

epicsEnvSet("SLOT_ID", "2")
epicsEnvSet("FPGA_IP","10.2.1.10${SLOT_ID}")

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/link_node.cmd
