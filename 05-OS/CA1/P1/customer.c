#include "customer.h"

Customer cst;
FdSet fds;

void makeTCPPort(){
    while(1){
        cst.TCP_port = random_port() ;
        cst.TCP_sock = makeServer(cst.TCP_port);
        if(cst.TCP_sock >= 0){
            //write(STDOUT_FILENO, "TCP port created\n", strlen("TCP port created\n"));
            char * msg = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
            sprintf(msg, "TCP port is:%d TCP sock is:%d\n", cst.TCP_port ,cst.TCP_sock);
            write(STDOUT_FILENO, msg, strlen(msg));
            break;
        }
        write(STDOUT_FILENO, "Error: Creating TCP port\n", strlen("Error: Creating TCP port\n"));
    }
}

char * introduceCustomer(Customer * cst){
    char * msg = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
    sprintf(msg, "%s %d %d", cst->username, cst->UDP_port , cst->UDP_sock );
    return msg;
}

void initFDS(){
  fds.max = 0;
  FD_ZERO(&fds.masterset);
  FD_SET(STDIN_FILENO,&fds.masterset);
  FD_SET(cst.UDP_sock,&fds.masterset);
  FD_SET(cst.TCP_sock,&fds.masterset);
  if(cst.UDP_sock >= fds.max)
    fds.max = cst.UDP_sock;
  if(cst.TCP_sock > fds.max)
    fds.max = cst.TCP_sock;
  if(STDIN_FILENO > fds.max)
    fds.max = STDIN_FILENO;
}

void alarmHandler(int signo){
  return;
}

void showRestaurants(char ** tokens){
  char * msg = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
  char * response = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
  sprintf(msg, "show restaurants %s %d", cst.username, cst.TCP_port);
  sendto(cst.UDP_sock,msg,strlen(msg),0,(struct sockaddr *)cst.UDP_addr,sizeof(*cst.UDP_addr));
  signal(SIGALRM,alarmHandler);
  siginterrupt(SIGALRM,1);
  while(1){
    int restSocket = -1;
    alarm(1); 
    restSocket = acceptClient(cst.TCP_sock);
    alarm(0);
    memset(response,0,MAX_MSG_SIZE);
    if(restSocket <= 0){
      break;
    }
    recv(restSocket,response,MAX_MSG_SIZE,0);
    char ** tokens = tokenize(response," ");
    char * msg2 = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
    sprintf(msg2,"Restaurant:%s port:%s\n",tokens[1],tokens[3]);
    write(STDOUT_FILENO,msg2,strlen(msg2));

  }
  free(msg);
  free(response);
}

void getMenu(){
  cst.recipes = (Recipe *)malloc(sizeof(Recipe)*20);
  getFoods(cst.recipes);
  char msg[NAME_SIZE];
  char ing [NAME_SIZE];

  for(int i = 0; i < 20 ; i++){
    if( strlen(cst.recipes[i].name)>1){
      sprintf(msg,"%d.%s\n",i,cst.recipes[i].name);
      write(STDOUT_FILENO,msg,strlen(msg));
    } 
  }
}
int time_out =0;
void alarmhandler2(int sig){
    time_out=1;
}

void orderFood(){
  char foodName[NAME_SIZE];
  char rstPortc[NAME_SIZE];
  getInput(STDIN_FILENO,">>Food name: ",foodName,NAME_SIZE);
  getInput(STDIN_FILENO,">>Restaurant port: ",rstPortc,NAME_SIZE);
  int rstPort = strToPort(rstPortc);
  int connectSocket;
  int result=connectServer(rstPort,&connectSocket);
  if(result<0){
      write(STDOUT_FILENO,"Error: Connecting to server\n",strlen("Error: Connecting to server\n"));
      return;
  }
  char * msg = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
  char * response = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
  signal(SIGALRM,alarmhandler2);
  siginterrupt(SIGALRM, 1);
  sprintf(msg,"order %s %s %d",foodName,cst.username, cst.TCP_port);
  write(connectSocket,msg,MAX_MSG_SIZE);
  sprintf(msg,"waiting for restaurant's response ... \n");
  write(STDOUT_FILENO,msg,strlen(msg));
  alarm(120);
  recv(connectSocket,response,MAX_MSG_SIZE,0);
  alarm(0);
  char ** tokens = tokenize(response," ");
    if(time_out==1){
        sprintf(msg,"REQUEST TIMEOUT\n");
        write(STDOUT_FILENO,msg,strlen(msg));
    }
    else if(!strcmp(tokens[0],"yes")){
        sprintf(msg,"%s restaurant accepted and your food is ready\n",tokens[1]);
        write(STDOUT_FILENO,msg,strlen(msg));
    }
    else if(!strcmp(tokens[0],"no")){
        sprintf(msg,"%s restaurant rejected and cry about it\n",tokens[1]);
        write(STDOUT_FILENO,msg,strlen(msg));
    }
    close(connectSocket);
    time_out=0;
}

