#include <string>
#include <stdio.h>
#include <asynPortDriver.h>
#include "l2mps_l1bsa.h"
#include "l2mps_l1bsa_channels.h"
#include "l2Mps_blm.h"
#include "l2Mps_mps.h"

// L2MpsL1BsaDriver Parameters
#define MAX_SIGNALS (100)

#define STREAM_ENABLE_STRING                      "ENABLE"
#define STREAM_COUNTER_STRING                     "STREAM_COUNTER"
#define STREAM_COUNTER_ERR_STRING                 "STREAM_COUNTER_ERR"
#define STREAM_COUNTER_RESET_STRING               "STREAM_COUNTER_RESET"

#define DIG_AID_PATH                              "/mmio/AppTop/AppCore/MpsLinkNodeCore/MpsDigitalMessage/AppId"

const int numBsaChs = numberOfBays * numBlmChs * numBlmIntChs * 2; // 2 AMC Bays * 3 chans per bay * 2 integrators * (1 int + 1 float) = 24 chansf

const int slope = MAX_SIGNALS-2; //Put para index for slope and offset fixed at the end of the param array
const int offset = MAX_SIGNALS-1;

struct ch_info_t
{
  int slope;
  int offset;
};

class L2MpsLnDriver : public asynPortDriver {
  public:
    L2MpsLnDriver(const char *portName);

    virtual asynStatus readInt32(asynUser *pasynUser, epicsInt32 *value);
    virtual asynStatus writeInt32(asynUser *pasynUser, epicsInt32 value);
    virtual asynStatus writeFloat64(asynUser *pasynUser, epicsFloat64 value);
    virtual asynStatus readFloat64(asynUser *pasynUser, epicsFloat64 *value);

    bool SetDigitalAppID(int aid);



  private:
    int _streamEnableParam;
    int _streamCounterParam;
    int _streamCounterErrParam;
    int _counterResetParam;
    ch_info_t chans[numBsaChs];
    ScalVal dAid;
};
