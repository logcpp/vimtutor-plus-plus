// Created On: 2022/1/21
// Usage: get any lines from stdin, shuffle and output to stdout
// ./shuffle \n line1 \n line2 \n line3 \n ...

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

typedef struct namelist_t
{
	char** namelist;
	long int namelist_len;
} Namelist;

Namelist* get_input();
char* buf_push(char* buf, long int buf_len, char c);
char** namelist_push(char** namelist, long int namelist_len, char* buf);
void shuffle(Namelist* nl);
void free_nl(Namelist* nl);

int main(int argc, char** argv)
{
	// input
	Namelist* nl = get_input();

	// shuffle
	shuffle(nl);

	// output
	for (long int i = 0; i < nl->namelist_len; i++){
		printf("%s\n", nl->namelist[i]);
	}

	free_nl(nl);
	return 0;
}

Namelist* get_input()
{
	char c;
	long int buf_len = 0;
	char* buf = NULL;
	long int namelist_len = 0;
	char** namelist = NULL;

	while ((c=getchar()) != EOF){
		if (c != '\n'){
			buf = buf_push(buf, ++buf_len, c);
		} else {
			buf = buf_push(buf, ++buf_len, '\0');
			namelist = namelist_push(namelist, ++namelist_len, buf);
			buf = NULL;
			buf_len = 0;
		}
	}
	if (buf != NULL){
		buf = buf_push(buf, ++buf_len, '\0');
		namelist = namelist_push(namelist, ++namelist_len, buf);
		buf = NULL;
		buf_len = 0;
	}

	Namelist* nl = (Namelist*) malloc(1 * sizeof(Namelist));
	nl->namelist = namelist;
	nl->namelist_len = namelist_len;
	return nl;
}

char* buf_push(char* buf, long int buf_len, char c)
{
	char* buf_new = (char*) malloc(buf_len * sizeof(char));
	if (buf != NULL){
		strcpy(buf_new, buf);
		free(buf);
	}
	buf_new[buf_len-1] = c;
	return buf_new;
}

char** namelist_push(char** namelist, long int namelist_len, char* buf)
{
	char** namelist_new = (char**) malloc(namelist_len * sizeof(char*));
	if (namelist != NULL){
		for (long int i = 0; i < namelist_len-1; i++){
			namelist_new[i] = namelist[i];
		}
		free(namelist);
	}
	namelist_new[namelist_len-1] = buf;
	return namelist_new;
}

void shuffle(Namelist* nl)
{
	long int n = nl->namelist_len;
	if (n > 1){
		srand(time(0));
		for (long int i = 0; i < n-1; i++){
			long int x = rand() % n;
			long int y = rand() % n;
			char* tmp;
			tmp = nl->namelist[x];
			nl->namelist[x] = nl->namelist[y];
			nl->namelist[y] = tmp;
		}
	}
	return;
}

void free_nl(Namelist* nl)
{
	for (long int i = 0; i < nl->namelist_len; i++){
		free(nl->namelist[i]);
	}
	free(nl->namelist);
	free(nl);
	return;
}
