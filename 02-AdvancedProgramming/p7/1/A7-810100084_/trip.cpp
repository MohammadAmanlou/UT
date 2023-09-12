#include "trip.hpp"

std::string Trip:: get_status_name(){
    if(status == WAITING){
        return "waiting";
    }
    else if(status == TRAVELING){
        return "traveling";
    }
    else{
        return "finished";
    }
}