#include <stdio.h>
#include <stdlib.h>
#include "StringList.h"


#ifdef STRINGLIST1
typedef char** StringList
#endif
#ifndef LIST_SIZE
#define LIST_SIZE 10
#endif
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
StringList insertStringByLength(char* string, StringList list);

//Input: StringList
//Output: Prints all the strings by their length (long to short),
//		  prefixed by their index number
void printStringList(StringList list);

//Free's the allocated memory !IMPORTANT
void freeStringList(StringList list){
	int i = 0;
	while (i < LIST_SIZE){
		int dummy;
		if (list[i] == NULL){
			continue;
		}
		else{
			free(list[i]);
		}
	}
};