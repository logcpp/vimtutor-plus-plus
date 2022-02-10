#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <err.h>
#include <string.h>
#include <unistd.h>

void f1(int* th_num);	// get input
void f2(int* th_num);
char c;

int main(void){
	c = 0;	// initialize
	
	pthread_t th_1, th_2;
	int ret_1, ret_2;
	int arg_1 = 1;
	int arg_2 = 2;

	ret_1 = pthread_create(&th_1, NULL, (void*) &f1, &arg_1);
	if (ret_1 != 0){ err(EXIT_FAILURE, "error: cannot create thread [1]: %s\r\n", strerror(ret_1)); }
	printf("created thread [1] successfully\r\n");
	ret_2 = pthread_create(&th_2, NULL, (void*) &f2, &arg_2);
	if (ret_2 != 0){ err(EXIT_FAILURE, "error: cannot create thread [2]: %s\r\n", strerror(ret_2)); }
	printf("created thread [2] successfully\r\n");

	ret_1 = pthread_join(th_1, NULL);
	if (ret_1 != 0){ err(EXIT_FAILURE, "error: cannot join thread [1]: %s\r\n", strerror(ret_1)); }
	ret_2 = pthread_join(th_2, NULL);
	if (ret_2 != 0){ err(EXIT_FAILURE, "error: cannot join thread [2]: %s\r\n", strerror(ret_2)); }

	printf("exited successfully\r\n");

	return 0;
}

void f1(int* th_num){
	printf("\e[32msubthread [%d] started\e[0m\r\n", *th_num);
	system("/bin/stty raw onlcr");

	while (c != 27){	// Esc
		c = getchar();
		printf("\e[2K\r");
	}

	system("/bin/stty cooked");
	printf("\e[32msubthread [%d] terminated\e[0m\r\n", *th_num);
}

void f2(int* th_num){
	printf("\e[32msubthread [%d] started\e[0m\r\n", *th_num);
	int cnt = 0;

	while (c != 27){	// Esc
		printf("Running subthread [%d]: cnt=%d, %c(%d)\r\n", *th_num, cnt, c, c);
		sleep(1);
	}

	printf("\e[32msubthread [%d] terminated\e[0m\r\n", *th_num);
}
