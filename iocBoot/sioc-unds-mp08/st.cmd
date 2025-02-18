#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:UNDH:MP08
#

< envPaths

# =======================================
# Define mode management and type
# =======================================
epicsEnvSet("MODE_INPV", "MPS:UNDS:1:FACMODE CPP MSI")
epicsEnvSet("TYPE","AN")
epicsEnvSet("CU","CU")

# =======================================
# Initialize default environment variables
# =======================================
< ${TOP}/iocBoot/common/support/ana_default.cmd

# =======================================
# Load specific environment variables for this unit
# =======================================
< ${TOP}/iocBoot/common/support/ana_sxr.cmd

# =======================================
# Load common initialization file
# =======================================
< ${TOP}/iocBoot/common/start.cmd
