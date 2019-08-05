#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:UNDH:MP01
#

< envPaths

# ===========================================
#            ENVIRONMENT VARIABLES
# ===========================================

#
# Link Node Configuration (generated from MPS database)
#
# This defines the location of the configuration files,
# we need know the cpu name, crate ID and slot number to 
# find the correct location.
#
epicsEnvSet("CONFIG_TOP", "/afs/slac/u/cd/lpiccoli/lcls2/mps_configuration/cu/link_node_db/app_db")
epicsEnvSet("CPU_NAME", "cpu-undh-sp01")
epicsEnvSet("CRATE_ID", "0000")
epicsEnvSet("SLOT_ID", "2")
epicsEnvSet("LN_CONFIG_TOP", "${CONFIG_TOP}/${CPU_NAME}/${CRATE_ID}/0${SLOT_ID}")
epicsEnvSet("SLOT_ID", "7") # This is later used to set the LN card IP address (testing it in slot 7)

#
# Loads common Link Node startup
#
< ${TOP}/iocBoot/common/link_node.cmd
