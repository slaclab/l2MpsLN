#ifndef LCLS1_BSA_H
#define LCLS1_BSA_H

#include <iostream>
#include <string>
#include <inttypes.h>
#include <thread>
#include <iocsh.h>
#include <epicsExport.h>
#include <errlog.h>
#include <yamlLoader.h>
#include <cpsw_api_user.h>
#include <BsaApi.h>

class ReadStream
{
public:
    ReadStream(const std::string& streamName, const std::string& recordPrefix);
    ~ReadStream();

private:
    Stream      strm_;
    std::thread streamThread_;
    void        streamTask();
};

#endif
