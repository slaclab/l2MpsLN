TOP=../..
include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE

#----------------------------------------------------
#  Optimization of db files using dbst (DEFAULT: NO)
#DB_OPT = YES

#----------------------------------------------------
# Create and install (or just install) into <top>/db
# databases, templates, substitutions like this

# ==========================================
# LCLS2 MPS application specific databases
# ==========================================
# Common database to all applications
DB_INSTALLS += $(L2MPSASYN)/db/mps.db
# Application specific database
DB_INSTALLS += $(L2MPSASYN)/db/mps_blm.db
DB_INSTALLS += $(L2MPSASYN)/db/mps_scale_factor.db
# ==========================================

# ==========================================
# MPS LN specific databases
# ==========================================
DB += mpsLN.db
DB += mpsAN.db
DB += mpsDN.db
DB += modeManagerLN.db
DB += modeManagerAN.db
# ==========================================

# For saving and loading yaml configuration
DB += saveLoadConfig.db

# Install Common databases needed by All IOCs
# ========================================================
# Install databases from iocAdmin package
# These databases support IOC Health and Monitoring
# ========================================================
DB_INSTALLS += $(IOCADMIN)/db/iocAdminSoft.db
DB_INSTALLS += $(IOCADMIN)/db/iocAdminScanMon.db
IOCRELEASE_DB += iocRelease.db

# Install Database to support reading the status of the autosave package:
DB_INSTALLS += $(AUTOSAVE)/db/save_restoreStatus.db

# Install Database to support reading the status of the seq package:
DB_INSTALLS += $(SEQ)/db/devSeqCar.db

# Install Database for tprTrigger module
DB_INSTALLS += $(TPRTRIGGER)/db/tprTrig.db
DB_INSTALLS += $(TPRTRIGGER)/db/tprDeviceNamePV.db

# Install Database for tprPattern module
DB_INSTALLS += $(TPRPATTERN)/db/tprPattern.db

# Install Database for crossbarControl module
DB_INSTALLS += $(CROSSBARCONTROL)/db/crossbarCtrl.db

# Install Database for the evrClient module
DB_INSTALLS += $(EVRCLIENT)/db/evr.db
DB_INSTALLS += $(EVRCLIENT)/db/evrEventCtrl.db
DB_INSTALLS += $(EVRCLIENT)/db/evrPatternAll.db
DB_INSTALLS += $(EVRCLIENT)/db/evrEventAll.db
DB_INSTALLS += $(EVRCLIENT)/db/evrDevTrig.db
DB_INSTALLS += $(EVRCLIENT)/db/bsaATTREdef.db

#----------------------------------------------------
# If <anyname>.db template is not named <anyname>*.template add
# <anyname>_template = <templatename>

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

