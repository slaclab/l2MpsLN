#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:GUNB:MP02
#

< envPaths

epicsEnvSet("SLOT_ID", "2")
epicsEnvSet("FPGA_IP","10.0.1.10${SLOT_ID}")
epicsEnvSet("FACILITY","lcls")
epicsEnvSet("TYPE","LN")

epicsEnvSet("LOCATION","GUNB")
epicsEnvSet("LOCATION_INDEX","MP02")
epicsEnvSet("MODE_INPV", "1")

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/start.cmd

cpswLoadConfigFile("iocBoot/sioc-gunb-mp02/mitigation_config.yaml", "mmio")

system("scripts/setupBPClockRT.sh shm-gunb-sp02-1")
