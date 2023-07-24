#include <stdio.h>
#include <stdlib.h>
int main() {
	int row, col, i;
	int** A;
	printf("Enter row and column:\n");
	scanf_s("%d %d", &row, &col);
	A = (int **) malloc(row *sizeof(int *)); /* 1. Complete this instruction */
	if (A == NULL) exit(EXIT_FAILURE);
	for (i = 0; i < row; i++) {
		A[i] = (int *) malloc(col *sizeof(int)); /* 2. Complete this instruction */
		if (A[i] == NULL)
			exit(EXIT_FAILURE);
	}
		for (i = 0; i < row; i++)
			free(A[i]);
	free(A);
	return 0;
}