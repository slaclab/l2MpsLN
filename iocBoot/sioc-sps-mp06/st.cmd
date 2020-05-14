#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:SPS:MP06
#

< envPaths

epicsEnvSet("SLOT_ID", "5")
epicsEnvSet("FPGA_IP","10.1.1.10${SLOT_ID}")

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/application_node.cmd
