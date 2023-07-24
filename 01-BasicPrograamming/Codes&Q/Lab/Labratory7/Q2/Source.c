#include <stdio.h>
#include <stdlib.h>
int main() {
	int* p = (int*)malloc(10 * sizeof(int));
	int i;
	printf("P = 0x%p\n", p);
	for (i = 0; i < 10; i++)
	{
		p[i] = i;
	}
	free(p);
	printf("P = 0x%p\n", p);
	printf("P[0] =%d", *p);
	return 0;
}