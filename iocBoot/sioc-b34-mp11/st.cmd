#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:B34:MP11
# shm-b34-sp08-1 slot 2

< envPaths

# =======================================
# Define mode management and type
# =======================================
epicsEnvSet("MODE_INPV", "MPS:UNDH:1:FACMODE CPP MSI")
epicsEnvSet("TYPE","LN")

# =======================================
# Initialize default environment variables
# =======================================
< ${TOP}/iocBoot/common/support/ana_default.cmd

# =======================================
# Set this IOC up as an Undulator BLM type
# =======================================
epicsEnvSet("BEAMPATH","H")
epicsEnvSet("EVR_EC","137")
epicsEnvSet("TPR_MASK","8")

# =======================================
# Load specific environment variables for this unit
# =======================================
< ${TOP}/iocBoot/${IOC}/${IOC}.cmd

# =======================================
# Load common initialization file
# =======================================
< ${TOP}/iocBoot/common/start.cmd
dbLoadRecords("db/mitigation.db", "P=${L2MPS_PREFIX}")
dbLoadRecords("db/mpsLN.db", "P=${L2MPS_PREFIX}, PORT=${YCPSWASYN_PORT}")
# =======================================
# Load undulator BLM settings
# =======================================
cpswLoadConfigFile("iocBoot/${IOC}/blm_config.yaml", "mmio")

# =======================================
# Setup crate backplane communication
# =======================================
system("scripts/setupBPClockRT.sh ${SHM}")
