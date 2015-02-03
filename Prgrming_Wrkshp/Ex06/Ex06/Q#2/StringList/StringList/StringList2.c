#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "stringList.h"

StringList initStringList() {
	return NULL;
}

StringList insertStringByLength(char* string, StringList list){
	StringList newNode = initStringList();
	int newStrLen = strlen(string);
	//Allocating memo for the node iteself, then for its string
	newNode = (StringList)malloc(sizeof(Node));
	newNode->data = (char*)malloc(sizeof(char) * newStrLen + 1);
	strcpy(newNode->data, string);

	//Got nothign to do, we leave
	if (list == NULL) { return newNode; }

	StringList currNode = list;

	while (currNode != NULL) {
		int currNodeLen = strlen(currNode->data);


		if (newStrLen > currNodeLen) {
			newNode->next = currNode;
			list = newNode;
			break;
		}
		else {
			if (currNode->next == NULL) {
				currNode->next = newNode;
				break;

			}
			else if (newStrLen > strlen(currNode->next->data)) {
				newNode->next = currNode->next;
				currNode->next = newNode;
				break;
			}
			else {
				currNode = currNode->next;
			}
		}
	}
	return list;

}


void printStringList(StringList list){
	int counter = 1;
	StringList currElem;
	for (currElem = list; currElem != NULL; currElem->next = list->next) {
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
