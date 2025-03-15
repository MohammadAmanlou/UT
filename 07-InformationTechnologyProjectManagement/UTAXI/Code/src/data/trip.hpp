#ifndef __TRIP_H__
#define __TRIP_H__

#include <string>
#include "location.hpp"
#include "../user/member.hpp"
#include "../defines.hpp"


class Trip
{
    public:
        Trip() {};
        Trip(Member* _passenger, Location* _origin, Location* _destination, int _id);

        bool is_same_as(int _id);
        double calc_price(bool hurry);
        void start();
        void finish();
        void delete_yourself();
        bool is_deleted();
        bool is_status(std::string in_stat);
        friend bool cmp_trips(Trip* t1, Trip* t2);

        void set_driver(Member* _driver) { driver = _driver; }
        void set_status(std::string _status) { status = _status; }
        void set_price(double _price) { price = _price; }
        Member* get_passenger() { return passenger; }
        Member* get_driver() { return driver; }
        Location* get_origin() { return origin; }
        Location* get_destination() { return destination;}
        std::string get_status() { return status; }
        int get_id() { return trip_id; }
        double get_price() { return price; }
        
    private:
        Member* passenger;
        Member* driver;
        Location* origin;
        Location* destination;
        std::string status;
        int trip_id;
        double price = 0;
};

#endif /* __TRIP_H__ */