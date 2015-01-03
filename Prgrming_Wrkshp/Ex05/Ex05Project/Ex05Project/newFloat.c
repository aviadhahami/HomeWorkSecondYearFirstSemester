/******************************************************
*        newFloat.c - code file for NewFloat          *
******************************************************/

#include "newFloat.h"
#include <stdio.h>


#if (EXPBITS < 2 || EXPBITS > 11)
#error "number of exponent bits allocated for NewFloat out or range [2,11]"
#endif

/*******************************************
*           C O N S T A N T S              *
*******************************************/

// offset in exponent of NewFloat ((2^(EXPBITS-1)-1) e.g., 127 = 2^7 - 1 for float with 8 exponent bits)
#define EXPOFFSET ((1 << (EXPBITS - 1)) - 1)

// constants for double percision fractional representation
#define MANBITS_DOUBLE   52
#define EXPBITS_DOUBLE   11
// offset in exponent of double ((2^(EXPBITS_DOUBLE-1)-1)

#define EXPOFFSET_DOUBLE ((1 << (EXPBITS_DOUBLE - 1)) - 1)

/****************************************
*              M A C R O S              *
****************************************/

// masking mantissa - returns exponent bits
#define MASKMAN(A) ((A)& (~0 << MANBITS))

// masking exponent - returns mantissa bits
#define MASKEXP(A) ((A)& (~(~0 << MANBITS)))

// gets exponent - shift exponent to right edge of 4-byte block
#define GETEXP(A)  (MASKMAN(A) >> MANBITS)

/****************************************************
*       I N T E R F A C E   F U N C T I O N S       *
****************************************************/
/***************************************************************************
* function doubleToNewFloat
* ~~~~~~~~~~~~~~~~~~~~~~~~~
* Converts a double to NewFloat
* - negative doubles are converted according to their absolute value (-3 represe                                                                                                             nted as 3)
* - if double exponent is too large, number is converted to NewFloat INF
* - if double exponent is too small, number is converted to 0 (all 0s)
* - double mantissa bits are truncated ( IS THIS ALWAYS THE CLOSEST REPRESENTATI                                                                                                             ON? )
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
	unsigned long long int infy = 0x7ff0000000000000;
	if (nfloat == 0.0) return (double)0;
	if (nfloat == INF) return *(double*)&infy;

	// mantissa of NewFloat added the ammount of heading zeros

	d_mantissa = ((unsigned long long int)MASKEXP(nfloat) << (MANBITS_DOUBLE - MANBITS));

	// exponent of NewFloat is exponent of Double, but need to re-set offset
	d_exponent = ((unsigned long long int)GETEXP(nfloat) - EXPOFFSET + EXPOFFSET_DOUBLE) << MANBITS_DOUBLE;

	d_as_long_long = d_exponent + d_mantissa;

#ifdef DEBUG
	printf("  double mantissa: %llx\n", d_mantissa);
	printf("  double exponent: %x\n", (unsigned)d_exponent);
	printf("  double all: %llx\n", d_as_long_long);
#endif

	return *((double*)(&d_as_long_long));

}
/** end of newFloatToDouble() **/

NewFloat newFloatSum(NewFloat x, NewFloat y) {
	unsigned long long int man_x, man_y, exp_x, exp_y, bigger_exp, bigger_man, smaller_exp, smaller_man, sum_man, MAX_man, MAX_exp;


	if ((newFloatToDouble(x) == 0.0)){
		return y;
	}
	else if ((newFloatToDouble(y) == 0.0)){
		return x;
	}


	man_x = MASKEXP(x);
	exp_x = GETEXP(x);
	man_y = MASKEXP(y);
	exp_y = GETEXP(y);

	bigger_exp = exp_x >= exp_y ? exp_x : exp_y;
	bigger_man = exp_x >= exp_y ? man_x : man_y;
	smaller_exp = exp_x < exp_y ? exp_x : exp_y;
	smaller_man = exp_x < exp_y ? man_x : man_y;

	MAX_man = (~(~0 << MANBITS));
	MAX_exp = (~(~0 << EXPBITS));

	sum_man = bigger_man + (1 << ((unsigned long long int)(smaller_exp - bigger_exp + MANBITS))) + ((unsigned long long int)smaller_man >> (bigger_exp - smaller_exp));


	while (sum_man > MAX_man) {
		bigger_exp++;
		sum_man = ((unsigned long long int)(sum_man) >> 1) - ((unsigned long long int)1 << (MANBITS - 1));

	}


	if (bigger_exp >= MAX_exp) return (NewFloat)INF;

	return (bigger_exp << MANBITS) + sum_man;


}


