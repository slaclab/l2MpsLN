#ifndef L2MPSLNFUNCTIONS_H
#define L2MPSLNFUNCTIONS_H

#include <string>
#include <stdio.h>
#include <cpsw_api_user.h>
#include <yamlLoader.h>

#define DIG_AID_PATH                              "/mmio/AppTop/AppCore/MpsLinkNodeCore/MpsDigitalMessage/AppId"
#define LC1_BAY_DISABLE                           "/mmio/AppTop/AppCore/MpsAnalogCore/MpsAnalogLcls1Reg/InputDisable"
#define LC2_BAY_DISABLE                           "/mmio/AppTop/AppCore/MpsAnalogCore/MpsAnalogLcls2Reg/InputDisable"
#define MPS_APP_TYPE                              "mmio/AmcCarrierCore/AppMps/AppMpsSalt/APP_TYPE_G"

/* MPS Types:
    {120,   "MPS_AN"},
    {121,   "MPS_LN"},
    {122,   "MPS_DN"}
*/

class L2MpsLnFunctions
{
public:
  ~L2MpsLnFunctions();
  static L2MpsLnFunctions* getInstance();
  bool setDigAppId(int aid);
  bool setBaysPresent(int bays);
  uint32_t mpsType;
  std::string mpsType_s;
private:
  L2MpsLnFunctions();
  static L2MpsLnFunctions* instance;
  L2MpsLnFunctions(const L2MpsLnFunctions&);
  ScalVal digAppId_ScalVal;
  ScalVal lc1BayPresent_ScalVal;
  ScalVal lc2BayPresent_ScalVal;
  ScalVal_RO mpsType_ScalVal_RO;
};

#endif