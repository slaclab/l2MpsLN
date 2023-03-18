# ====================================================================
# Setup environment variables specific to the DEV environment
# ====================================================================
# MPS Database location
epicsEnvSet("PHYSICS_TOP", "/afs/slac/g/lcls/physics")

# MPS history server configurations
epicsEnvSet("MPS_MANAGER_HOST", "lcls-dev3")
