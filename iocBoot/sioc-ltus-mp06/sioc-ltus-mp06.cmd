epicsEnvSet("LN","209")
epicsEnvSet("MPS_CONFIG_VERSION","2025-01-09-a")
epicsEnvSet("L2MPS_PREFIX","MPLN:LTUS:MP06:1")
epicsEnvSet("CRATE","0")
epicsEnvSet("SLOT_ID","2")
epicsEnvSet("LOCATION","LTUS")
epicsEnvSet("LOCATION_INDEX","MP06")
epicsEnvSet("SHM","shm-ltus-sp04-1")
epicsEnvSet("DIGAID","347")
dbLoadRecords("${TOP}/db/lc2_watchdog.db","P=MPLN:LTUS:MP06:1,CH=00,INPV=SIOC:LTUS:MP06:HEARTBEAT")
dbLoadRecords("${TOP}/db/lc2_analog_sw.db","P=MPLN:LTUS:MP06:1,CH=01,INPV=WIGG:LTUS:724:US:EncRbck,NAME=WIGG:LTUS:724:US_OUT")
dbLoadRecords("${TOP}/db/lc2_analog_sw.db","P=MPLN:LTUS:MP06:1,CH=02,INPV=WIGG:LTUS:724:DS:EncRbck,NAME=WIGG:LTUS:724:DS_IN")
dbLoadRecords("${TOP}/db/lc2_analog_sw.db","P=MPLN:LTUS:MP06:1,CH=03,INPV=WIGG:LTUS:724:DS:EncRbck,NAME=WIGG:LTUS:724:DS_OUT")
dbLoadRecords("${TOP}/db/lc2_analog_sw.db","P=MPLN:LTUS:MP06:1,CH=08,INPV=WIGG:LTUS:770:US:EncRbck,NAME=WIGG:LTUS:770:US_IN")
dbLoadRecords("${TOP}/db/lc2_analog_sw.db","P=MPLN:LTUS:MP06:1,CH=09,INPV=WIGG:LTUS:770:US:EncRbck,NAME=WIGG:LTUS:770:US_OUT")
dbLoadRecords("${TOP}/db/lc2_analog_sw.db","P=MPLN:LTUS:MP06:1,CH=10,INPV=WIGG:LTUS:770:DS:EncRbck,NAME=WIGG:LTUS:770:DS_IN")
dbLoadRecords("${TOP}/db/lc2_analog_sw.db","P=MPLN:LTUS:MP06:1,CH=11,INPV=WIGG:LTUS:770:DS:EncRbck,NAME=WIGG:LTUS:770:DS_OUT")
dbLoadRecords("${TOP}/db/lc2_analog_sw.db","P=MPLN:LTUS:MP06:1,CH=12,INPV=WIGG:LTUS:774:US:EncRbck,NAME=WIGG:LTUS:774:US_IN")
dbLoadRecords("${TOP}/db/lc2_analog_sw.db","P=MPLN:LTUS:MP06:1,CH=13,INPV=WIGG:LTUS:774:US:EncRbck,NAME=WIGG:LTUS:774:US_OUT")
dbLoadRecords("${TOP}/db/lc2_analog_sw.db","P=MPLN:LTUS:MP06:1,CH=14,INPV=WIGG:LTUS:774:DS:EncRbck,NAME=WIGG:LTUS:774:DS_IN")
dbLoadRecords("${TOP}/db/lc2_analog_sw.db","P=MPLN:LTUS:MP06:1,CH=15,INPV=WIGG:LTUS:774:DS:EncRbck,NAME=WIGG:LTUS:774:DS_OUT")
epicsEnvSet("APPID","278")
epicsEnvSet("BAYS","2")
epicsEnvSet("CH2_MPS","")
epicsEnvSet("CH2_L1BSA","")
epicsEnvSet("CH2_P","LBLM:LTUS:738:AS")
epicsEnvSet("CH2_R","LOSS")
epicsEnvSet("CH2_EGU","mV")
epicsEnvSet("CH3_MPS","")
epicsEnvSet("CH3_L1BSA","")
epicsEnvSet("CH3_P","LBLM:LTUH:738:AS")
epicsEnvSet("CH3_R","LOSS")
epicsEnvSet("CH3_EGU","mV")
epicsEnvSet("CH4_MPS","")
epicsEnvSet("CH4_L1BSA","")
epicsEnvSet("CH4_P","LBLM:LTUS:738:BS")
epicsEnvSet("CH4_R","LOSS")
epicsEnvSet("CH4_EGU","mV")
epicsEnvSet("CH5_MPS","")
epicsEnvSet("CH5_L1BSA","")
epicsEnvSet("CH5_P","LBLM:LTUH:738:BS")
epicsEnvSet("CH5_R","LOSS")
epicsEnvSet("CH5_EGU","mV")
