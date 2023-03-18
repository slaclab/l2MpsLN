## Configure asyn port driver
# L2MPSASYNConfig(
#    Port Name)                 # the name given to this port driver
L2MPSASYNConfig("${L2MPSASYN_PORT}")

## Set the MpsManager hostname and port number
# L2MPSASYNSetManagerHost(
#    MpsManagerHostName,   # Server hostname
#    MpsManagerPortNumber) # Server port number
#
# In DEV, the MpsManager runs in lcls-dev3, default port number.
L2MPSASYNSetManagerHost("${MPS_MANAGER_HOST}", 1975)
dbLoadRecords("db/mps${TYPE}.db", "P=${L2MPS_PREFIX}, PORT=${YCPSWASYN_PORT}")
dbLoadRecords("db/modeManager${TYPE}.db", "P=${L2MPS_PREFIX}, NAME=${IOC_NAME}, LOCA=${LOCATION}, IOC_UNIT=${LOCATION_INDEX},INST=${INST},TPR=${TPR}")
dbLoadRecords("db/facMode.template","IOC=${IOC_NAME},FLNK=${IOC_NAME}:SET_FACMODE,INPV=${MODE_INPV},INPR=${MODE_RBV}")
dbLoadRecords("db/timing_rx_error.db", "P=${TPR}, PORT=${YCPSWASYN_PORT}")
