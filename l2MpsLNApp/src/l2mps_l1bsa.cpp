/**
 *-----------------------------------------------------------------------------
 * Title         : L2MPS - LCLS1 BSA
 * ----------------------------------------------------------------------------
 * File          : l2mps_l1bsa.cpp
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

#include "l2mps_l1bsa.h"

static void C_streamTask(void *p) {
    L2MpsL1Bsa* pStreamBSA = L2MpsL1Bsa::getInstance();
    pStreamBSA->streamTask();
}

// Singleton design pattern: initialize class instance pointer to null.
L2MpsL1Bsa* L2MpsL1Bsa::instance = 0;

// Get the instance pointer for the class. If it is the first time,
// create a new one.
L2MpsL1Bsa* L2MpsL1Bsa::getInstance() {
    if (instance == 0) {
        instance = new L2MpsL1Bsa();
    }

    return instance;
}

L2MpsL1Bsa::L2MpsL1Bsa() {
    run_ = true;
    enable = true;
    debug = false;
    strmCounter = 0;
    strmTimeoutCounter = 0;
}

void L2MpsL1Bsa::setStreamName(std::string strmName) {  
    streamName = strmName; 
}

int L2MpsL1Bsa::fireStreamTask() {
    epicsThreadCreate(streamName.c_str(), epicsThreadPriorityHigh + 3,
                  epicsThreadGetStackSize(epicsThreadStackMedium),
                  (EPICSTHREADFUNC) C_streamTask, NULL);

    return 0;
}

L2MpsL1Bsa::~L2MpsL1Bsa()
{
    // Stop the thread
    run_ = false;
    delete instance;
}

void L2MpsL1Bsa::streamTask()
{
    // The stream contains: an 8-byte header, the stream_data_t structure, and a 1-byte footer
    std::size_t stream_data_size {sizeof(stream_data_t) + 9};
    uint8_t *buf = new uint8_t[stream_data_size];
    std::size_t got;
    Path p = cpswGetRoot();
    Path strm_name = p->findByName(streamName.c_str());
    Stream strm_ = IStream::create(strm_name);
    L2MpsL1BsaChannels *pChannels = L2MpsL1BsaChannels::getInstance();

    //std::size_t count {0};
    for(;;)
    {
        // Check if we should break the loop
        if (!run_)
            break;

        // Read the data stream. This call is blocking with a 1s timeout
        got = strm_->read( buf, stream_data_size, CTimeout(1000000) );

        // If BSA processing is disable, just discard the stream data
        // We still need to read the buffer to avoid back-pressuring the FW
        if ( !enable )
            continue;

        // Check if the stream read timed out
        if ( 0 == got ) {
            ++strmTimeoutCounter;
            continue;
        }

        // If we received data, check that we received the correct number of bytes
        if ( stream_data_size != got )
        {
            std::cerr << "ERROR: LCLS1 BSA Stream: bad size. Received " << got << ", instead of " << stream_data_size << " bytes" << std::endl;
            continue;
        }

        // Increment the stream counter
        ++strmCounter;

        // Create a stream data pointer on the received data buffer payload, after the 8-byte header
        stream_data_t* pSD{ (stream_data_t*)(buf + 8) };

        // Copy the LCLS1 BSA data from the stream into the BsaCore facility
        for (std::size_t i{0}; i < pChannels->size(); ++i)
        {
            double data = static_cast<double>(pSD->data[i]) * pChannels->getSlope(i) + pChannels->getOffset(i);
            BSA_StoreData(
                pChannels->at(i),
                pSD->timeStamp,
                data,
                static_cast<BsaStat>(epicsAlarmNone),  // For now, we don't support alarm
                static_cast<BsaSevr>(epicsSevNone));   // nor severity.
        }
        lastTimeStamp_ = pSD->timeStamp;
        // If debug mode is enabled, print out
        // 1/360 frames into the IOC shell
        if ( debug )
        {
            if ( 0 == (strmCounter % 360) )
            {
                std::cout << "Stream data:" << std::endl;
                std::cout << "===================" << std::endl;
                std::cout << std::hex;
                std::cout << "Header     = 0x" <<  pSD->header    << std::endl;
                std::cout << "Time stamp = 0x" <<  pSD->timeStamp.secPastEpoch << ", " << pSD->timeStamp.nsec << std::endl;
                for (std::size_t i{0}; i < 6; ++i)
                    std::cout << "DMOD       = 0x" <<  pSD->dmod[i] << std::endl;
                std::cout << "edefInit   = 0x" <<  pSD->edefInit  << std::endl;
                std::cout << "edefMajor  = 0x" <<  pSD->edefMajor << std::endl;
                std::cout << "edefMinor  = 0x" <<  pSD->edefMinor << std::endl;
                std::cout << "edefAvgDn  = 0x" <<  pSD->edefAvgDn << std::endl;
                std::cout << std::dec;
                for (std::size_t i{0}; i < pChannels->size(); ++i)
                    std::cout << pChannels->at(i) << " = " <<  pSD->data[i] << std::endl;
                std::cout << "===================" << std::endl;
                std::cout << "Stream received counter = " << strmCounter << std::endl;
                std::cout << std::endl;
            }
        }
    }
}

int L2MpsL1Bsa::setEnable(bool e) {
    enable = e;
    return 0;
}

int L2MpsL1Bsa::setDebug(bool e) {
    debug = e;
    return 0;
}

bool L2MpsL1Bsa::getEnable() {
    return enable;
}

bool L2MpsL1Bsa::getDebug() {
    return debug;
}

int L2MpsL1Bsa::getStreamCounts() {
  return (int)strmCounter;
}

int L2MpsL1Bsa::getStreamErrCounts() {
  return (int)strmTimeoutCounter;
}

void L2MpsL1Bsa::resetCounters() {
    strmCounter = 0;
    strmTimeoutCounter = 0;
}
  

void L2MpsL1Bsa::printStats() {
    std::cout << "L2MpsL1Bsa Driver" << std::endl;
    std::cout << "===================" << std::endl;
    std::cout << "Stream Name: " << streamName << std::endl;
    std::cout << "Run Flag: " <<  run_ << std::endl;
    std::cout << "Enable Flag: " <<  enable << std::endl;
    std::cout << "Debug Flag: " << debug << std::endl;
    std::cout << "Time stamp = 0x" <<  lastTimeStamp_.secPastEpoch << ", " << lastTimeStamp_.nsec << std::endl;
    std::cout << "Stream received counter = " << strmCounter << std::endl;
    std::cout << "Stream Timeout counter = " << strmTimeoutCounter << std::endl;
    std::cout << "===================" << std::endl;
    std::cout << std::endl;
}
