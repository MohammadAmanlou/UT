#include "ship.hpp"

void Ship:: make_in_window(){
    if (place.x < SHIP_SIZE){
        place.x = SHIP_SIZE;
    }
    if (place.x > win->get_width() ){
        place.x = win->get_width() ;
    }
    if (place.y < SHIP_SIZE){
        place.y = SHIP_SIZE;
    }
    if (place.y > win->get_height()){
        place.y = win->get_height();
    }
}

void Ship:: move(std::string direction){
    if (direction == "up"){
        move_up();
    }
    else if(direction == "down"){
        move_down();
    }
    else if(direction == "left"){
        move_left();
    }
    else if(direction == "right"){
        move_right();
    }
    else if (direction == "stop"){
        vx = 0;
        vy = 0;
    }
}

void Ship:: move_up(){
    vy = SHEEP_SPEED * (-1);
    vx = 0;
    place.y += vy;
    place.x += vx;
    make_in_window();
}

void Ship:: move_down(){
    vy = SHEEP_SPEED;
    vx = 0;
    place.y += vy;
    place.x += vx;
    make_in_window();
}

void Ship:: move_left(){
    vy = 0;
    vx = SHEEP_SPEED * (-1);
    place.y += vy;
    place.x += vx;
    make_in_window();
}

void Ship:: move_right(){
    vy = 0;
    vx = SHEEP_SPEED;
    place.y += vy;
    place.x += vx;
    make_in_window();
}

void Ship:: shoot(){
    rifles.push_back(Rifle(Point(place.x-(SHIP_SIZE/2), place.y-(SHIP_SIZE))));
}

void Ship:: go_rifle(){
    for (int i = 0; i < rifles.size(); i++){
        rifles[i].move_up();
        win->fill_circle(rifles[i].get_rifle_place(), 5, RED);
        if (rifles[i].get_rifle_place().y < 0){
            rifles.erase(rifles.begin()+i);
            break;
        }
    }
}

void Ship:: draw(){
    Rectangle rect = Rectangle(Point(this->get_ship_place().x-SHIP_SIZE, this->get_ship_place().y-SHIP_SIZE), this->get_ship_place());
    win->draw_img(this->get_ship_image(), rect);
}

void Hostage:: draw(){
    win->draw_img(image, Rectangle(Point(place.x-(SHIP_SIZE), place.y-(SHIP_SIZE)) , place));
}