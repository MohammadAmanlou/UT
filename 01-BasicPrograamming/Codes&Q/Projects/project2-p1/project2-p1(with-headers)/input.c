#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "input.h"
void input(char** command) {
	*command = (char*)malloc(sizeof(char) * 20);
	int max = 20;
	for (int i = 0; i < max; i++)
		(*command)[i] = 0;
	char c;
	int i = 0;
	getchar();
	while ((c = getchar()) != ' ' && (c != '\n')) {
		(*command)[i++] = c;
		if ((*command)[max - 1] != 0) {
			max += 10;
			*command = (char*)realloc(*command, max * sizeof(char));
		}
	}
	(*command)[i] = '\0';
	if ((*command)[i] == 0) { (*command)[i] = '\0'; }
}