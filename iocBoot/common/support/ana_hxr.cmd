# =======================================
# Set up analog processing PVs
# =======================================
epicsEnvSet("BEAMPATH","L")
epicsEnvSet("EVR_EC","119")
epicsEnvSet("SEQNUM","2")
epicsEnvSet("SEQBIT","5")
epicsEnvSet("CU","CU")
epicsEnvSet("MODE_INPV", "MPS:UNDH:1:FACMODE CPP MSI")
