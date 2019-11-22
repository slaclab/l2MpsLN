
#include "lcls1_bsa.h"

BsaChannels::BsaChannels(const std::string& prefix, const std::vector<std::string>& names)
{
    for (auto it ( names.begin() ) ; it != names.end(); ++it)
    {
        std::string id ( prefix + ":" + *it );
        channels_.push_back(BSA_CreateChannel(id.c_str()));
    }
}

BsaChannels::~BsaChannels()
{
    for (auto it ( channels_.begin() ); it != channels_.end(); ++it )
        BSA_ReleaseChannel(*it);
}

BsaChannel BsaChannels::at(std::size_t i) const
{
    // Do not check if the index is valid here.
    // The std::vector's "at" will do it.
    return channels_.at(i);
}

void BsaChannels::printChannelIds() const
{
    std::cout << "LCLS1 BSA channels:" << std::endl;
    std::cout << "======================" << std::endl;
    std::cout << "Total number of channels: " << channels_.size() << std::endl;
    for (auto it ( channels_.begin() ); it != channels_.end(); ++it )
    std::cout << "  - " << BSA_GetChannelId(*it) << std::endl;
    std::cout << "======================" << std::endl;
}

ReadStream::ReadStream(const std::string& streamName, const std::string& recordPrefix)
:
    // This are the parameters names for each of the 24 data words in the data stream.
    // The order here should match the order of the data words in the stream, as defined 
    // in the FW application.
    // The BSA PV name will be '${recordPrefix}:' followed by this parameter name.
    bsaChannelNames {
        "LC1_BSA_00",
        "LC1_BSA_01", 
        "LC1_BSA_02", 
        "LC1_BSA_03", 
        "LC1_BSA_04", 
        "LC1_BSA_05", 
        "LC1_BSA_06", 
        "LC1_BSA_07", 
        "LC1_BSA_08", 
        "LC1_BSA_09", 
        "LC1_BSA_10", 
        "LC1_BSA_11", 
        "LC1_BSA_12", 
        "LC1_BSA_13", 
        "LC1_BSA_14", 
        "LC1_BSA_15", 
        "LC1_BSA_16", 
        "LC1_BSA_17", 
        "LC1_BSA_18", 
        "LC1_BSA_19", 
        "LC1_BSA_20", 
        "LC1_BSA_21", 
        "LC1_BSA_22", 
        "LC1_BSA_23", 
    },
    //bsaChannels(createBsaChannels(recordPrefix, bsaChannelNames)),
    bsaChannels(recordPrefix, bsaChannelNames),
    strm_(IStream::create(cpswGetRoot()->findByName(streamName.c_str()))),
    run(true),
    streamThread_( std::thread( &ReadStream::streamTask, this) )
{
    // Set the name for the 'streamThread_' thread
    if( pthread_setname_np( streamThread_.native_handle(), "L2MpsLcls1Bsa" ) )
        std::cerr <<  "pthread_setname_np failed for L2MpsL1Bsa thread" << std::endl;

    bsaChannels.printChannelIds();
}

ReadStream::~ReadStream()
{
    // Stop the thread
    run = false;
    streamThread_.join();
}

void ReadStream::streamTask()
{
    uint8_t *buf = new uint8_t[500];
    std::size_t got;

    //std::size_t count {0};
    for(;;)
    {
        // Check if we should break the loop
        if (!run)
            break;

        // Read the data stream. This call is blocking with a 1s timeout
        got = strm_->read( buf, 10000, CTimeout(1000000) );
        
        // Check if the stream read timed out
        if ( 0 == got )
            continue;

        // If we received data, check that we received the correct number of bytes
        if ( sizeof(stream_data_t) != got )
        {
            std::cerr << "ERROR: LCLS1 BSA Stream: bad size. Received " << got << ", instead of " << sizeof(stream_data_t) << " bytes" << std::endl;
            continue;
        }

        // Create a stream data pointer on the received data buffer
        stream_data_t* pSD{ (stream_data_t*)buf };

        // Temporal fix: the FW app is swapping the word
        // order of the timestamp, so let do a swap in SW
        // for now
        epicsTimeStamp etimeStamp;
        etimeStamp.secPastEpoch = pSD->timeStamp_H;
        etimeStamp.nsec = pSD->timeStamp_L;

        // Copy the LCLS1 BSA data from the stream into the BsaCore facility
        for (std::size_t i{0}; i < bsaChannelNames.size(); ++i)
        {
            BSA_StoreData(
                bsaChannels.at(i), 
                etimeStamp, //pSD->timeStamp, 
                static_cast<double>(pSD->data[i]),
                static_cast<BsaStat>(epicsAlarmNone),  // For now, we don't support alarm
                static_cast<BsaSevr>(epicsSevNone));   // nor severity.
        }

        // This is temporal debug feature. It prints out 
        // 1/360 frames into the IOC shell
        //if (++count >= 359)
        //{
        //    count = 0;

        //    std::cout << "Stream data:" << std::endl;
        //    std::cout << "===================" << std::endl;
        //    std::cout << std::hex;
        //    std::cout << "Header     = 0x" <<  pSD->header    << std::endl;
        //    std::cout << "Time stamp = 0x" <<  etimeStamp.secPastEpoch << ", " << etimeStamp.nsec << std::endl;
        //    for (std::size_t i{0}; i < 6; ++i)
        //        std::cout << "DMOD       = 0x" <<  pSD->dmod[i] << std::endl;
        //    std::cout << "edefInit   = 0x" <<  pSD->edefInit  << std::endl;
        //    std::cout << "edefMajor  = 0x" <<  pSD->edefMajor << std::endl;
        //    std::cout << "edefMinor  = 0x" <<  pSD->edefMinor << std::endl;
        //    std::cout << "edefAvgDn  = 0x" <<  pSD->edefAvgDn << std::endl;
        //    for (std::size_t i{0}; i < 24; ++i)
        //        std::cout << "DATA       = 0x" <<  pSD->data[i] << std::endl;
        //    std::cout << std::dec;
        //    std::cout << "===================" << std::endl;
        //    std::cout << std::endl;
        //}
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
