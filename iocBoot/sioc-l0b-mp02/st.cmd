#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:L0B:MP02
#

< envPaths

epicsEnvSet("SLOT_ID", "2")
epicsEnvSet("FPGA_IP","10.0.1.10${SLOT_ID}")
epicsEnvSet("FACILITY","lcls")
epicsEnvSet("TYPE","LN")

epicsEnvSet("LOCATION","L0B")
epicsEnvSet("LOCATION_INDEX","MP02")
epicsEnvSet("MODE_INPV", "1")

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/start.cmd

system("scripts/setupBPClockRT.sh shm-l0b-sp01-1")
