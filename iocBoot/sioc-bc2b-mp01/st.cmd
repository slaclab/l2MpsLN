#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:BC2B:MP01
#

< envPaths

# =======================================
# Define mode management and type
# =======================================
epicsEnvSet("TYPE","LN")
epicsEnvSet("MODE_INPV", "1")

# =======================================
# Initialize default environment variables
# =======================================
< ${TOP}/iocBoot/common/support/ana_default.cmd

# =======================================
# Load specific environment variables for this unit
# =======================================
< ${TOP}/iocBoot/${IOC}/${IOC}.cmd

# =======================================
# Load common initialization file
# =======================================
< ${TOP}/iocBoot/common/start.cmd

# =======================================
# Setup crate backplane communication
# =======================================
system("scripts/setupBPClockRT.sh ${SHM}")
