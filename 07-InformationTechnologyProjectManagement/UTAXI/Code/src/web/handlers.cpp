#include "handlers.hpp"


Interface::SignupPageHandler::SignupPageHandler() {};
Response *Interface::SignupPageHandler::callback(Request *req)
{
    Response *res = new Response;
    change_error_text("");
    res = Response::redirect("/signup");
    return res;
}

Interface::SignupHandler::SignupHandler(Utaxi *utaxi_) { utaxi = utaxi_; }
Response *Interface::SignupHandler::callback(Request *req)
{
    Response *res = new Response;
    change_error_text("");
    SignupCredentials new_signup;
    std::string username = req->getBodyParam("username");
    std::string role = req->getBodyParam("role");
    new_signup.username = (username == "" ? EMPTY_ARG : username);
    new_signup.role = req->getBodyParam("role");
    try 
    {
        utaxi->signup(new_signup);
        change_error_text("");
        res = Response::redirect("/");
    }
    catch(std::runtime_error &er)
    {
        change_error_text(er.what());
        res = Response::redirect("/signup");
    }

    return res;
}

Interface::ReqTripPageHandler::ReqTripPageHandler() {};
Response *Interface::ReqTripPageHandler::callback(Request *req)
{
    Response *res = new Response;
    change_error_text("");
    res = Response::redirect("/reqtrip");
    return res;
}

Interface::ShowReqTripHandler::ShowReqTripHandler(Utaxi *utaxi_) { utaxi = utaxi_;}
Response *Interface::ShowReqTripHandler::callback(Request *req)
{
    Response *res = new Response;
    res->setHeader("Content-Type", "text/html");
    res->setBody(req_trip_html(utaxi->get_locs()));
    return res;
}

Interface::ReqTripHandler::ReqTripHandler(Utaxi *utaxi_) { utaxi = utaxi_;}
Response *Interface::ReqTripHandler::callback(Request *req)
{
    Response *res = new Response;
    TripRequestTokens new_trip;
    std::string username = req->getBodyParam("username");
    std::string origin = req->getBodyParam("origin");
    std::string destination = req->getBodyParam("destination");
    std::string form_req = req->getBodyParam("submit");
    new_trip.username = (username == "" ? EMPTY_ARG : username);
    new_trip.origin_name = (origin == "" ? EMPTY_ARG : origin);
    new_trip.destination_name = (destination == "" ? EMPTY_ARG : destination);
    new_trip.in_hurry = req->getBodyParam("in_hurry");
    try 
    {
        if(form_req == "Request")
        {
            utaxi->post_trips(new_trip);
            std::string trip_id = std::to_string(utaxi->get_trips_count());
            change_error_text("Trip ID: " + trip_id);
            res = Response::redirect("/reqtrip");
        }
        else if(form_req == "Calculate Cost")
        {
            std::string cost = std::to_string(utaxi->get_cost(new_trip));
            change_error_text("Trip cost: " + cost);
            res = Response::redirect("/reqtrip");
        }
    }
    catch(std::runtime_error &er)
    {
        change_error_text(er.what());
        res = Response::redirect("/reqtrip");
    }

    return res;
}

Interface::CancelTripPageHandler::CancelTripPageHandler() {};
Response *Interface::CancelTripPageHandler::callback(Request *req)
{
    Response *res = new Response;
    change_error_text("");
    res = Response::redirect("/canceltrip");
    return res;
}

Interface::CancelTripHandler::CancelTripHandler(Utaxi *utaxi_) { utaxi = utaxi_; }
Response *Interface::CancelTripHandler::callback(Request *req)
{
    Response *res = new Response;
    TripIntractTokens new_cancel;
    new_cancel.username = req->getBodyParam("username");
    new_cancel.id = (stoi(req->getBodyParam("id")) == 0 ? -1 : stoi(req->getBodyParam("id")));
    try
    {
        utaxi->delete_trip(new_cancel);
        change_error_text("Trip canceled!");
        res = Response::redirect("/canceltrip");
    }
    catch(std::runtime_error &er)
    {
        change_error_text(er.what());
        res = Response::redirect("/canceltrip");
    }

    return res;
}

