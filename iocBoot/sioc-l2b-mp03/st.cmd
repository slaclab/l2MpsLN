#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:L2B:MP03
#

< envPaths

epicsEnvSet("SLOT_ID", "2")
epicsEnvSet("FPGA_IP","10.0.1.10${SLOT_ID}")
epicsEnvSet("FACILITY","lcls")
epicsEnvSet("TYPE","LN")

epicsEnvSet("LOCATION","L2B")
epicsEnvSet("LOCATION_INDEX","MP03")
epicsEnvSet("MODE_INPV", "1")

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/start.cmd

system("scripts/setupBPClockRT.sh shm-l2b-sp03-1")
