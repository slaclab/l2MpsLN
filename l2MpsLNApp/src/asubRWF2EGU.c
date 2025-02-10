/*
 * file:                asubRWF2EGU.c
 * purpose:             subroutine to convert a raw waveform to EGU using slope and offset.
 * created:             13-Oct-2022
 *
 * revision history:
 *   xx-xxx-xxxx        x. xxxxxxxxxxxxxx       xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
 */
#include <epicsStdlib.h>
#include <epicsStdioRedirect.h>
#include <epicsMath.h>
#include <dbDefs.h>
#include <dbCommon.h>
#include <registryFunction.h>
#include <epicsExport.h>
#include <recSup.h>
#include <aSubRecord.h>
/* Make an array with each element */
/* EGU_WF= (RAW_WF + OFFSET) * SLOPE */

static long calcWFinEGU(aSubRecord *pasub) {
    short i;
    double scaledInput;
	short *rawInput = (short *)pasub->a;
	double slope    = *(double*)pasub->b;
	double offset   = (double)(*(short*)pasub->c);
	double *output  = (double*)pasub->vala;

	double debug    =  *(double *)pasub->d; /* Input: Debug Menu */


    //pasub->pact = 1;
    if (debug) {
		printf("\nProcess Begins");
		printf("\nslope : %f ", slope);
		printf("\noffset: %f ", offset);
    }

    for (i = 0; i < pasub->nea; i++) {
		if (debug) {
		printf("\nInput: %d (-> %.3f)", rawInput[i], (double)rawInput[i]);
        }
		
        scaledInput = (double)rawInput[i] + offset;
		
        if (debug) {
		printf("\nscaledInput %.3f", scaledInput);
        }
        
        output[i] = scaledInput * slope;
        
        if (debug) {
		printf("\noutput %.3f", output[i]);
        }
        
    }

    //pasub->pact = 0;
    return 0; /* process output links */
}

epicsRegisterFunction(calcWFinEGU);
