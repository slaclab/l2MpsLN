#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:B34:MP11
# shm-b34-sp08-1 slot 2

< envPaths

epicsEnvSet("SLOT_ID", "2")
epicsEnvSet("L2MPS_PREFIX", "MPLN:GUNB:MP01:1")
epicsEnvSet("FPGA_IP","10.0.1.10${SLOT_ID}")
epicsEnvSet("FACILITY","dev")
epicsEnvSet("TYPE","LN")
epicsEnvSet("APPID","2")
epicsEnvSet("DIGAID","1")

epicsEnvSet("LOCATION","GUNB")
epicsEnvSet("LOCATION_INDEX","MP01")
epicsEnvSet("MODE_INPV", "MPS:UNDH:1:FACMODE CPP MSI")

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/start.cmd

system("scripts/setupBPClockRT.sh shm-b34-sp08-1")