NewFloat newFloatProduct(NewFloat x, NewFloat y) {
	unsigned long long int man_x, man_y, exp_x, exp_y, prod_man, MAX_man, MAX_exp, prod_exp;

	if ((newFloatToDouble(x) == 0.0) || (newFloatToDouble(y) == 0)){
		return doubleToNewFloat(0);
	}
	man_x = MASKEXP(x);
	exp_x = GETEXP(x);
	man_y = MASKEXP(y);
	exp_y = GETEXP(y);

	MAX_man = (~(~0 << MANBITS));
	MAX_exp = (~(~0 << EXPBITS));

	prod_man = (unsigned long long)(man_x + man_y) + ((unsigned long long)(man_x * man_y) >> MANBITS);

	prod_exp = exp_x + exp_y - EXPOFFSET;

	while (prod_man > MAX_man) {
		prod_exp++;
		prod_man = ((unsigned long long int)(prod_man) >> 1) - ((unsigned long long int)1 << (MANBITS - 1));

	}

	if (prod_exp >= MAX_exp) return (NewFloat)INF;

	return (prod_exp << MANBITS) + prod_man;

}


NewFloat mult2(NewFloat nfloat) {
	double d;
	NewFloat n;
	d = 2.0;
	n = doubleToNewFloat(d);
	return newFloatProduct(n, nfloat);
}


NewFloat add2(NewFloat nfloat){
	double d;
	NewFloat n;
	d = 2.0;
	n = doubleToNewFloat(d);
	return newFloatSum(n, nfloat);
}

int main(int argc, char *argv[]) {
	double num1, num2;
	char *symb;

	if (argc != 4){
		fprintf(stderr, "Usage: newFloatTest num1 <op> num2\n");
		return 1;
	}
	else{
		num1 = atof(argv[1]);
		num2 = atof(argv[3]);
		if (((num1 == 0) && (strcmp(argv[1], "0") != 0)) || ((num2 == 0) && (strcmp(argv[3], "0") != 0))){
			fprintf(stderr, "Error: Both input must be of double type\n");
			return 1;
		}
		symb = argv[2];
		if ((strcmp(symb, "+") != 0) && (strcmp(symb, "x") != 0)){
			fprintf(stderr, "Error: Operator is not '+' or 'x'\n");
			return 1;
		}
		else {
			NewFloat newNum1, newNum2, answer;
			newNum1 = doubleToNewFloat(num1);
			newNum2 = doubleToNewFloat(num2);
			if (strcmp(symb, "+") != 1){
				//doing sum
				if (num2 == 2.0){
					printf("used add2. its good\n");
					answer = add2(newNum1);
				}
				else{
					answer = newFloatSum(newNum1, newNum2);
				}
			}
			else{
				//doing mult
				if (num2 == 2.0){
					printf("used mult2. its good\n");
					answer = mult2(newNum1);
				}
				else{
					answer = newFloatProduct(newNum1, newNum2);
				}
			}
			printf("%.7g %s %.7g = %.7g\n", num1, symb, num2, newFloatToDouble(answer));
		}
	}
	return 0;
}

/*******************************************
*        E N D   O F   F I L E             *
*******************************************/
