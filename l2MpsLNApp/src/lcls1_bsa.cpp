
#include "lcls1_bsa.h"

ReadStream::ReadStream(const std::string& streamName, const std::string& recordPrefix)
:
    strm_(IStream::create(cpswGetRoot()->findByName(streamName.c_str()))),
    streamThread_( std::thread( &ReadStream::streamTask, this) )
{
    std::cout << "Read Stream object created" << std::endl;
    std::cout << "record prefix: " << recordPrefix << std::endl;
}

ReadStream::~ReadStream()
{
    std::cout << "Read Stream object destroyed" << std::endl;
}

void ReadStream::streamTask()
{
    uint8_t *buf = new uint8_t[10000];
    std::size_t got;
    std::cout << "streamTask thread created" << std::endl;

    for(;;)
    {
        //std::cout << "  ... waiting stream data..." << std::endl;
        got = strm_->read( buf, 10000, CTimeout(1000000) );

        //std::cout << "   streamTask: received " << got << " bytes." << std::endl;

    }
}

extern "C" int Lcls1BsaConfig(const char* streamName, const char* recordPrefix)
{
    if ( (!streamName) || ('\0' == streamName[0]) )
    {
        fprintf( stderr, "Error: The name of the LCLS1 BSA stream is empty\n");
        return -1;
    }

    if ( (!recordPrefix) || ('\0' == recordPrefix[0]) )
    {
        fprintf( stderr, "Error: The record prefix for the LCLS1 BSA PVs is empty\n");
        return -1;
    }

    new ReadStream(streamName, recordPrefix);

    return 0;
}

static const iocshArg confArg0 = { "streamName",   iocshArgString };
static const iocshArg confArg1 = { "recordPrefix", iocshArgString };

static const iocshArg * const confArgs[] =
{
    &confArg0,
    &confArg1
};

static const iocshFuncDef configFuncDef = {"Lcls1BsaConfig", 2, confArgs};

static void configCallFunc(const iocshArgBuf *args)
{
    Lcls1BsaConfig(args[0].sval, args[1].sval);
}

void lcls1BsaRegister(void)
{
    iocshRegister( &configFuncDef, configCallFunc );
}

extern "C" {
    epicsExportRegistrar(lcls1BsaRegister);
}
