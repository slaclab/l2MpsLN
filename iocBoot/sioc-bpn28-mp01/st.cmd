#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:BPN28:MP01
#

< envPaths

epicsEnvSet("SLOT_ID", "2")
epicsEnvSet("FPGA_IP","10.0.1.10${SLOT_ID}")

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/link_node.cmd

system("scripts/setupBPClockRT.sh shm-bpn28-sp01-1")
