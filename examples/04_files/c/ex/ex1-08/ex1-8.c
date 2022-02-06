#include <stdio.h>

int main(){
	int c, sp, tb, nl;
	sp = tb = nl = 0;
	while ((c = getchar()) != EOF){
		switch (c){
			case ' ': ++sp; break;
			case '\t': ++tb; break;
			case '\n': ++nl; break;
		}
	}
	printf("SPACE: %d  TAB: %d  NEWLINE: %d\n", sp, tb, nl);
	return 0;
}
