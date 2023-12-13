#include <iostream>
#include <fstream>
#include <sstream>
#include <unistd.h>
#include <stdlib.h>
#include <string>
#include <sys/wait.h>
#include <vector>
#include <bits/stdc++.h>
#include <dirent.h>
#include <sys/types.h>
#include <stdio.h>
#include <fcntl.h>
#include <sys/stat.h>
#include "includes/Logger.hpp"

using namespace std;

#define FIFO "fifo_"
#define WRITE 1
#define READ 0
#define MAX 10000
#define BUILDING "./buildings.out"
#define WATER "./resources.out"
#define GAS "./resources.out"
#define ELECTRICITY "./resources.out"
#define WATER_COEFFICIENT 4
#define GAS_COEFFICIENT 3
#define ELECTRICITY_COEFFICIENT 2

Logger logger;
string name;

vector <string> tokenize(string chosen_pos,char delimiter)
{
    stringstream ss(chosen_pos); 
    string s; 
    vector <string> str;
    while (getline(ss, s, delimiter)) {    
        str.push_back(s);
    }
    return str; 
}

int create_process(int& write_pipe, int& read_pipe, string executable)
{
    int pipe_fd[2];
    int pipe_fd2[2];
    if (pipe(pipe_fd) == -1) {
        perror("pipe");
    }
    if (pipe(pipe_fd2) == -1) {
        perror("pipe");
    }
    int pid = fork();
    if (pid == 0) {
        // Child process
        close(pipe_fd[WRITE]);
        close(pipe_fd2[READ]);
        char read_fd[20];
        char write_fd[20];
        sprintf(read_fd , "%d" , pipe_fd[READ]);
        sprintf(write_fd , "%d" , pipe_fd2[WRITE]);
        execl(executable.c_str(), read_fd , write_fd, NULL);
        perror("execl");
    } else if (pid > 0) {
        // Parent process
        close(pipe_fd[READ]);
        close(pipe_fd2[WRITE]);
        read_pipe = pipe_fd2[READ] ;
        write_pipe = pipe_fd[WRITE];
    }else{
        perror("fork");
    }
    return pid;
}

void input_named_pipe(vector <string> buildings ){
	for (int i = 0 ; i < buildings.size() ; i++){
		if (mkfifo(buildings[i].c_str() , 0666) == -1){
			perror("mkfifo");
		}
        logger.log("FIFO " + buildings[i] + " created" , "green");
		int write_fd = open(buildings[i].c_str() , O_WRONLY);
        string coefs = to_string(WATER_COEFFICIENT) +","+ to_string(GAS_COEFFICIENT) +","+ to_string(ELECTRICITY_COEFFICIENT);
        logger.log("COEFFICIENTS " + coefs + " sent to " + buildings[i] , "blue");
        write(write_fd , coefs.c_str() , coefs.length());
		close(write_fd);
	}
}


vector<string> get_commands(int &read_fd){
    char arr [1000] ; 
    read(read_fd , arr , 1000);
    close(read_fd);
    vector <string> commands = tokenize(string(arr),'-');
    return commands;
}

int main(int argc , char* argv[])
{
    int read_fd = atoi(argv[0]);
    int write_fd = atoi(argv[1]);
    vector <string> commands = get_commands(read_fd);
    close(write_fd);
	name = commands[0];
	vector <string> resources = tokenize(commands[1],',');
	vector <string> buildings = tokenize(commands[2],',');
	input_named_pipe(buildings );
    return 0;
}