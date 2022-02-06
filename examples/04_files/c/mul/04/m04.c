#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

void die(char* str){
	perror(str);
	exit(2);
}

int main(){
	pid_t pid = fork();
	if (pid == -1){
		die("fork");
	}
	else if (pid == 0){
		usleep(1000000);
		exit(0);
	}
	else {
		printf("pid = %d\n", pid);
		int ws;
		pid_t cid = waitpid(pid, &ws, 0);
		if (cid == -1) { die("waitpid"); }
		if (WIFEXITED(ws)) {
			printf("%d : exited normally\n", cid);
		} else if (WIFSIGNALED(ws)) {
			printf("%d : terminated by signal\n", cid);
		}
	}
	printf("parent exited\n");
	return 0;
}
