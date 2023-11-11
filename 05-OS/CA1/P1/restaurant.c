
#include "restaurant.h"


#define BROADCAST_IP "192.168.1.255"
Restaurant rest;
FdSet fds;

void showRecipes(){
  char msg[NAME_SIZE];
  char ing [NAME_SIZE];

  for(int i = 0; i < 20 ; i++){
    if( strlen(rest.menu[i].name)>1){
      sprintf(msg,"%d.%s\n",i,rest.menu[i].name);
      write(STDOUT_FILENO,msg,strlen(msg));
      for (int j = 0; j < 20; j++){
          if(rest.menu[i].ings[j].quantity != 0){
            sprintf(ing,"\t %d.%s , %d\n",j,rest.menu[i].ings[j].name , rest.menu[i].ings[j].quantity);
            write(STDOUT_FILENO,ing,strlen(ing));
          }
      }
    } 
  }
}
int numOfIngs_extractIngredients = 0;
void extractIngredients(const Recipe* foods, Ingredient* ingredients) {
    if (ingredients == NULL) {
        ingredients = (Ingredient*)malloc(20 * sizeof(Ingredient));
    }

    for (int i = 0; i < foods->numIngredients; i++) {
        const Recipe* currentFood = &foods[i];
        for (int j = 0; j < currentFood->numIngredients; j++) {
            const Ingredient* currentIngredient = &currentFood->ings[j];
            int isDuplicate = 0;
            for (int k = 0; k < 20; k++) {
                if (strcmp(currentIngredient->name, ingredients[k].name) == 0) {
                    isDuplicate = 1;
                    break;
                }
            }
            if (!isDuplicate) {
                strcpy(ingredients[numOfIngs_extractIngredients].name, currentIngredient->name);
                ingredients[numOfIngs_extractIngredients].quantity=0;
                numOfIngs_extractIngredients++;
            }
        }
    }
}

void showIngredients(){
  char ingr[NAME_SIZE];
  for(int i = 0; i < rest.numIngredients ; i++){
  sprintf(ingr,"%s %d\n",rest.ingredients[i].name,rest.ingredients[i].quantity);
  write(STDOUT_FILENO,ingr,strlen(ingr));
  }
}

void alarmHandler(int signo ){
  return;
}

void showSuppliers(){
  char * msg = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
  char * response = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
  sprintf(msg , "Supplier Restaurant Introduction %d\n" , rest.TCP_port);
  sendto(rest.UDP_sock,msg,strlen(msg),0,(struct sockaddr *)rest.UDP_addr,sizeof(*rest.UDP_addr));
  signal(SIGALRM,alarmHandler);
  siginterrupt(SIGALRM,1);
  while(1){
    int supplierSocket = -1;
    alarm(1); 
    supplierSocket = acceptClient(rest.TCP_sock);
    alarm(0);
    memset(response,0,MAX_MSG_SIZE);
    if(supplierSocket <= 0){
      break;
    }
    recv(supplierSocket,response,MAX_MSG_SIZE,0);
    char ** tokens = tokenize(response," ");
    char * msg2 = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
    sprintf(msg2,"Supplier:%s port:%s\n",tokens[4],tokens[6]);
    write(STDOUT_FILENO,msg2,strlen(msg2));

  }
  free(msg);
  free(response);

}


//Global variable to check if the alarm has been triggered
int time_out = 0;

void alarmhandler2(int signo){
  time_out = 1;
  return;
}

void addIngredient(char * ingName , int ingNum){
  Ingredient ing;
  strcpy(ing.name,ingName);
  ing.quantity = ingNum;
  for(int i = 0; i < rest.numIngredients; i++){
      if(!strcmp(rest.ingredients[i].name,ingName)){
      rest.ingredients[i].quantity += ingNum;
      return;
    }
  }
  rest.ingredients[rest.numIngredients] = ing;
  rest.numIngredients++;
}

