# ===========================================
#             LCLS2 BSA Driver
# ===========================================
< ${TOP}/iocBoot/common/support/init_lc2_bsa.cmd

# ===========================================
#               MPS Driver
# ===========================================
< ${TOP}/iocBoot/common/support/init_mps_driver.cmd

# ===========================================
#             LCLS1 BSA Driver
# ===========================================
< ${TOP}/iocBoot/common/support/init_lc1_bsa.cmd

# ===========================================
#             LCLS2 BSAS Driver
# ===========================================
# < ${TOP}/iocBoot/common/support/init_lc2_bsas.cmd

# ===========================================
#          Load LN Specific databases
# ===========================================
dbLoadRecords("db/mpsWF.db","WF=${WF0},WFA=${WFA0},BAY=0,CH=0,ST=0, PORT=${YCPSWASYN_PORT}")
dbLoadRecords("db/mpsWF.db","WF=${WF1},WFA=${WFA1},BAY=0,CH=1,ST=1, PORT=${YCPSWASYN_PORT}")
dbLoadRecords("db/mpsWF.db","WF=${WF2},WFA=${WFA2},BAY=0,CH=2,ST=2, PORT=${YCPSWASYN_PORT}")
dbLoadRecords("db/mpsWF.db","WF=${WF3},WFA=${WFA3},BAY=1,CH=0,ST=4, PORT=${YCPSWASYN_PORT}")
dbLoadRecords("db/mpsWF.db","WF=${WF4},WFA=${WFA4},BAY=1,CH=1,ST=5, PORT=${YCPSWASYN_PORT}")
dbLoadRecords("db/mpsWF.db","WF=${WF5},WFA=${WFA5},BAY=1,CH=2,ST=6, PORT=${YCPSWASYN_PORT}")
dbLoadRecords("db/mpsGC.db","GC=${GC0},GCA=${GCA0},BAY=0,CH=0, PORT=${YCPSWASYN_PORT}")
dbLoadRecords("db/mpsGC.db","GC=${GC1},GCA=${GCA1},BAY=0,CH=1, PORT=${YCPSWASYN_PORT}")
dbLoadRecords("db/mpsGC.db","GC=${GC2},GCA=${GCA2},BAY=1,CH=0, PORT=${YCPSWASYN_PORT}")
dbLoadRecords("db/mpsGC.db","GC=${GC3},GCA=${GCA3},BAY=1,CH=1, PORT=${YCPSWASYN_PORT}")

set_pass0_restoreFile("ana_units.sav")
set_pass1_restoreFile("ana_units.sav")
