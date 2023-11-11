#ifndef Utils
#define Utils

#include <arpa/inet.h>
#include <string.h>
#include <sys/select.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <time.h>
#include <stdlib.h>
#include <ctype.h>
#include <sys/stat.h>
#include <fcntl.h>

#include "utils.h"
#include "ingredients.h"


#define NAME_SIZE 128
#define MAX_BUFF  256
#define BROADCAST_IP  "192.168.1.255"
#define MAX_PORT 65535
#define MAX_PORT_LEN 10
#define TCP_RANGE 1024
#define MAX_PORT 65535
#define MAX_MSG_SIZE 1024
#define ANSI_WHT "\x1b[37m"
#define ANSI_RESET "\x1b[0m"
#define ANSI_RED "\x1b[31m"
#define ANSI_GRN "\x1b[32m"
#define ANSI_YEL "\x1b[33m"
#define ANSI_BLU "\x1b[34m"
#define ANSI_RST "\x1b[0m"

typedef struct{
    int max;
    fd_set masterset;
    fd_set workingset;
}FdSet;

int random_port();

void getInput(int fd, const char* request, char* dst, size_t dstLen);

int strToPort(const char* str);

void checkStart(int argc);

int strToPort(const char* str);

void getInput(int fd, const char* request, char* dst, size_t dstLen);

char * strConcat(char* src, char* catStr,int dist);

char** tokenize(char* str, const char* delimiter);

void cliInit();

char* readFile();

int extractFoodsFromJson(const char* json_data , Recipe* foods);

int getFoods(Recipe* foods);









#endif