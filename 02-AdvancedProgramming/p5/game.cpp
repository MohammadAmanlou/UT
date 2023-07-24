#include "game.hpp"

void Game :: run (){
    win->draw_img("asset/galaxy.jpg");
    if (state == START_STATE && live_round_number ==1){
        init();
    }
    else if (state == SEC_STATE){
        round_number();
    }
    else if (state == GAME_STATE){
        play();
    }
    delay(50);
    win->clear();
}

void Game:: show_round_number(){
    std::string message = "";
    message =  "Round " + std::to_string(live_round_number) + " of " + std::to_string(number_of_rounds);
    win->show_text(message,Point(win->get_width()/2 - 60,win->get_height()/2 - 50), RED , "asset/FreeSans.ttf" , 40);
    win->show_text("Press any keys to start", Point(win->get_width()/2 + 50,win->get_height()/2 ), RED, "asset/FreeSans.ttf" , 10);
}

void Game :: round_number(){
    show_round_number();
    check_events();
    win->update_screen();
}

void Game:: start_message(){
    win->play_music("asset/start.mp3");
    win->show_text("Welcome to StarWars", Point(win->get_width()/2 - 60,win->get_height()/2 - 50), WHITE , "asset/FreeSans.ttf" , 40);
    win->show_text("Press any keys to start", Point(win->get_width()/2 + 50,win->get_height()/2 ), WHITE, "asset/FreeSans.ttf" , 10);
}

void Game :: init (){
    start_message();
    check_start_events();
    win->update_screen();
}

void Game:: loose(){
    win->clear();
    win->draw_img(game_over_image);
    check_events();
    win->update_screen();
    live_round_number = 0;
}

void Game:: win_game(){
    win->clear();
    win->draw_img(win_image);
    check_events();
    win->update_screen();
}

void Game:: check_ship_collision(){
    for (int i = 0 ; i < enemy_vector.size() ; i++){
        for (int j=0 ; j < enemy_vector[i]->get_rifles().size() ; j++){
            if ((enemy_vector[i]->get_rifles()[j].get_rifle_place().x <= ship->get_ship_place().x )
            && (enemy_vector[i]->get_rifles()[j].get_rifle_place().x >= ship->get_ship_place().x - SHIP_SIZE)
            && (enemy_vector[i]->get_rifles()[j].get_rifle_place().y <= ship->get_ship_place().y )
            && (enemy_vector[i]->get_rifles()[j].get_rifle_place().y >= ship->get_ship_place().y - SHIP_SIZE)){
                loose();
            }
        }
    }
}

void Game:: check_enemy_collision(){
    for (int i = 0 ; i < enemy_vector.size() ; i++){
        for (int j=0 ; j < ship->get_rifles().size() ; j++){
            if ((ship->get_rifles()[j].get_rifle_place().x <= enemy_vector[i]->get_place().x )
            && (ship->get_rifles()[j].get_rifle_place().x >= enemy_vector[i]->get_place().x - ENEMY_SIZE)
            && (ship->get_rifles()[j].get_rifle_place().y <= enemy_vector[i]->get_place().y )
            && (ship->get_rifles()[j].get_rifle_place().y >= enemy_vector[i]->get_place().y - ENEMY_SIZE)){
                enemy_vector.erase(enemy_vector.begin() + i);
            }
        }
    }
}

void Game:: draw_enemies(){
    for (int i=0 ; i<enemy_vector.size(); i++){
        enemy_vector[i]->draw();
        enemy_vector[i]->move();
        if (enemy_vector[i]->get_place().x > win->get_width()){
            enemy_vector.erase(enemy_vector.begin()+i);
        }
        else if(enemy_vector[i]->get_place().x < 0){
            enemy_vector.erase(enemy_vector.begin()+i);
        }
        else if(enemy_vector[i]->get_place().y > win->get_height() + ENEMY_SIZE){
            enemy_vector.erase(enemy_vector.begin()+i);
        }
        else if(enemy_vector[i]->get_place().y < 0){
            enemy_vector.erase(enemy_vector.begin()+i);
        }
    }
}

void Game:: draw_hostages(){
    for (int i=0 ; i<hostage_vector.size() ; i++){
        hostage_vector[i]->draw();
    }
}

