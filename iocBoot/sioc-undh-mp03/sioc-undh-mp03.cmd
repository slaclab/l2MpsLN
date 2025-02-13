epicsEnvSet("LN","138")
epicsEnvSet("MPS_CONFIG_VERSION","2025-01-09-a")
epicsEnvSet("L2MPS_PREFIX","MPLN:UNDH:MP03:1")
epicsEnvSet("CRATE","0")
epicsEnvSet("SLOT_ID","2")
epicsEnvSet("LOCATION","UNDH")
epicsEnvSet("LOCATION_INDEX","MP03")
epicsEnvSet("SHM","shm-undh-sp05-1")
epicsEnvSet("DIGAID","349")
dbLoadRecords("${TOP}/db/lc2_watchdog.db","P=MPLN:UNDH:MP03:1,CH=00,INPV=SIOC:UNDH:MP03:HEARTBEAT")
dbLoadRecords("${TOP}/db/lc2_bpm_sw.db","P=MPLN:UNDH:MP03:1,CH=01,INPV=BPMS:UNDH:1690:YCUHBR")
dbLoadRecords("${TOP}/db/lc2_bpm_sw.db","P=MPLN:UNDH:MP03:1,CH=02,INPV=BPMS:UNDH:1790:XCUHBR")
dbLoadRecords("${TOP}/db/lc2_bpm_sw.db","P=MPLN:UNDH:MP03:1,CH=03,INPV=BPMS:UNDH:1790:YCUHBR")
dbLoadRecords("${TOP}/db/lc2_bpm_sw.db","P=MPLN:UNDH:MP03:1,CH=04,INPV=BPMS:UNDH:1590:XCUHBR")
dbLoadRecords("${TOP}/db/lc2_bpm_sw.db","P=MPLN:UNDH:MP03:1,CH=05,INPV=BPMS:UNDH:1690:XCUHBR")
dbLoadRecords("${TOP}/db/lc2_bpm_sw.db","P=MPLN:UNDH:MP03:1,CH=06,INPV=BPMS:UNDH:1590:YCUHBR")
epicsEnvSet("APPID","288")
epicsEnvSet("BAYS","2")
epicsEnvSet("CH0_MPS","")
epicsEnvSet("CH0_L1BSA","")
epicsEnvSet("CH0_P","CBLM:UNDH:1775")
epicsEnvSet("CH0_R","LOSS")
epicsEnvSet("CH0_EGU","mV")
epicsEnvSet("CH1_MPS","")
epicsEnvSet("CH1_L1BSA","")
epicsEnvSet("CH1_P","CBLM:UNDH:1875")
epicsEnvSet("CH1_R","LOSS")
epicsEnvSet("CH1_EGU","mV")
epicsEnvSet("CH2_MPS","")
epicsEnvSet("CH2_L1BSA","")
epicsEnvSet("CH2_P","CBLM:UNDH:1975")
epicsEnvSet("CH2_R","LOSS")
epicsEnvSet("CH2_EGU","mV")
epicsEnvSet("CH3_MPS","")
epicsEnvSet("CH3_L1BSA","")
epicsEnvSet("CH3_P","CBLM:UNDH:2075")
epicsEnvSet("CH3_R","LOSS")
epicsEnvSet("CH3_EGU","mV")
epicsEnvSet("CH4_MPS","")
epicsEnvSet("CH4_L1BSA","")
epicsEnvSet("CH4_P","CBLM:UNDH:2175")
epicsEnvSet("CH4_R","LOSS")
epicsEnvSet("CH4_EGU","mV")
epicsEnvSet("CH5_MPS","")
epicsEnvSet("CH5_L1BSA","")
epicsEnvSet("CH5_P","CBLM:UNDH:2275")
epicsEnvSet("CH5_R","LOSS")
epicsEnvSet("CH5_EGU","mV")
