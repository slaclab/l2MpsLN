#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:BSYS:MP02
#

< envPaths

epicsEnvSet("SLOT_ID", "5")
epicsEnvSet("FPGA_IP","10.0.1.10${SLOT_ID}")
epicsEnvSet("FACILITY","lcls")
epicsEnvSet("TYPE","AN")

epicsEnvSet("LOCATION","BSYS")
epicsEnvSet("LOCATION_INDEX","MP02")
epicsEnvSet("MODE_INPV", "MPS:UNDS:1:FACMODE CPP MSI")

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/start.cmd
