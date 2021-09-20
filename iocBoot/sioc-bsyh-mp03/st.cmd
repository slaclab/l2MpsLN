#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:BSYH:MP03
#

< envPaths

epicsEnvSet("SLOT_ID", "2")
epicsEnvSet("FPGA_IP","10.0.1.10${SLOT_ID}")
#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/link_node.cmd

cpswLoadConfigFile("iocBoot/${IOC}/configs/specifics.yaml", "mmio")

system("scripts/setupBPClockRT.sh shm-bsyh-sp02-1")
