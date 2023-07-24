#ifndef _RIFLE_
#define _RIFLE_

#include <iostream>
#include "rsdl.hpp"
#include <sstream>
#include <string>

const int RIFLE_SPEED = 10;

class Rifle{
    public : 
        Rifle(Point my_place){
            _place = my_place;
        }
        void move_up();
        void move_down();
        Point get_rifle_place(){
            return _place;
        }
    private:
        Point _place;
};

#endif