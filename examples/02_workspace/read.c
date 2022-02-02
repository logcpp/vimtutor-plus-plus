// :mksession
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>

int main()
{
	printf("This is a program for testing.\n");

	int fd = open("./read.c", O_RDONLY);
	char buf;

	while (read(fd, &buf, 1) > 0){
		printf("%c", buf);
	}

	printf("END\n");

	close(fd);
	return 0;
}
