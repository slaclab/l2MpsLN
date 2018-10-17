#include <iocsh.h>

#include "virtualChannelDriver.h"

#include <epicsExport.h> /* This should be the last header */

static VirtualChannelDriver *pvcDriver = NULL;

static int configureVirtualChannel(const char *portName) {
  pvcDriver = new VirtualChannelDriver(portName);

  return 0;
}

static const iocshArg configArg0 = { "port name", iocshArgString};
static const iocshArg * const configArgs[] = {&configArg0};
static const iocshFuncDef configFuncDef = {"configureVirtualChannel", 1, configArgs};
static void configCallFunc(const iocshArgBuf *args) {
  configureVirtualChannel(args[0].sval);
}

static void initVirtualChannelRegistrar(void) {
  iocshRegister(&configFuncDef, configCallFunc);
}

extern "C" {
epicsExportRegistrar(initVirtualChannelRegistrar);
}

