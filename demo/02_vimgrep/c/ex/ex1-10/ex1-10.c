#include <stdio.h>

int main(){
	int c;

	while ((c = getchar()) != EOF){
		switch (c){
			case '\t': printf("\\t"); continue;
			case '\b': printf("\\b"); continue;
			case '\\':  printf("\\"); continue;
		}
		putchar(c);
	}

	return 0;
}
