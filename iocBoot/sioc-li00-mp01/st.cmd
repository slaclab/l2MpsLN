#!../../bin/linuxRT-x86_64/l2MpsLN

## You may have to change l2MpsLN to something else
## everywhere it appears in this file

#< envPaths

## Register all support components
dbLoadDatabase("../../dbd/l2MpsLN.dbd",0,0)
l2MpsLN_registerRecordDeviceDriver(pdbbase) 

## Load record instances
dbLoadRecords("../../db/l2MpsLN.db","user=jvasquez")

iocInit()

## Start any sequence programs
#seq sncl2MpsLN,"user=jvasquez"
