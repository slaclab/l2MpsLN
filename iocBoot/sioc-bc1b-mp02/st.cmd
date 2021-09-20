#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:BC1B:MP02
#

< envPaths

epicsEnvSet("SLOT_ID", "2")
epicsEnvSet("FPGA_IP","10.1.1.10${SLOT_ID}")

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/link_node.cmd

system("scripts/setupBPClockRT.sh shm-bc1b-sp01-2")
