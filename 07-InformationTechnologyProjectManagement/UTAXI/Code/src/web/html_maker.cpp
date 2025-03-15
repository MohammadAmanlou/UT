#include "html_maker.hpp"

std::string req_trip_html(const std::vector<Location*> &locations)
{
    std::string line;
    std::ifstream infile;
    infile.open("static/html_files/reqtrip.html");
    std::string body;
    while(std::getline(infile, line) && line != "<option value=\"\" class=\"loc\">choose origin</option>")
        body += line;

    body += line;
    for(int i = 0; i < locations.size(); i++)
        body += ("<option value=\"" + locations[i]->get_name() + "\" class=\"loc\">" + locations[i]->get_name() + "</option>");
    
    while(std::getline(infile, line) && line != "<option value=\"\" class=\"loc\">choose destination</option>")
        body += line;

    body += line;
    for(int i = 0; i < locations.size(); i++)
        body += ("<option value=\"" + locations[i]->get_name() + "\" class=\"loc\">" + locations[i]->get_name() + "</option>");
    
    while(std::getline(infile, line))
        body += line;

    infile.close();
    return body;
}

std::string req_trips_list_html(const std::vector<Trip*> &trips)
{
    std::string line;
    std::ifstream infile;
    infile.open("static/html_files/showtripslist.html");
    std::string body;
    while(std::getline(infile, line) && line != "</tr>")
        body += line;

    body += line;
    for(int i = 0; i < trips.size(); ++i)
    {
        if(trips[i]->get_status() == "deleted")
            continue;
        body += "<tr>";
        body += ("<td>" + std::to_string(trips[i]->get_id()) + "</td>");
        body += ("<td>" + trips[i]->get_passenger()->get_username() + "</td>");
        body += ("<td>" + trips[i]->get_origin()->get_name() + "</td>");
        body += ("<td>" + trips[i]->get_destination()->get_name() + "</td>");
        body += ("<td>" + trips[i]->get_status() + "</td>");
        body += ("<td>" + std::to_string(int(trips[i]->get_price())) + "</td>");
        if(trips[i]->get_status() == "waiting")
            body += ("<td><input type=\"radio\" name=\"id\" value=\"" + std::to_string(trips[i]->get_id()) + "\"/></td>");
        else
            body += "<td></td>";
        body += "</tr>";
    }

    while(std::getline(infile, line))
        body += line;

    return body;
}