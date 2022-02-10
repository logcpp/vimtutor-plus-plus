#include <stdio.h>

int main(){
	float fahr, celsius;
	int lower, upper, step;

	lower = 0;
	upper = 300;
	step = 10;
	fahr = lower;

	printf("  F        C\n");
	while (fahr <= upper){
		celsius = 5 * (fahr-32) / 9.0;
		printf("%3.0f%9.1f\n", fahr, celsius);
		fahr += step;
	}

	return 0;
}
