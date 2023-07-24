#include "enemy.hpp"

void Enemy :: draw(){
    if (type == ENEMY){
        Rectangle enemy_place = Rectangle(Point(this->get_place().x-ENEMY_SIZE, this->get_place().y-ENEMY_SIZE), this->get_place());
        win->draw_img(this->get_image_address(), enemy_place);
    }
    else if (type == STRICKER){
        Rectangle enemy_place = Rectangle(Point(this->get_place().x-STRICKER_SIZE, this->get_place().y-STRICKER_SIZE), this->get_place());
        win->draw_img(this->get_image_address(), enemy_place);
    }
}

void Enemy :: move(){
    if (type == ENEMY){
        this->move_down();
    }
    else if (type == STRICKER){
        this->move_horizontal();
    }
}

void Enemy :: move_up(){
    Enemy_place.y -= ENEMY_SPEED;
}

void Enemy :: move_down(){
    Enemy_place.y += ENEMY_SPEED;
}

void Enemy :: move_horizontal(){
    if (direction == RIGHT){
        Enemy_place.x += ENEMY_SPEED;
        if (Enemy_place.x > win->get_width()){
            Enemy_place.x = win->get_width();
            direction = LEFT;
        }
    }
    else if(direction == LEFT){
        Enemy_place.x -= ENEMY_SPEED;
        if (Enemy_place.x < ENEMY_SIZE){
            Enemy_place.x = ENEMY_SIZE;
            direction = RIGHT;
        }
    }
}

void Enemy:: go_rifle(){
    for (int i = 0; i < rifles.size(); i++){
        rifles[i].move_down();
        win->fill_circle(rifles[i].get_rifle_place(), 5, YELLOW);
        if (rifles[i].get_rifle_place().y > win->get_height()){
            rifles.erase(rifles.begin()+i);
            break;
        }
    }
}

void Enemy:: shoot(){
    rifles.push_back(Rifle(Point(Enemy_place.x-(ENEMY_SIZE/2), Enemy_place.y-(ENEMY_SIZE))));
    delay(50);
}