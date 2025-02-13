epicsEnvSet("LN","65")
epicsEnvSet("MPS_CONFIG_VERSION","2025-01-09-a")
epicsEnvSet("L2MPS_PREFIX","MPLN:BC2B:MP02:1")
epicsEnvSet("CRATE","0")
epicsEnvSet("SLOT_ID","2")
epicsEnvSet("LOCATION","BC2B")
epicsEnvSet("LOCATION_INDEX","MP02")
epicsEnvSet("SHM","shm-bc2b-sp02-1")
epicsEnvSet("DIGAID","358")
dbLoadRecords("${TOP}/db/lc2_watchdog.db","P=MPLN:BC2B:MP02:1,CH=00,INPV=SIOC:BC2B:MP02:HEARTBEAT")
epicsEnvSet("APPID","75")
epicsEnvSet("BAYS","2")
epicsEnvSet("CH0_MPS","")
epicsEnvSet("CH0_P","LBLM:L2B:1587:A")
epicsEnvSet("CH0_R","LOSS")
epicsEnvSet("CH0_EGU","mV")
epicsEnvSet("CH1_MPS","")
epicsEnvSet("CH1_P","LBLM:L2B:1587:B")
epicsEnvSet("CH1_R","LOSS")
epicsEnvSet("CH1_EGU","mV")
epicsEnvSet("CH2_WF","")
epicsEnvSet("CH2_GCH","0")
epicsEnvSet("CH2_P","LBLM:L2B:1587:B")
epicsEnvSet("CH2_R","FAST")
epicsEnvSet("CH2_EGU","raw")
epicsEnvSet("CH3_WF","")
epicsEnvSet("CH3_GCH","0")
epicsEnvSet("CH3_P","LBLM:L2B:1587:A")
epicsEnvSet("CH3_R","FAST")
epicsEnvSet("CH3_EGU","raw")
