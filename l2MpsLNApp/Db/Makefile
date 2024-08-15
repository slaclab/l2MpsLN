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

# ==========================================
# MPS LN specific databases
# ==========================================
DB += mpsLN.db
DB += mpsAN.db
DB += mpsDN.db
DB += mps_wf.db
DB += modeManagerLN.db
DB += modeManagerAN.db
DB += modeManagerDN.db
DB += l2MpsL1Bsa.db
DB += facMode.template
DB += amc_ai.db
DB += l1_bsa.db
DB += ioc_management.db
DB += tpr_management.db
DB += analog0bay.db
DB += analog1bay.db
DB += analog2bay.db
# ==========================================

# For saving and loading yaml configuration
DB += saveLoadConfig.db

#----------------------------------------------------
# If <anyname>.db template is not named <anyname>*.template add
# <anyname>_template = <templatename>

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

