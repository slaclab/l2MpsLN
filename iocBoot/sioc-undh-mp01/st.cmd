#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:UNDH:MP01
#

< envPaths

# =======================================
# Define mode management and type
# =======================================
epicsEnvSet("MODE_INPV", "MPS:UNDH:1:FACMODE CPP MSI")
epicsEnvSet("TYPE","LN")
epicsEnvSet("CU","CU")

# =======================================
# Initialize default environment variables
# =======================================
< ${TOP}/iocBoot/common/support/ana_default.cmd

# =======================================
# Load specific environment variables for this unit
# =======================================
< ${TOP}/iocBoot/common/support/ana_hxr.cmd

# =======================================
# Load common initialization file
# =======================================
< ${TOP}/iocBoot/common/start.cmd

# =======================================
# Load undulator BLM settings
# =======================================
cpswLoadConfigFile("iocBoot/${IOC}/blm_config.yaml", "mmio")

# =======================================
# Setup crate backplane communication
# =======================================
system("scripts/setupBPClockRT.sh ${SHM}")
