/*
 * purpose:             subroutine to calculate a polynomial with up to 8 coefficients; used with EPICS subroutine record
 * created:             12-May-2006
 * property of:         Stanford Linear Accelerator Center,
 *                      developed under contract from Mimetic Software Systems Inc.
 *
 * revision history:
 *   12-May-2006        Doug Murray             initial version
 */

#include <stdio.h>

#include <registryFunction.h>
#include <epicsExport.h>
#include <subRecord.h>

/*
 * apparently, this is required.
 */
static long
initPolynomial( subRecord *psub)
        {

        return 0;
        }

/*
 * Calculate polynomial.
 * f = a*x^0 + b*x^1 + c*x^2 + d*x^3 + e*x^4 + f*x^5 + g*x^6 + h*x^7
 */
static long
calcPolynomial( subRecord *psub)
        {
        double result;
        double x;
 
 
        if( psub == NULL)
                return 0;

        x = psub->l;

        result = psub->a;

        if( psub->b != 0)
                result += psub->b * x;

        x *= psub->l;
        if( psub->c != 0)
                result += psub->c * x;

        x *= psub->l;
        if( psub->d != 0)
                result += psub->d * x;

        x *= psub->l;
        if( psub->e != 0)
                result += psub->e * x;

        x *= psub->l;
        if( psub->f != 0)
                result += psub->f * x;

        x *= psub->l;
        if( psub->g != 0)
                result += psub->g * x;

        x *= psub->l;
        if( psub->h != 0)
                result += psub->h * x;

        psub->val = result;

        


        return 0;
        }

epicsRegisterFunction( initPolynomial);
epicsRegisterFunction( calcPolynomial);
