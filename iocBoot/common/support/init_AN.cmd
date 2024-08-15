# ===========================================
#   First set flag that this is not a LN
# ===========================================
epicsEnvSet("IS_LN","#")

# ===========================================
#      Then AN is the same as the LN
# ===========================================
< ${TOP}/iocBoot/common/support/init_LN.cmd
