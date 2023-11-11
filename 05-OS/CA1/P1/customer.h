#ifndef CUSTOMER
#define CUSTOMER


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/select.h>
#include <unistd.h>
#include <ctype.h>
#include <time.h>
#include <signal.h>

#include "connection.h"
#include "utils.h"
#include "customer.h"
#include "ingredients.h"

#define NAME_SIZE 100

typedef struct{
char username[NAME_SIZE];
int UDP_port;
int UDP_sock;
struct sockaddr_in * UDP_addr;
int TCP_port;
int TCP_sock;
Recipe * recipes;
}Customer;

char * introduceCustomer(Customer * cst);
void initFDS();
void interface();
void set_customer(const char* argv[]);
void makeTCPPort();
void STDINcommandHandler(char * buffer);
void getMenu();
void orderFood();
















#endif