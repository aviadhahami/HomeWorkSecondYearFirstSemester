int main(int argc, char *argv[]) {

	double num1, num2;
	char *symb;

	if (argc != 4){
		fprintf(stderr, "Usage: newFloatTest num1 <op> num2\n");
		return 1;
	}
	else {
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
				//doing sumCHANNANNANANANNANANAN
				if (num2 == 2.0){
					printf("used add2. its good\n");
					answer = add2(newNum1);
				}
				else {
					answer = newFloatSum(newNum1, newNum2);
				}
			else {
				//doing mult
				if (num2 == 2.0){
					printf("used mult2. its good\n");
					answer = mult2(newNum1);
				}
				else {
					answer = newFloatProduct(newNum1, newNum2);
				}
			}
			printf("%.7g %s %.7g = %.7g\n", num1, symb, num2, newFloatToDouble(answer));
			}
		}
		return 0;
	}