void requestRecipes(){
  char * response = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
  char supPortc[NAME_SIZE];
  getInput(STDIN_FILENO, ">>Port of supplier: ", supPortc, NAME_SIZE);
  int supPort = strToPort(supPortc);
  char ingName[NAME_SIZE];
  getInput(STDIN_FILENO, ">>Ingredient name: ", ingName, NAME_SIZE);
  char ingNumc[MAX_PORT_LEN];
  getInput(STDIN_FILENO, ">>Ingredient quantity: ", ingNumc, MAX_PORT_LEN);
  int ingNum = atoi(ingNumc);
  char * msg = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
  sprintf(msg,"Request ingredient %s %d",ingName,ingNum);
  int supSock ;
  int r = connectServer(supPort , &supSock);
  if (r == -1){
    write(STDOUT_FILENO,"Error connecting to supplier\n",strlen("Error connecting to supplier\n"));
    return;
  }
  send(supSock,msg,strlen(msg),0);
  signal(SIGALRM,alarmhandler2);
  siginterrupt(SIGALRM, 1);
  write(STDOUT_FILENO,"Waiting for response\n",strlen("Waiting for response\n"));
  alarm(90);
  recv(supSock,response,MAX_MSG_SIZE,0);
  alarm(0);
  if(time_out){
    write(STDOUT_FILENO,"Request timed out\n",strlen("Request timed out\n"));
    return;
  }
  char ** tokens = tokenize(response," ");
  if(!strcmp(tokens[1],"yes")){
    addIngredient(ingName,ingNum);
    char * msg2 = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
    sprintf(msg2 , "%s accepted your request\n",tokens[2]);
    write(STDOUT_FILENO,msg2,strlen(msg2));
  }
  else{
    char * msg2 = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
    sprintf(msg2 , "%s rejected your request\n",tokens[2]);
    write(STDOUT_FILENO,msg2,strlen(msg2));
  }
  close(supSock);
  free(msg);
  free(response);
  time_out = 0;

}


void makeTCPPort(){
    while(1){
        rest.TCP_port = random_port() ;
        rest.TCP_sock = makeServer(rest.TCP_port);
        if(rest.TCP_sock >= 0){
            //write(STDOUT_FILENO, "TCP port created\n", strlen("TCP port created\n"));
            char * msg = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
            sprintf(msg, "TCP port is:%d TCP sock is:%d\n", rest.TCP_port ,rest.TCP_sock);
            write(STDOUT_FILENO, msg, strlen(msg));
            break;
        }
        write(STDOUT_FILENO, "Error: Creating TCP port\n", strlen("Error: Creating TCP port\n"));
    }
}

void initFDS(){
  fds.max = 0;
  FD_ZERO(&fds.masterset);
  FD_SET(STDIN_FILENO,&fds.masterset);
  FD_SET(rest.UDP_sock,&fds.masterset);
  FD_SET(rest.TCP_sock,&fds.masterset);
  if(rest.UDP_sock >= fds.max)
    fds.max = rest.UDP_sock;
  if(rest.TCP_sock > fds.max)
    fds.max = rest.TCP_sock;
  if(STDIN_FILENO > fds.max)
    fds.max = STDIN_FILENO;
}

char * introduceRestaurant(Restaurant * rst){
    char * msg = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
    sprintf(msg, "%s %d %d %d %d", rst->username, rst->UDP_port , rst->TCP_port ,rst->UDP_sock , rst->TCP_sock);
    return msg;
}

void UDPcommandHandler(char * buffer){
  char ** tokens = tokenize(buffer , " ");
  char * msg = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
  if(!strcmp(tokens[1],"restaurants") && !strcmp(tokens[0],"show")){
    sprintf(msg,"u: %s p: %d ",rest.username , rest.TCP_port);
    int serverPort = strToPort(tokens[3]);
    int serverSock ;
    int fd = connectServer(serverPort , &serverSock);
    send(serverSock , msg , strlen(msg) , 0);
    close(serverSock);
  }
  else if(!strcmp(tokens[0],"duplicate")){
    if(!strcmp(tokens[2],rest.username)){
      sendto(rest.UDP_sock,"Repeated",strlen("Repeated"),0,(struct sockaddr *)rest.UDP_addr,sizeof(*rest.UDP_addr));
      return;
    }
  }
  else if(!strcmp(tokens[0],"Recipe")){
    //addRecipe(tokens);
  }
  else if(!strcmp(tokens[0],"Sale")){
    //addSale(tokens);
  }
}

