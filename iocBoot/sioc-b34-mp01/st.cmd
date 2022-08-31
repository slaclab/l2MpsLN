#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:GUNB:MP01
#

< envPaths

epicsEnvSet("SLOT_ID", "4")
epicsEnvSet("FPGA_IP","10.0.1.10${SLOT_ID}")

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/link_node_dev.cmd