void STDINcommandHandler(char * buffer){
  char ** tokens = tokenize(buffer , " ");
  char * msg = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
  if(!strcmp(tokens[0],"show") && !strcmp(tokens[1],"restaurants")){
    showRestaurants(tokens);
  }
  else if(!strcmp(tokens[0],"show") && !strcmp(tokens[1],"menu")){
    getMenu();
  }
  else if(!strcmp(tokens[0],"order") && !strcmp(tokens[1],"food")){
    orderFood();

  }
  else if(!strcmp(tokens[0],"exit")){
    //exit(tokens);
  }
  else{
    write(STDOUT_FILENO, "Error: Invalid command\n", strlen("Error: Invalid command\n"));
  }
}

void UDPcommandHandler(char * buffer){
  char ** tokens = tokenize(buffer , " ");
  char * msg = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
  if(!strcmp(tokens[0],"duplicate")){
    if(!strcmp(tokens[2],cst.username)){
      sendto(cst.UDP_sock,"Repeated",strlen("Repeated"),0,(struct sockaddr *)cst.UDP_addr,sizeof(*cst.UDP_addr));
      return;
    }
  }
  else if(!strcmp(tokens[0],"exit")){
    //exit(tokens);
  }
  else if((!strcmp(tokens[1] , "restaurant"))&& ( (!strcmp(tokens[2],"opened") || !strcmp(tokens[2],"closed")))){
    char * msg2 = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
    sprintf(msg2,"Restaurant:%s is %s\n",tokens[0],tokens[2]);
    write(STDOUT_FILENO, msg2, strlen(msg2));
  }
  else{
    write(STDOUT_FILENO, "Error: Invalid command\n", strlen("Error: Invalid command\n"));
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
    sprintf(brodMsg,"duplicate username %s",cst.username);
    int r = sendto(cst.UDP_sock,brodMsg,strlen(brodMsg),0,(struct sockaddr *)cst.UDP_addr,sizeof(*cst.UDP_addr));

    while(1){
        int res=-1;
        memset(responseBuf, 0, MAX_MSG_SIZE);
        alarm(1);
        res=recv(cst.UDP_sock,responseBuf,MAX_MSG_SIZE,0);
        alarm(0);
        if(res<0)  return;
        if(!strcmp(responseBuf,"Repeated")){
            getInput(STDIN_FILENO, "Duplicate! Try another username: ", cst.username, NAME_SIZE);
            sprintf(brodMsg,"duplicate username %s",cst.username);
            sendto(cst.UDP_sock,brodMsg,strlen(brodMsg),0,(struct sockaddr *)cst.UDP_addr,sizeof(*cst.UDP_addr));
        }
    } 
}


void Interface(){
  char * buffer = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
  initFDS();
  while (1)
  {
    cliInit();
    memset(buffer,0,MAX_MSG_SIZE);
    fds.workingset = fds.masterset;
    select(fds.max + 1,&fds.workingset,NULL,NULL,NULL);
          char * msg = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);

    for(int i = 0; i <= fds.max; i++){ //iterate on fds

      if(FD_ISSET(i,&fds.workingset)){ // is the fd working
    write(STDOUT_FILENO,msg,strlen(msg));
        char * msg = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
        if(i != STDIN_FILENO){
          write(STDOUT_FILENO,"\x1B[2K\r",6);
        }
        if(i == STDIN_FILENO){ //STDIN
          getInput(STDIN_FILENO, NULL, buffer, MAX_MSG_SIZE);
          STDINcommandHandler(buffer);
        }
        else if(i == cst.UDP_sock){ //BROADCAST
          read(i , buffer, MAX_MSG_SIZE);
          UDPcommandHandler(buffer);
        }
        else if(i == cst.TCP_sock){ //ACCEPT
          int acc = acceptClient(cst.TCP_sock);
          //close(i);
          //FD_CLEARER(i,&fds);
          FD_SETTER(acc,&fds);
        }
        else{ //TCP MESSAGE
          //TCPcommandHandler(buffer);
          continue;
        }
      }  
    }
  }
}

void set_customer(const char* argv[]){
    cst.UDP_port= strToPort(argv[1]);
    makeTCPPort();
    cst.UDP_addr = (struct sockaddr_in *)malloc(sizeof(struct sockaddr_in));
    cst.UDP_sock = makeBroadcast(BROADCAST_IP,cst.UDP_port, cst.UDP_addr);
    char * msg = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
    sprintf(msg , "UDP port is:%d UDP sock is:%d\n", cst.UDP_port ,cst.UDP_sock);
    write(STDOUT_FILENO, msg, strlen(msg));
}

void sayWelcome(){
    char * welcomeMsg = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
    sprintf(welcomeMsg, "welcome %s as a customer\n", cst.username);
    write(STDOUT_FILENO, welcomeMsg, strlen(welcomeMsg));
}

int main(int argc, const char* argv[]){
    checkStart(argc);
    set_customer(argv);
    getInput(STDIN_FILENO, "Please enter your username: ", cst.username, NAME_SIZE);
    checkDuplicate();
    sayWelcome();
    //char* msg = introduceRestaurant(&rest);
    //sendto(rest.UDP_sock, msg, strlen(msg), 0, (struct sockaddr *)&rest.UDP_addr, sizeof(&rest.UDP_addr));
    Interface();
    return 0 ; 
}