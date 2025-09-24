#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:SLTD:MP01
#

< envPaths

# =======================================
# Define mode management and type
# =======================================
epicsEnvSet("TYPE","DN")

# =======================================
# Initialize default environment variables
# =======================================
< ${TOP}/iocBoot/common/support/ana_default.cmd

# =======================================
# Load common initialization file
# =======================================
< ${TOP}/iocBoot/common/start.cmd

