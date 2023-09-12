#include <iostream>
#include <string>
#include <vector>  
#include "person.hpp"
#include "trip.hpp"
#include "utax.hpp"
#include <stdexcept>
#include <fstream>
#include <sstream>

using namespace std;

fstream make_file (string file_name){
    fstream file(file_name) ;
    if(!file) { // file couldn't be opened
        throw invalid_argument("Error: file could not be opened");
    }
    return file;
}

vector<string> mystrtok(string str, char delim)
{
    vector<string> tokens;
    string temp = "";
    for (int i = 0; i < str.length(); i++)
    {
        if (str[i] == delim)
        {
            tokens.push_back(temp);
            temp = "";
        }
        else
            temp += str[i];
    }
    tokens.push_back(temp);
    return tokens;
}

vector <Place> input_locations(fstream &file){
    vector <Place> places;
    string line;
    getline(file, line);
    while(getline(file, line)){
        vector <string> tokens = mystrtok(line, ',');
        string nam = tokens[0];
        float x = stof(tokens[1]);   
        float y = stof(tokens[2]);
        Place place;
        place.name = nam;
        place.lat = x;
        place.lon = y;
        places.push_back(place);
    }
    return places;
}

void handle_DELETE_trip_command(UTax& utax , vector <string> tokens){
    if (tokens[3] == "id" && tokens[5] == "username"){
        utax.delete_trip(tokens[6] , stoi(tokens[4]));
        cout << "OK" << endl;
    }
    else if (tokens[3] == "username" && tokens[5] == "id"){
        utax.delete_trip(tokens[4], stoi(tokens[6]));
        cout << "OK" << endl;
    }
    else{
        throw invalid_argument("Bad Request\n");
    }
}

void handle_signup_command(UTax& utax , vector <string> tokens){
    if (tokens.size() < 7){
        throw invalid_argument("Bad Request\n");
    }
    if (tokens[3] == "username" && tokens[5] == "role"){
        utax.signup(tokens[4], tokens[6]);
        cout << "OK\n";
    }
    else if (tokens[3] == "role" && tokens[5] == "username"){
        utax.signup(tokens[6], tokens[4]);
        cout << "OK\n";
    }
    else{
        throw invalid_argument("Bad Request\n");
    }
}

void handle_accept_command(UTax& utax , vector <string> tokens){
    if (tokens.size() < 7){
        throw invalid_argument("Bad Request\n");
    }
    if (tokens[3] == "id"){
        utax.accept_trip(tokens[6] , stoi(tokens[4]));
        cout << "OK\n";
    }
    else if (tokens[3] == "username"){
        utax.accept_trip(tokens[4] , stoi(tokens[6]));
        cout << "OK\n";
    }
    else{
        throw invalid_argument("Bad Request\n");
    }
}

void handle_finish_command(UTax& utax , vector <string> tokens){
    if (tokens.size() < 7){
        throw invalid_argument("Bad Request\n");
    }
    if (tokens[3] == "id"){
        utax.finish_trip(tokens[6] , stoi(tokens[4]));
        cout << "OK\n";
    }
    else if (tokens[3] == "username"){
        utax.finish_trip(tokens[4] , stoi(tokens[6]));
        cout << "OK\n";
    }
    else{
        throw invalid_argument("Bad Request\n");
    }
}

void handle_POST_trips_command(UTax& utax , vector <string> tokens){
    if (tokens.size() < 9){
        throw invalid_argument("Bad Request\n");
    }
    if (tokens[3] == "origin" && tokens[5] == "destination" && tokens[7] == "username"){
        utax.trip(tokens[4], tokens[6], tokens[8]);
        cout << utax.get_last_trip_id() << endl;
    }
    else if (tokens[3] == "destination" && tokens[5] == "origin" && tokens[7] == "username"){
        utax.trip(tokens[6], tokens[4], tokens[8]);
        cout << utax.get_last_trip_id() << endl;
    }
    else if (tokens[3] == "username" && tokens[5] == "origin" && tokens[7] == "destination"){
        utax.trip(tokens[6], tokens[8], tokens[4]);
        cout << utax.get_last_trip_id() << endl;
    }
    else if (tokens[3] == "username" && tokens[5] == "destination" && tokens[7] == "origin"){
        utax.trip(tokens[8], tokens[6], tokens[4]);
        cout << utax.get_last_trip_id() << endl;
    }
    else if (tokens[3] == "destination" && tokens[5] == "username" && tokens[7] == "origin"){
        utax.trip(tokens[8], tokens[4], tokens[6]);
        cout << utax.get_last_trip_id() << endl;
    }
    else if (tokens[3] == "origin" && tokens[5] == "username" && tokens[7] == "destination"){
        utax.trip(tokens[4], tokens[8], tokens[6]);
        cout << utax.get_last_trip_id() << endl;
    }
    else{
        throw invalid_argument("Bad Request\n");
    }
}

