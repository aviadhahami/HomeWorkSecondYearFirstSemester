#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "StringList.h"

StringList initStringList() {
	return NULL;
}
StringList insertStringByLength(char* string, StringList list){}


void printStringList(StringList list){
	int counter = 1;
	for (StringList currElem = list; currElem != NULL; currElem->next = list->next) {
		printf("%d. %s\n", counter, currElem->data);
		counter++;
	}
}


void freeStringList(StringList list) {
	while (list->next != NULL){
		free(list->data);
		free(list);
		list = list->next;
	}
}