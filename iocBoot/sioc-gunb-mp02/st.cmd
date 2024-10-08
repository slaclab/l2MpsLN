#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:GUNB:MP02
#

< envPaths

# =======================================
# Define mode management and type
# =======================================
epicsEnvSet("MODE_INPV", "1")
epicsEnvSet("TYPE","LN")

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
# Load mitigation settings
# =======================================
cpswLoadConfigFile("iocBoot/${IOC}/mitigation_config.yaml", "mmio")

# =======================================
# Setup crate backplane communication
# =======================================
system("scripts/setupBPClockRT.sh ${SHM}")
