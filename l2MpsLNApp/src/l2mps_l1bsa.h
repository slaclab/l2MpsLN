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
#include <epicsThread.h>
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
    ~L2MpsL1Bsa();

    // Flags and variables accessible from iocShell
    static L2MpsL1Bsa* getInstance();
    void setStreamName(std::string strmName);
    void setRecordPrefix(std::string rPrefix);
    void streamTask();
    int fireStreamTask();
    int setEnable(bool e);
    int setDebug(bool e);
    bool getEnable();
    bool getDebug();
    epicsTimeStamp lastTimeStamp_;
    void printStats();
    int getStreamCounts();
    int getStreamErrCounts();
    void resetCounters();

private:
    // Structure of the stream data.
    // This structure must be packed and byte
    // aligned to match the firmware stream
    typedef struct
    {
        uint32_t       header;
        epicsTimeStamp timeStamp;
        uint32_t       dmod[6];
        uint32_t       edefInit;
        uint32_t       edefMajor;
        uint32_t       edefMinor;
        uint32_t       edefAvgDn;
        int32_t        data[24];
    }
    __attribute__((packed, aligned(1)))
    stream_data_t;
    L2MpsL1Bsa();
    bool        enable;      // Flag to enable/disable the processing of BSA data
    bool        debug;       // Flag to enable/disable debug mode
    size_t strmCounter; // Number of streams received
    size_t strmTimeoutCounter; // Number of streams received
    L2MpsL1Bsa& operator=(const L2MpsL1Bsa&);
    // This method receive the data stream, process it, and move the data
    // to BsaCore. It runs in the streamThread_ thread.
    std::string streamName;
    static L2MpsL1Bsa* instance;
    L2MpsL1Bsa(const L2MpsL1Bsa&);

    boost::atomic<bool>            run_;             // Flag to stop the thread
    //std::thread                    streamThread_;    // Stream receiver thread
};

#endif
