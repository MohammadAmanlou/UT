#include "Node.h"

using namespace std;

int Node::get_id(){
    return id;
}

void Node::add_child(Node * child){
    for(int i = 0; i < children.size(); i++){
        if(children[i]->get_id() == child->get_id()){
            children[i] = child;
            return;
        }
    }
    children.push_back(child);
}

void Basis2::set_typing_to_value(){
    int temp = 0;
    for(int i = 0; i < typing.size(); i++){
        temp = temp * 2 + (typing[i] - '0');
    }
    value = temp;
}

void Operand::reset_typing(int typing_){
    typing = to_string(typing_);
    set_typing_to_value();
}

void Basis8::set_typing_to_value(){
    int temp = 0;
    for(int i = 0; i < typing.size(); i++){
        temp = temp * 8 + (typing[i] - '0');
    }
    value = temp;
}

int AndA::compute(){
    vector<Node *> children = get_children();
    return (children[0]->compute() * children[1]->compute());
}

void Basis16::set_typing_to_value(){
    int temp = 0;
    for(int i = 0; i < typing.size(); i++){
        temp = temp * 16 + (typing[i] - '0');
    }
    value = temp;
}

Node* AndA::change_mode(){
    return new AndB(get_id() , get_parent_id());
}

int OrA::compute(){
    vector<Node *> children = get_children();
    return (children[0]->compute() + children[1]->compute());
}


Node * OrA::change_mode(){
    return new OrB(get_id() , get_parent_id());
}

int NotA::compute(){
    vector<Node *> children = get_children();
    return (children[0]->compute() * -1 );
}


Node* NotA::change_mode(){
    return new NotB(get_id() , get_parent_id());
}

Node* XorA::findMedian(vector<Node*>& nodes){
    std::sort(nodes.begin(), nodes.end(), compareNodesByCompute);
    size_t vectorSize = nodes.size();
    size_t medianIndex = vectorSize / 2;
    Node* medianNode = nodes[medianIndex];
    return medianNode;
};

int XorA::compute(){
    vector<Node *> children = get_children();
    Node* medianNode = findMedian(children);
    return medianNode->compute();
}

Node * XorA::change_mode(){
    return new XorB(get_id() , get_parent_id());
}

int AndB::compute(){
    vector<Node *> children = get_children();
    return (children[0]->compute() & children[1]->compute());
}

Node * AndB::change_mode(){
    return new AndA(get_id() , get_parent_id());
}

int OrB::compute(){
    vector<Node *> children = get_children();
    return (children[0]->compute() | children[1]->compute());
}

Node * OrB::change_mode(){
    return new OrA(get_id() , get_parent_id());
}

int NotB::compute(){
    vector<Node *> children = get_children();
    return (~children[0]->compute());
}

Node * NotB::change_mode(){
    return new NotA(get_id() , get_parent_id());
}

int XorB::compute(){
    vector<Node *> children = get_children();
    int result = children[0]->compute();
    if(children.size() >=1){
        for (int i = 1; i < children.size(); i++){
        result = result ^ children[i]->compute();
        }
    }
    return result;
}

Node * XorB::change_mode(){
    return new XorA(get_id() , get_parent_id());
}