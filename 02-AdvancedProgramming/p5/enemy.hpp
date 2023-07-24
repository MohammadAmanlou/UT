#ifndef _ENEMY_
#define _ENEMY_

#include <iostream>
#include "rsdl.hpp"
#include "rifle.hpp"
#include <vector>

const int ENEMY_SIZE=50;
const int STRICKER_SIZE=50;
const int ENEMY_SPEED=1;

enum EnemyType {
    ENEMY,
    STRICKER
};

enum Direction {
    RIGHT,
    LEFT
};

class Enemy{
    private:
        Window * win;
        Point Enemy_place;
        std::string image_address;
        bool type;
        bool direction;
        std::vector<Rifle> rifles;
    public:
        Enemy(Window * wind , Point my_place , bool my_type ,  std::string my_image_address = "asset/enemy.png" , bool my_direction = RIGHT){
            win = wind;
            Enemy_place = my_place;
            image_address = my_image_address;
            type = my_type;
            direction = my_direction;
        }
        Point get_place(){
            return Enemy_place;
        }
        std::string get_image_address(){
            return image_address;
        };
        bool get_type(){
            return type;
        };
        std::vector<Rifle> get_rifles(){
            return rifles;
        };
        void draw();
        void move();
        void move_up();
        void move_down();
        void move_horizontal();
        void go_rifle();
        void shoot();
};


#endif