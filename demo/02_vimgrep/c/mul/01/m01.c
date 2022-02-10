#include <stdio.h>
#include <pthread.h>
#include <err.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void f1(void);

int main(void){
	pthread_t thread1;
	int ret1;	// result of pthread_create

	/* int pthread_create(pthread_t* thread, const pthread_attr_t* attr,
						  void* (*start_routine)(void*), void* arg) */
	ret1 = pthread_create(&thread1, NULL, (void*) f1, NULL);
	// if pthread_create successful, returns 0
	// else, returns error num
	if (ret1 != 0){
		err(EXIT_FAILURE, "cannot create thread 1: %s", strerror(ret1));
	}

	printf("thread created, execute pthread_join\n");
	/* int pthread_join(pthread_t thread, void** retval) */
	ret1 = pthread_join(thread1, NULL);
	// if pthread_join successful, returns 0
	// else, returns error num
	if (ret1 != 0){
		err(EXIT_FAILURE, "can not join thread 1");
	}
	printf("thread terminated, pthread_join finished\n");
	return 0;
}

void f1(void){
	for (int i = 0; i < 4; i++){
		printf("Running thread: %d\n", i);
		sleep(1);
	}
}
