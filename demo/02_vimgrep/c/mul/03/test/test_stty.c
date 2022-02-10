#include <stdio.h>
#include <stdlib.h>

int main(void){
	printf("start testing stty, press Esc to exit\n");
	system("/bin/stty raw onlcr");
	
	char c;
	while (c != 27){	// Esc
		c = getchar();
		printf("\e[D");
		printf("%d\n\r", c);
	}

	system("/bin/stty cooked");
	printf("exited successfully\n");
	return 0;
}
