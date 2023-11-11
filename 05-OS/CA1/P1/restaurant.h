#ifndef RESTAURANT
#define RESTAURANT

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/select.h>
#include <unistd.h>
#include <ctype.h>
#include <time.h>
#include <signal.h>

#include "connection.h"
#include "restaurant.h"
#include "utils.h"
#include "ingredients.h"


#define NAME_SIZE 100
#define OPEN 1
#define CLOSED 0
#define ACCEPTED 1
#define REJECTED 0
#define WAITING 2
#define TIME_OUT 3


typedef struct{
	char name[NAME_SIZE];
	char foodName[NAME_SIZE];
    int status;
    int tcpSocket;
}Request;

typedef struct{
char username[NAME_SIZE];
int UDP_port;
int UDP_sock;
struct sockaddr_in * UDP_addr;
int TCP_port;
int TCP_sock;
int status;
Ingredient ingredients[20];
int numIngredients;
Request * requests;
Request * sales;
int numRequests;
int numSales;
Recipe * menu;
int numMenu;
}Restaurant;

char * introduceRestaurant(Restaurant * rst);

void Interface();

void initFDS();

void STDINcommandHandler(char * buffer);

void setRestaurant(const char * argv[]);

void showIngredients();

void showSuppliers();

void sayWelcome();

void makeTCPPort();

void showRecipes();

void requestRecipes();


#endif


