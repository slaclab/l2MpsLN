#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:L3B:MP04
#

< envPaths

epicsEnvSet("SLOT_ID", "2")
epicsEnvSet("FPGA_IP","10.0.1.10${SLOT_ID}")

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/link_node.cmd

system("scripts/setupBPClockRT.sh shm-l3b-sp04-1")
