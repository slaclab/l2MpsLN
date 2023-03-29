#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:L0B:MP04
#

< envPaths

epicsEnvSet("SLOT_ID", "2")
epicsEnvSet("FPGA_IP","10.1.1.10${SLOT_ID}")
epicsEnvSet("FACILITY","lcls")
epicsEnvSet("TYPE","LN")

epicsEnvSet("LOCATION","L0B")
epicsEnvSet("LOCATION_INDEX","MP04")
epicsEnvSet("MODE_INPV", "1")

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/start.cmd

cpswLoadConfigFile("iocBoot/sioc-l0b-mp04/mitigation_config.yaml", "mmio")

system("scripts/setupBPClockRT.sh shm-l0b-sp02-2")
