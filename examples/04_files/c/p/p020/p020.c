#include <stdio.h>

int main(){
	int c;
	while ((c = getchar()) && c != EOF){
		putchar(c);
	}
	return 0;
}
