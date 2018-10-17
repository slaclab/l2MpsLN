# LCLS-II MPS Link Node

This is the LCLS-II MPS Link Node.


Virtual Channels
----------------

Link Nodes can have virtual channels (i.e. digital inputs driven by external EPICS PVs) besides regular digital and analog channels. Virtual channels are defined in the MPS configuration database and exported as EPICS databases that should be loaded by the link node.

In the st.cmd of the link node the call to initialize the virtual channel asyn driver should be added:

```
configureVirtualChannel("MPS_VIRTUAL_CHANNEL")
```

The generated EPICS database is located in the 'mps_configuration' area, under the link_node_db/<sioc-name> directory. The file name is virtual_inputs.db:

```
# ===========================================
#               VIRTUAL CHANNELS DB
# ===========================================
epicsEnvSet("MPS_ENV_DATABASE_VERSION", "import")
#epicsEnvSet("PHYSICS_TOP", "/usr/local/lcls/physics") # PROD
#epicsEnvSet("PHYSICS_TOP", "/afs/slac/g/lcls/physics") # DEV
epicsEnvSet("PHYSICS_TOP", "/afs/slac/u/cd/lpiccoli/top") # DEV2
epicsEnvSet("MPS_ENV_CONFIG_VERSION", "./")
epicsEnvSet("MPS_ENV_CONFIG_PATH", "${PHYSICS_TOP}/mps_configuration/${MPS_ENV_DATABASE_VERSION}")
dbLoadRecords("${MPS_ENV_CONFIG_PATH}/link_node_db/sioc-gunb-mp01/virtual_inputs.db")
```