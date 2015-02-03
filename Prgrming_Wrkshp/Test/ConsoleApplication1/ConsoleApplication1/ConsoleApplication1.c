
#include <stdio.h>
#include <string.h>
#define SIZE 3
typedef struct node{
	char *name;
	int id;
} Rec;
int main() {
	Rec n[SIZE], *p;
	int i;
	char *s[]= { "one", "two","three"};

	for (i = 0; i < SIZE; i++){
		n[i].name = malloc(strlen(s[i]) + 1);
		strcpy(n[i].name, s[i]);
		n[i].id = i;
	}
	p = n;
	for (i = 0; i < SIZE; i++){
		printf("%2d %s\n", p->id, p->name);
		p++;
	}
	getchar();
}