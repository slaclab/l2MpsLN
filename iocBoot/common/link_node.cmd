# ====================================================================
#
# Generic MPS Link Node Start Up for DEV
#
# ====================================================================

# ====================================================================
# Setup environment variables specific to the DEV environment
# ====================================================================
# MPS Database location
epicsEnvSet("PHYSICS_TOP", "/usr/local/g/lcls/physics")
epicsEnvSet("STATIC_IOC", "sioc-bpn25-mp01")

# MPS history server configurations
epicsEnvSet("MPS_MANAGER_HOST", "lcls-srv02")

# ====================================================================
# Load the common Central Node startup
# ====================================================================
 < ${TOP}/iocBoot/common/link_node_launch.cmd
