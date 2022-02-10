#include <stdio.h>

int main(){
	float celsius, fahrenheit;
	int lower, upper, step;

	lower = 0;
	upper = 300;
	step = 20;
	celsius = lower;

	printf("  C        F\n");
	while (celsius <= upper){
		fahrenheit = celsius * 9 / 5.0 + 32;
		printf("%3.0f%9.1f\n", celsius, fahrenheit);
		celsius += step;
	}

	return 0;
}
