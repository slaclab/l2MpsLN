# =======================================
# Set up analog processing PVs
# =======================================
epicsEnvSet("BEAMPATH","S")
epicsEnvSet("EVR_EC","120")
epicsEnvSet("SEQNUM","1")
epicsEnvSet("SEQBIT","13")
epicsEnvSet("CU","CU")
epicsEnvSet("MODE_INPV", "MPS:UNDS:1:FACMODE CPP MSI")
