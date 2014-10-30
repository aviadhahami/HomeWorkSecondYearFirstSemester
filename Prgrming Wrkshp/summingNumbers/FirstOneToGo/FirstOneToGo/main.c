#include <stdio.h>
int main(){
	int inputA, inputB;

	printf("enter a number: ");
	scanf("%d", inputA);
	printf("enter a number: ");
	scanf("%d", inputB);

	printf("number is %d\n", sum(inputA, inputB));
	
	return(0);
}

int sum(int a, int b){

	int c;
	c = a + b;
	return c;
}