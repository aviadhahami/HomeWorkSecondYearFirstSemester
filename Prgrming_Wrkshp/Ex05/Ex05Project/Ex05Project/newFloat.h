/******************************************************
*        newFloat.h - header file for NewFloat        *
******************************************************/

/***************************************************************************
* NewFloat provides a 4-byte floating point representation of numbers with
* user-defined percision defined by the number of bits allocated for the
* exponent (EXPBITS) and number of bits allocated for the mantissa
* (MANBITS = 4*8 - EXPBITS).
*
* Representation is defined as follows:
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
* - NewFloat represents only positive numbers and has no sign bit
* Special cases:
* - 0 is represented by the all-0 vector
* - infinity (INF) is represented by the all-1 exponent and all-0 mantissa
* Otherwise:
* - let exp be the integer in [0,2^EXPBITS-2] represented by the exponent bits
* - let man be the integer in [0,2^MANBITS-1] represented by the mantissa bits
* - let EXPOFFSET = 2^(EXPBITS-1)-1
* - the number represented by the 4-byte NewFloat is:
*     num = 2^(exp-EXPOFFSET) * (1 + man / 2^MANBITS)
*
* Notice: unlike in the standard floating point represenation, a leading 1 is
*         ALWAYS added to the mantissa, with the only exception being the 0 number
***************************************************************************/

#ifndef __NEWFLOAT_H
#define __NEWFLOAT_H

typedef unsigned long int NewFloat;

/*******************************************
*           C O N S T A N T S              *
*******************************************/

#define EXPBITS 6
#define MANBITS (4*8-EXPBITS)
#define INF (((1 << EXPBITS)-1) << MANBITS)


/***************************************************************************
* function doubleToNewFloat
* ~~~~~~~~~~~~~~~~~~~~~~~~~
* Converts a double to NewFloat
* - negative doubles are converted according to their absolute value (-3 represented as 3)
* - if double exponent is too large, number is converted to NewFloat INF
* - if double exponent is too small, number is converted to 0 (all 0s)
* - double mantissa bits are truncated ( IS THIS ALWAYS THE CLOSEST REPRESENTATION? )
*
* params:
* + d (double) - double to convert to NewFloat
*
* return:
* + a NewFloat number most closely representing the input double
**********************************/
NewFloat doubleToNewFloat(double d);


/***************************************************************************
* function newFloatToDouble
* ~~~~~~~~~~~~~~~~~~~~~~~~~
* Converts a NewFloat to double
* - conversion preserves the exact value of the number
* - 0 mapped to 0 and INF mapped to inf
*
* params:
* + nfloat (NewFloat) - NewFloat to convert to double
*
* return:
* + a double number identically representing the input NewFloat
**********************************/
double newFloatToDouble(NewFloat nfloat);


/***************************************************************************
* function newFloatSum
* ~~~~~~~~~~~~~~~~~~~~
* Adds two NewFloat numbers
* - if the sum overflows (exp of sum >= 2^EXPBITS-1), then returns INF
* - truncates mantissa bits that cannot be represetned
*
* params:
* + nfloat1 (NewFloat) - NewFloat to add
* + nfloat2 (NewFloat) - NewFloat to add
*
* return:
* + a NewFloat which is the sum of both numbers
**********************************/
NewFloat newFloatSum(NewFloat nfloat1, NewFloat nfloat2);


/***************************************************************************
* function newFloatProduct
* ~~~~~~~~~~~~~~~~~~~~~~~~~
* Multiplies two newFloat numbers.
* - if the product overflows  (exp of product >= 2^EXPBITS-1), then returns INF
* - if the product underflows (exp of product < 0), then returns 0
* - truncates mantissa bits that cannot be represetned
*
* params:
* + nfloat1 (NewFloat) - NewFloat to multiply
* + nfloat2 (NewFloat) - NewFloat to multiply
*
* return:
* + a NewFloat which is the product of both numbers
**********************************/
NewFloat newFloatProduct(NewFloat nfloat1, NewFloat nfloat2);


#endif

/*******************************************
*        E N D   O F   F I L E             *
*******************************************/

