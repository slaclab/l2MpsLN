#include "l2MpsLnDriver.h"
#include <iostream>
#include <epicsTypes.h>
#include <alarm.h>

L2MpsLnDriver::L2MpsLnDriver(const char *portName) 
  : asynPortDriver(portName,MAX_SIGNALS,
		 asynInt32Mask | asynFloat64Mask | asynDrvUserMask, // interfaceMask
		 asynInt32Mask | asynFloat64Mask, // interruptMask
		 ASYN_MULTIDEVICE,                       // asynFlags
		 1, 0, 0)            // autoConnect, priority, stackSize
{
  createParam(STREAM_ENABLE_STRING, asynParamInt32, &_streamEnableParam);
  createParam(STREAM_COUNTER_STRING, asynParamInt32, &_streamCounterParam);
  createParam(STREAM_COUNTER_ERR_STRING, asynParamInt32, &_streamCounterErrParam);
  createParam(STREAM_COUNTER_RESET_STRING, asynParamInt32, &_counterResetParam);
  int count = 0;
  int index;
  std::stringstream pName;
  for (int integrator = 0; integrator < numBlmIntChs; integrator++) {
    for (int bay = 0; bay < numberOfBays; bay++) {
      for (int ch = 0; ch < numBlmChs; ch++) {
        pName.str("");
        pName << "L1BSA_I" << integrator <<"_B" << bay << "_C" << ch;
        createParam(slope, pName.str().c_str(),asynParamFloat64, &index);
        chans[count].slope = index;
        createParam(offset, pName.str().c_str(),asynParamFloat64, &index);
        chans[count].offset = index;
        count++;
      }
    }
  }
  for (int integrator = 0; integrator < numBlmIntChs; integrator++) {
    for (int bay = 0; bay < numberOfBays; bay++) {
      for (int ch = 0; ch < numBlmChs; ch++) {
        pName.str("");
        pName << "L1BSA_I" << integrator <<"_B" << bay << "_C" << ch << "F";
        createParam(slope, pName.str().c_str(),asynParamFloat64, &index);
        chans[count].slope = index;
        createParam(offset, pName.str().c_str(),asynParamFloat64, &index);
        chans[count].offset = index;
        count++;
      }
    }
  }
}

asynStatus L2MpsLnDriver::readInt32(asynUser *pasynUser, epicsInt32 *value) {
  asynStatus status = asynSuccess;
  int addr;
  getAddress(pasynUser, &addr);

  if (_streamEnableParam == pasynUser->reason) {
    try {
      if (L2MpsL1Bsa::getInstance()->getEnable()) {
        *value = 1;
      } else {
        *value = 0;
      }
    } catch (std::exception &e) {
      status = asynError;
    }
  }
  else if (_streamCounterParam == pasynUser->reason) {
    try {
      *value = L2MpsL1Bsa::getInstance()->getStreamCounts();
    } catch (std::exception &e) {
      status = asynError;
    }
  }
  else if (_streamCounterErrParam == pasynUser->reason) {
    try {
      *value = L2MpsL1Bsa::getInstance()->getStreamErrCounts();
    } catch (std::exception &e) {
      status = asynError;
    }
  }
  return status;
}

asynStatus L2MpsLnDriver::writeInt32(asynUser *pasynUser, epicsInt32 value) {
  asynStatus status = asynSuccess;
  int addr;
  getAddress(pasynUser, &addr);

  if (_streamEnableParam == pasynUser->reason) {
    try {
      bool en = false;
      if (value > 0) {
        en = true;
      }
    L2MpsL1Bsa::getInstance()->setEnable(en);
    } catch (std::exception &e) {
      status = asynError;
    }
  }
  else if (_counterResetParam == pasynUser->reason) {
    try {
      if (value > 0) {
        L2MpsL1Bsa::getInstance()->resetCounters();
        value = 0;
      }
    } catch (std::exception &e) {
      status = asynError;
    }
  }
  return status;
}

asynStatus L2MpsLnDriver::writeFloat64(asynUser *pasynUser, epicsFloat64 value) {
  asynStatus status = asynSuccess;
  int addr;
  int function = pasynUser->reason;
  getAddress(pasynUser, &addr);
  if (addr == slope) {
    try {
      int index = -1;
      for(int i = 0; i < numBsaChs; i++) {
        if (function == chans[i].slope) {
          index = i;
        }
      }
      if (index > -1) {
        L2MpsL1BsaChannels::getInstance()->setSlope(index, value);
      }
      else {
        status = asynError;
      }
    } catch (std::exception &e) {
      status = asynError;
    }
  }
  else if (addr == offset) {
    try {
      int index = -1;
      for(int i = 0; i < numBsaChs; i++) {
        if (function == chans[i].offset) {
          index = i;
        }
      }
      if (index > -1) {
        L2MpsL1BsaChannels::getInstance()->setOffset(index, value);
      }
      else {
        status = asynError;
      }
    } catch (std::exception &e) {
      status = asynError;
    }
  }
  else {
    if ( 0 == asynPortDriver::writeFloat64(pasynUser, value) )
      status = asynSuccess;
    else status = asynError;
  }
  return status;
}

asynStatus L2MpsLnDriver::readFloat64(asynUser *pasynUser, epicsFloat64 *value) {
  asynStatus status = asynSuccess;
  int addr;
  int function = pasynUser->reason;
  getAddress(pasynUser, &addr);
  if (addr == slope) {
    try {
      int index = -1;
      for(int i = 0; i < numBsaChs; i++) {
        if (function == chans[i].slope) {
          index = i;
        }
      }
      if (index > -1) {
        *value = L2MpsL1BsaChannels::getInstance()->getSlope((size_t)index);
      }
      else {
        status = asynError;
      }
    } catch (std::exception &e) {
      status = asynError;
    }
  }
  else if (addr == offset) {
    try {
      int index = -1;
      for(int i = 0; i < numBsaChs; i++) {
        if (function == chans[i].offset) {
          index = i;
        }
      }
      if (index > -1) {
        *value = L2MpsL1BsaChannels::getInstance()->getOffset(index);
      }
      else {
        status = asynError;
      }
    } catch (std::exception &e) {
      status = asynError;
    }
  }
  else {
    if ( 0 == asynPortDriver::readFloat64(pasynUser, value) )
      status = asynSuccess;
    else status = asynError;
  }
  return status;
}
