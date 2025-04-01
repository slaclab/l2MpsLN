# =======================================
# Set up analog processing PVs
# =======================================
epicsEnvSet("BEAMPATH","S")
epicsEnvSet("EVR_EC","120")
epicsEnvSet("SEQNUM","2")
epicsEnvSet("SEQBIT","5")
epicsEnvSet("CU","CU")
epicsEnvSet("MODE_INPV", "MPS:UNDS:1:FACMODE CPP MSI")
