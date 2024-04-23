# =======================================
# Script to start MPS Link Node,
# Application Node, and Digital Node.
# Need to define environment variables:
# FACILITY = dev,lcls
# TYPE = LN, DN, AN
# =======================================
callbackSetQueueSize(12000)
# =======================================
# Set the facility variables to dev or lcls
# =======================================
< ${TOP}/iocBoot/common/support/init_manager_${FACILITY}.cmd

# =======================================
# Initialize common settings and drivers
# =======================================
< ${TOP}/iocBoot/common/support/init_common.cmd

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
dbLoadRecords("db/iocAdminSoft.db","IOC=${IOC_NAME}")
dbLoadRecords("db/iocAdminScanMon.db","IOC=${IOC_NAME}")
dbLoadRecords("db/iocRelease.db","IOC=${IOC_NAME}")
dbLoadRecords("db/devSeqCar.db"    ,"SIOC=${IOC_NAME}")
dbLoadRecords("db/save_restoreStatus.db", "P=${IOC_NAME}:")

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
create_monitor_set("ana_units.req" , 30, "P=${L2MPS_PREFIX}" )

#////////////////////////////////////////#
#Run script to generate archiver files   #
#////////////////////////////////////////#
cd(${TOP}/iocBoot/common/)
system("./makeArchive.sh ${IOC} &")
cd(${TOP})

# After call to restore thresholds, clear lcls1 timeout so MPS is functional
dbpf ${L2MPS_PREFIX}:LC1_TIMEOUT_EN.PROC 1
dbpf ${L2MPS_PREFIX}:DM0_BUFFER_SIZE 1000000
dbpf ${L2MPS_PREFIX}:DM1_BUFFER_SIZE 1000000
dbpf TPR:${LOCATION}:${LOCATION_INDEX}:${INST}:SYS0_CLK 156.25
dbpf TPR:${LOCATION}:${LOCATION_INDEX}:${INST}:SYS2_CLK 156.25
dbpf ${L2MPS_PREFIX}:TIM_CLK_SRC.PROC 1
dbpf ${L2MPS_PREFIX}:THR_LOADED 1
dbpf ${L2MPS_PREFIX}:MPS_EN 1
dbpf ${L2MPS_PREFIX}:SALT_RST_PLL.PROC 1
dbpf ${L2MPS_PREFIX}:DM0_HW_ARM 1
dbpf ${L2MPS_PREFIX}:DM1_HW_ARM 1
dbpf ${TPR}:TIMING_RX_ERR 0
dbpf ${L2MPS_PREFIX}:RESET_ERR.PROC 1
dbpf ${L2MPS_PREFIX}:LC1_CLRTIMEOUT.PROC 1


iocshCmd("pvxsl() > ${IOC_DATA}/${IOC}/iocInfo/IOC.pvxsl")
iocshCmd("pvxsr() > ${IOC_DATA}/${IOC}/iocInfo/IOC.pvxsr")
