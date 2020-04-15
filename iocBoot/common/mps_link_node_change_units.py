#!/usr/bin/env python
import os
import sys
import argparse
from epics import caget, caput

def change_units(PV, newHigh, newEGU, integrator=False):
  tempPV = '{pv}.EGU'.format(pv=PV)
  caput(tempPV,newEGU)
  if not integrator:
    tempPV1 = '{pv}.EGUF'.format(pv=PV)
    caput(tempPV1, newHigh)

#=== MAIN ==================================================================================
parser = argparse.ArgumentParser(description='Adjust scale and units for MPS analog inputs')
parser.add_argument('--prefix', metavar='prefix', required=True, help="MPLN Prefix for link node")
parser.add_argument('--ch', metavar='channel', required=True, help="MPLN Analog input channel")
parser.add_argument('--max', metavar='MaxValue', required=True, help="Maximum Value in EGU")
parser.add_argument('--egu', metavar='EGU', required=True, help="Engineering Units (String)")
parser.add_argument('--int',metavar="I0 or I1",required=False,help="Integrator Number (I0 or I1)")
args = parser.parse_args()

prefix = args.prefix
maxVal = float(args.max)
adcChannel = int(args.ch)
units = args.egu
integrator=args.int

if not integrator:
  PV = '{p}:ADC_DATA_{ch}'.format(p=prefix,ch=adcChannel)
  change_units(PV, maxVal, units)

  maxVal = maxVal*2

  PV = '{p}:ANA_MIN_VAL_{ch}'.format(p=prefix,ch=adcChannel)
  change_units(PV, maxVal, units)

  PV = '{p}:ANA_AVG_VAL_{ch}'.format(p=prefix,ch=adcChannel)
  change_units(PV, maxVal, units)

  PV = '{p}:ANA_MAX_VAL_{ch}'.format(p=prefix,ch=adcChannel)
  change_units(PV, maxVal, units)

  PV = '{p}:LC1_ANA_FPRCVAL_{ch}'.format(p=prefix,ch=adcChannel)
  change_units(PV, maxVal, units)

  PV = '{p}:LC1_ANA_FPRCVAL_{ch}_RBV'.format(p=prefix,ch=adcChannel)
  change_units(PV, maxVal, units)

  PV = '{p}:LC2_ANA_FPRCVAL_{ch}'.format(p=prefix,ch=adcChannel)
  change_units(PV, maxVal, units)

  PV = '{p}:LC2_ANA_FPRCVAL_{ch}_RBV'.format(p=prefix,ch=adcChannel)
  change_units(PV, maxVal, units)

  PV = '{p}:ANA_BSA_DATA_{ch}'.format(p=prefix,ch=adcChannel)
  change_units(PV, maxVal, units)

  PV = '{p}:ANA_BSA_DATA_{ch}'.format(p=prefix,ch=adcChannel+6)
  change_units(PV, maxVal, units)

  PV = '{p}:ANA_BSA_DATA_{ch}'.format(p=prefix,ch=adcChannel+12)
  change_units(PV, maxVal, units)

  PV = '{p}:ANA_BSA_DATA_{ch}'.format(p=prefix,ch=adcChannel+18)
  change_units(PV, maxVal, units)

if integrator == 'I0' or integrator == 'I1':
  slope = maxVal / 65536 * 2.
  PV = '{p}:{i}_FWSLO'.format(p=prefix,i=integrator)
  caput(PV,slope)
  TempUnits = "{u}/raw".format(u=units)
  change_units(PV,0,TempUnits,True)
  PV = '{p}:{i}_SS_RBV'.format(p=prefix,i=integrator)
  change_units(PV,0,TempUnits,True)

  PV = '{p}:{i}_T0_LC1_L'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T0_LC1_L_RBV'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T0_LC1_H'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T0_LC1_H_RBV'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)

  PV = '{p}:{i}_T0_L'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T0_L_RBV'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T0_H'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T0_H_RBV'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)

  PV = '{p}:{i}_T1_L'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T1_L_RBV'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T1_H'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T1_H_RBV'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)

  PV = '{p}:{i}_T2_L'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T2_L_RBV'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T2_H'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T2_H_RBV'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)

  PV = '{p}:{i}_T3_L'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T3_L_RBV'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T3_H'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T3_H_RBV'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  
  PV = '{p}:{i}_T4_L'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T4_L_RBV'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T4_H'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T4_H_RBV'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)

  PV = '{p}:{i}_T5_L'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T5_L_RBV'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T5_H'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T5_H_RBV'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)

  PV = '{p}:{i}_T6_L'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T6_L_RBV'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T6_H'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T6_H_RBV'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)

  PV = '{p}:{i}_T7_L'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T7_L_RBV'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T7_H'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
  PV = '{p}:{i}_T7_H_RBV'.format(p=prefix,i=integrator)
  change_units(PV,0,units,True)
