#ifndef L2MPS_L1BSA_CHANNELS_H
#define L2MPS_L1BSA_CHANNELS_H

/**
 *-----------------------------------------------------------------------------
 * Title         : L2MPS - LCLS1 BSA Channels
 * ----------------------------------------------------------------------------
 * File          : l2mps_l1bsa_channels.h
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

#include <iostream>
#include <string>
#include <vector>
#include <BsaApi.h>

class L2MpsL1BsaChannels
{
public:
    L2MpsL1BsaChannels(const std::string& prefix, const std::vector<std::string>& names);
    ~L2MpsL1BsaChannels();

    // Get an specific BSA channel
    BsaChannel at(std::size_t i) const;

    // Print a list of the BSA channels created
    void printChannelIds() const;

private:
    // BSA channels
    std::vector<BsaChannel> channels_;
};

#endif
