#ifndef _PERSON_
#define _PERSON_

#include <iostream>
#include <string>
#include <vector>

enum status{
    WAITING,
    TRAVELING,
    FINISHED
};

class Person {
    private:
        std::string name;
        bool status;
        std::string role;
    public:
        Person(std::string name_){
            name = name_;
            status = WAITING;
        }
        std::string get_name(){
            return name;
        }
        bool get_status(){
            return status;
        }
        virtual std::string get_role()=0;
        void set_status(bool status_){
            status = status_;
        }

};


class Passenger : public Person {
    private:
    public:
        Passenger(std::string name_): Person(name_){

        };
        std::string get_role(){
            return "passenger";
        }
};

class Driver : public Person {
    private:
    public:
        Driver(std::string name_): Person(name_){

        };
        std::string get_role(){
            return "driver";
        }
};

#endif