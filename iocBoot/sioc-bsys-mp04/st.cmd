#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:BSYS:MP04
#

< envPaths

epicsEnvSet("SLOT_ID", "2")
epicsEnvSet("FPGA_IP","10.0.1.10${SLOT_ID}")

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/link_node.cmd

cpswLoadConfigFile("iocBoot/${IOC}/configs/specifics.yaml", "mmio")

system("scripts/setupBPClockRT.sh shm-bsys-sp02-1")
