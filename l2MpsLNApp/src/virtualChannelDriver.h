#ifndef VIRTUALCHANNELDRIVER_H
#define VIRTUALCHANNELDRIVER_H

#include <string>
#include <map>
#include <iostream>
#include <asynPortDriver.h>

// Maximum number of virtual inputs (same as digital inputs)
static const int NUM_VIRTUAL_INPUT_PARAMS = 32;

// Keep number of times a fault was detected (one per second, from PV SCAN field)
typedef struct VirtualFaultCounter {
  int channelNumber;
  int faultCount;

  VirtualFaultCounter(int channel) {
    channelNumber = channel;
    faultCount = 0;
  }
} VirtualFaultCounter;

// Map for ASYN reason (function) to virtual channel number
typedef std::map<int, VirtualFaultCounter> VirtualParameterMap;

class VirtualChannelDriver : public asynPortDriver {
public:
  VirtualChannelDriver(const char *portname);
  virtual ~VirtualChannelDriver();

  //  virtual asynStatus writeInt32(asynUser *pasynUser, epicsInt32 value);
  virtual asynStatus writeUInt32Digital(asynUser *pasynUser, epicsUInt32 value, epicsUInt32 mask);

  virtual void report(FILE *fp, int details);
 private:
  // List of ASYN parameters
  VirtualParameterMap _virtualParams;
};

#endif
