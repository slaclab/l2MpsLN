#include <iocsh.h>
#include <epicsExport.h>
#include "l2mps_l1bsa.h"
#include "l2mps_l1bsa_channels.h"
#include "l2MpsLnDriver.h"
#include "l2MpsLnFunctions.h"

// L2MpsLNDriverInit
extern "C" int L2MpsLNDriverInit(const char* streamName, const char* portName)
{
    if ( (!streamName) || ('\0' == streamName[0]) )
    {
        fprintf( stderr, "Error: The name of the LCLS1 BSA stream is empty\n");
        return -1;
    }

    class L2MpsL1BsaChannels* pL2MpsL1BsaChannels;
    pL2MpsL1BsaChannels = L2MpsL1BsaChannels::getInstance();
    pL2MpsL1BsaChannels->createChannels();
    pL2MpsL1BsaChannels->printChannelIds();

    class L2MpsL1Bsa* pL2MpsL1Bsa;
    pL2MpsL1Bsa = L2MpsL1Bsa::getInstance();
    pL2MpsL1Bsa->setStreamName(streamName);
    pL2MpsL1Bsa->fireStreamTask();

    //Set default initial condition of dig App ID = 0 and both bays present
    class L2MpsLnFunctions* pL2MpsLnFunctions;
    pL2MpsLnFunctions = L2MpsLnFunctions::getInstance();
    pL2MpsLnFunctions->setDigAppId(0);
    pL2MpsLnFunctions->setBaysPresent(2);

    new L2MpsLnDriver(portName);

    return 0;
}

static const iocshArg confArg0 = { "streamName",   iocshArgString };
static const iocshArg confArg1 = { "portName",     iocshArgString };

static const iocshArg * const confArgs[] =
{
    &confArg0,
    &confArg1
};

static const iocshFuncDef configFuncDef = {"L2MpsLNDriverInit", 2, confArgs};

static void configCallFunc(const iocshArgBuf *args)
{
    L2MpsLNDriverInit(args[0].sval, args[1].sval);
}

// L2MpsL1BsaEnable
extern "C" int L2MpsL1BsaEnable(bool e)
{
    class L2MpsL1Bsa* pL2MpsL1Bsa;
    pL2MpsL1Bsa = L2MpsL1Bsa::getInstance();
    pL2MpsL1Bsa->setEnable(e);

    return 0;
}

static const iocshArg setEnableArg0 = { "Flag (0=off, 1=on)",   iocshArgInt };

static const iocshArg * const setEnableArgs[] =
{
    &setEnableArg0,
};

static const iocshFuncDef setEnableFuncDef = {"L2MpsL1BsaEnable", 1, setEnableArgs};

static void setEnableCallFunc(const iocshArgBuf *args)
{
    L2MpsL1BsaEnable(args[0].ival);
}

// L2MpsL1BsaDebug
extern "C" int L2MpsL1BsaDebug(bool d)
{
    class L2MpsL1Bsa* pL2MpsL1Bsa;
    pL2MpsL1Bsa = L2MpsL1Bsa::getInstance();
    pL2MpsL1Bsa->setDebug(d);

    return 0;
}

static const iocshArg setDebugArg0 = { "Flag (0=off, 1=on)",   iocshArgInt };

static const iocshArg * const setDebugArgs[] =
{
    &setDebugArg0,
};

static const iocshFuncDef setDebugFuncDef = {"L2MpsL1BsaDebug", 1, setDebugArgs};

static void setDebugCallFunc(const iocshArgBuf *args)
{
    L2MpsL1BsaDebug(args[0].ival);
}

// L2MpsL1BsaPrintCounter
extern "C" int L2MpsL1BsaPrintCounter()
{
    class L2MpsL1Bsa* pL2MpsL1Bsa;
    pL2MpsL1Bsa = L2MpsL1Bsa::getInstance();
    pL2MpsL1Bsa->printStats();

    return 0;
}

static const iocshFuncDef printCounterFuncDef = {"L2MpsL1BsaPrintStats", 0};

static void printCounterCallFunc(const iocshArgBuf *args)
{
    L2MpsL1BsaPrintCounter();
}
// L2MpsSetDigAppId
extern "C" int L2MpsSetDigAppId(int aid)
{
    class L2MpsLnFunctions* pL2MpsLnFunctions;
    pL2MpsLnFunctions = L2MpsLnFunctions::getInstance();
    pL2MpsLnFunctions->setDigAppId(aid);

    return 0;
}

static const iocshArg setDigAppIdArg0 = { "Digital App ID number",   iocshArgInt };

static const iocshArg * const setDigAppIdArgs[] =
{
    &setDigAppIdArg0,
};

static const iocshFuncDef setDigAppIdFuncDef = {"L2MpsSetDigAppId", 1, setDigAppIdArgs};

static void setDigAppIdCallFunc(const iocshArgBuf *args)
{
    L2MpsSetDigAppId(args[0].ival);
}

// L2MpsSetBaysPresent
extern "C" int L2MpsSetBaysPresent(int bays)
{
    class L2MpsLnFunctions* pL2MpsLnFunctions;
    pL2MpsLnFunctions = L2MpsLnFunctions::getInstance();
    pL2MpsLnFunctions->setBaysPresent(bays);

    return 0;
}

static const iocshArg setBaysPresentArg0 = { "Analog Input Bays Populated",   iocshArgInt };

static const iocshArg * const setBaysPresentArgs[] =
{
    &setBaysPresentArg0,
};

static const iocshFuncDef setBaysPresentFuncDef = {"L2MpsSetBaysPresent", 1, setDigAppIdArgs};

static void setBaysPresentCallFunc(const iocshArgBuf *args)
{
    L2MpsSetBaysPresent(args[0].ival);
}

// iocshRegister
void L2MpsLNDriverRegister(void)
{
    iocshRegister( &configFuncDef,        configCallFunc         );
    iocshRegister( &setEnableFuncDef,     setEnableCallFunc      );
    iocshRegister( &setDebugFuncDef,      setDebugCallFunc       );
    iocshRegister( &printCounterFuncDef,  printCounterCallFunc   );
    iocshRegister( &setDigAppIdFuncDef,   setDigAppIdCallFunc    );
    iocshRegister( &setBaysPresentFuncDef,setBaysPresentCallFunc );
}

extern "C" {
    epicsExportRegistrar(L2MpsLNDriverRegister);
}

