#ifndef INGREDIENTS
#define INGREDIENTS

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/select.h>
#include <unistd.h>

#define NAME_SIZE 100

typedef struct{
	char name[NAME_SIZE];
	int quantity; 
}Ingredient;

typedef struct{
	char name[NAME_SIZE];
	Ingredient ings[20];
	int numIngredients;

}Recipe;





#endif