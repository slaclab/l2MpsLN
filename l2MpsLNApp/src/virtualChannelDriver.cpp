#include "virtualChannelDriver.h"
#include <sstream>

static const int INVALID_PARAM = -1;

VirtualChannelDriver::VirtualChannelDriver(const char *portname) :
  asynPortDriver(portname, 1024, 10,
		 asynOctetMask | asynInt32Mask | asynInt16ArrayMask | asynFloat64Mask |
		 asynInt8ArrayMask | asynUInt32DigitalMask | asynDrvUserMask, // interfaceMask
		 asynInt32Mask | asynInt16ArrayMask | asynInt8ArrayMask | asynFloat64Mask, // interruptMask
		 ASYN_MULTIDEVICE | ASYN_CANBLOCK,                       // asynFlags
		 1, 0, 0) {           // autoConnect, priority, stackSize
  std::stringstream paramName;
  // Create 32 virtual input parameters
  for (int channel = 0; channel < NUM_VIRTUAL_INPUT_PARAMS; ++channel) {
    int key = 0;
    VirtualFaultCounter c(channel);
    paramName.str("");
    paramName << "MPS_VIRTUAL_INPUT_" << channel;
    createParam(paramName.str().c_str(), asynParamUInt32Digital, &key);
    _virtualParams.insert(std::make_pair(key, c));
  }
}

VirtualChannelDriver::~VirtualChannelDriver() {
}

/**
 * This method gets called when one of the virtual input PVs has a HIHI/LOLO
 * alarm or there is a link error (e.g. ioc that provides the PV is turned off).
 */
asynStatus VirtualChannelDriver::writeUInt32Digital(asynUser *pasynUser, 
						    epicsUInt32 value, 
						    epicsUInt32 mask) {
  int appCard;
  this->getAddress(pasynUser, &appCard);

  VirtualParameterMap::iterator it = _virtualParams.find(pasynUser->reason);
  if (it != _virtualParams.end()) {
    const char *name;
    this->getParamName(appCard, pasynUser->reason, &name);
    // If the value of the input matches the mask, then there is a fault
    if (value == mask) {
      (*it).second.faultCount++;
      // Here code should call LN function to write FAULT to the channel
      std::cout << "FAULT (app=" << appCard << ", value=" << value
		<< ", name=" << name << ", mask=" << mask
		<< ", timeout=" << pasynUser->timeout << ")" << std::endl;
    }
    else {
      // Here code should call LN function to write OK to the channel
      std::cout << "OK (app=" << appCard << ", value=" << value
		<< ", name=" << name << ", mask=" << mask
		<< ", timeout=" << pasynUser->timeout << ")" << std::endl;
    }
  }

  return asynSuccess;
}

void VirtualChannelDriver::report(FILE *fp, int details) {
  std::cout << "Virtual MPS Channels (ch #, fault counter):" << std::endl;
  int i = 0;
  for (VirtualParameterMap::iterator it = _virtualParams.begin();
       it != _virtualParams.end(); ++it, ++i) {
    if (i % 4 == 0) std::cout << std::endl << "  ";
    std::cout << "[" << (*it).second.channelNumber << ": " << (*it).second.faultCount << "] ";
  }
  std::cout << std::endl << std::endl;
}
