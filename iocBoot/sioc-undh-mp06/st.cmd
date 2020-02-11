#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:UNDH:MP06
#

< envPaths

epicsEnvSet("SLOT_ID", "2")
epicsEnvSet("FPGA_IP","10.1.1.10${SLOT_ID}")
epicsEnvSet("LOCATION", "UNDH")
epicsEnvSet("LOCATION_INDEX", "06")
epicsEnvSet("CARD_INDEX", "1")

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/link_node.cmd
