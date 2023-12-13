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

Logger logger;

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

string decode_csv(const char name[]){
    string nums;
    vector <string> results;
    string _name = name, line;
    ifstream file(_name);
    vector <int> day;
    nums = "";
    while(getline(file, line)){
        day.clear();
        if(line[0]!='Y')
            nums += line + '\n';
    }
    return nums;
}

vector<string> get_commands(int &read_fd){
    char buf [100] ; 
    read(read_fd , buf , 100);
    close(read_fd);
    vector <string> commands = tokenize(buf,'-');
    return commands;
}

int main(int argc , char* argv[])
{
    int read_fd = atoi(argv[0]);
    int write_fd = atoi(argv[1]);
    vector <string> commands = get_commands(read_fd);
    string address = commands[0];
	string nums  = decode_csv(address.c_str());;
	write(write_fd , nums.c_str() , nums.size());
    close(write_fd);
    exit(0);
    return 0;
}