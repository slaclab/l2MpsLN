# ====================================================================
#
# Common Settings
#
# ====================================================================

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
cpswLoadConfigFile("${TOP}/iocBoot/common/configs/disableBsa.yaml","mmio/AmcCarrierCore/AmcCarrierBsa")

# ==========================================
# Load default configurations
# ==========================================
# Load the default configuration
cpswLoadConfigFile("${DEFAULTS_FILE}", "mmio")

## Set MPS Configuration location
# setMpsConfigurationPath(
#   Path)                   # Path to the MPS configuraton TOP directory
setMpsConfigurationPath("${FACILITY_ROOT}/physics/mps_configuration/current/link_node_db")

## Configure asyn port driverx
# YCPSWASYNConfig(
#    Port Name,                 # the name given to this port driver
#    Root Path                  # OPTIONAL: Root path to start the generation. If empty, the Yaml root will be used
#    Record name Prefix,        # Record name prefix
#    DB Autogeneration mode,    # Set autogeneration of records. 0: disabled, 1: Enable using maps, 2: Enabled using hash names.
#    Load dictionary,           # Dictionary file path with registers to load. An empty string will disable this function
YCPSWASYNConfig("${YCPSWASYN_PORT}", "", "", "0", "${YCPSWASYN_DICT_FILE}", "")

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
# Connect to the crossbar
# ==========================================
crossbarControlAsynDriverConfigure("crossbar", "mmio/AmcCarrierCore/AxiSy56040")

# ==========================================
# Load application specific configurations
# ==========================================
cpswLoadConfigFile("iocBoot/common/configs/specifics${TYPE}.yaml", "mmio")

# ==========================================
# Load Timing Databases
# ==========================================
dbLoadRecords("db/tprDeviceNamePV.db","PORT=${TPRTRIGGER_PORT},LOCA=${LOCATION},IOC_UNIT=${LOCATION_INDEX},INST=${INST},NN=08,DEV_PREFIX=${TPR}:GP0_")
dbLoadRecords("db/tprDeviceNamePV.db","PORT=${TPRTRIGGER_PORT},LOCA=${LOCATION},IOC_UNIT=${LOCATION_INDEX},INST=${INST},NN=09,DEV_PREFIX=${TPR}:GP1_")
dbLoadRecords("db/tprTrig.db", "PORT=${TPRTRIGGER_PORT},LOCA=${LOCATION},IOC_UNIT=${LOCATION_INDEX},INST=${INST}")
dbLoadRecords("db/crossbarCtrl.db", "DEV=${TPR},PORT=crossbar")
dbLoadRecords("db/tprPattern.db", "PORT=${TPRPATTERN_PORT},LOCA=${LOCATION},IOC_UNIT=${LOCATION_INDEX},INST=${INST}")
