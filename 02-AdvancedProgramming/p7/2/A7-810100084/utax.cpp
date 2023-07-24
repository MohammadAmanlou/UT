#include "utax.hpp"

void UTax::signup(std::string name , std::string role){
    for (int i=0 ; i<members.size() ; i++){
        if (members[i]->get_name() == name){
            throw std::invalid_argument("Bad Request\n");
        }
    }
    if(role == "passenger"){
        members.push_back(new Passenger(name));
    }
    else if(role == "driver"){
        members.push_back(new Driver(name));
    }
    else{
        throw std::invalid_argument("Bad Request\n");
    }
}

bool check_passenger(std::string passenger_name, std::vector<Person *> members){
    for(int i=0; i<members.size(); i++){
        if(members[i]->get_name() == passenger_name){
            if (members[i]->get_status() != WAITING){
                throw std::runtime_error("Bad Request\n");
            }
            else return true;
        }
    }
    return false;
}

bool check_places(std::string origin , std::string destination , std::vector<Place> places){
    for(int i=0; i<places.size(); i++){
        if(places[i].name == origin){
            for(int j=0; j<places.size(); j++){
                if(places[j].name == destination){
                    return true;
                }
            }
        }
    }
    return false;
}

bool UTax::have_trip(std::string passenger_name, std::string origin , std::string destination){
    if (check_passenger(passenger_name, members) && check_places(origin, destination, places)){
        return true;
    }
    return false;
}

void UTax::trip(std::string origin, std::string destination, std::string passenger , bool is_hurry){
    if(have_trip(passenger, origin, destination)){
        for (int i=0 ; i<members.size();i++){
            if(members[i]->get_name() == passenger){
                if (members[i]->get_role() == "passenger"){
                    last_trip_id ++;
                    int cost = find_trip_cost(origin,destination , is_hurry);
                    trips.push_back(new Trip(origin, destination, (Passenger*)members[i] , last_trip_id , cost));
                }
                else if(members[i]->get_role() == "driver"){
                    throw std::runtime_error("Permission denied\n");
                }
            }
        }
    }
    else{
        throw std::runtime_error("Not Found\n");
    }
}

double find_dist(Place origin , Place destination){
    double dist = 110.5 * sqrt(pow(origin.lat-destination.lat,2) + pow(origin.lon-destination.lon,2));
    return dist;
}

double find_cost(Place origin , Place destination){
    return (find_dist(origin ,destination)*(origin.traffic + destination.traffic)*10000);
}

double UTax::find_trip_cost(std::string origin, std::string destination , bool is_hurry){
    Place origin_place;
    Place destination_place;
    for (int i=0 ; i<places.size() ; i++){
        if (places[i].name == origin){
            origin_place = places[i];
        }
        if (places[i].name == destination){
            destination_place = places[i];
        }
    }
    if (is_hurry){
        return (1.2*find_cost(origin_place , destination_place));
    }
    return find_cost(origin_place , destination_place);
}

bool check_empty_trips(std::vector<Trip *> trips){
    if (trips.size() == 0){
        return true;
    }
    return false;
}

std::vector<Trip *> UTax::get_trips(std::string requester){
    if (check_empty_trips(trips)){
        throw std::runtime_error("Empty\n");
    }
    for (int i=0 ; i<members.size() ; i++){
        if(members[i]->get_name() == requester){
            if (members[i]->get_role() == "passenger"){
                throw std::runtime_error("Permission denied\n");
            }
            else if(members[i]->get_role() == "driver"){
                return trips;
            }
        }
    }
    throw std::runtime_error("Not Found\n");
}

Trip * UTax::get_trip(std::string requester, int trip_id){
    for (int i=0 ; i<members.size() ; i++){
        if(members[i]->get_name() == requester){
            if (members[i]->get_role() == "passenger"){
                throw std::runtime_error("Permission denied\n");
            }
            else if(members[i]->get_role() == "driver"){
                for (int j=0 ; j<trips.size() ; j++){
                    if (trips[j]->get_id() == trip_id){
                        return trips[j];
                    }
                }
                throw std::runtime_error("Not Found\n");
            }
        }
    }
    throw std::runtime_error("Not Found\n");
}

void UTax::delete_trip(std::string requester, int trip_id){
    for (int i=0 ; i<members.size() ; i++){
        if(members[i]->get_name() == requester){
            if (members[i]->get_role() == "driver"){
                throw std::runtime_error("Permission denied\n");
            }
            else if(members[i]->get_role() == "passenger"){
                for (int j=0 ; j<trips.size() ; j++){
                    if (trips[j]->get_id() == trip_id){
                        if (trips[j]->get_status() == WAITING){
                            trips.erase(trips.begin() + j);
                            return;
                        }
                        else{
                            throw std::runtime_error("Bad Request\n");
                        }
                        
                    }
                }
                throw std::runtime_error("Not Found\n");
            }
        }
    }
    throw std::runtime_error("Not Found\n");
}

void UTax::accept_trip(std::string requester, int trip_id){
    for (int i=0 ; i<members.size() ; i++){
        if(members[i]->get_name() == requester){
            if (members[i]->get_role() == "passenger"){
                throw std::runtime_error("Permission denied\n");
            }
            else if(members[i]->get_role() == "driver"){
                for (int j=0 ; j<trips.size() ; j++){
                    if (trips[j]->get_id() == trip_id){
                        if (trips[j]->get_status() == WAITING && members[i]->get_status() == WAITING){
                            trips[j]->set_status(TRAVELING);
                            trips[j]->set_driver((Driver*)&members[i]);
                            trips[j]->get_passenger()->set_status(TRAVELING);
                            trips[j]->get_driver()->set_status(TRAVELING);
                            members[i]->set_status(TRAVELING);
                            return;
                        }
                        else{
                            throw std::runtime_error("Bad Request\n");
                        }
                    }
                }
                throw std::runtime_error("Not Found\n");
            }
        }
    }
    throw std::runtime_error("Not Found\n");
}

void UTax::finish_trip(std::string requester, int trip_id){
    for (int i=0 ; i<members.size() ; i++){
        if(members[i]->get_name() == requester){
            if (members[i]->get_role() == "passenger"){
                throw std::runtime_error("Permission denied\n");
            }
            else if(members[i]->get_role() == "driver"){
                for (int j=0 ; j<trips.size() ; j++){
                    if (trips[j]->get_id() == trip_id){
                        if (trips[j]->get_status() == TRAVELING){
                            trips[j]->set_status(FINISHED);
                            trips[j]->get_passenger()->set_status(FINISHED);
                            trips[j]->get_driver()->set_status(FINISHED);
                            members[i]->set_status(FINISHED);
                            return;
                        }
                        else{
                            throw std::runtime_error("Bad Request\n");
                        }
                    }
                }
                throw std::runtime_error("Not Found\n");
            }
        }
    }
    throw std::runtime_error("Not Found\n");
}

