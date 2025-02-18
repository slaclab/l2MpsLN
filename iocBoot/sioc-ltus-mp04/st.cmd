#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:LTUS:MP04
#

< envPaths

# =======================================
# Define mode management and type
# =======================================
epicsEnvSet("MODE_INPV", "MPS:UNDS:1:FACMODE CPP MSI")
epicsEnvSet("TYPE","LN")

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

# =======================================
# Setup crate backplane communication
# =======================================
system("scripts/setupBPClockRT.sh ${SHM}")
