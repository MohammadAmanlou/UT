#ifndef MAIN
#define MAIN

#include <iostream>
#include <string>
#include <vector>
#include "Node.h"
#include "Tree.h"
#include "IO.h"

using namespace std;

int main(){
    try {
        Input_handler input_handler;
        input_handler.read_input();
        Tree tree(input_handler.get_nodes());
        Command_handler command_handler(&tree);
        command_handler.get_command();
        return 0;
    }
    catch (const string& exception) {
        cerr << "Exception occurred: " << exception << endl;
        // Here, it would have been better to create several classes to manage exceptions, but due to lack of time, only its text is output
        return 1;
    }
}



#endif