#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:GUNB:MP01
#

< envPaths

epicsEnvSet("SLOT_ID", "6")
epicsEnvSet("FPGA_IP","10.0.1.10${SLOT_ID}")
epicsEnvSet("FACILITY","dev")
epicsEnvSet("TYPE","AN")

epicsEnvSet("LOCATION","UNDH")
epicsEnvSet("LOCATION_INDEX","MP07")
epicsEnvSet("MODE_INPV", "MPS:UNDH:1:FACMODE CPP MSI")

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/start.cmd

