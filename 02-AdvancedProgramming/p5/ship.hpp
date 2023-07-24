#ifndef _SHIP_
#define _SHIP_

#include <iostream>
#include "rsdl.hpp"
#include "rifle.hpp"
#include <sstream>
#include <string>
#include <vector>

const int SHEEP_SPEED = 5;
const int SHIP_SIZE =50;

class Ship
{
    public:
        Ship(Window* wind , std::string my_image = "asset/ship.png"){
            win = wind;
            image = my_image;
            srand(time(0));
            place.x = (rand() % (win->get_width() - SHIP_SIZE)) + SHIP_SIZE;
            place.y = win->get_height();
            vx = 0;
            vy = 0;
        }
        std::string get_ship_image(){
            return image;
        }
        Point get_ship_place(){
            return place;
        }
        std::vector<Rifle> get_rifles(){
            return rifles;
        }
        void move_up();
        void move_down();
        void move_left();
        void move_right();
        void make_in_window();
        void shoot();
        void go_rifle();
        void draw();
        void move(std::string direction);
    private:
        Window * win;
        std::string image;
        Point place;
        int vx;
        int vy;
        std::vector<Rifle> rifles;
};

class Hostage{
    private:
        Window * win;
        Point place;
        std::string image;
    public:
        Hostage(Window * wind , Point my_place , std::string my_image = "asset/hostage.png"){
            win = wind;
            place = my_place;
            image = my_image;
        }
        Point get_place(){
            return place;
        }
        std::string get_image(){
            return image;
        }
        void draw();
};

#endif