#!../../bin/linuxRT-x86_64/l2MpsLN

## You may have to change l2MpsLN to something else
## everywhere it appears in this file

< envPaths

# ===========================================
#            ENVIRONMENT VARIABLES
# ===========================================

# Location
epicsEnvSet("LOCATION", "GUNB")
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

# MPS Configuration location
epicsEnvSet("MPS_CONFIGURATION_TOP", "/afs/slac/g/lcls/epics/iocTop/users/jvasquez/github/mps_jesus/mps_database/results")

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

## yamlLoader
cpswLoadYamlFile("${YAML}", "NetIODev", "", "${FPGA_IP}")

# *****************************************
# **** Driver setup for L2MPSASYNConfig ****
## Configure asyn port driver
# L2MPSASYNConfig(
#    Port Name                  # the name given to this port driver
L2MPSASYNConfig("${L2MPSASYN_PORT}")

## Configure asyn port driver
# YCPSWASYNConfig(
#    Port Name,                 # the name given to this port driver
#    Root Path                  # OPTIONAL: Root path to start the generation. If empty, the Yaml root will be used
#    Record name Prefix,        # Record name prefix
#    DB Autogeneration mode,    # Set autogeneration of records. 0: disabled, 1: Enable usig maps, 2: Enabled using hash names.
#    Load dictionary,           # Dictionary file path with registers to load. An empty string will disable this function
YCPSWASYNConfig("${YCPSWASYN_PORT}", "", "", "0", "${YCPSWASYN_DICT_FILE}", "")

# ==========================================
# Load application specific configurations
# ==========================================
# Load the defautl configuration
cpswLoadConfigFile("${DEFAULTS_FILE}", "mmio")
# ==========================================

# ===========================================
#               ASYN MASKS
# ===========================================
asynSetTraceMask("${L2MPSASYN_PORT}",, -1, 0)
asynSetTraceMask("${YCPSWASYN_PORT}",, -1, 0)

# ===========================================
#               DB LOADING
# ===========================================
# Link Node database
dbLoadRecords("db/mpsLN.db", "P=${L2MPS_PREFIX}, PORT=${YCPSWASYN_PORT}")

# Save/load configuration database
dbLoadRecords("db/saveLoadConfig.db", "P=${L2MPS_PREFIX}, PORT=${YCPSWASYN_PORT}")

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
dbLoadRecords("db/save_restoreStatus.db", "P=${L2MPS_PREFIX}:")

# ===========================================
#           SETUP AUTOSAVE/RESTORE
# ===========================================

# If all PVs don't connect continue anyway
save_restoreSet_IncompleteSetsOk(1)

# created save/restore backup files with date string
# useful for recovery.
save_restoreSet_DatedBackupFiles(1)

# Where to find the list of PVs to save
# Where "/data" is an NFS mount point setup when linuxRT target
# boots up.
set_requestfile_path("${IOC_DATA}/${IOC}/autosave-req")

# Where to write the save files that will be used to restore
set_savefile_path("${IOC_DATA}/${IOC}/autosave")

# Prefix that is use to update save/restore status database
# records
save_restoreSet_UseStatusPVs(1)
save_restoreSet_status_prefix("${L2MPS_PREFIX}:")

## Restore datasets
set_pass1_restoreFile("defaults.sav")

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
