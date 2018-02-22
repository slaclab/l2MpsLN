#!../../bin/linuxRT-x86_64/l2MpsLN

## You may have to change l2MpsLN to something else
## everywhere it appears in this file

< envPaths

# ===========================================
#            ENVIRONMENT VARIABLES
# ===========================================

# **************************************************
# **** Environment variables for L2MPSASYN      ****

# Location
epicsEnvSet("LOCATION", "LI00")
epicsEnvSet("LOCATION_INDEX", "01")
epicsEnvSet("CARD_INDEX", "1")

# CPSW Port names
epicsEnvSet("L2MPSASYN_PORT","LI00-SP01_S2_MPS")

# Firmware project name
epicsEnvSet("FW_PROJ_NAME", "AmcCarrierMpsAnalogLinkNode_project.yaml")

# YAML file
epicsEnvSet("YAML","firmware/${FW_PROJ_NAME}/000TopLevel.yaml")

# Defaults Yaml file
epicsEnvSet("DEFAULTS_FILE", "firmware/${FW_PROJ_NAME}/config/defaults.yaml")

# FPGA IP Address
epicsEnvSet("FPGA_IP","10.0.1.102")

# PV nama prefix, for the MPS application
epicsEnvSet("PREFIX_MPS_BASE","MPLN:${LOCATION}:MP${LOCATION_INDEX}:${CARD_INDEX}")

# PV nama prefix, for the application on Bay 0
epicsEnvSet("PREFIX_MPS_BAY0","MPLN:LI00:BAY0")

# PV nama prefix, for the application on Bay 1
epicsEnvSet("PREFIX_MPS_BAY1","MPLN:LI00:BAY1")

# Application ID
epicsEnvSet("MPS_APP_ID", "0x01")

# ======================================
# Start from TOP
# ======================================
cd ${TOP}

# ===========================================
#               DBD LOADING
# ===========================================
## Register all support components
dbLoadDatabase("dbd/l2MpsLN.dbd",0,0)
l2MpsLN_registerRecordDeviceDriver(pdbbase)

# ===========================================
#              DRIVER SETUP
# ===========================================

## yamlLoader
cpswLoadYamlFile("${YAML}", "NetIODev", "", "${FPGA_IP}")

# *****************************************
# **** Driver setup for L2MPSASYNConfig ****
## Configure asyn port driver
# L2MPSASYNConfig(
#    Port Name,                 # the name given to this port driver
#    App ID,                    # Application ID
#    Record name Prefix,        # Record name prefix
#    AppType bay0,              # Bay 0 Application type (BPM, BLEN)
#    AppType bay1,              # Bay 1 Application type (BPM, BLEN)
#    MPS Root Path              # OPTIONAL: Root path to the MPS register area
L2MPSASYNConfig("${L2MPSASYN_PORT}","${MPS_APP_ID}", "${PREFIX_MPS_BASE}", "${PREFIX_MPS_BAY0}", "${PREFIX_MPS_BAY1}", "")

# ===========================================
#               ASYN MASKS
# ===========================================
asynSetTraceMask("${L2MPSASYN_PORT}",, -1, 0)

# ===========================================
#          CHANNEL ACESS SECURITY
# ===========================================
# This is required if you use caPutLog.
# Set access security filea
# Load common LCLS Access Configuration File
< ${ACF_INIT}

# ===========================================
#               IOC INIT
# ===========================================
iocInit()
