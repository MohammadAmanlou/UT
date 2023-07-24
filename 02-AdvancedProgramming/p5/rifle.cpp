#include "rifle.hpp"

void Rifle :: move_up(){
    _place.y -= RIFLE_SPEED ;
}

void Rifle :: move_down(){
    _place.y += RIFLE_SPEED ;
}

