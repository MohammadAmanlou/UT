#ifndef _ERRORS_
#define _ERRORS_
#include <iostream>
#include <string>

using namespace std;

class Bad_req {
    public:
    Bad_req(const string& msg) : msg_(msg) {}
    ~Bad_req() {}

    string getMessage() const {return(msg_);}
    private:
    string msg_;
};

class Not_found {
    public:
    Not_found(const string& msg) : msg_(msg) {}
    ~Not_found() {}

    string getMessage() const {return(msg_);}
    private:
    string msg_;
};

class Permission_error {
    public:
    Permission_error(const string& msg) : msg_(msg) {}
    ~Permission_error() {}

    string getMessage() const {return(msg_);}
    private:
    string msg_;
};



#endif // _ERRORS_