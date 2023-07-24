#include <stdio.h>
#define INPUT_FILE_ADRESS "input2.bmp"
#define OUTPUT_FILE_ADRESS "out.bmp"
#pragma warning(disable : 4996)
int main() {
	FILE* input = fopen(INPUT_FILE_ADRESS, "rb");
	FILE* output = fopen(OUTPUT_FILE_ADRESS, "wb");
	char file_properties[154], picture_data[50][50][3];
	fread(file_properties, sizeof(char), 154 , input);
	for (int i = 0; i < 50; i++) {
		for (int j = 0; j < 50; j++) {
			fread(picture_data[i][j], sizeof(char), 3, input);
			for (int k = 0; k < 3; k++) picture_data[i][j][k] += 100;
		}
	}
	fwrite(file_properties, sizeof(char), 154, output);
	for (int i = 0; i < 50; i++) {
		for (int j = 0; j < 50; j++) {
			fwrite(picture_data[i][j], sizeof(char), 3, output);
		}
	}
}