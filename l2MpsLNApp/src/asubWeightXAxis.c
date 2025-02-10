#include <registryFunction.h>
#include <epicsExport.h>
#include <aSubRecord.h>

static long calcTimeArray(aSubRecord *pasub) {
    long i;
    double clkFreq, sum = 0.0, timeNs;
    double debug;

    clkFreq = (double)(*(long *)pasub->a);
    debug   = *(double *)pasub->b; /* Input: Debug Menu */

    /* Calculate the time in ns between each sample */
    timeNs = 1000.0 / (2.0 * clkFreq);

    if (debug) {
        printf("\nX Axis Process Begins");
        printf("\nFrequency : %f ", clkFreq);
        printf("\nns spacing : %f ", timeNs);
        printf("\nCounter at Start: %i ", i);
    }
    /* Then make an array with each element a distance of `timeNs` apart */
    for (i = 0; i < pasub->nova; i++) {
        ((double *)pasub->vala)[i] = sum;
        sum += timeNs;
        if (debug) {
            if (i%100000 == 0) {
                printf("\n  nS : %f ", sum);
            }
        }
    }
    if (debug) {
        printf("\nFrequency : %f ", clkFreq);
        printf("\nCounter at End: %i ", i);
        printf("\nX Axis Process Ends");

    }


    return 0; /* process output links */
}

epicsRegisterFunction(calcTimeArray);
