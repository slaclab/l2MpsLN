#include "l2MpsLnFunctions.h"

// Singleton design pattern: initialize class instance pointer to null.
L2MpsLnFunctions* L2MpsLnFunctions::instance = 0;
// Get the instance pointer for the class. If it is the first time,
// create a new one.
L2MpsLnFunctions* L2MpsLnFunctions::getInstance() {
    if (instance == 0) {
        instance = new L2MpsLnFunctions();
    }
    return instance;
}
L2MpsLnFunctions::L2MpsLnFunctions() {
    Path root = cpswGetRoot();
    try {
      mpsType_ScalVal_RO = IScalVal_RO::create(root->findByName(MPS_APP_TYPE));
    }
    catch (CPSWError &e) {
      printf("ERROR: Could not get MPS Type");
    }
    mpsType = 0;
    mpsType_ScalVal_RO->getVal(&mpsType);
    switch(mpsType) {
    case 120:
      mpsType_s = "MPS Application Node";
      break;
    case 121:
      mpsType_s = "MPS Link Node";
      break;
    case 122:
      mpsType_s = "MPS Digital Node";
      break;
    default:
      mpsType_s = "None";
    }
    std::cout << "Link Node Driver detected type: " << mpsType_s << std::endl;
    try {
      if (mpsType == 121 || mpsType == 122) {
        digAppId_ScalVal = IScalVal::create(root->findByName(DIG_AID_PATH));
      }
      if (mpsType == 120 || mpsType == 121) {
        lc1BayPresent_ScalVal = IScalVal::create(root->findByName(LC1_BAY_DISABLE));
        lc2BayPresent_ScalVal = IScalVal::create(root->findByName(LC2_BAY_DISABLE)); 
      }
    }
    catch (CPSWError &e) {}
    
}
bool L2MpsLnFunctions::setDigAppId(int aid) {
  if (mpsType == 121 || mpsType == 122){
    try {
      digAppId_ScalVal->setVal(aid);
      std::cout << "Digital App ID set to: " << aid << std::endl;
    }
    catch (CPSWError &e) {}
  }
  return true;
}
bool L2MpsLnFunctions::setBaysPresent(int bays) {
  /* The register is actually which bays to disable,
     but the function is how many bays are present.
     The assumption is that the hardware is populated
     from bay0 first and then bay 1.  So:
     bays == 0 --> Disable both bays
     bays == 1 --> Disable bay 1
     bays == 2 --> Disable none
     From yaml file:
       #########################################################
      InputDisable:
        class: IntField
        at:
          offset: 0x00B0
        sizeBits: 2
        lsBit: 0
        mode: RW
        enums:
          - { name: "None", value: 0 }
          - { name: "Bay0", value: 1 }
          - { name: "Bay1", value: 2 }
          - { name: "Both", value: 3 }
        description: "LCLS Disable analog AMC card."
  */
  int writeVal = 0; //default is to enable both bays.  If we get it wrong analog won't process at all if one is missing.
  if (bays == 0) {
    writeVal = 3;
  }
  else if (bays == 1) {
    writeVal = 2;
  }
  else if (bays == 2) {
    writeVal = 0;
  }
  else {
    printf("ERROR: Incorrect number of bays!");
    return false;
  }
  if (mpsType == 120 || mpsType == 121) {
    try {
      lc1BayPresent_ScalVal->setVal(writeVal);
      lc2BayPresent_ScalVal->setVal(writeVal);
      std::cout << "Number of Bays disabled set to: " << writeVal << std::endl;
    }
    catch (CPSWError &e) {}
  }
  return true;
}