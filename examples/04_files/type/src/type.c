// 2021/01/20

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct word_list
{
	int line_num;
	int *word_len;
	char **list;
} Word_list;

void clear();
void hidec();
void showc();
char* gen_word(char wordlen);
void print_word(char *str, char wordlen, char idx);
char read_key(char *str, char wordlen);
void rand_type(char minlen, char maxlen);
void load_word(char *srcfile, Word_list *word);
void free_word(Word_list *word);
void norm_type(char *srcfile);

int main()
{
	printf("before system");
	system("/bin/stty raw");
	
	printf("before srcfile");
	char *srcfile = "src/type.txt";
	FILE *fp = fopen(srcfile, "r");
	printf("fp");
	fclose(fp);
	if (fp == NULL){
		printf("\rerror: cannot find file \"%s\", execute in random mode?(y/n)", srcfile);
		char c;
		if ((c = getc(stdin)) == 'y'){ rand_type(5, 20); }
	} else {
		printf("befor norm");
		norm_type(srcfile);
	}

	system("/bin/stty cooked");
	return 0;
}

void clear(){ printf("\r\e[2K\e[0m"); }
void hidec(){ printf("\e[?25l"); }
void showc(){ printf("\e[?25h"); }

char* gen_word(char wordlen)
{
	char *str = (char*) malloc(wordlen * sizeof(char));
	char idx = 0;
	for (int i = 0; i < wordlen; i++){ str[idx++] = rand() % 26 + 'a'; }
	str[idx] = '\0';
	return str;
}

void print_word(char *str, char wordlen, char idx)
{
	clear();
	for (int i = 0; i < wordlen; i++){
		if (i < idx){ printf("\e[36;1m"); }
		else { printf("\e[0m"); }
		printf("%c", str[i]);
	}
	printf("\r");
	for (int i = 0; i < idx; i++){ printf("\e[C"); }
}

char read_key(char *str, char wordlen)
{
	char idx = 0;
	while (idx < wordlen){
		print_word(str, wordlen, idx);
		char c;
		if ((c = getc(stdin)) == 27){ return 1; } // Esc
		while (c != str[idx]){
			print_word(str, wordlen, idx);
			printf("\e[31;1m%c\e[D", str[idx]);
			if ((c = getc(stdin)) == 27){ return 1; }
		}
		printf("\e[D\e[36;1m%c", str[idx++]);
	}
	return 0;
}

void rand_type(char minlen, char maxlen)
{
	char gmov = 0;
	srand(time(0));
	hidec();
	while (!gmov){
		char wordlen = rand() % (maxlen - minlen) + minlen;
		char *str = gen_word(wordlen);
		gmov = read_key(str, wordlen);
		free(str);
	}
	clear();
	showc();
}

void load_word(char *srcfile, Word_list *word)
{
	FILE *fp;

	// load line_num
	word->line_num = 0;
	fp = fopen(srcfile, "r");
	char c;
	while ((c = getc(fp)) != EOF){ if (c == '\n'){ word->line_num++; } }
	fclose(fp);

	// load word_len
	word->word_len = (int*) malloc(word->line_num * sizeof(int));
	fp = fopen(srcfile, "r");
	int idx = 0;
	int cnt = 0;
	while ((c = getc(fp)) != EOF){
		if (c == '\n'){
			word->word_len[idx] = cnt;
			cnt = 0; idx++;
		} else { cnt++; }
	}
	fclose(fp);

	// load list
	word->list = (char**) malloc(word->line_num * sizeof(char*));
	fp = fopen(srcfile, "r");
	for (int i = 0; i < word->line_num; i++){
		word->list[i] = (char*) malloc((word->word_len[i] + 1) * sizeof(char));
		if (fscanf(fp, "%[^\n]%*1[\n]", word->list[i]) == EOF){
			fprintf(stderr, "error: size of file \"%s\" has been modified\n", srcfile);
			exit(1);
		}
	}
	fclose(fp);
}

void free_word(Word_list *word)
{
	for (int i = 0; i < word->line_num; i++){ free(word->list[i]); }
	free(word->word_len);
	free(word->list);
	free(word);
}

void norm_type(char *srcfile)
{
	Word_list *word = (Word_list*) malloc(sizeof(Word_list));
	load_word(srcfile, word);

	char gmov = 0;
	srand(time(0));
	hidec();
	while (!gmov){
		int w = rand() % word->line_num;
		gmov = read_key(word->list[w], word->word_len[w]);
	}
	clear();
	showc();

	free_word(word);
}
