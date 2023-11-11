#ifndef CONNECTION
#define CONNECTION

#include <arpa/inet.h>
#include <string.h>
#include <sys/select.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <stdio.h>
#include <sys/types.h>
#include <netinet/in.h>

#include "utils.h"

int makeBroadcast(const char* ipAddr, unsigned short port, struct sockaddr_in* addrOut);

int makeServer(unsigned short port);

int acceptClient(int serverFd);

int connectServer(unsigned short port, int* outServerSocket);

void FD_SETTER(int socket, FdSet* fdset);

void FD_CLEARER(int socket, FdSet* fdset);




#endif