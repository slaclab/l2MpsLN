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

L2MpsL1BsaChannels::L2MpsL1BsaChannels(const std::string& prefix, const std::vector<std::string>& names)
{
    for (auto it ( names.begin() ) ; it != names.end(); ++it)
    {
        std::string id ( prefix + ":" + *it );
        channels_.push_back(BSA_CreateChannel(id.c_str()));
    }
}

L2MpsL1BsaChannels::~L2MpsL1BsaChannels()
{
    for (auto it ( channels_.begin() ); it != channels_.end(); ++it )
        BSA_ReleaseChannel(*it);
}

BsaChannel L2MpsL1BsaChannels::at(std::size_t i) const
{
    // Do not check if the index is valid here.
    // The std::vector's "at" will do it.
    return channels_.at(i);
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

