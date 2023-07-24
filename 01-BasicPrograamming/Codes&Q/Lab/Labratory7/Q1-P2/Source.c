#include <stdio.h>
#include <stdlib.h>
#define INITIAL_ARRAY_SIZE 4
#define FINAL_ARRAY_SIZE 5
#define ZERO 0
#define ONE 1
#define FIVE 5
void print_array(int* array_of_int, int size) {
	for (int i = 0; i < size; i++)
		printf("%d ", array_of_int[i]);
	printf("\n");
}
void initislizing_the_array(int* array_of_int, int size) {
	for (int i = ZERO; i < size; i++)
		array_of_int[i] = ZERO;
}
int main(int argv, char** argc) {
	int* array_of_int = (int*)malloc(INITIAL_ARRAY_SIZE *
		sizeof(int));
	initislizing_the_array(array_of_int, INITIAL_ARRAY_SIZE);
	print_array(array_of_int, INITIAL_ARRAY_SIZE);
	array_of_int = (int*)realloc(NULL, FINAL_ARRAY_SIZE *sizeof(int));
	array_of_int[FINAL_ARRAY_SIZE - ONE] = FIVE;
	print_array(array_of_int, FINAL_ARRAY_SIZE);
	return 0;
}