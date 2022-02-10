#include <stdio.h>
#include <pthread.h>
#include <err.h>
//#include <errno.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

void f_1(int* arg);

int main(void){
	pthread_t thread_1, thread_2;
	int ret_1, ret_2;
	int arg_1 = 1;
	int arg_2 = 2;

	ret_1 = pthread_create(&thread_1, NULL, (void*) f_1, &arg_1);
	if (ret_1 != 0){ err(EXIT_FAILURE, "error: cannot create thread_1: %s\n", strerror(ret_1)); }
	printf("created thread_1 successfully\n");

	ret_2 = pthread_create(&thread_2, NULL, (void*) f_1, &arg_2);
	if (ret_2 != 0){ err(EXIT_FAILURE, "error: cannot create thread_2: %s\n", strerror(ret_2)); }
	printf("created thread_2 successfully\n");

	ret_1 = pthread_join(thread_1, NULL);
	if (ret_1 != 0){ fprintf(stderr, "error: cannot join thread_1\n"); exit(2); }
	printf("joined thread_1 successfully\n");

	ret_2 = pthread_join(thread_2, NULL);
	if (ret_2 != 0){ fprintf(stderr, "cannot join thread_2\n"); exit(2); }
	printf("joined thread_2 successfully\n");

	return 0;
}

void f_1(int* arg){
	printf("\t\e[32msubthread [%d] started\e[0m\n", *arg);
	for (int i = 0; i < 4; i++){
		printf("\tRunning subthread [%d]: %d\n", *arg, i);
		sleep(1);
	}
	printf("\t\e[32msubthread [%d] terminated\e[0m\n", *arg);
}
