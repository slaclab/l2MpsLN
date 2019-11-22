#ifndef LCLS1_BSA_H
#define LCLS1_BSA_H

#include <iostream>
#include <string>
#include <inttypes.h>
#include <thread>
#include <iocsh.h>
#include <epicsExport.h>
#include <alarm.h>
#include <errlog.h>
#include <boost/atomic.hpp>
#include <yamlLoader.h>
#include <cpsw_api_user.h>
#include <BsaApi.h>

// Class to manage BSA Channels
class BsaChannels
{
public:
    BsaChannels(const std::string& prefix, const std::vector<std::string>& names);
    ~BsaChannels();

    // Get an specific BSA channel
    BsaChannel at(std::size_t i) const;

    // Print a list of the BSA channels created
    void printChannelIds() const;

private:
    // BSA channels
    std::vector<BsaChannel> channels_;
};

class ReadStream
{
public:
    ReadStream(const std::string& streamName, const std::string& recordPrefix);
    ~ReadStream();

private:
    // Factory method to crete all the vector of BSA channels based on the vector of channel names.
    //static std::vector<BsaChannel> createBsaChannels(const std::string& prefix, const std::vector<std::string>& names);

    // Structure of the stream data.
    // This structure must be packed and byte
    // aligned to match the firmware stream
    typedef struct 
    {
        uint32_t header;
        // Temporal fix: the FW app is swapping the word 
        // order of the timestamp, so let do a swap in SW 
        // for now
        uint32_t timeStamp_L; //epicsTimeStamp timeStamp;
        uint32_t timeStamp_H;
        uint32_t dmod[6];
        uint32_t edefInit;
        uint32_t edefMajor;
        uint32_t edefMinor;
        uint32_t edefAvgDn;
        uint32_t data[24];
    } 
    __attribute__((packed, aligned(1)))
    stream_data_t;

    // This method receive the dat stream, process it, and move the data
    // to BsaCore. It runs in the streamThread_ thread.
    void streamTask();

    const std::vector<std::string> bsaChannelNames; // BSA channel names
    BsaChannels                    bsaChannels;     // BSA channels
    Stream                         strm_;           // Firmware data stream interface
    boost::atomic<bool>            run;             // Flag to stop the thread
    std::thread                    streamThread_;   // Stream receiver thread
};

#endif
