# ====================================================================
#
# Generic MPS Link Node Start Up for DEV
#
# ====================================================================

# ====================================================================
# Setup environment variables specific to the DEV environment
# ====================================================================
# MPS Database location
epicsEnvSet("PHYSICS_TOP", "/afs/slac/g/lcls/physics")
epicsEnvSet("STATIC_IOC", "sioc-b34-mp01")

# MPS history server configurations
epicsEnvSet("MPS_MANAGER_HOST", "lcls-dev3")

# ====================================================================
# Load the common Central Node startup
# ====================================================================
 < ${TOP}/iocBoot/common/link_node_launch.cmd
