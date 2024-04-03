/* subroutine record for calculating the voltage output corresponding to*/
/* Gain requested      						*/
/*					        				*/
/* Version History:							*/
/*	24-Jul-2022	  N. Balakrishnan (namrata) */
/*	 Initial version 						*/

#include <epicsStdlib.h>
#include <epicsStdioRedirect.h>
#include <epicsMath.h>
#include <dbDefs.h>
#include <dbCommon.h>
#include <registryFunction.h>
#include <epicsExport.h>
#include <recSup.h>
#include <aSubRecord.h>


/* Initialization function for all  subroutines */
static int	aInit(aSubRecord *pasub) {
	return(0);
}

/* Gain to Volatge converstion */
static int calcG2V(aSubRecord *precord) {

	double gainTotal     =  *(double*)precord->a; /* Input: Gain request*/ 
	double DEBUG         =  *(double*)precord->b; /* Input: Debug Menu */

    //Gin = 20*log10(100/241.1);
    //Gout = 20*log10((100/104.99)*(1+330/680)*(50/52.1));
    double Gin           = -7.6439;/* Attenuation at input to first AD60 */ 
    double Gout          = 2.6559;/* Partially compensate for this loss with gain at output op amp (without% loss of overall bandwidth */
    
    // Internal variables for calculations
    double e             = 0;
    double f             = 0;
    double g             = 0;
    //

    double G1            = 0;
    double G2            = 0;
    double G12           = 0;
    double V             = 0;/* DAQ Voltage requested */                           
   
    if (DEBUG) {
		printf("\nProcess Begins");
		printf("\ngainTotal : %f ", gainTotal);
    }

    if (DEBUG) {
		printf("\nGin = %f ", Gin);
		printf("\nGout = %f ", Gout);
    }
    G12 = gainTotal - Gin - Gout;

    if (DEBUG) {
		printf("\nG12 = %f ", G12);
    }

    if (G12 < -21) {
        G2 = -11;
        G1 = G12-G2+10;
        e = (double)G1/1.07 ;
        V = -0.5 + ( 0.05 * log(1 + e));

//        V  = -0.5+0.05*log(1+(G1+10)/1.07);        

        if (DEBUG) {
	    	printf("\nG < -21 so V = %f ", V);
        }
    }
    else {
         if (G12 <= 17) {
             G2 = -11;
             G1 = G12-G2;
             V  = (G1-10)/40;        
             if (DEBUG) {
	         	printf("\nG >-21 but <= 17 so V = %f ", V);
             }
         }
         else {
              if (G12 < 23 ){
                 V  = 0.45 + 0.0206 * (G12 -17);        
                 if (DEBUG) {
	              	printf("\nG > 17 but < 23 so V = %f ", V);
                 }
              }
              else {
                   if (G12 <=60) {
                       G1 = 31;
                       G2 = G12-G1;
                       V  = 1.024 + (G2 -10)/40;        
                       if (DEBUG) {
	                   	printf("\nG >=23 but G <=60 so V = %f ", V);
                       }
                   }
                   else {
                       G1 = 31;
                       G2 = G12-G1;
                       f = G2 - 30;
                       g = (double)f/1.07 ;
                       V  = 1.524 - (0.05 * log(1-g));
                       if (DEBUG) {
	                   	printf("\nG >60 so V = %f ", V);
                       }
                   }
              }
         }
    }     

    if (DEBUG) {
       	printf("\nProcess Ends\n");
    }

    *(double *)precord->vala = V;

	return(0);
}

epicsRegisterFunction(aInit);
epicsRegisterFunction(calcG2V);
