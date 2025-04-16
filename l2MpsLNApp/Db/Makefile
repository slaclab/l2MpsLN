TOP=../..
include $(TOP)/configure/CONFIG

IOCRELEASE_DB += iocRelease.db
# ==========================================================
# SC Timing: Pull in Database Templates for BSA/BSSS
# ==========================================================
DB_INSTALLS += $(BSADRIVER)/db/bsssCtrl.db
DB_INSTALLS += $(BSADRIVER)/db/bsasCtrl.db

# ==========================================================
# SC Timing: Pull in Database Templates for BSA/BSSS
# ==========================================================
DB_INSTALLS += $(L2MPSASYN)/db/mps.db
DB_INSTALLS += $(L2MPSASYN)/db/mps_soft.db
DB_INSTALLS += $(L2MPSASYN)/db/lc2_analog_sw.db
DB_INSTALLS += $(L2MPSASYN)/db/lc2_bpm_sw.db
DB_INSTALLS += $(L2MPSASYN)/db/lc2_watchdog.db



# ==========================================
# MPS LN specific databases
# ==========================================
DB += mpsLN.db
DB += mpsLN_UND.db
DB += mpsAN.db
DB += mpsAN_UND.db
DB += mpsDN.db
DB += mps_wf.db
DB += modeManagerLN.db
DB += modeManagerLN_UND.db
DB += modeManagerAN.db
DB += modeManagerAN_UND.db
DB += modeManagerDN.db
DB += l2MpsL1Bsa.db
DB += facMode.template
DB += amc_ai.db
DB += amc_ai_UND.db
DB += l1_bsa.db
DB += ioc_management.db
DB += tpr_management.db
DB += analog0bay.db
DB += analog1bay.db
DB += analog2bay.db
DB += mitigation.db
# ==========================================

# For saving and loading yaml configuration
DB += saveLoadConfig.db

#----------------------------------------------------
# If <anyname>.db template is not named <anyname>*.template add
# <anyname>_template = <templatename>

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

