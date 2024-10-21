# ===========================================
#             LCLS2 BSA Driver
# ===========================================
 < ${TOP}/iocBoot/common/support/init_lc2_bsa.cmd

# ===========================================
#             LCLS2 BSAS Driver
# ===========================================
 < ${TOP}/iocBoot/common/support/init_lc2_bsas.cmd

# ===========================================
#         Load LN Soft Input databases
# ===========================================

$(IS_LN="")dbLoadRecords("db/mps_soft.db","P=${L2MPS_PREFIX},PORT=${L2MPSASYN_PORT}")

# ===========================================
#       Load MPS Analog Input databases
# ===========================================
# Channel 0
$(CH0_MPS=#)dbLoadRecords("db/amc_ai.db","P=${CH0_P},ATTR=${CH0_R},EGU=${CH0_EGU},BAY=0,INP=0,TPR=$(TPR)")
$(CH0_L1BSA=#)dbLoadRecords("db/l1_bsa.db","P=${CH0_P},ATTR=${CH0_R},EGU=${CH0_EGU},BAY=0,INP=0")
$(CH0_WF=#)dbLoadRecords("db/mps_wf.db","P=${CH0_P},BAY=0,INP=0,GCH=${CH0_GCH}")

# Channel 1
$(CH1_MPS=#)dbLoadRecords("db/amc_ai.db","P=${CH1_P},ATTR=${CH1_R},EGU=${CH1_EGU},BAY=0,INP=1,TPR=$(TPR)")
$(CH1_L1BSA=#)dbLoadRecords("db/l1_bsa.db","P=${CH1_P},ATTR=${CH1_R},EGU=${CH1_EGU},BAY=0,INP=1")
$(CH1_WF=#)dbLoadRecords("db/mps_wf.db","P=${CH1_P},BAY=0,INP=0,GCH=${CH1_GCH}")

# Channel 2
$(CH2_MPS=#)dbLoadRecords("db/amc_ai.db","P=${CH2_P},ATTR=${CH2_R},EGU=${CH2_EGU},BAY=0,INP=2,TPR=$(TPR)")
$(CH2_L1BSA=#)dbLoadRecords("db/l1_bsa.db","P=${CH2_P},ATTR=${CH2_R},EGU=${CH2_EGU},BAY=0,INP=2")
$(CH2_WF=#)dbLoadRecords("db/mps_wf.db","P=${CH2_P},BAY=0,INP=0,GCH=${CH2_GCH}")

# Channel 3
$(CH3_MPS=#)dbLoadRecords("db/amc_ai.db","P=${CH3_P},ATTR=${CH3_R},EGU=${CH3_EGU},BAY=1,INP=0,TPR=$(TPR)")
$(CH3_L1BSA=#)dbLoadRecords("db/l1_bsa.db","P=${CH3_P},ATTR=${CH3_R},EGU=${CH3_EGU},BAY=1,INP=0")
$(CH3_WF=#)dbLoadRecords("db/mps_wf.db","P=${CH3_P},BAY=0,INP=0,GCH=${CH3_GCH}")

# Channel 4
$(CH4_MPS=#)dbLoadRecords("db/amc_ai.db","P=${CH4_P},ATTR=${CH4_R},EGU=${CH4_EGU},BAY=1,INP=1,TPR=$(TPR)")
$(CH4_L1BSA=#)dbLoadRecords("db/l1_bsa.db","P=${CH4_P},ATTR=${CH4_R},EGU=${CH4_EGU},BAY=1,INP=1")
$(CH4_WF=#)dbLoadRecords("db/mps_wf.db","P=${CH4_P},BAY=0,INP=0,GCH=${CH4_GCH}")

# Channel 5
$(CH5_MPS=#)dbLoadRecords("db/amc_ai.db","P=${CH5_P},ATTR=${CH5_R},EGU=${CH5_EGU},BAY=1,INP=2,TPR=$(TPR)")
$(CH5_L1BSA=#)dbLoadRecords("db/l1_bsa.db","P=${CH5_P},ATTR=${CH5_R},EGU=${CH5_EGU},BAY=1,INP=2")
$(CH5_WF=#)dbLoadRecords("db/mps_wf.db","P=${CH5_P},BAY=0,INP=0,GCH=${CH5_GCH}")

set_pass0_restoreFile("ana_units.sav")
set_pass1_restoreFile("ana_units.sav")
