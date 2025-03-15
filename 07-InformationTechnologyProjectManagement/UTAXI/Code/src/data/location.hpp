#ifndef __LOCATION_H__
#define __LOCATION_H__

#include <string>
#include <cmath>

#include "../defines.hpp"
#include "../utils/general.hpp"
class Location
{
    public:
        Location();
        Location(std::string _name, double _lat, double _long, int _traffic);
        bool is_same_as(std::string check_loc);
        double distance_to(Location* loc2);
        int traffic_to(Location* loc2);

        std::string get_name() { return name; }
        double get_latitude() const { return latitude; }
        double get_longitude() const { return longitude; }
        int get_traffic() const { return traffic; }
    private:
        std::string name;
        double latitude;
        double longitude;
        int traffic;
};

#endif /* __LOCATION_H__ */