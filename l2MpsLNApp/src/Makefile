TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = l2MpsLN
# l2MpsLN.dbd will be created and installed
DBD += l2MpsLN.dbd

# l2MpsLN.dbd will be made up from these files:
l2MpsLN_DBD += base.dbd

# Include dbd files from all support applications:
#l2MpsLN_DBD += xxx.dbd

# Add all the support libraries needed by this IOC
#l2MpsLN_LIBS += xxx

# l2MpsLN_registerRecordDeviceDriver.cpp derives from l2MpsLN.dbd
l2MpsLN_SRCS += l2MpsLN_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
l2MpsLN_SRCS_DEFAULT += l2MpsLNMain.cpp
l2MpsLN_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#l2MpsLN_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
l2MpsLN_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