void showRequests(){
    printf("username/port/order\n");
    for(int i=0;i<rest.numRequests;i++){
        printf("%s %d %s\n",rest.requests[i].name,rest.requests[i].tcpSocket,rest.requests[i].foodName);
    }
}

void showSales(){
    printf("username/order/result\n");
    for(int i=0;i<rest.numSales;i++){
            char *result;
            if(rest.sales[i].status==ACCEPTED)
                result="accept";
            if(rest.sales[i].status==REJECTED)
                result="reject";
            if(rest.sales[i].status==TIME_OUT)
                result="TIMEOUT";
            printf("%s %s %s\n",rest.sales[i].name,rest.sales[i].foodName,result);  
    }
}

void moveRequestToSales(int index) {
    if (index < 0 || index >= rest.numRequests) {
        printf("Invalid request index.\n");
        return;
    }
    Request requestToMove = rest.requests[index];
    for (int i = index; i < rest.numRequests - 1; i++) {
        rest.requests[i] = rest.requests[i + 1];
    }
    rest.numRequests--;

    if (rest.numSales == 0) {
        rest.sales = (Request*)malloc(sizeof(Request));
    } else {
        rest.sales = (Request*)realloc(rest.sales ,(rest.numSales + 1) * sizeof(Request));
    }

    rest.sales[rest.numSales] = requestToMove;
    rest.numSales++;
    printf("Request moved to sales successfully.\n");
}

void addRequestToRestaurant(const char *foodName,const char*name, int tcpPort) {
    // Check if the RequestArray is NULL, if so, allocate memory for it
    if (rest.requests == NULL) {
        rest.requests = (Request *)malloc(20 * sizeof(Request)); // Allocate space for MAX_REQUESTS requests
        if (rest.requests == NULL) {
            printf("Failed to allocate memory for requests array.\n");
            exit(EXIT_FAILURE);
        }
        rest.numRequests = 0; // Initialize the size
    }

    if (rest.numRequests < 20) {
        Request newRequest;
        strcpy(newRequest.foodName, foodName);
        strcpy(newRequest.name, name);
        newRequest.status = WAITING;
        newRequest.tcpSocket = tcpPort;

        rest.requests[rest.numRequests] = newRequest;
        rest.numRequests++;
        printf("Request added to the restaurant's requests.\n");
    } else {
        printf("Request array is full, cannot add more requests.\n");
    }
}

int findRequestIndexByTcpPort(int tcpPort) {
    for (int i = 0; i < 20 ; i++) {
        if (rest.requests[i].tcpSocket == tcpPort) {
            return i;
        }
    }
    write(STDOUT_FILENO, "Error: Request with the given tcpPort not found\n", strlen("Error: Request with the given tcpPort not found\n"));
    return -1;  // Request with the given tcpPort not found
}

int findFoodIndexByName(char* name) {
    for (int i = 0; i < 20; i++) {
        if (!strcmp(rest.menu[i].name,name)) {
            return i;
        }
    }
    return -1;  // Request with the given tcpPort not found
}

int findIngredientIndexByName(char* name) {
    for (int i = 0; i < 20; i++) {
        if (!strcmp(rest.ingredients[i].name,name)) {
            return i;
        }
    }
    return -1;  // Request with the given tcpPort not found
}

