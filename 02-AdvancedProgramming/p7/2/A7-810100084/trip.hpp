#ifndef _TRIP_
#define _TRIP_

#include <iostream>
#include <string>
#include <vector>
#include "person.hpp"

typedef struct Place{
    std::string name;
    float lat;
    float lon;
    int traffic;
}Place;

class Trip{
    private:
        std::string origin;
        std::string destination;
        Passenger * passenger;
        Driver * driver;
        int id;
        int status;
        double cost;

    public:
        Trip(std::string _origin, std::string _destination, Passenger * _passenger , int id_ , int cost_){
            origin = _origin;
            destination = _destination;
            passenger = _passenger;
            status = WAITING ;
            id = id_;
            cost = cost_;
        }
        std::string get_origin(){
            return origin;
        }
        std::string get_destination(){
            return destination;
        }
        int get_id(){
            return id;
        }
        std::string get_status_name();
        int get_status(){
            return status;
        }
        void set_status(int status_){
            status = status_;
        }
        Passenger * get_passenger(){
            return passenger;
        }
        void set_driver(Driver * driver_){
            driver = driver_;
        }
        Driver * get_driver(){
            return driver;
        }
        double get_cost(){
            return cost;
        }
};

#endif