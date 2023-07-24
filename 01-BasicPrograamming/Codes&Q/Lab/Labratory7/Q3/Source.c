#include <stdio.h>
#include <stdlib.h>
void main() {
	int* p = NULL;
	int i = 50000000;
	while (1) {
		p = realloc(p, i * sizeof(int));/*put breakpoint here*/
		i += 50000000;
	}
	free(p);
	//return 0;
}