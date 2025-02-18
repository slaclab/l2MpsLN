#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:SPS:MP07
#

< envPaths

# =======================================
# Define mode management and type
# =======================================
epicsEnvSet("MODE_INPV", "1")
epicsEnvSet("TYPE","AN")

# =======================================
# Initialize default environment variables
# =======================================
< ${TOP}/iocBoot/common/support/ana_default.cmd

# =======================================
# Load common initialization file
# =======================================
< ${TOP}/iocBoot/common/start.cmd
