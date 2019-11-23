#ifndef L2MPS_L1BSA_H
#define L2MPS_L1BSA_H

/**
 *-----------------------------------------------------------------------------
 * Title         : L2MPS - LCLS1 BSA
 * ----------------------------------------------------------------------------
 * File          : l2mps_l1bsa.h
 * Created       : 2019-11-22
 *-----------------------------------------------------------------------------
 * Description :
 *    LCLS1 BSA support for the  LCLS2 MPS Link Node
 *-----------------------------------------------------------------------------
 * This file is part of l2MpsLN. It is subject to
 * the license terms in the LICENSE.txt file found in the top-level directory
 * of this distribution and at:
    * https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html.
 * No part of l2MpsLN, including this file, may be
 * copied, modified, propagated, or distributed except according to the terms
 * contained in the LICENSE.txt file.
 *-----------------------------------------------------------------------------
**/

#include <iostream>
#include <iomanip>
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
#include "l2mps_l1bsa_channels.h"

class L2MpsL1Bsa
{
public:
    L2MpsL1Bsa(const std::string& streamName, const std::string& recordPrefix);
    ~L2MpsL1Bsa();

    // Flags and variables accessible from iocShell
    static bool        enable_;      // Flag to enable/disable the processing of BSA data
    static bool        debug_;       // Flag to enable/disable debug mode
    static std::size_t strmCounter_; // Number of streams received

private:
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

    // This method receive the data stream, process it, and move the data
    // to BsaCore. It runs in the streamThread_ thread.
    void streamTask();

    const std::vector<std::string> bsaChannelNames_; // BSA channel names
    L2MpsL1BsaChannels             bsaChannels_;     // BSA channels
    Stream                         strm_;            // Firmware data stream interface
    boost::atomic<bool>            run_;             // Flag to stop the thread
    std::thread                    streamThread_;    // Stream receiver thread
};

#endif
