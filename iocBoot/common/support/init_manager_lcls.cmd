# ====================================================================
# Setup environment variables specific to the LCLS environment
# ====================================================================
# MPS Database location
epicsEnvSet("PHYSICS_TOP", "/usr/local/g/lcls/physics")

# MPS history server configurations
epicsEnvSet("MPS_MANAGER_HOST", "lcls-srv02")
