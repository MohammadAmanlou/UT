#ifndef SUPPLIER
#define SUPPLIER

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/select.h>
#include <unistd.h>
#include <ctype.h>
#include <time.h>
#include <signal.h>

#include "connection.h"
#include "supplier.h"
#include "utils.h"
#include "ingredients.h"


#define NAME_SIZE  128
#define MAX_BUFF  256
#define BROADCAST_IP  "192.168.1.255"
#define MAX_PORT 65535

typedef struct{
char username[NAME_SIZE];
int UDP_port;
int UDP_sock;
struct sockaddr_in * UDP_addr;
int TCP_port;
int TCP_sock;
}Supplier;

void initFDS();
void Interface();
void STDINcommandHandler(char * buffer);
void setSupplier(const char * argv[]);
char* introduceSupplier(Supplier* spr);
void UDPcommandHandler(char * buffer);
void TCPCommandHandler(int i);
void sayWelcome();
void makeTCPPort();

#endif