void Game:: shoot_enemies(){
    for (int i=0 ; i<enemy_vector.size() ; i++){
        if (enemy_vector[i]->get_rifles().size() == 0){
            enemy_vector[i]->shoot();
            delay(60);
        }
    }
    for (int i =0 ; i < enemy_vector.size() ; i++){
        enemy_vector[i]->go_rifle();
    }
}

void Game :: draw_players(){
    ship->draw();
    draw_enemies();
    draw_hostages();
}

void Game::check_start_events(){
    Event last_event;
    while (win->has_pending_event()){
        last_event = win->poll_for_event();
        switch(last_event.get_type()){

            case Event::EventType::KEY_PRESS:
                state = SEC_STATE;
                break;

            case Event::EventType::QUIT:
                win->clear();
                exit(0);
                break;

            default:
                break;
        }
    }
}

void Game:: check_events(){
    Event last_event;
    while (win->has_pending_event()){
        last_event = win->poll_for_event();
        switch(last_event.get_type()){

            case Event::EventType::KEY_PRESS:
                state = GAME_STATE;
                break;

            case Event::EventType::QUIT:
                win->clear();
                exit(0);
                break;

            default:
                break;
        }
    }

}

std::string direction;
void Game:: play_check_events(){
    Event event;
    while (win->has_pending_event()){
        event = win->poll_for_event();
        switch(event.get_type()){

            case Event::EventType::KEY_PRESS:
            if (event.get_pressed_key() == 'w'){
                direction = "up";
            }
            if (event.get_pressed_key() == 's'){
                direction = "down";
            }
            else if (event.get_pressed_key() == 'a'){
                direction = "left";
            }
            else if (event.get_pressed_key() == 'd'){
                direction = "right";
            }
            else if (event.get_pressed_key() == ' '){
                ship->shoot();
            }
            break; 

            case Event::EventType::KEY_RELEASE:
            if ((event.get_pressed_key() == 'w') || (event.get_pressed_key() == 's') 
            || (event.get_pressed_key() == 'a') || (event.get_pressed_key() == 'd')){
                direction = "stop";
            }
            break; 

            case Event::EventType::QUIT:
                win->clear();
                exit(0);
                break;

            default:
                break;
        }
    }
    ship->move(direction);
}

void Game:: shoot_ship(){
    if (ship->get_rifles().size() > 0){
        ship->go_rifle();
    }
}

void Game:: check_hostages_collision(){
    for (int i = 0 ; i < hostage_vector.size() ; i++){
        for (int j=0 ; j < ship->get_rifles().size() ; j++){
            if ((ship->get_rifles()[j].get_rifle_place().x <= hostage_vector[i]->get_place().x )
            && (ship->get_rifles()[j].get_rifle_place().x >= hostage_vector[i]->get_place().x - SHIP_SIZE)
            && (ship->get_rifles()[j].get_rifle_place().y <= hostage_vector[i]->get_place().y )
            && (ship->get_rifles()[j].get_rifle_place().y >= hostage_vector[i]->get_place().y - SHIP_SIZE)){
                loose();
            }
        }
    }
}

void Game:: check_enemy_ship_collision(){
    for (int i = 0 ; i < enemy_vector.size() ; i++){
        if ((ship->get_ship_place().x < enemy_vector[i]->get_place().x + SHIP_SIZE )
        && (ship->get_ship_place().x > enemy_vector[i]->get_place().x - ENEMY_SIZE)
        && (ship->get_ship_place().y > enemy_vector[i]->get_place().y -  ENEMY_SIZE)
        && (ship->get_ship_place().y  < enemy_vector[i]->get_place().y + SHIP_SIZE)){
            loose();
        }
    }
}

void Game:: check_win_round(){
    if(enemy_vector.size()==0){
        live_round_number++;
        state = SEC_STATE;
    }
}

void Game :: play (){
    draw_players();
    check_enemy_collision();
    check_ship_collision();
    check_hostages_collision();
    check_enemy_ship_collision();
    play_check_events();
    shoot_enemies();
    shoot_ship();
    check_win_round();
    win->update_screen();
}