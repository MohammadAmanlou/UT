#ifndef NODE
#define NODE

#include <iostream>
#include <string>
#include <vector>
#include <algorithm>


using namespace std;

class Node{
    private:
        int id;
        Node * parent;
        vector<Node *> children;
        int parent_id;

    public:
        Node(int id_ , int parent_id_){id = id_; parent_id = parent_id_;};
        int get_parent_id(){return parent_id;}
        int get_id();
        virtual int get_value()=0;
        Node * get_parent(){return parent;}
        vector<Node *> get_children(){return children;}
        void set_parent(Node * parent_){parent = parent_;}
        virtual void add_child(Node * child);
        // virtual because we cant add child to operand so we need to override it and throw an error in operand class 
        virtual int compute() = 0;
        virtual string get_mode() = 0;
        virtual Node * change_mode() = 0;
        virtual void reset_typing(int typing_) = 0;
        virtual string get_typing() = 0;
};

class Operand: public Node{
    private:
        string typing;
        int value;

    public:
        Operand(int id_, int parent_id_, int typing_):Node(id_, parent_id_){typing = to_string(typing_);value = typing_;}
        string get_typing(){return typing;}
        int get_value(){return value;}
        int compute(){return value;}
        void add_child(Node * child) override{throw "Operand cant have children";}
        virtual void set_typing_to_value(){value = stoi(typing);};
        string get_mode(){return "Operand";}
        Node * change_mode(){throw "Operand cant change mode"; return this;}
        void reset_typing(int typing_);

    friend class Basis2;
    friend class Basis8;
    friend class Basis16;
};

class Basis2 : public Operand{
    private:
    public:
        Basis2(int id_ , int parent_id_, int typing_):Operand(id_,parent_id_ , typing_){set_typing_to_value();};
        void set_typing_to_value();
};

class Basis8 : public Operand{
    private:
    public:
        Basis8(int id_ ,int parent_id_, int typing_):Operand(id_,parent_id_, typing_){set_typing_to_value();};
        void set_typing_to_value();
};
class Basis16 : public Operand{
    private:
    public:
        Basis16(int id_ ,int parent_id_, int typing_):Operand(id_,parent_id_, typing_){
            set_typing_to_value();
        };
        void set_typing_to_value();
};

///////////////////////////////////////////////////////////////////////////////////////

class Operator : public Node{
    private:
    public:
        Operator(int id_ , int parent_id_):Node(id_ , parent_id_){};
        virtual int compute() = 0;
        int get_value(){throw "Operator cant have value";}
        virtual string get_mode() = 0;
        virtual Node * change_mode() = 0;
        void reset_typing(int typing_){throw "Operator cant have value";}
        string get_typing(){throw "Operator cant have value";}
        virtual void check_num_of_children(){if(get_children().size()==0) throw "Operators should have child";}

};

class Arithmetic : public Operator{
    private:
    public:
        Arithmetic(int id_ , int parent_id_):Operator(id_ , parent_id_){};
        virtual int compute() = 0;
        string get_mode(){return "-a";}
        virtual Node * change_mode() = 0;
        virtual void check_num_of_children() = 0;

};

class Bitwise : public Operator{
    private:
    public:
        Bitwise(int id_ , int parent_id_):Operator(id_ , parent_id_){};
        virtual int compute() = 0;
        string get_mode(){return "-b";}
        virtual Node * change_mode() = 0;
        virtual void check_num_of_children() = 0;
};

class AndA : public Arithmetic {
    private:
    public:
        AndA(int id_ , int parent_id_):Arithmetic(id_ , parent_id_){};
        int compute();
        Node * change_mode();
        void check_num_of_children(){if(get_children().size()!=2) throw "And should have 2 children";}
};

class OrA : public Arithmetic {
    private:
    public:
        OrA(int id_ , int parent_id_):Arithmetic(id_  , parent_id_){};
        int compute();
        Node * change_mode();
        void check_num_of_children(){if(get_children().size()!=2) throw "Or should have 2 children";}
};

class NotA : public Arithmetic {
    private:
    public:
        NotA(int id_ , int parent_id_):Arithmetic(id_ , parent_id_){};
        int compute();
        Node * change_mode();
        void check_num_of_children(){if(get_children().size()!=1) throw "Not should have 1 child";}
};

class XorA : public Arithmetic{
    private:
        static bool compareNodesByCompute(Node* node1, Node* node2) {
            return node1->compute() < node2->compute();
        };
        Node* findMedian(vector<Node*>& nodes);

    public:
        XorA(int id_ , int parent_id_):Arithmetic(id_ , parent_id_){};
        int compute();
        Node * change_mode();
        void check_num_of_children(){};
};


class AndB : public Bitwise {
    private:
    public:
        AndB(int id_ , int parent_id_):Bitwise(id_ , parent_id_){};
        int compute();
        Node * change_mode();
        void check_num_of_children(){if(get_children().size()!=2) throw "And should have 2 children";}
};

class OrB : public Bitwise {
    private:
    public:
        OrB(int id_ , int parent_id_):Bitwise(id_ , parent_id_){};
        int compute();
        Node * change_mode();
        void check_num_of_children(){if(get_children().size()!=2) throw "Or should have 2 children";}
};

class NotB : public Bitwise {
    private:
    public:
        NotB(int id_ , int parent_id_):Bitwise(id_ , parent_id_){};
        int compute();
        Node * change_mode();
        void check_num_of_children(){if(get_children().size()!=1) throw "Not should have 1 child";}
};

class XorB : public Bitwise{
    private:
    public:
        XorB(int id_ , int parent_id_):Bitwise(id_ , parent_id_){};
        int compute();
        Node * change_mode();
        void check_num_of_children(){};
};

#endif
