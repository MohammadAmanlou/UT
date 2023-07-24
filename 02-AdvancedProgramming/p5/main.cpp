#include "rsdl.hpp"
#include <iostream>
#include <string>
#include <vector>
#include <fstream>
#include <sstream>
#include "game.hpp"
#include "ship.hpp"
#include "enemy.hpp"

using namespace std;

fstream make_file (string file_name){
    fstream file(file_name) ;
    if(!file) { // file couldn't be opened
        cerr << "Error: file could not be opened" << endl;
        exit(1);
    }
    return file;
}

Window * make_window(fstream &file){
    string line;
    getline(file, line);
    stringstream s(line);
    string string_length , string_width;
    s >> string_length;
    s >> string_width;
    int length = stoi(string_length);
    int width = stoi(string_width);
    return new Window(length, width , "STARWARS");
}

int get_number_of_rounds(fstream &file){
    string line;
    getline(file, line);
    stringstream s(line);
    string string_number_of_rounds;
    s >> string_number_of_rounds;
    int number_of_rounds = stoi(string_number_of_rounds);
    return number_of_rounds;
}

vector<Enemy *> make_enemy_vector(fstream &file , Window& window){
    string line;
    vector <Enemy *> enemy_vector;
    while(getline(file, line)){
        stringstream s(line);
        string string_length , string_width , type_of_enemy;
        s >> type_of_enemy;
        s >> string_length;
        s >> string_width;
        if ( type_of_enemy == "G"){
            break;
        }
        if (type_of_enemy == "E"){
            bool type = ENEMY;
            int length = stoi(string_length);
            int width = stoi(string_width);
            Enemy * enemy = new Enemy(&window, Point(length, width) , type);
            enemy_vector.push_back(enemy);
        }
        else if (type_of_enemy == "S"){
            bool type = STRICKER;
            int length = stoi(string_length);
            int width = stoi(string_width);
            Enemy * enemy = new Enemy(&window, Point(length, width) , type);
            enemy_vector.push_back(enemy);
        }
    }
    return enemy_vector;
}

vector <Hostage *> make_hostage_vector(fstream &file , Window &window){
    string line;
    string type;
    vector <Hostage *> hostage_vector;
    while(getline(file, line)){
        stringstream s(line);
        string string_length , string_width;
        s >> type;
        if (type == "G"){
            break;
        }
        if (type == "H"){
            s >> string_length;
            s >> string_width;
            int length = stoi(string_length);
            int width = stoi(string_width);
            Hostage * hostage = new Hostage(&window, Point(length, width));
            hostage_vector.push_back(hostage);
        }
    }
    return hostage_vector;
}

void start_game(Game& game ,int live_round_number , int number_of_rounds , Window& window , fstream &file , fstream &sec_file){
while (true){
        if (game.get_live_round_number() == 0){
            game.loose();
        }
        else if (game.get_live_round_number() == number_of_rounds+1){
            game.win_game();
        }
        else {
            if (game.get_live_round_number()!= live_round_number){
                live_round_number ++;
                vector<Enemy *> enemies = make_enemy_vector(file, window);
                vector <Hostage *> hostages = make_hostage_vector(sec_file,window);
                Ship *new_ship = new Ship(&window);
                Game new_game(&window , number_of_rounds , new_ship , enemies , hostages);
                new_game.set_live_round_number(live_round_number);
                new_game.set_state_to_sec();
                game = new_game;
            }
            game.run();
        }
    }
}

int main (int argc , char *argv[]){
    string file_name = argv[1];
    fstream file = make_file(file_name);
    fstream sec_file = make_file(file_name);
    Window *window = make_window(file);
    Ship *ship = new Ship(window);
    int number_of_rounds = get_number_of_rounds(file);
    vector<Enemy *> enemies = make_enemy_vector(file, *window);
    vector <Hostage *> hostages = make_hostage_vector(sec_file, *window);
    Game game(window , number_of_rounds , ship , enemies , hostages);
    int live_round_number = 1 ;
    start_game(game , live_round_number , number_of_rounds , *window , file , sec_file);
    return 0;
}