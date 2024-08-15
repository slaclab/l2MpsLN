#!iocSpecificRelease/bin/linuxRT-x86_64/l2MpsLN
#
# SIOC:B34:MP11
# shm-b34-sp08-1 slot 2

< envPaths

< ${TOP}/iocBoot/common/support/ana_default.cmd

< ${TOP}/iocBoot/${IOC}/${IOC}.cmd

epicsEnvSet("FPGA_IP","10.${CRATE}.1.10${SLOT_ID}")
#
# Load common Link Node startup
#
< ${TOP}/iocBoot/common/start.cmd

system("scripts/setupBPClockRT.sh $(SHM}")