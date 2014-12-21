/******************************************************
*        newFloat.c - code file for NewFloat          *
******************************************************/

#include "newFloat.h"
#include <stdio.h>


#if (EXPBITS < 2 || EXPBITS > 11)
#error "number of exponent bits allocated for NewFloat out of range [2,11]"
#endif

/*******************************************
*           C O N S T A N T S              *
*******************************************/

// offset in exponent of NewFloat ((2^(EXPBITS-1)-1) e.g., 127 = 2^7 - 1 for float with 8 exponent bits)
#define EXPOFFSET  ((1 << (EXPBITS-1))-1)

// constants for double percision fractional representation
#define MANBITS_DOUBLE   52
#define EXPBITS_DOUBLE   11
// offset in exponent of double ((2^(EXPBITS_DOUBLE-1)-1)
#define EXPOFFSET_DOUBLE   ((1 << (EXPBITS_DOUBLE -1))-1)

/****************************************
*              M A C R O S              *
****************************************/

// masking mantissa - returns exponent bits
#define MASKMAN(A) ((A) & (~0 << MANBITS))

// masking exponent - returns mantissa bits
#define MASKEXP(A) ((A) & 0x7FFFFF)

// gets exponent - shift exponent to right edge of 4-byte block
#define GETEXP(A)  (((((A)<<1)>>1) & 0x7FFF)>>23)


/****************************************************
*       I N T E R F A C E   F U N C T I O N S       *
****************************************************/


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
NewFloat doubleToNewFloat(double d) {

	NewFloat nfloat_mantissa, nfloat_exponent;
	unsigned long long int d_as_long_long;
	int nfloat_exp_offseted_int;

#ifdef DEBUG
	printf("double %lf to NewFloat\n", d);
#endif

	// 0.0 is mapped to 0.0 and negative numbers are mapped to positive numbers
	if (d == 0.0) return (NewFloat)0;
	if (d < 0.0) d = -d;

	// this is a trick using referencing and de-refererncing by a pointer to convert d
	// to an 8-byte unsigned long long so that we could manipulate its bits
	d_as_long_long = *((unsigned long long*)&d);

	// mantissa of NewFloat looses MANBITS_DOUBLE - MANBITS least significant bits
	nfloat_mantissa = MASKEXP(d_as_long_long >> (MANBITS_DOUBLE - MANBITS));
	// exponent of NewFloat is exponent of double, but need to re-set offset
	nfloat_exp_offseted_int = ((int)(d_as_long_long >> MANBITS_DOUBLE) - EXPOFFSET_DOUBLE + EXPOFFSET);

#ifdef DEBUG
	printf("  nfloat mantissa: %lx\n", nfloat_mantissa);
	printf("  double exponent: %d, %x\n", (int)(d_as_long_long >> MANBITS_DOUBLE), (unsigned int)(d_as_long_long >> MANBITS_DOUBLE));
	printf("  nfloat exponent (offseted, as int): %d\n", nfloat_exp_offseted_int);
#endif

	//  check for overflow / underflow   
	if (nfloat_exp_offseted_int > (int)(2 * EXPOFFSET)) {
		// overflow - exponent is too large to be represented by a NewFloat - represent as INF
		return (NewFloat)INF;
	}
	else if (nfloat_exp_offseted_int < 0) {
		// underflow - exponent is too small
		return (NewFloat)0;
	}

	nfloat_exponent = (NewFloat)nfloat_exp_offseted_int << MANBITS;

	return nfloat_mantissa + nfloat_exponent;

}
/** end of doubleToNewFloat() **/

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
double newFloatToDouble(NewFloat nfloat) {

	unsigned long long int d_mantissa, d_exponent, d_as_long_long;


	/******************
	*  ADD CODE HERE  *
	******************/

#ifdef DEBUG
	printf("  double mantissa: %llx\n", d_mantissa);
	printf("  double exponent: %x\n", (unsigned)d_exponent);
	printf("  double all: %llx\n", d_as_long_long);
#endif

	//	return *((double*)(&d_as_long_long));

}
/** end of newFloatToDouble() **/


/*******************************************
*        E N D   O F   F I L E             *
*******************************************/

