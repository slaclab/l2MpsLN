#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:GUNB:MP01
#

< envPaths

epicsEnvSet("SLOT_ID", "2")
epicsEnvSet("FPGA_IP","10.0.1.10${SLOT_ID}")

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/link_node.cmd

cpswLoadConfigFile("iocBoot/sioc-gunb-mp01/mitigation_config.yaml", "mmio")

system("scripts/setupBPClockRT.sh shm-gunb-sp01-1")
