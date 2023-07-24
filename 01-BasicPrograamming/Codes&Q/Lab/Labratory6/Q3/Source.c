#include <stdio.h>
#define ZERO 0
#define ONE 1
#define READ_CHAR_SIZE 100 // tedad horoofi ke dar input.txt hast 51 ast vali inja 78 zekr shode chera?
#define WRITE_CHAR_SIZE 100 // tedad horoofi ke dar output.txt bayad bashe 51 ast vali inja 78 zekr shode chera?
#define INPUT_TXT_ADDRESS "input.txt"
#define OUTPUT_FILE_ADDRESS "output.txt"
#pragma warning(disable : 4996)
char* read_input_file() {
	int i;
	char* in_order_array = (char*)malloc(READ_CHAR_SIZE * sizeof(char));
	FILE* input = fopen(INPUT_TXT_ADDRESS, "r");
	for (i = 0; i < READ_CHAR_SIZE; i++) {
		if (feof(input)) break;
		//fscanf(input, "%c", &in_order_array[i]);
		fread(in_order_array + i, sizeof(char), 1, input);
	}
	in_order_array[i] = EOF;
	fclose(input);
	return in_order_array;
}
char* reverse_array(char* in_order_array) {
	int in_order_array_length, i;
	char* reversed_array = (char*) malloc(READ_CHAR_SIZE * sizeof(char));
	for (in_order_array_length = 0; in_order_array[in_order_array_length] != EOF; in_order_array_length++);
	for (i = ZERO; i < in_order_array_length; i++) {
		reversed_array[i] = in_order_array[in_order_array_length - i - 2];
	}
	reversed_array[in_order_array_length] = EOF;
	return reversed_array;
}
void write_reversed_array_in_file(char* in_order_array) {
	int reversed_array_length;
	char* reversed_array = reverse_array(in_order_array);
	for (reversed_array_length = 0; reversed_array[reversed_array_length] != EOF; reversed_array_length++);
	FILE* output = fopen(OUTPUT_FILE_ADDRESS, "w");
	int i = 0;
	while (1) {
		if (reversed_array[i + 1] == EOF) break;
		fprintf(output, "%c", reversed_array[i]);
		i++;
	}
	fclose(output);
}
/*chon tedad horoof neveshte shode dar file input.txt 51 ast va tedad horoofi ke mikhanim 78 tast 27 character baghimande ra on chizi por mikonad ke az ebteda dar khane ekhtesas yafte be reversed array mojood boode*/
int main() {
	char* in_order_array = read_input_file();
	write_reversed_array_in_file(in_order_array);
	return 0;
}