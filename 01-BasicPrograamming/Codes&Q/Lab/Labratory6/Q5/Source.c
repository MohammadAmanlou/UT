#include <stdio.h>
#define ZERO 0
#define ONE 1
#define READ_CHAR_SIZE 78 // tedad horoofi ke dar input.txt hast 51 ast vali inja 78 zekr shode chera?
#define WRITE_CHAR_SIZE 78 // tedad horoofi ke dar output.txt bayad bashe 51 ast vali inja 78 zekr shode chera?
#define INPUT_TXT_ADDRESS "input.txt"
#define OUTPUT_FILE_ADDRESS "output.txt"
#pragma warning(disable : 4996)
int main() {
	FILE* input = fopen(INPUT_TXT_ADDRESS, "r");
	FILE* output = fopen(OUTPUT_FILE_ADDRESS, "a");
	while (!feof(input)) {
		char c = fgetc(input);
		if (c != EOF) fprintf(output, "%c", c);
	}
	fclose(input);
	fclose(output);
}