Interface::FinishTripPageHandler::FinishTripPageHandler() {};
Response *Interface::FinishTripPageHandler::callback(Request *req)
{
    Response *res = new Response;
    change_error_text("");
    res = Response::redirect("/finishtrip");
    return res;
}

Interface::FinishTripHandler::FinishTripHandler(Utaxi *utaxi_) { utaxi = utaxi_; }
Response *Interface::FinishTripHandler::callback(Request *req)
{
    Response *res = new Response;
    TripIntractTokens new_finish;
    new_finish.username = req->getBodyParam("username");
    new_finish.id = (stoi(req->getBodyParam("id")) == 0 ? -1 : stoi(req->getBodyParam("id")));
    try
    {
        utaxi->finish(new_finish);
        change_error_text("Trip finished!");
        res = Response::redirect("/finishtrip");
    }
    catch(std::runtime_error &er)
    {
        change_error_text(er.what());
        res = Response::redirect("/finishtrip");
    }

    return res;
}

Interface::ReqTripsListPageHandler::ReqTripsListPageHandler() {};
Response *Interface::ReqTripsListPageHandler::callback(Request *req)
{
    Response *res = new Response;
    change_error_text("");
    res = Response::redirect("/reqtripslist");
    return res;
}

Interface::ReqTripsListHandler::ReqTripsListHandler(Utaxi *utaxi_) { utaxi = utaxi_; };
Response *Interface::ReqTripsListHandler::callback(Request *req)
{
    change_error_text("");
    Response *res = new Response;
    TripIntractTokens new_list;
    new_list.username = req->getBodyParam("username");
    new_list.id = (stoi(req->getBodyParam("id")) == 0 ? -1 : stoi(req->getBodyParam("id")));
    new_list.cost_sorted = (req->getBodyParam("sort_by_cost") == "" ? "no" : "yes");
    try
    {
        req->getBodyParam("id-check") == "no-id" ? (utaxi->trips_list(new_list)) : (utaxi->trip_data(new_list));
        change_error_text("");
        res = Response::redirect("/showtripslistpage");
    }
    catch(std::runtime_error &er)
    {
        change_error_text(er.what());
        res = Response::redirect("/reqtripslist");
    }
    
    return res;
}

Interface::TripsListPageHandler::TripsListPageHandler() {};
Response *Interface::TripsListPageHandler::callback(Request *req)
{
    Response *res = new Response;
    change_error_text("");
    res = Response::redirect("/showtripslist");
    return res;
}

Interface::ShowTripsListHandler::ShowTripsListHandler(Utaxi *utaxi_) { utaxi = utaxi_; };
Response *Interface::ShowTripsListHandler::callback(Request *req)
{
    Response *res = new Response;
    res->setHeader("Content-Type", "text/html");
    res->setBody(req_trips_list_html(utaxi->get_trips()));
    return res;
}

Interface::AcceptTripHandler::AcceptTripHandler(Utaxi *utaxi_) { utaxi = utaxi_; }
Response *Interface::AcceptTripHandler::callback(Request *req)
{
    Response *res = new Response;
    TripIntractTokens new_accept;
    new_accept.username = req->getBodyParam("username");
    new_accept.id = (req->getBodyParam("id") == "" ? -1 : stoi(req->getBodyParam("id")));
    try
    {
       utaxi->accept(new_accept);
       change_error_text(new_accept.username + " " + "accepted trip" + " " +std::to_string(new_accept.id));
    }
    catch(std::runtime_error &er)
    {
        change_error_text(er.what());
    }
    res = Response::redirect("/showtripslist");

    return res;
}

Interface::SaveDataHandler::SaveDataHandler(Utaxi *utaxi_) { utaxi = utaxi_; }
Response *Interface::SaveDataHandler::callback(Request *req)
{
    Response *res = new Response;
    utaxi->save_data();
    res = Response::redirect("/");
    return res;
}
