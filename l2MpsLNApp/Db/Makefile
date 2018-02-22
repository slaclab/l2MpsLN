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
DB_INSTALLS += $(L2MPSASYN)/db/blm.db
# ==========================================

# ================================================
# YCPSWASYN databases
# ================================================
DB_INSTALLS += $(YCPSWASYN)/db/RegisterIn.template
DB_INSTALLS += $(YCPSWASYN)/db/RegisterOut.template
DB += mpsLN.db
# ================================================

#----------------------------------------------------
# If <anyname>.db template is not named <anyname>*.template add
# <anyname>_template = <templatename>

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

