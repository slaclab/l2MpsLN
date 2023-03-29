#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:FEES:MP03
#

< envPaths

epicsEnvSet("SLOT_ID", "7")
epicsEnvSet("FPGA_IP","10.0.1.10${SLOT_ID}")
epicsEnvSet("FACILITY","lcls")
epicsEnvSet("TYPE","AN")

epicsEnvSet("LOCATION","FEES")
epicsEnvSet("LOCATION_INDEX","MP03")
epicsEnvSet("MODE_INPV", "MPS:UNDS:1:FACMODE CPP MSI")

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/start.cmd

