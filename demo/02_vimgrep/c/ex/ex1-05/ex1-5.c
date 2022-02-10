#include <stdio.h>

#define L 0
#define U 300
#define S 20

int main(){
	for (int fahr = U; fahr >= L; fahr -= S){
		printf("%3d %6.1f\n", fahr, 5.0*(fahr-32)/9.0);
	}
	return 0;
}
