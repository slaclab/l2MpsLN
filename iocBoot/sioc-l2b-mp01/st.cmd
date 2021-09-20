#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:L2B:MP01
#

< envPaths

epicsEnvSet("SLOT_ID", "2")
epicsEnvSet("FPGA_IP","10.0.1.10${SLOT_ID}")

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/link_node.cmd

system("scripts/setupBPClockRT.sh shm-l2b-sp01-1")
