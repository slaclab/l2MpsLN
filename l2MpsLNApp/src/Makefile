TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================
USR_CXXFLAGS += -std=c++0x

# =====================================================
# Path to "NON EPICS" External PACKAGES: USER INCLUDES
# ======================================================
USR_INCLUDES += -I$(BOOST_INCLUDE)
USR_INCLUDES += -I$(CPSW_FRAMEWORK_INCLUDE)
USR_INCLUDES += -I$(YAML_INCLUDE)
USR_INCLUDES += -I$(YAMLREADER_INCLUDE)
USR_INCLUDES += -I$(DEVICELIB_INCLUDE)
USR_INCLUDES += -I$(COMMONATCA_INCLUDE)
USR_INCLUDES += -I$(HPSTPR_INCLUDE)
USR_INCLUDES += -I$(BSA_INCLUDE)
USR_INCLUDES += -I$(L2MPS_INCLUDE)
# =====================================================

# ======================================================
#PATH TO "NON EPICS" EXTERNAL PACKAGES: USER LIBRARIES
# ======================================================
cpsw_DIR          = $(CPSW_FRAMEWORK_LIB)
yaml-cpp_DIR      = $(YAML_LIB)
l2Mps_DIR         = $(L2MPS_LIB)
deviceLib_DIR     = $(DEVICELIB_LIB)
yamlReader_DIR    = $(YAMLREADER_LIB)
hpstpr_DIR        = $(HPSTPR_LIB)
boost_system_DIR  = $(BOOST_LIB)
hpstpr_DIR        = $(HPSTPR_LIB)
bsa_DIR           = $(BSA_LIB)
commonATCA_DIR    = $(COMMONATCA_LIB)

# =====================================================

# ======================================================
# LINK "NON EPICS" EXTERNAL PACKAGE LIBRARIES STATICALLY
# =======================================================
USR_LIBS_Linux += l2Mps    
USR_LIBS_Linux += cpsw 
USR_LIBS_Linux += boost_system 
USR_LIBS_Linux += yaml-cpp 
USR_LIBS_Linux += hpstpr 
USR_LIBS_Linux += bsa 
USR_LIBS_Linux += commonATCA
USR_LIBS_Linux += yamlReader 
USR_LIBS_Linux += deviceLib
# ======================================================

#=============================
# Build the IOC application
#============================
#PROD_IOC_linuxRT-x86_64 = l2MpsLN
#PROD_IOC = $(PROD_IOC_$(T_A))

PROD_IOC = l2MpsLN


# l2MpsLN.dbd will be created and installed
DBD += l2MpsLN.dbd

# l2MpsLN.dbd will be made up from these files:
l2MpsLN_DBD += base.dbd
l2MpsLN_DBD += devIocStats.dbd
l2MpsLN_DBD += asSupport.dbd
l2MpsLN_DBD += l2mps_l1bsa.dbd

# Include dbd files from all support applications:
l2MpsLN_DBD += system.dbd
l2MpsLN_DBD += asyn.dbd
l2MpsLN_DBD += l2MpsAsyn.dbd
l2MpsLN_DBD += yamlLoader.dbd
l2MpsLN_DBD += ycpswasyn.dbd
l2MpsLN_DBD += yamlDownloader.dbd
l2MpsLN_DBD += tprTriggerAsynDriver.dbd
l2MpsLN_DBD += tprPatternAsynDriver.dbd
l2MpsLN_DBD += bsaCore.dbd
l2MpsLN_DBD += bsa.dbd
l2MpsLN_DBD += iocAdmin.dbd
l2MpsLN_DBD += devSeqCar.dbd
l2MpsLN_DBD += crossbarControl.dbd
l2MpsLN_DBD += ATCACommon.dbd
l2MpsLN_DBD += bsaAsynDriver.dbd
l2MpsLN_DBD += pvxsIoc.dbd
l2MpsLN_DBD += streamManipulation.dbd

# l2MpsLN_registerRecordDeviceDriver.cpp derives from l2MpsLN.dbd
l2MpsLN_SRCS += l2MpsLN_registerRecordDeviceDriver.cpp
l2MpsLN_SRCS += IOCfunctions.cpp
l2MpsLN_SRCS += l2MpsLnDriver.cpp
l2MpsLN_SRCS += l2mps_l1bsa.cpp l2mps_l1bsa_channels.cpp
l2MpsLN_SRCS += asubG2V.c asubRWF2EGU.c asubV2RAW.c

# Add all the support libraries needed by this IOC
l2MpsLN_LIBS += devIocStats
l2MpsLN_LIBS += autosave
l2MpsLN_LIBS += ATCACommon
l2MpsLN_LIBS += yamlLoader
l2MpsLN_LIBS += l2MpsAsyn
l2MpsLN_LIBS += yamlDownloader
l2MpsLN_LIBS += ycpswasyn
l2MpsLN_LIBS += eventBsaSupport
l2MpsLN_LIBS += tprPattern
l2MpsLN_LIBS += tprTrigger
l2MpsLN_LIBS += bsaDriver
l2MpsLN_LIBS += BsaCore
l2MpsLN_LIBS += asyn
l2MpsLN_LIBS += seqCar seq pv
l2MpsLN_LIBS += pvxsIoc
l2MpsLN_LIBS += pvxs
#l2MpsLN_LIBS += streamManipulation

# Link QSRV (pvAccess Server) if available
ifdef EPICS_QSRV_MAJOR_VERSION
   l2MpsLN_LIBS += qsrv
   l2MpsLN_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
   l2MpsLN_DBD  += PVAServerRegister.dbd
   l2MpsLN_DBD  += qsrv.dbd
endif


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

