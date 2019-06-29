#================================================================
#
# Generic MPS Link Node Start Up 
#

# CPSW Port names
epicsEnvSet("L2MPSASYN_PORT","L2MPSASYN_PORT")
epicsEnvSet("YCPSWASYN_PORT","YCPSWASYN_PORT")

# Location to download the YAML file from the FPGA
epicsEnvSet("YAML_DIR","${IOC_DATA}/${IOC}/yaml")

# YAML file
epicsEnvSet("YAML","${YAML_DIR}/000TopLevel.yaml")

# Defaults Yaml file
epicsEnvSet("DEFAULTS_FILE", "${YAML_DIR}/config/defaults.yaml")

# YCPSWASYN Dictionary file
epicsEnvSet("YCPSWASYN_DICT_FILE", "firmware/mpsLN.dict")

# FPGA IP Address
epicsEnvSet("FPGA_IP","10.0.1.10${SLOT_ID}")

# PV name prefix, for the MPS application
epicsEnvSet("PREFIX_MPS_BASE","MPLN:${IOC_AREA}:${IOC_LOCATION}:${IOC_CARD_INDEX}")

# PV name prefix, for the application on Bay 0
$(MPS_DIG_APP) epicsEnvSet("PREFIX_MPS_BAY0", "NO_APP_BAY0")
$(MPS_ANA_APP) epicsEnvSet("PREFIX_MPS_BAY0","MPLN:${IOC_AREA}:${IOC_LOCATION}:BAY0")

# PV name prefix, for the application on Bay 1
$(MPS_DIG_APP) epicsEnvSet("PREFIX_MPS_BAY1", "NO_APP_BAY1")
$(MPS_ANA_APP) epicsEnvSet("PREFIX_MPS_BAY1","MPLN:${IOC_AREA}:${IOC_LOCATION}:BAY1")


# *********************************************
# **** Environment variables for IOC Admin ****
epicsEnvSet("ENGINEER","Luciano Piccoli")
epicsEnvSet("IOC_NAME","SIOC:${IOC_AREA}:${IOC_LOCATION}")

# ===========================================
# Start from TOP
# ===========================================
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
#DownloadYamlFile("${FPGA_IP}", "${YAML_DIR}")

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
L2MPSASYNConfig("${L2MPSASYN_PORT}","${MPS_ANA_APP_ID}", "${PREFIX_MPS_BASE}", "${PREFIX_MPS_BAY0}", "${PREFIX_MPS_BAY1}", "")

## Configure asyn port driverx
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
# Load the default configuration
cpswLoadConfigFile("iocBoot/${IOC}/configs/defaults.yaml", "mmio")

# Load link node specific configuration (e.g. digital app id)
cpswLoadConfigFile("${LN_CONFIG_TOP}/config.yaml", "mmio")

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
dbLoadRecords("${LN_CONFIG_TOP}/mps.db", "YCPSWASYN_PORT=${YCPSWASYN_PORT}, L2MPSASYN_PORT=${L2MPSASYN_PORT}")

# Link Node specific databases for analog channels and scale factors
< ${LN_CONFIG_TOP}/mps_analog_channels.cmd
< ${LN_CONFIG_TOP}/mps_scale_factor.cmd

# Save/load configuration database
#dbLoadRecords("db/saveLoadConfig.db", "P=${PREFIX_MPS_BASE}, PORT=${YCPSWASYN_PORT}")

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
save_restoreSet_status_prefix("${PREFIX_MPS_BASE}:")

## Restore datasets
set_pass0_restoreFile("info_settings.sav")
set_pass1_restoreFile("info_settings.sav")

# ===========================================
#          CHANNEL ACESS SECURITY
# ===========================================
# This is required if you use caPutLog.
# Set access security filea
# Load common LCLS Access Configuration File
#< ${ACF_INIT}

# ===========================================
#               IOC INIT
# ===========================================
iocInit()

# Start the save_restore task
# save changes on change, but no faster
# than every 30 seconds.
# Note: the last arg cannot be set to 0
create_monitor_set("info_settings.req" , 30 )
