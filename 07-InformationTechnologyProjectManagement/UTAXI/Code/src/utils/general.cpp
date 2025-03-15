#include "general.hpp"

std::vector<std::string> parse_line(std::string line, std::string delimiter)
{
    std::vector<std::string> tokens;
    size_t pos = 0;
    while ((pos = line.find(delimiter)) != std::string::npos) 
    {
        tokens.push_back(line.substr(0, pos));
        line.erase(0, pos + delimiter.length());
    }
    tokens.push_back(line.substr(0, pos));

    return tokens;
}

double calc_linear_dist(double lat1, double long1, double lat2, double long2)
{
    return (sqrt(pow(lat2 - lat1, 2) + pow(long2 - long1, 2)));
}

bool has_id(std::vector<std::string> tokens)
{
    for(int i = 0; i < tokens.size(); i++)
        if(tokens[i] == "id")
            return true;
    
    return false;
}

bool has_cost_sort(std::vector<std::string> tokens)
{
    for(int i = 0; i < tokens.size(); i++)
        if(tokens[i] == "sort_by_cost")
            return true;
            
    return false;
}

void change_error_text(std::string err_text) {
    std::ofstream js_err;
    js_err.open("static/js_files/error.js");
    if (err_text == "") js_err << " ";
    else js_err << "alert(\'" << err_text << "\');";
    js_err.close();
}