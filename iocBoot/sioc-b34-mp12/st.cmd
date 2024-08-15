#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:B34:MP11
# shm-b34-sp08-1 slot 2

< envPaths

# =======================================
# Define mode management
# =======================================
epicsEnvSet("MODE_INPV", "MPS:UNDH:1:FACMODE CPP MSI")

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