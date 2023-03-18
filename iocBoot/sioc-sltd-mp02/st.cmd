#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:SLTD:MP01
#

< envPaths

epicsEnvSet("SLOT_ID", "3")
epicsEnvSet("FPGA_IP","10.0.1.10${SLOT_ID}")
epicsEnvSet("FACILITY","lcls")
epicsEnvSet("TYPE","LN")

epicsEnvSet("LOCATION","SLTD")
epicsEnvSet("LOCATION_INDEX","MP02")
epicsEnvSet("MODE_INPV", "1")

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/start.cmd
