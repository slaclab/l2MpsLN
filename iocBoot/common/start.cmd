# =======================================
# Script to start MPS Link Node,
# Application Node, and Digital Node.
# Need to define environment variables:
# FACILITY = dev,lcls
# TYPE = LN, DN, AN
# =======================================
callbackSetQueueSize(12000)


# =======================================
# Initialize common settings and drivers
# =======================================
epicsEnvSet("FPGA_IP","10.${CRATE}.1.10${SLOT_ID}")
epicsEnvSet("INST","0")
epicsEnvSet("IOC_NAME", "SIOC:${LOCATION}:${LOCATION_INDEX}")
epicsEnvSet("TPR","TPR:${LOCATION}:${LOCATION_INDEX}:${INST}")
epicsEnvSet("BSAS","BSAS:${LOCATION}:${LOCATION_INDEX}:${INST}")
epicsEnvSet("MODE_RBV","${IOC_NAME}:FACMODE_RBV_CALC")

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
epicsEnvSet("YCPSWASYN_DICT_FILE", "firmware/mps${TYPE}.dict")

# *********************************************
# **** Environment variables for IOC Admin ****
epicsEnvSet("ENGINEER","Jeremy Mock")

# ===========================================
# Start from TOP
# ===========================================
cd ${TOP}

# ===========================================
#             CPSW DRIVER SETUP
# ===========================================

## yamlDownloader
DownloadYamlFile("${FPGA_IP}", "${YAML_DIR}")

## yamlLoader
cpswLoadYamlFile("${YAML}", "NetIODev", "", "${FPGA_IP}")
cpswLoadConfigFile("${TOP}/iocBoot/common/configs/disableBsa.yaml","mmio/AmcCarrierCore/AmcCarrierBsa")

# ==========================================
#    Load default configuration from yaml
# ==========================================
# Load the default configuration
cpswLoadConfigFile("${DEFAULTS_FILE}", "mmio")

# ==========================================
#             YCPSWASYN Driver
# ==========================================
## Configure asyn port driverx
# YCPSWASYNConfig(
#    Port Name,                 # the name given to this port driver
#    Root Path                  # OPTIONAL: Root path to start the generation. If empty, the Yaml root will be used
#    Record name Prefix,        # Record name prefix
#    DB Autogeneration mode,    # Set autogeneration of records. 0: disabled, 1: Enable using maps, 2: Enabled using hash names.
#    Load dictionary,           # Dictionary file path with registers to load. An empty string will disable this function
YCPSWASYNConfig("${YCPSWASYN_PORT}", "", "", "0", "${YCPSWASYN_DICT_FILE}", "")

# ==========================================
#        TPR Driver and Configuration
# ==========================================
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

# Connect to the crossbar
crossbarControlAsynDriverConfigure("crossbar", "mmio/AmcCarrierCore/AxiSy56040")

# Load Timing Databases
dbLoadRecords("db/tpr_management.db","LOCA=${LOCATION},IOC_UNIT=${LOCATION_INDEX}")

# ==========================================
# Load application specific configurations
# ==========================================
cpswLoadConfigFile("iocBoot/common/configs/specifics${TYPE}.yaml", "mmio")

# ==========================================
#     Load IOC specific configurations
# ==========================================
cpswLoadConfigFile("iocBoot/${IOC}/${IOC}.yaml", "")

## Configure asyn port driver
# L2MPSASYNConfig(
#    Port Name,    # the name given to this port driver
#    APP ID,       # the unique application ID
#    MPS Prefix)   # the MPS PV prefix
L2MPSASYNConfig("${L2MPSASYN_PORT}","${APPID}","${L2MPS_PREFIX}")

## Configure the Link Node driver
# L2MpsLNDriverInit(
#    LC1 bsa streamName,        # Name of the CPSW stream interface for the LCLS1 BSA data
#    port)                      # LCLS1 BSA PV support asyn port name.
L2MpsLNDriverInit("Lcls1BsaStream", "L2MPS_L1BSA")
L2MpsSetDigAppId ${DIGAID}
L2MpsSetBaysPresent ${BAYS}

