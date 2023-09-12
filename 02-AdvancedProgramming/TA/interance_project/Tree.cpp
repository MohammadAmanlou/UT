#include "Tree.h"

using namespace std;

int Tree::FindNodeByID(int id_) {
    for (int i = 0; i < nodes.size(); i++) {
        if (nodes[i]->get_id() == id_)
            return i;
    }
    return nodes.size() + 1;
}

void Tree:: remode(int id_, string mode) {
    int i = FindNodeByID(id_);
    if (nodes.size() >= i) {
        if (mode != nodes[i]->get_mode()) {
            nodes[i] = nodes[i]->change_mode();
            make_nodes_relation();
        }
    }
}

void Tree::reset(int id_, int typing_) {
    int i = FindNodeByID(id_);
    if (nodes.size() >= i) {
        nodes[i]->reset_typing(typing_);
        make_nodes_relation();
    }
}

void Tree::rebase(string base, int id_) {
    int i = FindNodeByID(id_);
    if (nodes.size() >= i) {
        switch (base[1]) {
        case 'b':
            nodes[i] = new Basis2(nodes[i]->get_id(), nodes[i]->get_parent_id(), stoi(nodes[i]->get_typing()));
            break;
        case 'o':
            nodes[i] = new Basis8(nodes[i]->get_id(), nodes[i]->get_parent_id(), stoi(nodes[i]->get_typing()));
            break;
        case 'd':
            nodes[i] = new Operand(nodes[i]->get_id(), nodes[i]->get_parent_id(), stoi(nodes[i]->get_typing()));
            break;
        case 'h':
            nodes[i] = new Basis16(nodes[i]->get_id(), nodes[i]->get_parent_id(), stoi(nodes[i]->get_typing()));
            break;
        default:
            throw "Invalid base";
        }
        make_nodes_relation();
    }
}


