#include <stdio.h>
#include <string.h>

//custom includes
#include "readString.h"


#define DEBUG

main(){

	char input[MAX_STR_LEN];
	printf("Enter string(up to %d characters) :\n", MAX_STR_LEN);
	readString(input);
	printf("You entered the following string (length %d):\n", strlen(input));
	printf("%s\n", input);
	printf("Done.\n");

#ifdef DEBUG
	holdExit();
#endif


}

holdExit(){
	getchar();
	return 0;
}
