#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define EINVAL	22

int main(void){
	printf("%s\n", strerror(EINVAL));
	return 0;
}
