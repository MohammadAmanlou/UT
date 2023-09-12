#ifndef IO
#define IO

#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <istream>
#include <sstream>
#include <bitset>
#include "Node.h"
#include "Tree.h"

using namespace std;

const bool OPERAND = 0;
const bool OPERATOR = 1;

class IO_handler{
    private:
        int num_of_nodes;
        vector <Node *> nodes;
        Tree * tree;
        int result;
        string result_base;
    public:
        vector <Node *> get_nodes(){return nodes;};

    friend class Input_handler;
    friend class Command_handler;

};

class Input_handler : public IO_handler{
    private:
        Node * make_single_operator(string type , int id , int parent_id){
            Node * node;
            if (type == "AND"){
                node = new AndA(id , parent_id);
            }
            if (type == "OR"){
                node = new OrA(id , parent_id);
            }
            if (type == "NOT"){
                node = new NotA(id, parent_id );
            }
            if (type == "XOR"){
                node = new XorA(id , parent_id);
            }
            // I have considered that all the operators are initially arithmetic
            return node;
        };
        vector<string> tokenize_input() {
            int id, parent_id;
            string type, argument;
            string line;
            getline(cin, line);

            istringstream iss(line);
            vector<string> tokens;
            string token;
            while (getline(iss, token, ' ')) {
                tokens.push_back(token);
            }
            return tokens;
        };
        Node * make_node(vector<string> data){
            int id = stoi(data[0]);
            int parent_id = stoi(data[1]);
            string type = data[2];
            Node * node;
            if (type == "input"){
                node = new Operand(id , parent_id , stoi(data[3]));
            }
            else if (type == "operator"){
                node = make_single_operator(data[3] , id , parent_id);
            }
            return node;
        };
    public:
        void input_num_of_nodes(){
            cin >> num_of_nodes;
            cin.ignore();
        }
        void input_nodes();
        void read_input(){
            input_num_of_nodes();
            input_nodes();
        };
};



class Command_handler : public IO_handler{
    private:
    public:
        Command_handler(Tree * tree_){
            tree = tree_;
        };
        void print_output();

        void get_command();
};





#endif