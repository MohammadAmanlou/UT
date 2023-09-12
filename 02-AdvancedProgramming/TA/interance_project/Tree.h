#ifndef TREE
#define TREE

#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include "Node.h"

using namespace std;

class Tree{
    private:
        Node * root;
        vector<Node *> nodes;
        void make_nodes_relation(){
            for (int i = 0; i < nodes.size(); i++){
                if (nodes[i]->get_parent_id() == -1){
                    root = nodes[i];
                }
                else{
                    for (int j = 0; j < nodes.size(); j++){
                        if (nodes[j]->get_id() == nodes[i]->get_parent_id()){
                            nodes[i]->set_parent(nodes[j]);
                            nodes[j]->add_child(nodes[i]);
                            
                        }
                    }
                }
            }
        };
    public:
        Tree(vector<Node *> nodes_){
            nodes = nodes_;
            make_nodes_relation();
        }
        Node * get_root(){return root;}
        vector<Node *> get_nodes(){return nodes;}
        void add_node(Node * node){nodes.push_back(node);}
        void set_root(Node * root_){root = root_;}
        int compute(){return root->compute();}

        int FindNodeByID(int id_);
        void remode(int id_, string mode);

        void reset(int id_, int typing_);

        void rebase(string base, int id_);

        int evaluate(){return root->compute();}

};


#endif // TREE