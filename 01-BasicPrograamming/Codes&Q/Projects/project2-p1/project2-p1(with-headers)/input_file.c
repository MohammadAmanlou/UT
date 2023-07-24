#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "input_file.h"
void input_file(char** buffer, FILE* file) {
	(*buffer) = (char*)malloc(sizeof(char) * 20);
	int max = 20;
	for (int i = 0; i < max; i++)
		(*buffer)[i] = 0;
	char c;
	int i = 0;
	while ((!feof(file) && (c = fgetc(file)) != ' ') && (c != '\n')) {
		(*buffer)[i++] = c;
		if ((*buffer)[max - 1] != 0) {
			max += 10;
			(*buffer) = (char*)realloc((*buffer), max * sizeof(char));
		}
	}
	(*buffer)[i] = '\0';
	if ((*buffer)[i] == 0) { (*buffer)[i] = '\0'; }
}