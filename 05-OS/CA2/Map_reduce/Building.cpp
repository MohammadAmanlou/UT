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
#include <algorithm>
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

void create_gas_process(vector <int>& child_pids ,string address , vector<vector<int>>& gas){
    int write_pipe;
    int read_pipe;
    int pid = create_process(write_pipe,read_pipe,GAS);
    logger.log("Created unnamed pipe and gas process for building " + name  , "green");
    char data[100] ;
    sprintf(data , "%s/Gas.csv" , address.c_str());
    write(write_pipe, data, strlen(data));
    char stats[20000];
    read(read_pipe, stats, 20000);
    logger.log(name + ": Gas data received from unnamed pipe" , "blue");
    vector <string> days = tokenize(string(stats),'\n');
    for (int i = 0; i < days.size(); i++)  
    {
        vector <string> results2 = tokenize(days[i],',');
        vector <int> results3;
        for (int j = 0; j < results2.size(); j++)
        {
            results3.push_back(atoi(results2[j].c_str()));
        }
        gas.push_back(results3);
    }
    child_pids.push_back(pid);
    close(write_pipe);
}

void create_electricity_process(vector <int>& child_pids ,string address , vector<vector<int>>& elec){
    int write_pipe;
    int read_pipe;
    int pid = create_process(write_pipe,read_pipe,ELECTRICITY);
    logger.log("Created unnamed pipe and electricity process for building " + name  , "green");
    char data[100] ;
    sprintf(data , "%s/Electricity.csv" , address.c_str());
    write(write_pipe, data, strlen(data));
    char stats[20000];
    read(read_pipe, stats, 20000);
    logger.log(name + ": Electricity data received from unnamed pipe" , "blue");
    vector <string> days = tokenize(string(stats),'\n');
    for (int i = 0; i < days.size(); i++)  
    {
        vector <string> results2 = tokenize(days[i],',');
        vector <int> results3;
        for (int j = 0; j < results2.size(); j++)
        {
            results3.push_back(atoi(results2[j].c_str()));
        }
        elec.push_back(results3);
    }
    child_pids.push_back(pid);
    close(write_pipe);
}

void create_water_process(vector <int>& child_pids ,string address , vector<vector<int>>& water){
    int write_pipe;
    int read_pipe;
    int pid = create_process(write_pipe,read_pipe,WATER);
    logger.log("Created unnamed pipe and water process for building " + name  , "green");
    char data[100] ;
    sprintf(data , "%s/Water.csv" , address.c_str());
    write(write_pipe, data, 100);
    char stats[20000];
    read(read_pipe, stats, 20000);
    logger.log(name + ": Water data received from unnamed pipe" , "blue");
    vector <string> days = tokenize(string(stats),'\n');
    for (int i = 0; i < days.size(); i++) 
    {
        vector <string> results2 = tokenize(days[i],',');
        vector <int> results3;
        for (int j = 0; j < results2.size(); j++)
        {
            results3.push_back(atoi(results2[j].c_str()));
        }
        water.push_back(results3);
    }
    child_pids.push_back(pid);
    close(write_pipe);
}

vector<vector<int>> make_message(vector <vector<int>>& data){
    vector<vector<int>> result;
    for (int month = 0; month < 12; month++) {
        int sum_usage_per_month = 0;
        int max_usage_pick_hour_per_month = 0;
        int sum_usage_pick_hour_per_month = 0;
        vector<int> hour_usage (6, 0);

        for (int day = 0; day < 30; day++) {
            int sum_usage_per_day = 0;
            for (int hour = 3; hour < data[day+month*30].size(); hour++) {
                int current_hour_usage = data[day+month*30][hour];
                sum_usage_per_day += current_hour_usage;
                hour_usage[hour-3] += (current_hour_usage);
            }
            sum_usage_per_month += sum_usage_per_day;
        }
        auto max_IT = max_element(hour_usage.begin(), hour_usage.end());
        max_usage_pick_hour_per_month = distance(hour_usage.begin(), max_IT);
        sum_usage_pick_hour_per_month = hour_usage[max_usage_pick_hour_per_month];
        int mean_usage_per_month = sum_usage_per_month / 30;
        int diff_usage_per_month = mean_usage_per_month - sum_usage_pick_hour_per_month / 30  ;
        int sum_less_than_mean = 0;
        for (int day = 0; day < 30; day++) {
            int sum_usage_per_day = 0;
            for (int hour = 3; hour < data[day+month*30].size(); hour++) {
                int current_hour_usage = data[day+month*30][hour];
                sum_usage_per_day += current_hour_usage;
            }
            if(sum_usage_per_day < mean_usage_per_month){
                sum_less_than_mean += sum_usage_per_day;
            }
        }
        vector<int> message = {month+1, mean_usage_per_month , sum_usage_per_month , max_usage_pick_hour_per_month , sum_usage_pick_hour_per_month , diff_usage_per_month , sum_less_than_mean};
        result.push_back(message);
    }
    return result;
}

string coded_result(vector <vector<int>> data){
    string result = "";
    for (int i = 0; i < data.size(); i++) {
        for (int j = 0; j < data[i].size(); j++) {
            result += to_string(data[i][j]) + ",";
        }
        result += "/";
    }
    return result;
}

