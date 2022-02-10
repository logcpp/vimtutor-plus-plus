#include <stdio.h>

int main(){
	int c, sp;
	sp = 0;
	while ((c = getchar()) != EOF){
		if (sp > 0 && c == ' '){ continue; }
		else if (c == ' '){ ++sp; }
		else{ sp = 0; }
		putchar(c);
	}
	return 0;
}
