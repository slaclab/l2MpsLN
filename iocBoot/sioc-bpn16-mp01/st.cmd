#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:BPN16:MP01
#

< envPaths

epicsEnvSet("SLOT_ID", "2")
epicsEnvSet("FPGA_IP","10.0.1.10${SLOT_ID}")
epicsEnvSet("FACILITY","lcls")
epicsEnvSet("TYPE","LN")

epicsEnvSet("LOCATION","BPN16")
epicsEnvSet("LOCATION_INDEX","MP01")
epicsEnvSet("MODE_INPV", "1")

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/start.cmd

system("scripts/setupBPClockRT.sh shm-bpn16-sp01-1")
