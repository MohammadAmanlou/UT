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

#define DAYS 30
#define MONTH 12
#define FIFO "fifo_"
#define WRITE 1
#define READ 0
#define MAX 10000
#define BUILDINGS "./buildings.out"
#define BILLER "./biller.out"
#define BILLS_PATH "buildings/bills.csv"

Logger logger;

string coded_resources(vector <string> resources);
void make_path(vector <string>& buildings,string path);

vector <string> find_buildings_dir(string path)
{
    vector <string> files;
    vector <string> org_files;
    DIR *dr;
    struct dirent *en;
    char* temp[MAX];
    dr = opendir(path.c_str());
    if (dr) {
        while ((en = readdir(dr)) != NULL) {
            files.push_back(en->d_name);
        }
        closedir(dr);
    }
    for (int i = 0; i< files.size(); i++)
    {
        if ( files[i] != "." && files[i] != ".." && files[i] != "bills.csv" && files[i] != ".DS_Store")
        {
            org_files.push_back(files[i]);
        }
    }
    return org_files;
}

vector <string> tokenize(string inp_str,char delimiter)
{
    stringstream ss(inp_str); 
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
    fflush(stdout);
    int pid = fork();
    if (pid == -1) {
        perror("fork");
    }
    if (pid == 0) {
        // Child process
        close(pipe_fd[WRITE]);
        close(pipe_fd2[READ]);
        //close(pipe_fd[READ]);
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

string building_data(string folder, string resources,int id)
{
    folder = folder + "-" + resources + "-" + to_string(id);
    return folder;
}

vector<int> create_buildings_process(vector<string> folders, vector<string> chosen_resources,vector <int>& child_pids , string path)
{
    vector<int> read_pipes;
    make_path(folders,path);
    string resources = coded_resources(chosen_resources);
    for (int i = 0; i < folders.size(); i++)
    {
        int write_pipe;
        int read_pipe;
        int pid = create_process(write_pipe,read_pipe,BUILDINGS);
        logger.log("BUILDING Forked and PID: " + to_string(pid) , "green");
        logger.log("BUILDING Informed about its unnamed pipe" , "green");
        string data = building_data(folders[i],resources,i);
        write(write_pipe, data.c_str(), 100);
        logger.log("BUILDING Introduced throw pipe as: " + data   , "green");
        child_pids.push_back(pid);
        close(write_pipe);
        read_pipes.push_back(read_pipe);
    }
    return read_pipes;

}

void create_biller_process(vector <int>& child_pids ,vector <string> buildings, vector<string> resources){
    int write_pipe;
    int read_pipe;
    int pid = create_process(write_pipe,read_pipe,BILLER);
    logger.log("BILLER Forked and PID: " + to_string(pid) , "green");
    logger.log("BILLER Informed about its unnamed pipe" , "green");
    string data = "Biller-" + coded_resources(resources) + "-" + coded_resources(buildings);
    write(write_pipe, data.c_str(), 1000);
    logger.log("BILLER Introduced throw pipe "  , "green");
    child_pids.push_back(pid);
    close(write_pipe);
    close(read_pipe);
}

string resource_data(string resource,string resource_size,int country_size,int club_size)
{
    string data = resource_size ;//+ ',' ;//+ to_string(country_size) + ',' + to_string(club_size);
    data = data + "-" + resource;
    return data;
}

string coded_resources(vector <string> resources)
{
	string result = resources[0];
	for (int i=1; i< resources.size(); i++)
    {
		result = result + ',' + resources[i];
    }
    return result;
}

void make_path(vector <string>& buildings,string path)
{
    for(int i=0; i< buildings.size(); i++)
    {
        buildings[i] = path + "/" + buildings[i];
    }
    return; 
}

vector <string> input_chosen_buildings(){
    vector <string> buildings;
    string temp;
    getline(cin, temp);
    vector <string> chosen_buildings = tokenize(temp,' ');
    for (int i = 0; i< chosen_buildings.size(); i++)
    {
        buildings.push_back(chosen_buildings[i]);
    }
    return buildings;
}

vector <string> input_chosen_resources(){
    vector <string> resources;
    string temp;
    cout << "Enter resources from {Water,Electricity,Gas}:" << endl;
    getline(cin, temp);
    vector <string> chosen_resources = tokenize(temp,' ');
    for (int i = 0; i< chosen_resources.size(); i++)
    {
        resources.push_back(chosen_resources[i]);
    }
    return resources;
}

void show_buildings(string path){
    vector <string> buildings = find_buildings_dir(path);
    int count = 0;
    cout << "The number of buildings is: " << buildings.size() << endl;
    cout<<"Building names are:"<<endl;
    while (true)
    {
        cout<<buildings[count];
        count ++;
        if (buildings.size() == count)
        {
            cout<<endl;
            break;
        }
        cout<<" - ";
    }
    cout << "Enter buildings to get stats:"<<endl;
    return;
}

void make_unnamed_pipes(int ** pipes , int building_size){
    for (int i=0 ; i<building_size ; i++){
        if (pipe(pipes[i]) < 0){
            perror("unnamed pipe");
        }
    }
}

void show_result(vector <string> chosen_buildings , vector<int>& read_pipes ){
    for (int i =0 ; i < chosen_buildings.size() ; i ++){
        char buf[10240];
        read(read_pipes[i], buf, 10240);
        close(read_pipes[i]);
        printf("%s\n",buf);
        fflush(stdout);
    }
    logger.log("Done!" , "green");
}

int main(int argc, char const *argv[])
{
    string path = argv[1]; 
    show_buildings(path);
    vector <string> chosen_buildings = input_chosen_buildings();
    vector <string> chosen_resources = input_chosen_resources();
    vector <int> child_pids;
    create_biller_process(child_pids,chosen_buildings,chosen_resources);
    vector<int> read_pipes = create_buildings_process(chosen_buildings,chosen_resources,child_pids , path);
    show_result(chosen_buildings ,read_pipes);
    return 0;
}

