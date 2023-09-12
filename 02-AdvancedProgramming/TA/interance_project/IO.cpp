#include "IO.h"

using namespace std;

void Input_handler::input_nodes() {
    for (int i = 0; i < num_of_nodes; i++) {
        vector<string> data = tokenize_input();
        Node* node = make_node(data);
        nodes.push_back(node);
    }
};

void Command_handler:: print_output() {
    switch (result_base[1]) {
    case 'b':
        cout << bitset<8>(result) << endl;
        // Instead of printing as a positive binary with a negative sign, the value of its complement is printed
        break;
    case 'd':
        cout << result << endl;
        break;
    case 'h':
        cout << hex << result << endl;
        break;
    case 'o':
        cout << oct << result << endl;
        break;
    }
};

void Command_handler::get_command() {
    string line;
    while (getline(cin, line)) {
        istringstream iss(line);
        vector<string> tokens;
        string token;
        while (getline(iss, token, ' ')) {
            tokens.push_back(token);
        }
        if (tokens[0] == "remode") {
            tree->remode(stoi(tokens[2]), tokens[1]);
        }
        else if (tokens[0] == "reset") {
            tree->reset(stoi(tokens[1]), stoi(tokens[2]));
        }
        else if (tokens[0] == "rebase") {
            tree->rebase(tokens[1], stoi(tokens[2]));
        }
        else if (tokens[0] == "evaluate") {
            result = tree->evaluate();
            result_base = tokens[1];
            print_output();
        }
    }
}