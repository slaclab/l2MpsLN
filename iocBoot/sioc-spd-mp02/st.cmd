#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:SPD:MP02
#

< envPaths

# =======================================
# Define mode management and type
# =======================================
epicsEnvSet("TYPE","LN")

# =======================================
# Initialize default environment variables
# =======================================
< ${TOP}/iocBoot/common/support/ana_default.cmd
epicsEnvSet("CARED_FOR", "1")

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
