#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "stringList.h"

//2. If the list has n strings, then the first n entries of the array point to valid strings, and the others have NULL value(the figure above demonstrates a list with two strings)
//3. A string of length m should occupy exactly m + 1 bytes in memory(including the byte reserved for the terminating ‘\0’)
//4. If you try to insert a string to the list when it is full, then insertStringByLength() returns NULL.


//Inits a StringList type of variable
StringList initStringList(){
	StringList list;
	list = (StringList)malloc(LIST_SIZE * sizeof(char*));
	int i = 0;
	while (i < LIST_SIZE){
		list[i] = NULL;
	}
	return list;
};

//Input: a StringList and a string
//Logic: The function inserts the new string after the first string with same length.
//		 If non exit -> will inject it @ top of StringList.
//Output : StringList post insertion, all strings are sorted by length.
//Expections: Will throw back NULL if couldn't allocate memo
StringList insertStringByLength(char* string, StringList list){
	int  currLength = strlen(string);
	// we check for more room in the list, assuming NULLs are propagated right
	if (!gotRoom(list)) return NULL;
	//TODO: gotRoom
	//main logic, if we got free spot we malloc them, else we propagate right and then malloc them.
	int i =0;
	for (i=0; i < LIST_SIZE; i++){
		if (list[i] != NULL){
			if (!currLength < strlen(list[i])){
				propagateRight(list, i);
				list[i] = (char*)malloc(currLength * sizeof(char) + 1);
				strcpy(list[i], string);
				return list;
			}else{
				list[i] = (char*)malloc(currLength * sizeof(char) + 1);
				strcpy(list[i], string);
				return list;
			}
		}
	}
	return 0;
}

void propagateRight(StringList list, int currIndex){
	int i =0;
	for ( i = LIST_SIZE - 1; currIndex <= i; i--){
		if (list[i] != NULL)
			list[i + 1] = list[i];
	}
}
//this func returns true if the last item is null.
//We depend on a heuristic saying that the last spot in the array
//is null if we got a room 
int gotRoom(StringList list){
	return list[LIST_SIZE - 1] == NULL ? 1 : 0;
}

//Input: StringList
//Output: Prints all the strings by their length (long to short),
//		  prefixed by their index number
void printStringList(StringList list){
	if (list == NULL) return;
	int i = 0;
	while (i < LIST_SIZE){
		if (list[i] != NULL){
			printf("$d. %s \n", i, list[i]);
		}
	}
}

//Free's the allocated memory !IMPORTANT
void freeStringList(StringList list){
	int i = 0;
	while (i < LIST_SIZE){
		if (list[i] != NULL){
			free(list[i]);
		}
	}
};
