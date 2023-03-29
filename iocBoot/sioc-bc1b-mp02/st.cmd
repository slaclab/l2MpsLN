#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:BC1B:MP02
#

< envPaths

epicsEnvSet("SLOT_ID", "2")
epicsEnvSet("FPGA_IP","10.1.1.10${SLOT_ID}")
epicsEnvSet("FACILITY","lcls")
epicsEnvSet("TYPE","LN")

epicsEnvSet("LOCATION","BC1B")
epicsEnvSet("LOCATION_INDEX","MP02")
epicsEnvSet("MODE_INPV", "1")

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/start.cmd

system("scripts/setupBPClockRT.sh shm-bc1b-sp01-2")