void handle_GET_all_trips_command(UTax& utax , vector <string> tokens){
    if (tokens[3] == "username"){
        vector <Trip *> trips = utax.get_trips(tokens[4]);
        for (int i = 0; i < trips.size(); i++){
            cout << trips[i]->get_id() << " " << trips[i]->get_passenger()->get_name() << " "
             << trips[i]->get_origin() << " " << trips[i]->get_destination() << " " << trips[i]->get_status_name() << endl;
        }
    }
    else{
        throw invalid_argument("Bad Request\n");
    }
}

void handle_GET_trip_command(UTax& utax , vector <string> tokens){
    if (tokens[3] == "id" && tokens[5] == "username"){
        Trip * trip = utax.get_trip(tokens[6] , stoi(tokens[4]));
        cout << trip->get_id() << " " << trip->get_passenger()->get_name() << " " 
        << trip->get_origin() << " " << trip->get_destination() << " " << trip->get_status_name() << endl;
    }
    else if (tokens[3] == "username" && tokens[5] == "id"){
        Trip * trip = utax.get_trip(tokens[4], stoi(tokens[6]));
        cout << trip->get_id() << " " << trip->get_passenger()->get_name() << " "
        << trip->get_origin() << " " << trip->get_destination() << " " << trip->get_status_name() << endl;
    }
    else{
        throw invalid_argument("Bad Request\n");
    }
}

void handle_POST_commands(UTax& utax , vector <string> tokens){
    if (tokens[1] == "signup"){
        handle_signup_command(utax, tokens);
    }
    else if (tokens[1] == "accept"){
        handle_accept_command(utax, tokens);
    }
    else if (tokens[1] == "finish"){
        handle_finish_command(utax, tokens);
    }
    else if (tokens[1] == "trips"){
        handle_POST_trips_command(utax, tokens);
    }
    else {
        throw invalid_argument("Bad Request\n");
    }
}

void handle_GET_commands(UTax& utax , vector <string> tokens){
    if (tokens[1] == "trips"){
        if (tokens.size() == 5){
            handle_GET_all_trips_command(utax, tokens);
        }
        else if (tokens.size() == 7){
            handle_GET_trip_command(utax, tokens);
        }
        else {
            throw invalid_argument("Bad Request\n");
        }
    } 
    else {
        throw invalid_argument("Bad Request\n");
    }

}

void handle_DELETE_commands(UTax& utax , vector <string> tokens){
    if (tokens[1] == "trips"){
        if (tokens.size() == 7){
            handle_DELETE_trip_command(utax, tokens);
        }
        else {
            throw invalid_argument("Bad Request\n");
        }
    }
    else {
        throw invalid_argument("Bad Request\n");
    }
}

void command (UTax& utax){
    string line;
    while (getline(cin, line)){
        vector <string> tokens = mystrtok(line, ' ');
        if (tokens[0] == "POST"){
            handle_POST_commands(utax , tokens);
        }
        else if (tokens[0] == "GET"){
            handle_GET_commands(utax , tokens);
        }
        else if (tokens[0] == "DELETE"){
            handle_DELETE_commands(utax , tokens);
        }
        else{
            throw invalid_argument("Bad Request\n");
        }
    }
}

int main (int argc, char* argv[]){
    fstream file = make_file(argv[1]);
    vector <Place> places = input_locations(file);
    file.close();
    UTax utax(places);
    while (1){
        try{
        command(utax);
        }
        catch(invalid_argument &e){
            cerr << e.what() ;
        }
        catch(runtime_error &e){
            cerr << e.what();
        }
    }
    return 0;
}

