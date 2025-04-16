# Set the IS_DN flag to ignore commands later in startup
epicsEnvSet("IS_DN","#")
dbLoadRecords("db/mitigation.db", "P=${L2MPS_PREFIX}, CARED_FOR=${CARED_FOR}")
