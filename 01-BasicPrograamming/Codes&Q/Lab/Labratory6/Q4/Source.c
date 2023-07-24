#include <stdio.h>
#include <stdlib.h>
#define ZERO 0
#define ONE 1
#define READ_CHAR_SIZE 51
#define WRITE_CHAR_SIZE 51
#define INPUT_TXT_ADDRESS "input.txt"
#define OUTPUT_FILE_ADDRESS "output.txt"
#pragma warning(disable : 4996)
char* read_input_file() {
	char* in_order_array = (char*)malloc(READ_CHAR_SIZE * sizeof(char));
	FILE* input = fopen(INPUT_TXT_ADDRESS, "r");
	char c;
	int j = 0;
	for (int i = 0; i < READ_CHAR_SIZE; i += 4)
	{
		fseek(input, i, SEEK_SET);
		c = fgetc(input);
		in_order_array[j] = c;
		j++;
	}
	fclose(input);

	return in_order_array;
}
char* reverse_array(char* in_order_array) {

	char* reversed_array = (char*)malloc(READ_CHAR_SIZE * sizeof(char));
	for (int i = ZERO; i < 13; i++) {
		reversed_array[i] = in_order_array[13 - 1 - i];
	}

	return reversed_array;
}
void write_reversed_array_in_file(char* in_order_array) {
	char* reversed_array = reverse_array(in_order_array);
	FILE* output = fopen(OUTPUT_FILE_ADDRESS, "w");
	fwrite(reversed_array, sizeof(char), 13, output);
	fclose(output);
}
int main() {
	char* in_order_array = read_input_file();
	write_reversed_array_in_file(in_order_array);
	return 0;
}