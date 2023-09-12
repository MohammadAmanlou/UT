#include "handler.hpp"

Signup_handler :: Signup_handler(UTax * utax_){
    utax = utax_;
}

Response * Signup_handler :: callback (Request * req) {
    try {
    std::string username = req->getBodyParam("username");
    std::string role = req->getBodyParam("role");
    utax->signup(username , role);
    Response * res = Response::redirect("/");
    return res;
    }
    catch (Bad_req & e){
        Response * res = Response::redirect("/bad_req");
        return res;
    }
    catch (Permission_error & e){
        Response * res = Response::redirect("/permission_error");
        return res;
    }
    catch (Not_found & e){
        Response * res = Response::redirect("/not_found");
        return res;
    }
    catch (std::exception & e){
        Response * res = Response::redirect("/error");
        return res;
    }
}

bool stringToBool(std::string str){
    if (str == "yes"){
        return 1;
    }
    else if (str == "no"){ 
        return 0;
    }
    else {
        throw Bad_req("Bad Request\n");
    }
}

Response * make_successfully_trip_response(Response * res , UTax * utax){
    res->setHeader("Content-Type", "text/html");
    std::ostringstream body;
    body << "<!DOCTYPE html>" << std::endl 
         << "<html lang='en'><head><title>UTAXI &#9992</title><meta charset='UTF-8'><link rel='stylesheet' href='/common.css'></head>"
         << "<html>" << std::endl  << "<header><h1>UTAXI</h1></header>"
         << "<body><p>Your request has been successfully submitted. Wait for the driver to accept your request</p>" << std::endl 
         << "<p>Your trip id is: " << std::to_string(utax->get_last_trip_id()) << "</p>"<< std::endl 
         << "<a href='/'>Go to home page</a><br />"
         << "</body></html>" << std::endl;
    res->setBody(body.str());
    return res;
}

Response * make_money_response(Response * res , UTax * utax , double money){
    res->setHeader("Content-Type", "text/html");
    std::ostringstream body;
    body << "<!DOCTYPE html>" << std::endl 
         << "<html lang='en'><head><title>UTAXI &#9992</title><meta charset='UTF-8'><link rel='stylesheet' href='/common.css'></head>"
         << "<html>" << std::endl  << "<header><h1>UTAXI</h1></header>"
         << "<p>Your trip cost: " << std::to_string(money) << "</p>"<< std::endl 
         << "<a href='/'>Go to home page</a><br />"
         << "<a href='/trip'>Go to reserve</a><br />"
         << "</body></html>" << std::endl;
    res->setBody(body.str());
    return res;
}

Response * Trip_handler :: callback (Request * req) {
    try {
        std::string username = req->getBodyParam("username");
        std::string destination = req->getBodyParam("destination");
        std::string origin = req->getBodyParam("origin");
        std::string hurry = req->getBodyParam("hurry");
        std::string btn = req->getBodyParam("action");
        if (btn == "ok"){
            utax->trip(origin , destination , username , stringToBool(hurry));
            Response * res = new Response;
            return make_successfully_trip_response(res , utax);
        }
        else if (btn == "money"){
            double money = utax->find_trip_cost(origin , destination , stringToBool(hurry));
            Response * res = new Response;
            return make_money_response(res ,  utax , money);
        }
    }
    catch (Bad_req & e){
        Response * res = Response::redirect("/bad_req");
        return res;
    }
    catch (Permission_error & e){
        Response * res = Response::redirect("/permission_error");
        return res;
    }
    catch (Not_found & e){
        Response * res = Response::redirect("/not_found");
        return res;
    }
    catch (std::exception & e){
        Response * res = Response::redirect("/error");
        return res;
    }

}

Response * Cancel_handler :: callback (Request * req) {
    try {
        std::string username = req->getBodyParam("username");
        std::string trip_id = req->getBodyParam("id");
        utax->delete_trip(username , std::stoi(trip_id));
        Response * res = Response::redirect("/");
        return res;
    }
    catch (Bad_req & e){
        Response * res = Response::redirect("/bad_req");
        return res;
    }
    catch (Permission_error & e){
        Response * res = Response::redirect("/permission_error");
        return res;
    }
    catch (Not_found & e){
        Response * res = Response::redirect("/not_found");
        return res;
    }
    catch (std::exception & e){
        Response * res = Response::redirect("/error");
        return res;
    }
}

