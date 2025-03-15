#ifndef __HTML_MAKER_H__
#define __HTML_MAKER_H__
#include <string>
#include <vector>
#include <sstream>
#include <fstream>
#include <iostream>
#include "../data/trip.hpp"
#include "../data/location.hpp"
#include "myserver.hpp"

std::string req_trip_html(const std::vector<Location*> &locations);
std::string req_trips_list_html(const std::vector<Trip*> &trips);

#endif /* __HTML_MAKER_H__ */