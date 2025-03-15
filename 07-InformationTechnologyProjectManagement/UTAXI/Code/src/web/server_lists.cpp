#include "myserver.hpp"
#include "interface.hpp"
#include "handlers.hpp"

void Interface::server_pages(MyServer &server)
{
    server.get("/", new ShowPage("static/html_files/home.html"));
    server.get("/signup", new ShowPage("static/html_files/signup.html"));
    //server.get("/reqtrip", new ShowPage("static/html_files/reqtrip.html"));
    server.get("/trips", new ShowPage("static/html_files/trips.html"));
    server.get("/reqtripslist", new ShowPage("static/html_files/reqtripslist.html"));
    //server.get("/showtripslist", new ShowPage("static/html_files/showtripslist.html"));
    server.get("/finishtrip", new ShowPage("static/html_files/finishtrip.html"));
    server.get("/canceltrip", new ShowPage("static/html_files/canceltrip.html"));
    server.get("/about", new ShowPage("static/html_files/about.html"));
}

void Interface::server_css(MyServer &server)
{
    server.get("/default.css", new ShowFile("static/css_files/default.css", "text/css"));
    server.get("/home.css", new ShowFile("static/css_files/home.css", "text/css"));
    server.get("/signup.css", new ShowFile("static/css_files/signup.css", "text/css"));
    server.get("/reqtrip.css", new ShowFile("static/css_files/reqtrip.css", "text/css"));
    server.get("/trips.css", new ShowFile("static/css_files/trips.css", "text/css"));
    server.get("/reqtripslist.css", new ShowFile("static/css_files/reqtripslist.css", "text/css"));
    server.get("/showtripslist.css", new ShowFile("static/css_files/showtripslist.css", "text/css"));
    server.get("/finishtrip.css", new ShowFile("static/css_files/finishtrip.css", "text/css"));
    server.get("/canceltrip.css", new ShowFile("static/css_files/canceltrip.css", "text/css"));
    server.get("/about.css", new ShowFile("static/css_files/about.css", "text/css"));
}

void Interface::server_js(MyServer &server)
{
    server.get("/error.js", new ShowFile("static/js_files/error.js", "text/js"));
}

void Interface::server_images(MyServer &server) 
{
    server.get("/favicon.jpg", new ShowImage("static/images/favicon.jpg"));
    server.get("/about.png", new ShowImage("static/images/about.png"));
}

void Interface::server_handlers(MyServer &server)
{
    server.get("/save", new SaveDataHandler(utaxi));
    server.get("/signuppage", new SignupPageHandler());
    server.post("/signup", new SignupHandler(utaxi));

    server.get("/reqtrippage", new ReqTripPageHandler());
    server.get("/reqtrip", new ShowReqTripHandler(utaxi));
    server.post("/reqtrip", new ReqTripHandler(utaxi));

    server.get("/canceltrippage", new CancelTripPageHandler());
    server.post("/canceltrip", new CancelTripHandler(utaxi));
    server.get("/finishtrippage", new FinishTripPageHandler());
    server.post("/finishtrip", new FinishTripHandler(utaxi));

    server.get("/reqtripslistpage", new ReqTripsListPageHandler());
    server.post("/reqtripslist", new ReqTripsListHandler(utaxi));

    server.get("/showtripslistpage", new TripsListPageHandler());
    server.get("/showtripslist", new ShowTripsListHandler(utaxi));
    server.post("/showtripslist", new AcceptTripHandler(utaxi));
}