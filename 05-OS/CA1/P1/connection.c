#include "connection.h"

int makeBroadcast(const char* ipAddr, unsigned short port, struct sockaddr_in* addrOut) {
    int socketId = socket(AF_INET, SOCK_DGRAM, 0);
    if (socketId < 0) 
        return socketId;

    int broadcast = 1;
    int reuseport = 1;
    setsockopt(socketId, SOL_SOCKET, SO_BROADCAST, &broadcast, sizeof(broadcast));
    setsockopt( socketId, SOL_SOCKET, SO_REUSEPORT, &reuseport, sizeof(reuseport));
    //struct sockaddr_in addr;
    addrOut->sin_family = AF_INET;
    addrOut->sin_port = htons(port);
    addrOut->sin_addr.s_addr = inet_addr("255.255.255.255");//inet_addr("192.168.1.255");
    //inet_pton(AF_INET, ipAddr, &(addrOut->sin_addr.s_addr));
    memset(addrOut->sin_zero, '\0', sizeof(addrOut->sin_zero));

    bind(socketId, (struct sockaddr*)addrOut, sizeof(*addrOut));
    return socketId;
}

int makeServer(unsigned short port) {
    int socketId = socket(PF_INET, SOCK_STREAM, 0);
    if (socketId < 0) return socketId;

    int opt = 1;
    setsockopt(socketId, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));

    struct sockaddr_in addr;
    addr.sin_family = AF_INET;
    addr.sin_port = htons(port);
    addr.sin_addr.s_addr = INADDR_ANY;
    memset(addr.sin_zero, '\0', sizeof(addr.sin_zero));

    int b = bind(socketId, (struct sockaddr*)&addr, sizeof(addr));
    if (b < 0) {
        write(STDOUT_FILENO, "Error: Binding socket\n", strlen("Error: Binding socket\n"));
        return b;
    }

    int l = listen(socketId, 10);
    if (l < 0) {
        write(STDOUT_FILENO, "Error: Listening socket\n", strlen("Error: Listening socket\n"));
        return l;
    }
    return socketId;
}

int acceptClient(int serverFd) {
    int clientFd;
    struct sockaddr_in clientAddress;
    int addressLen = sizeof(clientAddress);
    
    clientFd = accept(serverFd, (struct sockaddr *)&clientAddress, (socklen_t*) &addressLen);
    
    return clientFd;
}

int connectServer(unsigned short port, int* outServerSocket) {
    int serverId = socket(AF_INET, SOCK_STREAM, 0);
    if (serverId < 0) return serverId;
    struct sockaddr_in addr;
    addr.sin_family = AF_INET;
    addr.sin_port = htons(port);
    inet_pton(AF_INET, "127.0.0.1", &(addr.sin_addr.s_addr));
    memset(addr.sin_zero, '\0', sizeof(addr.sin_zero));

    *outServerSocket = serverId;
    return connect(serverId, (struct sockaddr*)&addr, sizeof(addr));
    
}

void FD_SETTER(int socketId, FdSet* fdset) {
    FD_SET(socketId, &fdset->masterset);
    if (socketId > fdset->max) 
        fdset->max = socketId;
}

void FD_CLEARER(int socketId, FdSet* fdset) {
    FD_CLR(socketId, &fdset->masterset);
    if (socketId == fdset->max)
        --fdset->max;
}

/*int* makeTCPPort(){
    int* ports = (int *)malloc(sizeof(int)*2);
    while(1){
        ports[0] = random_port() ;
        ports[1] = makeServer(ports[0]);
        if(ports[1] >= 0){
            write(STDOUT_FILENO, "TCP port created\n", strlen("TCP port created\n"));
            break;
        }
        write(STDOUT_FILENO, "Error: Creating TCP port\n", strlen("Error: Creating TCP port\n"));
    }
    return ports;
}*/
