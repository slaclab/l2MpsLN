#include <string>
#include <stdio.h>
#include <asynPortDriver.h>
#include "l2mps_l1bsa.h"
#include "l2mps_l1bsa_channels.h"

// L2MpsL1BsaDriver Parameters
#define STREAM_ENABLE_STRING                      "ENABLE"
#define STREAM_COUNTER_STRING                     "STREAM_COUNTER"
#define STREAM_COUNTER_ERR_STRING                 "STREAM_COUNTER_ERR"
#define STREAM_COUNTER_RESET_STRING               "STREAM_COUNTER_RESET"
#define SLOPE_STRING                              "SLOPE"
#define OFFSET_STRING                             "OFFSET"

class L2MpsL1BsaDriver : public asynPortDriver {
  public:
    L2MpsL1BsaDriver(const char *portName);

    //virtual asynStatus writeOctet(asynUser *pasynUser, const char *value, size_t maxChars, size_t *nActual);
    virtual asynStatus readInt32(asynUser *pasynUser, epicsInt32 *value);
    virtual asynStatus writeInt32(asynUser *pasynUser, epicsInt32 value);
    virtual asynStatus writeFloat64(asynUser *pasynUser, epicsFloat64 value);
    virtual asynStatus readFloat64(asynUser *pasynUser, epicsFloat64 *value);



  private:
    int _streamEnableParam;
    int _streamCounterParam;
    int _streamCounterErrParam;
    int _counterResetParam;
    int _slopeParam;
    int _offsetParam;

};
