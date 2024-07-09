## Configure the LCLS1 BSA driver
# L2MpsL1BsaConfig(
#    streamName,                # Name of the CPSW stream interface for the LCLS1 BSA data
#    recordPrefix)              # Record name prefix for the LCLS1 BSA PVs
L2MpsL1BsaConfig("Lcls1BsaStream", "L2MPS_L1BSA")
dbLoadRecords("db/l2MpsL1Bsa.db","P=${L2MPS_PREFIX}")
