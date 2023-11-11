#include "supplier.h"

Supplier spr;
FdSet fds;

void initFDS(){
  fds.max = 0;
  FD_ZERO(&fds.masterset);
  FD_SET(STDIN_FILENO,&fds.masterset);
  FD_SET(spr.UDP_sock,&fds.masterset);
  FD_SET(spr.TCP_sock,&fds.masterset);
  if(spr.UDP_sock >= fds.max)
    fds.max = spr.UDP_sock;
  if(spr.TCP_sock > fds.max)
    fds.max = spr.TCP_sock;
}

void makeTCPPort(){
    while(1){
        spr.TCP_port = random_port() ;
        spr.TCP_sock = makeServer(spr.TCP_port);
        if(spr.TCP_sock >= 0){
            char * msg = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
            sprintf(msg, "TCP port is:%d TCP sock is:%d\n", spr.TCP_port ,spr.TCP_sock);
            write(STDOUT_FILENO, msg, strlen(msg));
            //write(STDOUT_FILENO, "TCP port created\n", strlen("TCP port created\n"));
            break;
        }
    }
}

void TCPCommandHandler(int clientSocket){
  char msg[MAX_MSG_SIZE];
  int len = read(clientSocket,msg,MAX_MSG_SIZE);
  char response[MAX_MSG_SIZE];
  char answer[3];
  if(len ==0){
      FD_CLEARER(clientSocket,&fds);
      printf("request timeout\n");
      return;
  }
  //sprintf(msg,"new request ingredient\n");
  //write(STDOUT_FILENO,msg,strlen(msg));
  getInput(STDIN_FILENO, "your answer: ", answer, MAX_MSG_SIZE);
  sprintf(response,"a %s %s \n",answer , spr.username);
  write(clientSocket,response,strlen(response));
  FD_CLEARER(clientSocket,&fds);
  close(clientSocket);
}

void UDPcommandHandler(char * buffer){
  char ** tokens = tokenize(buffer , " ");
  char * msg = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
  if(!(strcmp(tokens[0],"Supplier")) && !(strcmp(tokens[1] , "Restaurant") && !(strcmp(tokens[2],"Introduction")))){
    sprintf(msg,"Restaurant Supplier Introduction u: %s p: %d ",spr.username , spr.TCP_port);
    int serverPort = strToPort(tokens[3]);
    char * server = (char *)malloc(sizeof(char) * 100);
    int serverSock ;
    int fd = connectServer(serverPort , &serverSock);
    send(serverSock , msg , strlen(msg) , 0);
    close(serverSock);
  }
  //write(STDOUT_FILENO, buffer, strlen(buffer));
  else if((!strcmp(tokens[1] , "restaurant"))&& ( (!strcmp(tokens[2],"opened") || !strcmp(tokens[2],"closed")))){
    char * msg2 = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
    sprintf(msg2,"Restaurant:%s is %s\n",tokens[0],tokens[2]);
    write(STDOUT_FILENO, msg2, strlen(msg2));
  }
  else if(!strcmp(tokens[0],"duplicate")){
    if(!strcmp(tokens[2],spr.username)){
      sendto(spr.UDP_sock,"Repeated",strlen("Repeated"),0,(struct sockaddr *)spr.UDP_addr,sizeof(*spr.UDP_addr));
      return;
    }
  }

}

void alarmhandler3(int signo){
    return;
}

void checkDuplicate(){
    signal(SIGALRM,alarmhandler3);
    siginterrupt(SIGALRM,1);
    char responseBuf[MAX_MSG_SIZE];
    char brodMsg[MAX_MSG_SIZE];
    sprintf(brodMsg,"duplicate username %s",spr.username);
    int r = sendto(spr.UDP_sock,brodMsg,strlen(brodMsg),0,(struct sockaddr *)spr.UDP_addr,sizeof(*spr.UDP_addr));

    while(1){
        int res=-1;
        memset(responseBuf, 0, MAX_MSG_SIZE);
        alarm(1);
        res=recv(spr.UDP_sock,responseBuf,MAX_MSG_SIZE,0);
        alarm(0);
        if(res<0)  return;
        if(!strcmp(responseBuf,"Repeated")){
            getInput(STDIN_FILENO, "Duplicate! Try another username: ", spr.username, NAME_SIZE);
            sprintf(brodMsg,"duplicate username %s",spr.username);
            sendto(spr.UDP_sock,brodMsg,strlen(brodMsg),0,(struct sockaddr *)spr.UDP_addr,sizeof(*spr.UDP_addr));
        }
    } 
}

void Interface(){
  char* buffer = (char*) malloc(sizeof(char) * MAX_MSG_SIZE);
  initFDS();
  while (1)
  {
    cliInit();
    memset(buffer,0,MAX_MSG_SIZE);
    fds.workingset = fds.masterset;
    select(fds.max + 1,&fds.workingset,NULL,NULL,NULL);

    for(int i = 0; i <= fds.max ; i++){ //iterate on fds
      if(FD_ISSET(i,&fds.workingset)){ // is the fd working
        if(i != STDIN_FILENO){
          write(STDOUT_FILENO,"\x1b[2K\r",6);
        } 
        if(i == STDIN_FILENO){ //STDIN
          getInput(STDIN_FILENO, NULL, buffer, MAX_MSG_SIZE);
          //STDINcommandHandler(buffer);
        }
        else if(i == spr.UDP_sock){ //BROADCAST
          memset(buffer,0,MAX_MSG_SIZE);
          recv(i , buffer, MAX_MSG_SIZE, 0);
          UDPcommandHandler(buffer);
        }
        else if(i == spr.TCP_sock){ //ACCEPT
          int acc = acceptClient(spr.TCP_sock);
          if (acc > 0){
            write(STDOUT_FILENO,"new request ingredient\n",strlen("new request ingredient\n"));
          }
          //close(i);
          //FD_CLEARER(i,&fds);
          FD_SETTER(acc,&fds);
          continue;
        }
        else{ //TCP MESSAGE
          TCPCommandHandler(i);
          continue;
        }
      }  
    }
  }
}

void setSupplier(const char* argv[]){
    spr.UDP_port= strToPort(argv[1]);
    makeTCPPort();
    //struct sockaddr_in brodAddr;
    spr.UDP_addr = (struct sockaddr_in *)malloc(sizeof(struct sockaddr_in));
    spr.UDP_sock = makeBroadcast(BROADCAST_IP,spr.UDP_port, spr.UDP_addr);
}

char * introduceSupplier(Supplier * spr){
	char * msg = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
	sprintf(msg, "%s %d %d %d %d", spr->username, spr->UDP_port , spr->TCP_port ,spr->UDP_sock , spr->TCP_sock);
	return msg;
}

void sayWelcome(){
    char * welcomeMsg = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
    sprintf(welcomeMsg, "welcome %s as a supplier\n", spr.username);
    write(STDOUT_FILENO, welcomeMsg, strlen(welcomeMsg));
}

int main(int argc, const char* argv[]){
    checkStart(argc);
    setSupplier(argv);
    getInput(STDIN_FILENO, "Please enter your username: ", spr.username, NAME_SIZE);
    checkDuplicate();
    sayWelcome();
    //char* msg = introduceSupplier(&spr);
    //sendto(spr.UDP_sock, msg, strlen(msg), 0, (struct sockaddr *)&spr.UDP_addr, sizeof(&spr.UDP_addr));
    Interface();
    return 0 ; 
}