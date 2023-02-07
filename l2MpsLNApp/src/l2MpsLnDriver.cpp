#include "l2MpsLnDriver.h"
#include <iostream>
#include <epicsTypes.h>
#include <alarm.h>

L2MpsL1BsaDriver::L2MpsL1BsaDriver(const char *portName) 
  : asynPortDriver(portName,10000,
		 asynInt32Mask | asynFloat64Mask | asynDrvUserMask, // interfaceMask
		 asynInt32Mask | asynFloat64Mask, // interruptMask
		 ASYN_MULTIDEVICE,                       // asynFlags
		 1, 0, 0)            // autoConnect, priority, stackSize
{
  createParam(STREAM_ENABLE_STRING, asynParamInt32, &_streamEnableParam);
  createParam(STREAM_COUNTER_STRING, asynParamInt32, &_streamCounterParam);
  createParam(STREAM_COUNTER_ERR_STRING, asynParamInt32, &_streamCounterErrParam);
  createParam(STREAM_COUNTER_RESET_STRING, asynParamInt32, &_counterResetParam);
  createParam(SLOPE_STRING, asynParamInt32, &_slopeParam);
  createParam(OFFSET_STRING, asynParamInt32, &_offsetParam);
}

asynStatus L2MpsL1BsaDriver::readInt32(asynUser *pasynUser, epicsInt32 *value) {
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

asynStatus L2MpsL1BsaDriver::writeInt32(asynUser *pasynUser, epicsInt32 value) {
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

asynStatus L2MpsL1BsaDriver::writeFloat64(asynUser *pasynUser, epicsFloat64 value) {
  asynStatus status = asynSuccess;
  int addr;
  getAddress(pasynUser, &addr);
  if (_slopeParam == pasynUser->reason) {
    try {
      if (addr < 24 && addr >= 0) {
        L2MpsL1BsaChannels::getInstance()->setSlope(addr, value);
      }
    } catch (std::exception &e) {
      status = asynError;
    }
  }
  else if (_offsetParam == pasynUser->reason) {
    try {
      if (addr < 24 && addr >= 0) {
        L2MpsL1BsaChannels::getInstance()->setOffset(addr, value);
      }
    } catch (std::exception &e) {
      status = asynError;
    }
  }
  return status;
}

asynStatus L2MpsL1BsaDriver::readFloat64(asynUser *pasynUser, epicsFloat64 *value) {
  asynStatus status = asynSuccess;
  int addr;
  getAddress(pasynUser, &addr);
  if (_slopeParam == pasynUser->reason) {
    try {
      if (addr >= 0 && addr < 24) {
        *value = L2MpsL1BsaChannels::getInstance()->getSlope((size_t)addr);
      }
    } catch (std::exception &e) {
      status = asynError;
    }
  }
  else if (_offsetParam == pasynUser->reason) {
    try {
      if (addr >= 0 && addr < 24) {
        *value = L2MpsL1BsaChannels::getInstance()->getOffset(addr);
      }
    } catch (std::exception &e) {
      status = asynError;
    }
  }
  return status;
}
