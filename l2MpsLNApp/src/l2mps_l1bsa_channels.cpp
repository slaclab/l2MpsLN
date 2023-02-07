/**
 *-----------------------------------------------------------------------------
 * Title         : L2MPS - LCLS1 BSA Channels
 * ----------------------------------------------------------------------------
 * File          : l2mps_l1bsa_channels.cpp
 * Created       : 2019-11-22
 *-----------------------------------------------------------------------------
 * Description :
 *    LCLS1 BSA channel wrapper class for the  LCLS2 MPS Link Node
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

#include "l2mps_l1bsa_channels.h"

L2MpsL1BsaChannels* L2MpsL1BsaChannels::instance = 0;

L2MpsL1BsaChannels* L2MpsL1BsaChannels::getInstance() {
    if (instance == 0) {
        instance = new L2MpsL1BsaChannels();
    }
    return instance;
}

L2MpsL1BsaChannels::L2MpsL1BsaChannels() {
}

int L2MpsL1BsaChannels::createChannels(const std::string& prefix) {
    bsaChannelNames_ = {
        "LC1_BSA_B0_C0_I0",
        "LC1_BSA_B0_C1_I0",
        "LC1_BSA_B0_C2_I0",
        "LC1_BSA_B1_C0_I0",
        "LC1_BSA_B1_C1_I0",
        "LC1_BSA_B1_C2_I0",
        "LC1_BSA_B0_C0_I1",
        "LC1_BSA_B0_C1_I1",
        "LC1_BSA_B0_C2_I1",
        "LC1_BSA_B1_C0_I1",
        "LC1_BSA_B1_C1_I1",
        "LC1_BSA_B1_C2_I1",
        "LC1_BSA_B0_C0_I2",
        "LC1_BSA_B0_C1_I2",
        "LC1_BSA_B0_C2_I2",
        "LC1_BSA_B1_C0_I2",
        "LC1_BSA_B1_C1_I2",
        "LC1_BSA_B1_C2_I2",
        "LC1_BSA_B0_C0_I3",
        "LC1_BSA_B0_C1_I3",
        "LC1_BSA_B0_C2_I3",
        "LC1_BSA_B1_C0_I3",
        "LC1_BSA_B1_C1_I3",
        "LC1_BSA_B1_C2_I3",
    };
    for (auto it ( bsaChannelNames_.begin() ) ; it != bsaChannelNames_.end(); ++it)
    {
        std::string id ( prefix + ":" + *it );
        channels_.push_back(BSA_CreateChannel(id.c_str()));
        offsets_.push_back(0.);
        slopes_.push_back(1.);
    }
    return 0;
}

L2MpsL1BsaChannels::~L2MpsL1BsaChannels()
{
    delete instance;
}

BsaChannel L2MpsL1BsaChannels::at(std::size_t i) const
{
    // Do not check if the index is valid here.
    // The std::vector's "at" will do it.
    return channels_.at(i);
}

double L2MpsL1BsaChannels::getSlope(std::size_t i) {
    return slopes_.at(i);
}

double L2MpsL1BsaChannels::getOffset(std::size_t i) {
    return offsets_.at(i);
}

size_t L2MpsL1BsaChannels::size() {
    return channels_.size();
}

void L2MpsL1BsaChannels::setSlope(std::size_t i, double val) {
    slopes_.at(i) = val;
}

void L2MpsL1BsaChannels::setOffset(std::size_t i, double val) {
    offsets_.at(i) = val;
}

void L2MpsL1BsaChannels::printChannelIds() const
{
    std::cout << "LCLS1 BSA channels:" << std::endl;
    std::cout << "======================" << std::endl;
    std::cout << "Total number of channels: " << channels_.size() << std::endl;
    for (auto it ( channels_.begin() ); it != channels_.end(); ++it )
    std::cout << "  - " << BSA_GetChannelId(*it) << std::endl;
    std::cout << "======================" << std::endl;
}

