#ifndef _GAME_
#define _GAME_

#include <iostream>
#include "rsdl.hpp"
#include "ship.hpp"
#include "rifle.hpp"
#include "enemy.hpp"
#include <sstream>
#include <string>
#include <vector>

const int START_STATE = 0;
const int GAME_STATE = 1;
const int SEC_STATE = 2;

class Game{
    public:
        Game (Window * wind , int my_number_of_rounds , Ship * my_ship 
        , std::vector<Enemy *> my_enemy_vector , std::vector<Hostage *> my_hostage_vector){
            win = wind;
            state = START_STATE;
            number_of_rounds = my_number_of_rounds;
            live_round_number = 1;
            ship = my_ship;
            enemy_vector = my_enemy_vector;
            hostage_vector = my_hostage_vector;
            game_over_image = "asset/gameover.png";
            win_image = "asset/win.png";
        };
        Window * get_window(){
            return win;
        };
        int get_live_round_number(){
            return live_round_number;
        }
        void set_live_round_number(int input){
            live_round_number = input;
        }
        void set_state_to_sec(){
            state = SEC_STATE;
        }
        void init();
        void run ();
        void round_number();
        void play();
        void draw_players();
        void draw_enemies();
        void draw_hostages();
        void loose();
        void win_game();
        void play_check_events();
        void check_events();
        void show_round_number();
        void check_start_events();
        void start_message();
        void check_ship_collision();
        void check_enemy_collision();
        void check_hostages_collision();
        void check_enemy_ship_collision();
        void check_win_round();
        void shoot_enemies();
        void shoot_ship();
        
        private:
        Window * win;
        int state;
        int number_of_rounds;
        int live_round_number;
        Ship * ship;
        std::string game_over_image;
        std::string win_image;
        std::vector<Enemy *> enemy_vector;
        std::vector<Hostage *> hostage_vector;
};

#endif