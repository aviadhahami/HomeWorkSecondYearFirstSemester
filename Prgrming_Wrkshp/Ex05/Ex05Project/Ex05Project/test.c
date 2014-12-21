#include "newFloat.h"
#include <stdio.h>



// offset in exponent of NewFloat ((2^(EXPBITS-1)-1) e.g., 127 = 2^7 - 1 for float with 8 exponent bits)
#define EXPOFFSET  ((1 << (EXPBITS-1))-1)
#define MANBITS_DOUBLE   52
#define EXPBITS_DOUBLE   11
// offset in exponent of double ((2^(EXPBITS_DOUBLE-1)-1)
#define EXPOFFSET_DOUBLE   ((1 << (EXPBITS_DOUBLE -1))-1)

// masking exponent - returns mantissa bits
#define MASKEXP(A) ((A) & 0x7FFFFF)

// gets exponent - shift exponent to right edge of 4-byte block
#define GETEXP(A)  (((((A)<<1)>>1) & 0x7FFF)>>23)

void main(){
	int c, d;
	int maskEXP = 0x7FFFFF;
	int getEXP = 0x7FFF;
	printf("%d",EXPOFFSET);

	//getBinary(20);
	//getBinary(c = 20 << 1);
	//getBinary(d = c >> 1);
	//getBinary(maskEXP);
	//getBinary(getEXP);

	getchar();
	return(0);
}


int getBinary(int n){
	while (n) {
		if (n & 1)
			printf("1");
		else
			printf("0");

		n >>= 1;
	}
	printf("\n");
}