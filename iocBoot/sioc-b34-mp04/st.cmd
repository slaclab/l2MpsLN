#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:GUNB:MP01
#

< envPaths

epicsEnvSet("SLOT_ID", "6")
epicsEnvSet("FPGA_IP","10.0.1.10${SLOT_ID}")

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/application_node.cmd

