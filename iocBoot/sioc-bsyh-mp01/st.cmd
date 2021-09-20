#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:BSYH:MP01
#

< envPaths

epicsEnvSet("LOCATION", "GUNB")
epicsEnvSet("LOCATION_INDEX", "01")
epicsEnvSet("CARD_INDEX", "1")

epicsEnvSet("SLOT_ID", "2")
epicsEnvSet("FPGA_IP","10.0.1.10${SLOT_ID}")

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/link_node.cmd

system("scripts/setupBPClockRT.sh shm-bsyh-sp01-1")