# Load MPS Driver Databases
dbLoadRecords("db/l2MpsL1Bsa.db","P=${L2MPS_PREFIX}")
dbLoadRecords("db/mps.db","P=${L2MPS_PREFIX},PORT=${L2MPSASYN_PORT}")
dbLoadRecords("db/mps${TYPE}.db", "P=${L2MPS_PREFIX}, VER=${MPS_CONFIG_VERSION},NUM=${BAYS}, PORT=${YCPSWASYN_PORT}")
dbLoadRecords("db/modeManager${TYPE}.db", "P=${L2MPS_PREFIX}, NAME=${IOC_NAME}, LOCA=${LOCATION}, IOC_UNIT=${LOCATION_INDEX},INST=${INST},TPR=${TPR},PORT=bsaPort")
dbLoadRecords("db/facMode.template","IOC=${IOC_NAME},FLNK=${IOC_NAME}:SET_FACMODE,INPV=${MODE_INPV},INPR=${MODE_RBV}")
dbLoadRecords("db/analog${BAYS}bay.db","P=${L2MPS_PREFIX}")

# =======================================
# Initialize type-specific settings and drivers
# =======================================
< ${TOP}/iocBoot/common/support/init_${TYPE}.cmd

# ===========================================
#               ASYN MASKS
# ===========================================
asynSetTraceMask("${L2MPSASYN_PORT}",, -1, 0)
asynSetTraceMask("${YCPSWASYN_PORT}",, -1, 0)

# ==========================================
# Load IOC Management databases
# ==========================================
dbLoadRecords("db/ioc_management.db", "IOC=${IOC_NAME}")

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
save_restoreSet_status_prefix("${IOC_NAME}:")

## Restore datasets
set_pass0_restoreFile("info_settings.sav")
set_pass1_restoreFile("info_settings.sav")
set_pass0_restoreFile("info_positions.sav")
set_pass1_restoreFile("info_positions.sav")

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

# ===========================================
#           AUTOSAVE TASKS
# ===========================================

# Wait before building autosave files
epicsThreadSleep(1)

# Generate the autosave PV list. Note we need change directory to
# where we are saving the restore request file, and then we go back ${TOP}.
cd ${IOC_DATA}/${IOC}/autosave-req
makeAutosaveFiles()
cd ${TOP}

# Start the save_restore task save changes on change, but no faster
# than every 30 seconds.
# Note: the last arg cannot be set to 0
create_monitor_set("info_settings.req" , 30 )
create_monitor_set("info_positions.req", 30 )
create_monitor_set("manual_settings.req" , 30 )
$(IS_DN="")create_monitor_set("ana_units.req" , 30, "P=${L2MPS_PREFIX}" )

#////////////////////////////////////////#
#Run script to generate archiver files   #
#////////////////////////////////////////#
cd(${TOP}/iocBoot/common/)
system("./makeArchive.sh ${IOC} &")
cd(${TOP})


# After call to restore thresholds, clear lcls1 timeout so MPS is functional
dbpf ${L2MPS_PREFIX}:LC1_TIMEOUT_EN.PROC 1
$(IS_DN="")dbpf ${L2MPS_PREFIX}:DM0_BUFFER_SIZE 1000000
$(IS_DN="")dbpf ${L2MPS_PREFIX}:DM1_BUFFER_SIZE 1000000
dbpf TPR:${LOCATION}:${LOCATION_INDEX}:${INST}:SYS0_CLK 156.25
dbpf TPR:${LOCATION}:${LOCATION_INDEX}:${INST}:SYS2_CLK 156.25
#dbpf ${L2MPS_PREFIX}:MPS_EN 1
dbpf ${L2MPS_PREFIX}:SALT_RST_PLL.PROC 1
$(IS_DN="")dbpf ${L2MPS_PREFIX}:DM0_HW_ARM 1
$(IS_DN="")dbpf ${L2MPS_PREFIX}:DM1_HW_ARM 1
dbpf ${TPR}:RXLNKSTATUS_RESET 1
dbpf ${L2MPS_PREFIX}:RESET_ERR.PROC 1
dbpf ${L2MPS_PREFIX}:LC1_CLRTIMEOUT.PROC 1


iocshCmd("pvxsl() > ${IOC_DATA}/${IOC}/iocInfo/IOC.pvxsl")
iocshCmd("pvxsr() > ${IOC_DATA}/${IOC}/iocInfo/IOC.pvxsr")