int haveEnoughIngredient(int index){
    char* name=rest.requests[index].foodName;
    int foodIdx=findFoodIndexByName(name);
    int found = 0;
    for(int i=0; i < rest.numMenu;i++){
        if(!strcmp(rest.menu[i].name ,name)){
            found=1;
            break;
        }
    }
    if(!found){
        return 0;
    }
    for(int i=0; i < rest.menu[foodIdx].numIngredients;i++){
        int needed = rest.menu[foodIdx].ings[i].quantity;
        int ingIdx=findIngredientIndexByName(rest.menu[foodIdx].ings[i].name);
        if(needed>rest.ingredients[ingIdx].quantity){
            return 0;
        }
    }
    for(int i=0;i<rest.menu[foodIdx].numIngredients;i++){
        int needed=rest.menu[foodIdx].ings[i].quantity;
        int ingIdx=findIngredientIndexByName(rest.menu[foodIdx].ings[i].name);
        rest.ingredients[ingIdx].quantity-=needed;
    }
    return 1;
}

void orderRequest(){
    char reqPort[MAX_PORT_LEN];
    char answer[MAX_MSG_SIZE];
    char msg[MAX_MSG_SIZE];
    getInput(STDOUT_FILENO,"port of request: ",reqPort,MAX_PORT_LEN);
    int requestPort= strToPort(reqPort);
    getInput(STDOUT_FILENO,"your answer : ",answer,MAX_MSG_SIZE);
    int index = findRequestIndexByTcpPort(requestPort);
    if(index==-1){
        //TODO: ERROR
        printf("not found port\n");
        return;
    }
    if (!strcmp(answer,"yes"))
    {
        if(haveEnoughIngredient(index) == 0){
            strcpy(answer,"no");
            printf("don't have enough ingredient\n");
        }
        else{
            rest.requests[index].status = ACCEPTED;
            }
    }
    if (!strcmp(answer,"no"))
    {
        rest.requests[index].status= REJECTED;
    }
    sprintf(msg,"%s %s",answer,rest.username);
    write(requestPort,msg,MAX_MSG_SIZE);
    FD_CLEARER(rest.requests[index].tcpSocket,&fds);
    close(rest.requests[index].tcpSocket);
    if(rest.requests[index].status == ACCEPTED)
      moveRequestToSales(index);
}

void TCPCommandHandler(int clientSocket){
  if(rest.status == CLOSED){
    printf("restaurant is closed\n");
    return;
  }
  char msg[MAX_MSG_SIZE];
  int len = read(clientSocket,msg,MAX_MSG_SIZE);
  char response[MAX_MSG_SIZE];
  char answer[3];
  if(len==0){
    int index = findRequestIndexByTcpPort(clientSocket);
    rest.requests[index].status = TIME_OUT;
    FD_CLEARER(clientSocket,&fds);
    printf("order timeout\n");
    return;}
    char ** tokens = tokenize(msg," ");
    addRequestToRestaurant(tokens[1],tokens[2],clientSocket); //food name ,name
    sprintf(msg,"new order!\n");
    write(STDOUT_FILENO,msg,strlen(msg));
  //sprintf(msg,"new request ingredient\n");
}

