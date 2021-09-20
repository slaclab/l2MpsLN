#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:FEES:MP01
#

< envPaths

epicsEnvSet("SLOT_ID", "2")
epicsEnvSet("FPGA_IP","10.0.1.10${SLOT_ID}")
#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/digital_node.cmd

system("scripts/setupBPClockRT.sh shm-fees-sp01-1")
