#!../../bin/rhel6-x86_64/l2MpsLN

## You may have to change l2MpsLN to something else
## everywhere it appears in this file

< envPaths

# ===========================================
#            ENVIRONMENT VARIABLES
# ===========================================

# Location
epicsEnvSet("LOCATION", "B34")
epicsEnvSet("LOCATION_INDEX", "01")
epicsEnvSet("CARD_INDEX", "1")

# PV nama prefix, for the MPS application
epicsEnvSet("PREFIX_MPS_BASE","MPLN:${LOCATION}:MP${LOCATION_INDEX}:${CARD_INDEX}")

# Application ID
epicsEnvSet("MPS_APP_ID", "0x01")

# *********************************************
# **** Environment variables for IOC Admin ****
epicsEnvSet("ENGINEER","Luciano Piccoli")
epicsEnvSet("IOC_NAME","SIOC:${LOCATION}:MP${LOCATION_INDEX}")

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
configureVirtualChannel("MPS_VIRTUAL_CHANNEL")

# ===========================================
#               DB LOADING
# ===========================================
# Link Node database 
dbLoadRecords("db/mpsLN.db", "P=${PREFIX_MPS_BASE}, PORT=${YCPSWASYN_PORT}")

# ===========================================
#               VIRTUAL CHANNELS DB
# ===========================================
epicsEnvSet("MPS_ENV_DATABASE_VERSION", "import")
#epicsEnvSet("PHYSICS_TOP", "/usr/local/lcls/physics") # PROD
#epicsEnvSet("PHYSICS_TOP", "/afs/slac/g/lcls/physics") # DEV
epicsEnvSet("PHYSICS_TOP", "/afs/slac/u/cd/lpiccoli/top") # DEV2
epicsEnvSet("MPS_ENV_CONFIG_VERSION", "./")
epicsEnvSet("MPS_ENV_CONFIG_PATH", "${PHYSICS_TOP}/mps_configuration/${MPS_ENV_DATABASE_VERSION}")
dbLoadRecords("${MPS_ENV_CONFIG_PATH}/link_node_db/sioc-gunb-mp01/virtual_inputs.db")

# Save/load configuration database
dbLoadRecords("db/saveLoadConfig.db", "P=${PREFIX_MPS_BASE}, PORT=${YCPSWASYN_PORT}")

# **********************************************************************
# **** Load iocAdmin databases to support IOC Health and monitoring ****
dbLoadRecords("db/iocAdminSoft.db","IOC=${IOC_NAME}")
dbLoadRecords("db/iocAdminScanMon.db","IOC=${IOC_NAME}")

# The following database is a result of a python parser
# which looks at RELEASE_SITE and RELEASE to discover
# versions of software your IOC is referencing
# The python parser is part of iocAdmin
dbLoadRecords("db/iocRelease.db","IOC=${IOC}")

# *******************************************
# **** Load database for autosave status ****
dbLoadRecords("db/save_restoreStatus.db", "P=${PREFIX_MPS_BASE}:")

# ===========================================
#           SETUP AUTOSAVE/RESTORE
# ===========================================

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

# Start the save_restore task
# save changes on change, but no faster
# than every 30 seconds.
# Note: the last arg cannot be set to 0
create_monitor_set("defaults.req" , 30 )
