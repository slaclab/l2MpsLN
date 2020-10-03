#!/usr/bin/env python
import os
import sys
import argparse
from epics import caget, caput

def change_units(PV, newHigh, newLow, newEGU, integrator=False):
  tempPV = '{pv}.EGU'.format(pv=PV)
  caput(tempPV,newEGU)
  if not integrator:
    tempPV1 = '{pv}.EGUF'.format(pv=PV)
    caput(tempPV1, newHigh)
    tempPV1 = '{pv}.EGUL'.format(pv=PV)
    caput(tempPV1, newLow)

#=== MAIN ==================================================================================
parser = argparse.ArgumentParser(description='Adjust scale and units for MPS analog inputs')
parser.add_argument('--prefix', metavar='prefix', required=True, help="MPLN Prefix for link node")
parser.add_argument('--ch', metavar='channel', required=True, help="MPLN Analog input channel number")
parser.add_argument('--slope', metavar='Slope', required=True, help="Conversion slope in raw/egu")
parser.add_argument('--offset', metavar='offset', required=True, help="Conversion offset in raw")
parser.add_argument('--egu', metavar='EGU', required=True, help="Engineering Units (String)")
parser.add_argument('--int',metavar="1 or 2",required=True,help="Number of integrators (1 or 2)")
args = parser.parse_args()

prefix = args.prefix
slope = float(args.slope)
offset = float(args.offset)
adcChannel = int(args.ch)
units = args.egu
nInt=int(args.int)
device = caget('{0}:CH{1}_PVNAME'.format(prefix,adcChannel))
fType = caget('{0}:CH{1}_FAULT_TYPE'.format(prefix,adcChannel))

typ = device.split(':')[0]
print typ

lowADC = -32768
highADC = 32768
totalADC = 65536

lowerLimit = (lowADC - offset) / slope
upperLimit = (highADC - offset) / slope
rang = upperLimit - lowerLimit

egul = (0-offset) / slope
eguf = rang + egul

maxVal = eguf
minVal = egul

PV = '{p}:ANA_MIN_VAL_{ch}'.format(p=prefix,ch=adcChannel)
change_units(PV, maxVal, minVal, units)

PV = '{p}:ANA_AVG_VAL_{ch}'.format(p=prefix,ch=adcChannel)
change_units(PV, maxVal,minVal, units)

PV = '{p}:ANA_MAX_VAL_{ch}'.format(p=prefix,ch=adcChannel)
change_units(PV, maxVal,minVal, units)

PV = '{p}:LC1_ANA_FPRCVAL_{ch}'.format(p=prefix,ch=adcChannel)
change_units(PV, maxVal,minVal, units)

PV = '{p}:LC1_ANA_FPRCVAL_{ch}_RBV'.format(p=prefix,ch=adcChannel)
change_units(PV, maxVal,minVal, units)

PV = '{p}:LC2_ANA_FPRCVAL_{ch}'.format(p=prefix,ch=adcChannel)
change_units(PV, maxVal,minVal, units)

PV = '{p}:LC2_ANA_FPRCVAL_{ch}_RBV'.format(p=prefix,ch=adcChannel)
change_units(PV, maxVal,minVal, units)

PV = '{p}:ANA_BSA_DATA_{ch}'.format(p=prefix,ch=adcChannel)
change_units(PV, maxVal,minVal, units)

PV = '{p}:ANA_BSA_DATA_{ch}'.format(p=prefix,ch=adcChannel+6)
change_units(PV, maxVal,minVal, units)

PV = '{p}:ANA_BSA_DATA_{ch}'.format(p=prefix,ch=adcChannel+12)
change_units(PV, maxVal,minVal, units)

PV = '{p}:ANA_BSA_DATA_{ch}'.format(p=prefix,ch=adcChannel+18)
change_units(PV, maxVal,minVal, units)

PV = '{p}:ADC_DATA_{ch}'.format(p=prefix,ch=adcChannel)
change_units(PV, maxVal, minVal, units)

maxVal = maxVal/2

prefix = device

slope = 1. / (slope)

print slope
print offset
for integrator in range(nInt):

  PV = '{p}:I{i}_FWSLO'.format(p=prefix,i=integrator)
  caput(PV,slope)
  TempUnits = "{u}/raw".format(u=units)
  change_units(PV,maxVal,minVal,TempUnits,True)
  PV = '{p}:I{i}_SS_RBV'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,TempUnits,True)
  if typ == 'CBLM':
  	PV = '{p}:I{i}_{ty}.ASLO'.format(p=prefix,i=integrator,ty=fType)
  	caput(PV,slope)

  PV = '{p}:I{i}_FWOFF'.format(p=prefix,i=integrator)
  caput(PV,offset)
  if typ == 'CBLM':
  	PV = '{p}:I{i}_{ty}.AOFF'.format(p=prefix,i=integrator,ty=fType)
  	caput(PV,egul)
  	
  PV = '{p}:I{i}_{ty}HXR.ASLO'.format(p=prefix,i=integrator,ty=fType)
  caput(PV,slope)
  PV = '{p}:I{i}_{ty}HXR.AOFF'.format(p=prefix,i=integrator,ty=fType)
  caput(PV,offset)
  PV = '{p}:I{i}_{ty}SXR.ASLO'.format(p=prefix,i=integrator,ty=fType)
  caput(PV,slope)
  PV = '{p}:I{i}_{ty}SXR.AOFF'.format(p=prefix,i=integrator,ty=fType)
  caput(PV,offset)

  PV = '{p}:I{i}_T0_LC1_L'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
  PV = '{p}:I{i}_T0_LC1_L_RBV'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
  PV = '{p}:I{i}_T0_LC1_H'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
  PV = '{p}:I{i}_T0_LC1_H_RBV'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)

  PV = '{p}:I{i}_T0_L'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
  PV = '{p}:I{i}_T0_L_RBV'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
  PV = '{p}:I{i}_T0_H'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
  PV = '{p}:I{i}_T0_H_RBV'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)

  PV = '{p}:I{i}_T1_L'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
  PV = '{p}:I{i}_T1_L_RBV'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
  PV = '{p}:I{i}_T1_H'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
  PV = '{p}:I{i}_T1_H_RBV'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)

  PV = '{p}:I{i}_T2_L'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
  PV = '{p}:I{i}_T2_L_RBV'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
  PV = '{p}:I{i}_T2_H'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
  PV = '{p}:I{i}_T2_H_RBV'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)

  PV = '{p}:I{i}_T3_L'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
  PV = '{p}:I{i}_T3_L_RBV'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
  PV = '{p}:I{i}_T3_H'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
  PV = '{p}:I{i}_T3_H_RBV'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
  
  PV = '{p}:I{i}_T4_L'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
  PV = '{p}:I{i}_T4_L_RBV'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
  PV = '{p}:I{i}_T4_H'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
  PV = '{p}:I{i}_T4_H_RBV'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)

  PV = '{p}:I{i}_T5_L'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
  PV = '{p}:I{i}_T5_L_RBV'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
  PV = '{p}:I{i}_T5_H'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
  PV = '{p}:I{i}_T5_H_RBV'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)

  PV = '{p}:I{i}_T6_L'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
  PV = '{p}:I{i}_T6_L_RBV'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
  PV = '{p}:I{i}_T6_H'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
  PV = '{p}:I{i}_T6_H_RBV'.format(p=prefix,i=integrator)
  change_units(PV,maxVal,minVal,units,True)