string create_msg(vector <string> chosen_resource ,vector <vector<int>> water,vector <vector<int>> gas,vector <vector<int>> electricity){
    string masg = "";
    for (int i = 0; i< chosen_resource.size(); i++){
        string msg = "";
        if (chosen_resource[i] == "Water"){
            vector <vector<int>> message = make_message(water);
            msg = "Water/" + coded_result(message);
        }
        else if (chosen_resource[i] == "Gas"){
            vector <vector<int>> message = make_message(gas);
            msg = "Gas/" + coded_result(message);
        }
        else if (chosen_resource[i] == "Electricity"){
            vector <vector<int>> message = make_message(electricity);
            msg = "Electricity/" + coded_result(message);
        }
        masg = masg + msg + "$" ;
        
    }
    return masg;
}

string send_msg_on_named_pipe(string msg){
    int read_fd = open(name.c_str() , O_RDONLY);
    if(read_fd == -1){
        close(read_fd);
        return "NO_FILE";
        
    }
    char buf[100];
    read(read_fd , buf , 100);
    buf[99] = '\0';
    //logger.log(name + ": Coefficients received from named pipe: " + string(buf) , "yellow");
    string buf_str;
    buf_str = buf;
    close(read_fd);
    return buf_str;
}

string make_screen(vector <vector<string>> results){
	string ans = name + "\n";
    ans += results[0][0] + ":\n";
    ans += "Month|Mean |Sum  |hour |SumH |Diff |LsAvg|Bill |\n";
	for(int i = 1 ; i < results.size() ; i++){
		for(int j = 0 ; j < results[i].size() ; j++){
			ans += results[i][j];
            for(int k=0 ; k < 5 - results[i][j].length() ; k++){
                ans += " ";
            }
            ans += "|";
		}
		ans += '\n';
	}
	return ans;
}

string compute_water_bill(vector <string> results , int coef){
	vector <vector<string>> results2;
	for(int i = 0; i < results.size() ; i++){
		vector <string> temp = tokenize(results[i],',');
        if(i > 0){
            int bill = (atoi(temp[2].c_str()) - atoi(temp[4].c_str())) * coef + 1.25*atoi(temp[4].c_str())*coef;
            temp.push_back(to_string(bill));
        }
		results2.push_back(temp);

	}
	return make_screen(results2);
}

string compute_electricity_bill(vector <string> results , int coef){
	vector <vector<string>> results2;
	for(int i = 0; i < results.size() ; i++){
		vector <string> temp = tokenize(results[i],',');
        if(i > 0){
            int bill = 1 * (atoi(temp[2].c_str()) - atoi(temp[4].c_str()) - atoi(temp[6].c_str())) + 1.25*atoi(temp[4].c_str()) + 0.75*atoi(temp[6].c_str());
            bill = bill*coef;
            temp.push_back(to_string(bill));
        }
		results2.push_back(temp);

	}
	return make_screen(results2);
}

string compute_gas_bill(vector <string> results , int coef){
	vector <vector<string>> results2;
	for(int i = 0; i < results.size() ; i++){
		vector <string> temp = tokenize(results[i],',');
        if(i > 0){
            int bill = (atoi(temp[2].c_str())) * coef ;
            temp.push_back(to_string(bill));
        }
		results2.push_back(temp);

	}
	return make_screen(results2);
}

string compute_bill(string buf, int water_coef , int gas_coef ,int elec_coef){
    string ans = "";
    vector<string> resources = tokenize(buf,'$');
    for(int r =0 ; r < resources.size() ; r++){
        vector <string> results = tokenize(resources[r],'/');
        if(results[0] == "Water"){
            ans += compute_water_bill(results , water_coef);
            logger.log(name +": Water bill created "  , "blue");
        }else if(results[0] == "Electricity"){
            ans += compute_electricity_bill(results , elec_coef);
            logger.log(name + ": Electricity bill created "  , "blue");
        }else if(results[0] == "Gas"){
            ans += compute_gas_bill(results , gas_coef);
            logger.log(name+": Gas bill created "  , "blue");
        }
        else
            return "nothing";
    }
    return ans;

}

string make_results(vector <string> chosen_resource ,vector <vector<int>> water,vector <vector<int>> gas,vector <vector<int>> electricity){
    string msg = create_msg(chosen_resource,water,gas,electricity);
    string coefs_str = send_msg_on_named_pipe(msg);
    if(coefs_str == "NO_FILE"){
        exit(0);
    }
    vector <string> coefs = tokenize(coefs_str,',');
    int water_coef = atoi(coefs[0].c_str());
    int gas_coef = atoi(coefs[1].c_str());
    int elec_coef = atoi(coefs[2].c_str());
    string res = compute_bill(msg,water_coef,gas_coef,elec_coef);

    return res;
}

vector<string> get_commands(int &read_fd){
    char buf [100] ; 
    read(read_fd , buf , 100);
    close(read_fd);
    vector <string> commands = tokenize(string(buf),'-');
    return commands;
}

void create_processes(vector<int>& child_pids ,vector <vector<int>>& water , vector <vector<int>>& gas , vector <vector<int>>& electricity , vector <string> commands){
    create_water_process(child_pids,commands[0] , water);
    create_gas_process(child_pids,commands[0] , gas);
    create_electricity_process(child_pids,commands[0] , electricity);
}

int main(int argc , char* argv[])
{
    int read_fd = atoi(argv[0]);
    int write_fd = atoi(argv[1]);
    vector <string> commands = get_commands(read_fd);
    vector <string> pathes = tokenize(commands[0],'/');
    name = pathes[pathes.size()-1];
    vector <string> chosen_resource = tokenize(commands[1],',');
    vector <vector<int>> water , gas , electricity;
    vector<int> child_pids;
    create_processes(child_pids,water,gas,electricity,commands);
    string result = make_results(chosen_resource,water,gas,electricity);
    write(write_fd , result.c_str() , 10240);
    close(write_fd);
    exit(0);
    return 0;
}