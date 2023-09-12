#ifndef _HANDLER_
#define _HANDLER_

#include "server/server.hpp"
#include "iostream"
#include "string"
#include "vector"
#include "utax.hpp"
#include <sstream>
#include <iomanip>
#include "errors.hpp"

class Trip_handler : public RequestHandler{
    public :
        Trip_handler(UTax * utax_){
            utax = utax_;
        }
        Response * callback(Request * req);
    private : 
        UTax * utax;
};

class Signup_handler : public RequestHandler{
    public :
        Signup_handler(UTax * utax_);
        Response * callback(Request * req);
    private : 
        UTax * utax;
};

class Cancel_handler : public RequestHandler{
    public :
        Cancel_handler(UTax * utax_){
            utax = utax_;
        }
        Response * callback(Request * req);
    private : 
        UTax * utax;
};

class Show_handler : public RequestHandler{
    public :
        Show_handler(UTax * utax_){
            utax = utax_;
        }
        Response * callback(Request * req);
    private : 
        UTax * utax;
};

class Accept_handler : public RequestHandler{
    public :
        Accept_handler(UTax * utax_){
            utax = utax_;
        }
        Response * callback(Request * req);
    private : 
        UTax * utax;
};

#endif