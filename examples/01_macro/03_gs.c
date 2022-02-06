// replace '\' with '\\' only in the code, not in the comments
// run `:v/^\s*\/\//s/'\\'/'\\\\'/g`
#include <stdio.h>

int main()
{
	// To escape the '\' character, you have to add 1 more '\' before '\'
	printf("To escape the '\' character, you have to add 1 more '\' before '\'\n");
	return 0;
}
