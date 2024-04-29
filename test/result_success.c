#include <stdio.h>
#include <stdbool.h>

int SMALLER = 0;
int BIGGER = 0;
int TEMP = 0;

int main() {
	scanf("%d", &BIGGER);
	scanf("%d", &SMALLER);
	if (SMALLER > BIGGER) {
		TEMP = SMALLER;
		SMALLER = BIGGER;
		BIGGER = TEMP;
	}
	
	printf("%d", BIGGER);
	return 0;
}