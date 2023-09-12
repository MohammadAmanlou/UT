#include <iostream>
#include <string>
#include <vector>
#include "person.hpp"
#include "trip.hpp"
#include "utax.hpp"
#include <stdexcept>
#include <fstream>
#include <sstream>
#include <iomanip>
#include "server/server.hpp"
#include "handler.hpp"
#include "errors.hpp"

using namespace std;

fstream make_file(string file_name)
{
    fstream file(file_name);
    if (!file)
    { // file couldn't be opened
        throw invalid_argument("Error: file could not be opened");
    }
    return file;
}

bool stb(string str)
{
    if (str == "yes")
    {
        return 1;
    }
    else
    {
        return 0;
    }
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

vector<Place> input_locations(fstream &file)
{
    vector<Place> places;
    string line;
    getline(file, line);
    while (getline(file, line))
    {
        vector<string> tokens = mystrtok(line, ',');
        string nam = tokens[0];
        float x = stof(tokens[1]);
        float y = stof(tokens[2]);
        int traffic_ = stoi(tokens[3]);
        Place place;
        place.name = nam;
        place.lat = x;
        place.lon = y;
        place.traffic = traffic_;
        places.push_back(place);
    }
    return places;
}

void handle_DELETE_trip_command(UTax &utax, vector<string> tokens)
{
    if (tokens[3] == "id" && tokens[5] == "username")
    {
        utax.delete_trip(tokens[6], stoi(tokens[4]));
        cout << "OK" << endl;
    }
    else if (tokens[3] == "username" && tokens[5] == "id")
    {
        utax.delete_trip(tokens[4], stoi(tokens[6]));
        cout << "OK" << endl;
    }
    else
    {
        throw Bad_req("Bad Request\n");
    }
}

void handle_signup_command(UTax &utax, vector<string> tokens)
{
    if (tokens.size() < 7)
    {
        throw Bad_req("Bad Request\n");
    }
    if (tokens[3] == "username" && tokens[5] == "role")
    {
        utax.signup(tokens[4], tokens[6]);
        cout << "OK\n";
    }
    else if (tokens[3] == "role" && tokens[5] == "username")
    {
        utax.signup(tokens[6], tokens[4]);
        cout << "OK\n";
    }
    else
    {
        throw Bad_req("Bad Request\n");
    }
}

void handle_accept_command(UTax &utax, vector<string> tokens)
{
    if (tokens.size() < 7)
    {
        throw Bad_req("Bad Request\n");
    }
    if (tokens[3] == "id")
    {
        utax.accept_trip(tokens[6], stoi(tokens[4]));
        cout << "OK\n";
    }
    else if (tokens[3] == "username")
    {
        utax.accept_trip(tokens[4], stoi(tokens[6]));
        cout << "OK\n";
    }
    else
    {
        throw Bad_req("Bad Request\n");
    }
}

void handle_finish_command(UTax &utax, vector<string> tokens)
{
    if (tokens.size() < 7)
    {
        throw Bad_req("Bad Request\n");
    }
    if (tokens[3] == "id")
    {
        utax.finish_trip(tokens[6], stoi(tokens[4]));
        cout << "OK\n";
    }
    else if (tokens[3] == "username")
    {
        utax.finish_trip(tokens[4], stoi(tokens[6]));
        cout << "OK\n";
    }
    else
    {
        throw Bad_req("Bad Request\n");
    }
}

void handle_POST_trips_command(UTax &utax, vector<string> tokens)
{
    if (tokens.size() < 11)
    {
        throw Bad_req("Bad Request\n");
    }
    string origin;
    string destination;
    string username;
    string hurry;
    int number_of_true_arguments = 0;
    for (int i = 0; i < tokens.size(); i++)
    {
        if (tokens[i] == "origin")
        {
            origin = tokens[i + 1];
            number_of_true_arguments++;
        }
        else if (tokens[i] == "destination")
        {
            destination = tokens[i + 1];
            number_of_true_arguments++;
        }
        else if (tokens[i] == "username")
        {
            username = tokens[i + 1];
            number_of_true_arguments++;
        }
        else if (tokens[i] == "in_hurry")
        {
            hurry = tokens[i + 1];
            number_of_true_arguments++;
        }
    }
    if (number_of_true_arguments < 4)
    {
        throw Bad_req("Bad Request\n");
    }
    utax.trip(origin, destination, username, stb(hurry));
    cout << utax.get_last_trip_id() << endl;
}

void show_normal(vector<Trip *> trips)
{
    for (int i = 0; i < trips.size(); i++)
    {
        cout << trips[i]->get_id() << " " << trips[i]->get_passenger()->get_name() << " "
             << trips[i]->get_origin() << " " << trips[i]->get_destination() << " "
             << fixed << setprecision(2) << trips[i]->get_cost()
             << " " << trips[i]->get_status_name() << endl;
    }
}

vector<Trip *> sort_by_cost(vector<Trip *> trips)
{
    vector<Trip *> trips_ = trips;
    for (int i = 0; i < trips_.size() - 1; i++)
    {
        if (trips_[i]->get_cost() < trips_[i + 1]->get_cost())
        {
            Trip *temp = trips_[i];
            trips_[i] = trips_[i + 1];
            trips_[i + 1] = temp;
        }
    }
    return trips_;
}

void show_by_cost(vector<Trip *> trips)
{
    vector<Trip *> sorted_by_cost_trips = sort_by_cost(trips);
    show_normal(sorted_by_cost_trips);
}

void handle_GET_all_trips_command(UTax &utax, vector<string> tokens)
{
    if (tokens[3] == "username" && tokens[5] == "sort_by_cost")
    {
        vector<Trip *> trips = utax.get_trips(tokens[4]);
        if (stb(tokens[6]))
        {
            show_by_cost(trips);
        }
        else
        {
            show_normal(trips);
        }
    }
    else if (tokens[5] == "username" && tokens[3] == "sort_by_cost")
    {
        vector<Trip *> trips = utax.get_trips(tokens[6]);
        if (stb(tokens[4]))
        {
            show_by_cost(trips);
        }
        else
        {
            show_normal(trips);
        }
    }
    else
    {
        throw Bad_req("Bad Request\n");
    }
}

void handle_GET_trip_command(UTax &utax, vector<string> tokens)
{
    if (tokens[3] == "id" && tokens[5] == "username")
    {
        Trip *trip = utax.get_trip(tokens[6], stoi(tokens[4]));
        cout << trip->get_id() << " " << trip->get_passenger()->get_name() << " "
             << trip->get_origin() << " " << trip->get_destination() << " " << fixed << setprecision(2) << trip->get_cost() << " "
             << trip->get_status_name() << endl;
    }
    else if (tokens[3] == "username" && tokens[5] == "id")
    {
        Trip *trip = utax.get_trip(tokens[4], stoi(tokens[6]));
        cout << trip->get_id() << " " << trip->get_passenger()->get_name() << " "
             << trip->get_origin() << " " << trip->get_destination() << " " << fixed << setprecision(2) << trip->get_cost() << " "
             << trip->get_status_name() << endl;
    }
    else
    {
        throw Bad_req("Bad Request\n");
    }
}

bool is_passenger(vector<Person *> persons, string username)
{
    for (int i = 0; i < persons.size(); i++)
    {
        if (persons[i]->get_name() == username)
        {
            if (persons[i]->get_role() == "passenger")
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }
    }
    cout << "mmd";
    return 0;
}

bool have_place(string place, vector<Place> places)
{
    for (int i = 0; i < places.size(); i++)
    {
        if (place == places[i].name)
        {
            return 1;
        }
    }
    return 0;
}

bool check_existence(string username, string origin, string destination, UTax &utax)
{
    if ((is_passenger(utax.get_members(), username)) && (have_place(origin, utax.get_places())) && (have_place(destination, utax.get_places())))
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

void handle_GET_cost_command(UTax &utax, vector<string> tokens)
{
    if (tokens.size() < 11)
    {
        throw Bad_req("Bad Request\n");
    }
    string origin;
    string username;
    string destination;
    string hurry;
    int number_of_true_arguments = 0;
    for (int i = 0; i < tokens.size(); i++)
    {
        if (tokens[i] == "username")
        {
            username = tokens[i + 1];
            number_of_true_arguments++;
        }
        else if (tokens[i] == "origin")
        {
            origin = tokens[i + 1];
            number_of_true_arguments++;
        }
        else if (tokens[i] == "destination")
        {
            destination = tokens[i + 1];
            number_of_true_arguments++;
        }
        else if (tokens[i] == "in_hurry")
        {
            hurry = tokens[i + 1];
            number_of_true_arguments++;
        }
    }
    if (number_of_true_arguments < 4)
    {
        throw Bad_req("Bad Request\n");
    }
    else if (!check_existence(username, origin, destination, utax))
    {
        throw Not_found("Not Found\n");
    }
    cout << fixed << setprecision(2) << utax.find_trip_cost(origin, destination, stb(hurry)) << endl;
}

void handle_POST_commands(UTax &utax, vector<string> tokens)
{
    if (tokens[1] == "signup")
    {
        handle_signup_command(utax, tokens);
    }
    else if (tokens[1] == "accept")
    {
        handle_accept_command(utax, tokens);
    }
    else if (tokens[1] == "finish")
    {
        handle_finish_command(utax, tokens);
    }
    else if (tokens[1] == "trips")
    {
        handle_POST_trips_command(utax, tokens);
    }
    else
    {
        throw Bad_req("Bad Request\n");
    }
}

void handle_GET_commands(UTax &utax, vector<string> tokens)
{
    bool arg;
    if (tokens[1] == "trips")
    {
        for (int i = 0; i < tokens.size(); i++)
        {
            if (tokens[i] == "id")
            {
                handle_GET_trip_command(utax, tokens);
                arg = 1;
                break;
            }
            else if (tokens[i] == "sort_by_cost")
            {
                handle_GET_all_trips_command(utax, tokens);
                arg = 1;
                break;
            }
        }
        if (!arg)
        {
            throw Bad_req("Bad Request\n");
        }
    }
    else if (tokens[1] == "cost")
    {
        handle_GET_cost_command(utax, tokens);
    }
    else
    {
        throw Bad_req("Bad Request\n");
    }
}

void handle_DELETE_commands(UTax &utax, vector<string> tokens)
{
    if (tokens[1] == "trips")
    {
        if (tokens.size() == 7)
        {
            handle_DELETE_trip_command(utax, tokens);
        }
        else
        {
            throw invalid_argument("Bad Request\n");
        }
    }
    else
    {
        throw invalid_argument("Bad Request\n");
    }
}

void command(UTax &utax)
{
    string line;
    while (getline(cin, line))
    {
        vector<string> tokens = mystrtok(line, ' ');
        if (tokens[0] == "POST")
        {
            handle_POST_commands(utax, tokens);
        }
        else if (tokens[0] == "GET")
        {
            handle_GET_commands(utax, tokens);
        }
        else if (tokens[0] == "DELETE")
        {
            handle_DELETE_commands(utax, tokens);
        }
        else
        {
            throw Bad_req("Bad Request\n");
        }
    }
}

int main(int argc, char *argv[])
{
    fstream file = make_file(argv[1]);
    vector<Place> places = input_locations(file);
    file.close();
    UTax *utax = new UTax(places);
    Server server(8080);
    server.get("/", new ShowPage("static/homepage.html"));
    server.get("/home.png", new ShowImage("static/home.png"));
    server.get("/signup", new ShowPage("static/signup.html"));
    server.post("/signup", new Signup_handler(utax));
    server.get("/common.css" , new ShowPage("static/common.css"));
    server.get("/trip", new ShowPage("static/trip.html"));
    server.post("/trip", new Trip_handler(utax));
    server.get("/cancel", new ShowPage("static/cancel.html"));
    server.post("/cancel", new Cancel_handler(utax));
    server.get("/driver" , new ShowPage ("static/driver.html"));
    server.post("/driver" , new Show_handler (utax));
    server.get("accept" , new ShowPage ("static/accept.html"));
    server.post("/accept", new Accept_handler(utax));
    server.get("/error" , new ShowPage ("static/error.html"));
    server.get("/not_found" , new ShowPage ("static/not_found.html"));
    server.get("/bad_req" , new ShowPage ("static/bad_req.html"));
    server.get("/Permission_error" , new ShowPage ("static/Permission_error.html"));
    server.run();
    return 0;
}
