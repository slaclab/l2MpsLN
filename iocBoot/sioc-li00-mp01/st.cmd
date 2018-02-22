#!../../bin/linuxRT-x86_64/l2MpsLN

## You may have to change l2MpsLN to something else
## everywhere it appears in this file

< envPaths

# ===========================================
#            ENVIRONMENT VARIABLES
# ===========================================

# Location
epicsEnvSet("LOCATION", "LI00")
epicsEnvSet("LOCATION_INDEX", "01")
epicsEnvSet("CARD_INDEX", "1")

# CPSW Port names
epicsEnvSet("L2MPSASYN_PORT","L2MPSASYN_PORT")
epicsEnvSet("YCPSWASYN_PORT","YCPSWASYN_PORT")

# Firmware project name
epicsEnvSet("FW_PROJ_NAME", "AmcCarrierMpsAnalogLinkNode_project.yaml")

# YAML file
epicsEnvSet("YAML","firmware/${FW_PROJ_NAME}/000TopLevel.yaml")

# Defaults Yaml file
epicsEnvSet("DEFAULTS_FILE", "firmware/${FW_PROJ_NAME}/config/defaults.yaml")

# YCPSWASYN Dictionary file
epicsEnvSet("YCPSWASYN_DICT_FILE", "firmware/mpsLN.dict")

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

## Configure asyn port driver
# YCPSWASYNConfig(
#    Port Name,                 # the name given to this port driver
#    Yaml Doc,                  # Path to the YAML file
#    Root Path                  # OPTIONAL: Root path to start the generation. If empty, the Yaml root will be used
#    IP Address,                # OPTIONAL: Target FPGA IP Address. If not given it is taken from the YAML file
#    Record name Prefix,        # Record name prefix
#    Record name Length Max,    # Record name maximum length (must be greater than lenght of prefix + 4)
#    Use DB Autogeneration,     # Set to 1 for autogeneration of records from the YAML definition. Set to 0 to disable it
#    Load dictionary,           # Dictionary file path with registers to load. An empty string will disable this function
# In Sector 0 L2KA00-05, the BCMs are in slots 6 and 7. Here, for testing purposes we are using slots 4 and 5.
YCPSWASYNConfig("${YCPSWASYN_PORT}", "", "", "", "", 50, "0", "${YCPSWASYN_DICT_FILE}")

# ===========================================
#               ASYN MASKS
# ===========================================
asynSetTraceMask("${L2MPSASYN_PORT}",, -1, 0)
asynSetTraceMask("${YCPSWASYN_PORT}",, -1, 0)

# ===========================================
#               DB LOADING
# ===========================================
dbLoadRecords("db/mpsLN.db", "P=${PREFIX_MPS_BASE}, PORT=${YCPSWASYN_PORT}")

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