void STDINcommandHandler(char * buffer){
  if(rest.status == CLOSED){
    printf("restaurant is closed\n");
    return;
  }
  char ** tokens = tokenize(buffer , " ");
  char * msg  = (char*)malloc(sizeof(char)*MAX_MSG_SIZE);
  if (!(strcmp(tokens[0],"start")) && !(strcmp(tokens[1],"working"))){
    rest.status = OPEN;
    sprintf(msg,"%s restaurant opened \n",rest.username);
    sendto(rest.UDP_sock,msg,strlen(msg),0,(struct sockaddr *)rest.UDP_addr,sizeof(*rest.UDP_addr));
  }
  else if(!strcmp(tokens[0],"break")){
    rest.status = CLOSED;
    sprintf(msg,"%S restaurant closed \n",rest.username);
    sendto(rest.UDP_sock,msg,strlen(msg),0,(struct sockaddr *)rest.UDP_addr,sizeof(*rest.UDP_addr));
  }
  else if(!(strcmp(tokens[0],"show"))&& !(strcmp(tokens[1],"ingredients"))){
    showIngredients();
  }
  else if(!(strcmp(tokens[0],"show"))&&!(strcmp(tokens[1],"recipes"))){
    showRecipes();
  }
  else if(!(strcmp(tokens[0],"show")) && !(strcmp(tokens[1],"suppliers"))){
    showSuppliers();
  }
  else if(!(strcmp(tokens[0],"show"))&&!(strcmp(tokens[1],"requests"))){
    showRequests();
  }
  else if(!(strcmp(tokens[0],"show"))&&!(strcmp(tokens[1],"sales"))){
    showSales();
  }
  else if(!(strcmp(tokens[0],"request"))&&!(strcmp(tokens[1],"recipe"))){
    requestRecipes();
  }
  else if(!(strcmp(tokens[0],"answer"))&&!(strcmp(tokens[1],"request"))){
    orderRequest();
  }

  else{
    write(STDOUT_FILENO,"Invalid command\n",17);
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
    sprintf(brodMsg,"duplicate username %s",rest.username);
    int r = sendto(rest.UDP_sock,brodMsg,strlen(brodMsg),0,(struct sockaddr *)rest.UDP_addr,sizeof(*rest.UDP_addr));

    while(1){
        int res=-1;
        memset(responseBuf, 0, MAX_MSG_SIZE);
        alarm(1);
        res=recv(rest.UDP_sock,responseBuf,MAX_MSG_SIZE,0);
        alarm(0);
        if(res<0)  return;
        if(!strcmp(responseBuf,"Repeated")){
            getInput(STDIN_FILENO, "Duplicate! Try another username: ", rest.username, NAME_SIZE);
            sprintf(brodMsg,"duplicate username %s",rest.username);
            sendto(rest.UDP_sock,brodMsg,strlen(brodMsg),0,(struct sockaddr *)rest.UDP_addr,sizeof(*rest.UDP_addr));
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
        else if(i == rest.UDP_sock){ //BROADCAST
          read(i , buffer, MAX_MSG_SIZE);
          UDPcommandHandler(buffer);
        }
        else if(i == rest.TCP_sock){ //ACCEPT
          if(rest.status == CLOSED){
            printf("restaurant is closed\n");
            close(i);
            FD_CLEARER(i,&fds);
            continue;
          }
          int acc = acceptClient(rest.TCP_sock);
          //close(i);
          //FD_CLEARER(i,&fds);
          FD_SETTER(acc,&fds);
        }
        else{ //TCP MESSAGE
          TCPCommandHandler(i);
          continue;
        }
      }  
    }
  }
}

void set_restaurant(const char* argv[]){
    rest.status = OPEN;
    rest.numIngredients = 0;
    rest.UDP_port= strToPort(argv[1]);
    rest.menu = (Recipe *)malloc(sizeof(Recipe)*20);
    rest.numMenu = getFoods(rest.menu);
    //getFoods(rest.menu);
    //extractIngredients(rest.menu,rest.ingredients);
    makeTCPPort();
    rest.UDP_addr = (struct sockaddr_in *)malloc(sizeof(struct sockaddr_in));
    rest.UDP_sock = makeBroadcast(BROADCAST_IP,rest.UDP_port, rest.UDP_addr);
    char * msg = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
    sprintf(msg , "UDP port is:%d UDP sock is:%d\n", rest.UDP_port ,rest.UDP_sock);
    write(STDOUT_FILENO, msg, strlen(msg));
}

void sayWelcome(){
    char * msg = (char *)malloc(sizeof(char)*MAX_MSG_SIZE);
    sprintf(msg, "Welcome %s as a restaurant\n", rest.username);
    write(STDOUT_FILENO, msg, strlen(msg));
}

int main(int argc, const char* argv[]){
    checkStart(argc);
    set_restaurant(argv);
    getInput(STDIN_FILENO, "Please enter your username: ", rest.username, NAME_SIZE);
    checkDuplicate();
    sayWelcome();
    //char* msg = introduceRestaurant(&rest);
    //sendto(rest.UDP_sock, msg, strlen(msg), 0, (struct sockaddr *)&rest.UDP_addr, sizeof(&rest.UDP_addr));
    Interface();
    return 0 ; 
}
