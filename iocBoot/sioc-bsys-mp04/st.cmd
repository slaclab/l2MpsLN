#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:BSYS:MP04
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
# Set this IOC up as an Undulator BLM type
# =======================================
epicsEnvSet("UND","_UND")

# =======================================
# Load specific environment variables for this unit
# =======================================
< ${TOP}/iocBoot/${IOC}/${IOC}.cmd

# =======================================
# Load common initialization file
# =======================================
< ${TOP}/iocBoot/common/start.cmd

# =======================================
# Load mitigation settings
# =======================================
cpswLoadConfigFile("iocBoot/${IOC}/mitigation_config.yaml", "mmio")

# =======================================
# Setup crate backplane communication
# =======================================
system("scripts/setupBPClockRT.sh ${SHM}")
