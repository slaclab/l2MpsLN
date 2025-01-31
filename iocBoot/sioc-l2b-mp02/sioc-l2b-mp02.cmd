epicsEnvSet("LN","61")
epicsEnvSet("MPS_CONFIG_VERSION","2025-01-09-a")
epicsEnvSet("L2MPS_PREFIX","MPLN:L2B:MP02:1")
epicsEnvSet("CRATE","0")
epicsEnvSet("SLOT_ID","2")
epicsEnvSet("LOCATION","L2B")
epicsEnvSet("LOCATION_INDEX","MP02")
epicsEnvSet("SHM","shm-l2b-sp02-1")
epicsEnvSet("DIGAID","56")
dbLoadRecords("${TOP}/db/lc2_watchdog.db","P=MPLN:L2B:MP02:1,CH=00,INPV=SIOC:L2B:MP02:HEARTBEAT")
dbLoadRecords("${TOP}/db/lc2_analog_sw.db","P=MPLN:L2B:MP02:1,CH=01,INPV=QUAD:L2B:0585:INTOL,NAME=QUAD:L2B:0585:INTOL")
dbLoadRecords("${TOP}/db/lc2_analog_sw.db","P=MPLN:L2B:MP02:1,CH=02,INPV=QUAD:L2B:0685:INTOL,NAME=QUAD:L2B:0685:INTOL")
dbLoadRecords("${TOP}/db/lc2_analog_sw.db","P=MPLN:L2B:MP02:1,CH=03,INPV=QUAD:L2B:0785:INTOL,NAME=QUAD:L2B:0785:INTOL")
dbLoadRecords("${TOP}/db/lc2_analog_sw.db","P=MPLN:L2B:MP02:1,CH=04,INPV=QUAD:L2B:0885:INTOL,NAME=QUAD:L2B:0885:INTOL")
dbLoadRecords("${TOP}/db/lc2_analog_sw.db","P=MPLN:L2B:MP02:1,CH=05,INPV=QUAD:L2B:0985:INTOL,NAME=QUAD:L2B:0985:INTOL")
dbLoadRecords("${TOP}/db/lc2_analog_sw.db","P=MPLN:L2B:MP02:1,CH=06,INPV=QUAD:L2B:1085:INTOL,NAME=QUAD:L2B:1085:INTOL")
dbLoadRecords("${TOP}/db/lc2_analog_sw.db","P=MPLN:L2B:MP02:1,CH=07,INPV=QUAD:L2B:1185:INTOL,NAME=QUAD:L2B:1185:INTOL")
dbLoadRecords("${TOP}/db/lc2_analog_sw.db","P=MPLN:L2B:MP02:1,CH=08,INPV=QUAD:L2B:1285:INTOL,NAME=QUAD:L2B:1285:INTOL")
dbLoadRecords("${TOP}/db/lc2_analog_sw.db","P=MPLN:L2B:MP02:1,CH=09,INPV=QUAD:L2B:1385:INTOL,NAME=QUAD:L2B:1385:INTOL")
dbLoadRecords("${TOP}/db/lc2_analog_sw.db","P=MPLN:L2B:MP02:1,CH=10,INPV=QUAD:L2B:1485:INTOL,NAME=QUAD:L2B:1485:INTOL")
dbLoadRecords("${TOP}/db/lc2_analog_sw.db","P=MPLN:L2B:MP02:1,CH=11,INPV=QUAD:L2B:1585:INTOL,NAME=QUAD:L2B:1585:INTOL")
dbLoadRecords("${TOP}/db/lc2_analog_sw.db","P=MPLN:L2B:MP02:1,CH=12,INPV=QUAD:L2B:0485:INTOL,NAME=QUAD:L2B:0485:INTOL")
