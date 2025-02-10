# ===========================================
#      Set Default Environment Variables
# ===========================================

epicsEnvSet("DIGAID","0")
epicsEnvSet("APPID","0")
epicsEnvSet("BAYS","0")
epicsEnvSet("CH0_P","")
epicsEnvSet("CH0_R","")
epicsEnvSet("CH0_EGU","")
epicsEnvSet("CH0_GCH","")
epicsEnvSet("CH1_P","")
epicsEnvSet("CH1_R","")
epicsEnvSet("CH1_EGU","")
epicsEnvSet("CH1_GCH","")
epicsEnvSet("CH2_P","")
epicsEnvSet("CH2_R","")
epicsEnvSet("CH2_EGU","")
epicsEnvSet("CH2_GCH","")
epicsEnvSet("CH3_P","")
epicsEnvSet("CH3_R","")
epicsEnvSet("CH3_EGU","")
epicsEnvSet("CH3_GCH","")
epicsEnvSet("CH4_P","")
epicsEnvSet("CH4_R","")
epicsEnvSet("CH4_EGU","")
epicsEnvSet("CH4_GCH","")
epicsEnvSet("CH5_P","")
epicsEnvSet("CH5_R","")
epicsEnvSet("CH5_EGU","")
epicsEnvSet("CH5_GCH","")
epicsEnvSet("UND","")
epicsEnvSet("BEAMPATH","L")
epicsEnvSet("TPR_MASK","62")
epicsEnvSet("EVR_EC","140")
epicsEnvSet("NC_TS_DELAY","3")
epicsEnvSet("SC_TS_DELAY","4")

# ===========================================
#               DBD LOADING
# ===========================================
## Register all support components
dbLoadDatabase("${TOP}/dbd/l2MpsLN.dbd",0,0)
l2MpsLN_registerRecordDeviceDriver(pdbbase)
