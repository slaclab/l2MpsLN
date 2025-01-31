epicsEnvSet("LN","204")
epicsEnvSet("MPS_CONFIG_VERSION","2025-01-09-a")
epicsEnvSet("L2MPS_PREFIX","MPLN:LTUS:MP02:1")
epicsEnvSet("CRATE","0")
epicsEnvSet("SLOT_ID","2")
epicsEnvSet("LOCATION","LTUS")
epicsEnvSet("LOCATION_INDEX","MP02")
epicsEnvSet("SHM","shm-ltus-sp02-1")
epicsEnvSet("DIGAID","368")
dbLoadRecords("${TOP}/db/lc2_watchdog.db","P=MPLN:LTUS:MP02:1,CH=00,INPV=SIOC:LTUS:MP02:HEARTBEAT")
dbLoadRecords("${TOP}/db/lc2_bpm_sw.db","P=MPLN:LTUS:MP02:1,CH=01,INPV=BPMS:UNDS:3590:XCUSBR")
dbLoadRecords("${TOP}/db/lc2_bpm_sw.db","P=MPLN:LTUS:MP02:1,CH=02,INPV=BPMS:UNDS:3590:YCUSBR")
dbLoadRecords("${TOP}/db/lc2_bpm_sw.db","P=MPLN:LTUS:MP02:1,CH=03,INPV=BPMS:UNDS:1690:XCUSBR")
dbLoadRecords("${TOP}/db/lc2_bpm_sw.db","P=MPLN:LTUS:MP02:1,CH=04,INPV=BPMS:UNDS:1690:YCUSBR")
dbLoadRecords("${TOP}/db/lc2_bpm_sw.db","P=MPLN:LTUS:MP02:1,CH=05,INPV=BPMS:UNDS:1990:XCUSBR")
epicsEnvSet("APPID","248")
epicsEnvSet("BAYS","2")
epicsEnvSet("CH0_MPS","")
epicsEnvSet("CH0_L1BSA","")
epicsEnvSet("CH0_P","BEND:DMPS:400")
epicsEnvSet("CH0_R","BACT")
epicsEnvSet("CH0_EGU","GeV/c")
epicsEnvSet("CH1_MPS","")
epicsEnvSet("CH1_L1BSA","")
epicsEnvSet("CH1_P","BEND:LTUS:525")
epicsEnvSet("CH1_R","BACT")
epicsEnvSet("CH1_EGU","GeV/c")
epicsEnvSet("CH2_MPS","")
epicsEnvSet("CH2_L1BSA","")
epicsEnvSet("CH2_P","LBLM:LTUS:105:AS")
epicsEnvSet("CH2_R","LOSS")
epicsEnvSet("CH2_EGU","mV")
epicsEnvSet("CH3_MPS","")
epicsEnvSet("CH3_L1BSA","")
epicsEnvSet("CH3_P","LBLM:LTUH:105:BS")
epicsEnvSet("CH3_R","LOSS")
epicsEnvSet("CH3_EGU","mV")
epicsEnvSet("CH4_WF","")
epicsEnvSet("CH4_GCH","0")
epicsEnvSet("CH4_P","LBLM:LTUS:105:A")
epicsEnvSet("CH4_R","FAST")
epicsEnvSet("CH4_EGU","raw")