std::vector<Trip *> sort_cost(std::vector<Trip *> trips)
{
    std::vector<Trip *> trips_ = trips;
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

Response * make_show(Response * res , UTax * utax , std::string username ){
    std::vector <Trip * >  trips = utax->get_trips(username );
    std::ostringstream body;
    std::cout << "trips size: " << std::endl;
    res->setHeader("Content-Type", "text/html");
    body << "<!DOCTYPE html>" << std::endl 
    << "<html lang='en'><head><title>UTAXI &#9992</title><meta charset='UTF-8'><link rel='stylesheet' href='/common.css'></head>"
    << "<html>" << std::endl  << "<header><h1>UTAXI</h1><br />"
    << "<h2><a href='/'>Go to home page</a></h2></header>" 
    <<"<style>table, th, td {border:1px solid black;}</style>" 
    << "<body><p>Your trips:</p>" << std::endl 
    << "<table style='width:100%'>" << std::endl 
    << "<tr><th>Trip id</th><th>Origin</th><th>Destination</th>"
    <<"<th>Hurry</th><th>Status</th><th>Price</th></tr>" << std::endl;
    for (int i = 0 ; i < trips.size() ; i++){
        body << "<tr><td>" << std::to_string(trips[i]->get_id()) << "</td><td>" 
        << trips[i]->get_origin() << "</td><td>" << trips[i]->get_destination() 
        << "</td><td>" << (trips[i]->get_passenger()->get_name()) << "</td><td>" 
        << trips[i]->get_status_name()  <<"</td><td>" << std::to_string(trips[i]->get_cost()) 
        << "</td></tr>"  << std::endl;
    }
    body << "</table>" << std::endl;
    body << "<div><br/><form action='/accept' method='post'><input name='trip_id' type='username' placeholder='Trip id'  /><input name='D_username' type='hidden' placeholder='username' value=" 
    << "'" << username << "'"<<"/><button type='submit' name = 'action'  value = 'accept' style=display:rgb(255, 0, 0); >ACCEPT</button>"<<
    "<button type='submit' name = 'action'  value = 'finish' style='display:rgb(255, 0, 0);' >FINISH</button></form></div>" << std::endl;
    res->setHeader("Content-Type", "text/html");
    res->setBody(body.str());
    return res;
}

Response * make_show_by_price(Response * res , UTax * utax , std::string username ){
    std::vector <Trip * >  trips = sort_cost(utax->get_trips(username ));
    std::ostringstream body;
    res->setHeader("Content-Type", "text/html");
    body << "<!DOCTYPE html>" << std::endl 
    << "<html lang='en'><head><title>UTAXI &#9992</title><meta charset='UTF-8'><link rel='stylesheet' href='/common.css'></head>"
    << "<html>" << std::endl  << "<header><h1>UTAXI</h1><br />"
    << "<h2><a href='/'>Go to home page</a></h2></header>" 
    <<"<style>table, th, td {border:1px solid black;}</style>" 
    << "<body><p>Your trips:</p>" << std::endl 
    << "<table style='width:100%'>" << std::endl 
    << "<tr><th>Trip id</th><th>Origin</th><th>Destination</th><th>Hurry</th>"
    << "<th>Status</th><th>Price</th></tr>" << std::endl;
    for (int i = 0 ; i < trips.size() ; i++){
        body << "<tr><td>" << std::to_string(trips[i]->get_id()) << "</td><td>" 
        << trips[i]->get_origin() << "</td><td>" << trips[i]->get_destination() 
        << "</td><td>" << (trips[i]->get_passenger()->get_name()) << "</td><td>" 
        << trips[i]->get_status_name()  <<"</td><td>" << std::to_string(trips[i]->get_cost()) 
        << "</td></tr>"  << std::endl;
    }
    body << "</table>" << std::endl;
    body << "<div><br/><form action='/accept' method='post'><input name='trip_id' type='username' placeholder='Trip id'  /><input name='D_username' type='hidden' placeholder='username' value=" 
    << "'" << username << "'"<<"/><button type='submit' name = 'action'  value = 'accept' style=display:rgb(255, 0, 0); >ACCEPT</button>"<<
    "<button type='submit' name = 'action'  value = 'finish' style='display:rgb(255, 0, 0);' >FINISH</button></form></div>" << std::endl;
    res->setHeader("Content-Type", "text/html");
    res->setBody(body.str());
    return res;
}

Response * Show_handler :: callback (Request * req) {
    try {
        std::string username = req->getBodyParam("username");
        std::string btn = req->getBodyParam("action");
        Response * res = new Response;
        if (btn == "show_by_id"){
            res = make_show(res , utax , username);
        }
        else if (btn == "show_by_price"){
            res = make_show_by_price(res , utax , username);
        }
        return res;
    }
    catch (Bad_req & e){
        Response * res = Response::redirect("/bad_req");
        return res;
    }
    catch (Permission_error & e){
        Response * res = Response::redirect("/permission_error");
        return res;
    }
    catch (Not_found & e){
        Response * res = Response::redirect("/not_found");
        return res;
    }
    catch (std::exception & e){
        Response * res = Response::redirect("/error");
        return res;
    }
}

Response * Accept_handler :: callback (Request * req) {
    try {
        std::string username = req->getBodyParam("D_username");
        std::string trip_id = req->getBodyParam("trip_id");
        std::string btn = req->getBodyParam("action");
        if (btn == "accept"){
            utax->accept_trip(username, std::stoi(trip_id));
            Response * res = Response::redirect("/");
            return res;
        }
        else if (btn == "finish"){
            utax->finish_trip(username, std::stoi(trip_id));
            Response * res = Response::redirect("/");
            return res;
        }
        
    }
    catch (Bad_req & e){
        Response * res = Response::redirect("/bad_req");
        return res;
    }
    catch (Permission_error & e){
        Response * res = Response::redirect("/permission_error");
        return res;
    }
    catch (Not_found & e){
        Response * res = Response::redirect("/not_found");
        return res;
    }
    catch (std::exception & e){
        Response * res = Response::redirect("/error");
        return res;
    }
}
