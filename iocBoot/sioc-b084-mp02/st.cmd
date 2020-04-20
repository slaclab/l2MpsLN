#!../../bin/linuxRT-x86_64/l2MpsLN

## You may have to change l2MpsLN to something else
## everywhere it appears in this file

< envPaths

# ===========================================
#            ENVIRONMENT VARIABLES
# ===========================================

# CPSW Port names
epicsEnvSet("L2MPSASYN_PORT","L2MPSASYN_PORT")
epicsEnvSet("YCPSWASYN_PORT","YCPSWASYN_PORT")
epicsEnvSet("TPRTRIGGER_PORT","TPRTRIGGER_PORT")
epicsEnvSet("TPRPATTERN_PORT","TPRPATTERN_PORT")

# Point 'YAML_PATH' to the yaml_fixes directory
epicsEnvSet("YAML_PATH", "${TOP}/firmware/yaml_fixes")

# Location to download the YAML file from the FPGA
epicsEnvSet("YAML_DIR","${IOC_DATA}/${IOC}/yaml")

# YAML file
epicsEnvSet("YAML","${YAML_DIR}/000TopLevel.yaml")

# Defaults Yaml file
epicsEnvSet("DEFAULTS_FILE", "${YAML_DIR}/config/defaults.yaml")

# YCPSWASYN Dictionary file
epicsEnvSet("YCPSWASYN_DICT_FILE", "firmware/mpsLN.dict")

# FPGA IP Address
epicsEnvSet("FPGA_IP","10.0.1.102")

# *********************************************
# **** Environment variables for IOC Admin ****
epicsEnvSet("ENGINEER","Luciano Piccoli")

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

## yamlDownloader
DownloadYamlFile("${FPGA_IP}", "${YAML_DIR}")

## yamlLoader
cpswLoadYamlFile("${YAML}", "NetIODev", "", "${FPGA_IP}")

## Set MPS Configuration location
# setMpsConfigurationPath(
#   Path)                   # Path to the MPS configuraton TOP directory
#
# In DEV, we temporary point to a local copy in this IOC application
setMpsConfigurationPath("iocBoot/${IOC}/mps_database_output")

## LCLS-II MPS
# L2MPSASYNConfig(
#    Port Name)            # the name given to this port driver
L2MPSASYNConfig("${L2MPSASYN_PORT}")

## Set the MpsManager hostname and port number
# L2MPSASYNSetManagerHost(
#    MpsManagerHostName,   # Server hostname
#    MpsManagerPortNumber) # Server port number
#
# In DEV, the MpsManager runs in lcls-dev3, default port number.
L2MPSASYNSetManagerHost("lcls-dev3", 0)

## Configure the LCLS1 BSA driver
# L2MpsL1BsaConfig(
#    streamName,                # Name of the CPSW stream interface for the LCLS1 BSA data
#    recordPrefix)              # Record name prefix for the LCLS1 BSA PVs
L2MpsL1BsaConfig("Lcls1BsaStream", "${L2MPS_PREFIX}")

## Configure the YCPSWASYN driver
# YCPSWASYNConfig(
#    Port Name,                 # The name given to this port driver
#    Root Path                  # OPTIONAL: Root path to start the generation. If empty, the Yaml root will be used
#    Record name Prefix,        # Record name prefix
#    DB Autogeneration mode,    # Set autogeneration of records. 0: disabled, 1: Enable usig maps, 2: Enabled using hash names.
#    Load dictionary)           # Dictionary file path with registers to load. An empty string will disable this function
YCPSWASYNConfig("${YCPSWASYN_PORT}", "", "", "0", "${YCPSWASYN_DICT_FILE}")

## Configure the tprTrigger driver
# tprTriggerAsynDriverConfigure(
#    Port name,                 # The name given to this port driver
#    Root path)                 # Root path to the AmcCarrierCore register area
tprTriggerAsynDriverConfigure("${TPRTRIGGER_PORT}", "mmio/AmcCarrierCore")

## Configure the tprPattern driver
# tprPatternAsynDriverConfigure(
#    Port name,                 # The name given to this port driver
#    Root path,                 # Root path to the AmcCarrierCore register area
#    Stream name)               # Name of the timing stream
tprPatternAsynDriverConfigure("${TPRPATTERN_PORT}", "mmio/AmcCarrierCore", "tstream")

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

# tprTrigger database
dbLoadRecords("db/tprTrig.db", "PORT=${TPRTRIGGER_PORT},LOCA=${LOCATION},IOC_UNIT=MP${LOCATION_INDEX},INST=0")

# tprPattern database
dbLoadRecords("db/tprPattern.db", "PORT=${TPRPATTERN_PORT},LOCA=${LOCATION},IOC_UNIT=MP${LOCATION_INDEX},INST=0")

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
set_requestfile_path("${TOP}/iocBoot/common")

# Where to write the save files that will be used to restore
set_savefile_path("${IOC_DATA}/${IOC}/autosave")

# Prefix that is use to update save/restore status database
# records
save_restoreSet_UseStatusPVs(1)
save_restoreSet_status_prefix("${L2MPS_PREFIX}:")

## Restore datasets
set_pass0_restoreFile("info_positions.sav")
set_pass0_restoreFile("info_settings.sav")
set_pass1_restoreFile("info_settings.sav")
set_pass1_restoreFile("manual_settings.sav")
set_pass0_restoreFile("ana_units.sav")

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

# ===========================================
#           AUTOSAVE TASKS
# ===========================================

# Wait before building autosave files
epicsThreadSleep(1)

# Generate the autosave PV list
# Note we need change directory to
# where we are saving the restore
# request file, and then we go back
# ${TOP}.
cd ${IOC_DATA}/${IOC}/autosave-req
makeAutosaveFiles()
cd ${TOP}

# Start the save_restore task
# save changes on change, but no faster
# than every 5 seconds.
# Note: the last arg cannot be set to 0
create_monitor_set("info_positions.req", 5 )
create_monitor_set("info_settings.req" , 5 )
create_monitor_set("manual_settings.req" , 5 )
create_monitor_set("ana_units.req" , 30, "P=${L2MPS_PREFIX}" )

# - FIXME -
# Workaround: Adding this value and setting PINI=YES
# in the record doesn't work properly with input
# buffer start addresses. Setting the initial value
# here for now.
dbpf TPR:${LOCATION}:MP${LOCATION_INDEX}:${CARD_INDEX}:SYS0_CLK 156.25
dbpf TPR:${LOCATION}:MP${LOCATION_INDEX}:${CARD_INDEX}:SYS2_CLK 156.25
dbpf ${L2MPS_PREFIX}:DM0_BUFFER_SIZE 1000000
dbpf ${L2MPS_PREFIX}:DM1_BUFFER_SIZE 1000000
