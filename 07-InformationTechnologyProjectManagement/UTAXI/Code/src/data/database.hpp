#ifndef __DATABASE_H__
#define __DATABASE_H__

#include <vector>
#include <string>
#include <stdexcept>
#include <algorithm>

#include "../data/location.hpp"
#include "../user/member.hpp"
#include "../user/driver.hpp"
#include "../user/passenger.hpp"
#include "trip.hpp"
#include "../utils/general.hpp"
#include "database_items.hpp"
#include "../defines.hpp"
#include "sqlite_orm.h"


class Database
{
    public:
        Database() {}
        void save_data();
        void read_data();
        void add_member(SignupCredentials new_mem);
        void add_location(Location* new_loc);
        void add_trip(TripRequestTokens new_trip);

        double calc_trip_cost(TripRequestTokens new_trip_tokens);
        std::vector<Trip*> get_trips(std::string sorted);

        void check_passenger_trip_errors(TripRequestTokens new_trip_tokens);
        void check_accept_errors(TripIntractTokens new_accpet_tokens);
        void check_finish_errors(TripIntractTokens new_finish_tokens);
        void check_delete_trip_errors(TripIntractTokens new_delete_trip_tokens);
        void check_member_is_available(std::string _username);
        void check_user_exist(std::string _username);
        void check_location_is_available(std::string loc_name);
        void check_trip_is_available(int _id);
        void check_trip_is_deleted(int _id);
        void check_trip_is(std::string status, int _id);
        void check_dest_orig_same(std::string dest, std::string orig);
        void check_delete_another_user_trip(TripIntractTokens new_delete_trip_tokens);
        void check_finish_another_user_trip(TripIntractTokens new_finish_trip_tokens);
        void check_is_passenger(std::string _username);
        void check_is_driver(std::string _username);
        void check_member_is(bool status, std::string _username);
        int find_member_index(std::string member_name);
        int find_location_index(std::string location_name);
        int find_trip_index(int _id);
        Member* find_passenger_by_trip(int _id);
        Member* find_driver_by_trip(int _id);
        Member* find_member_by_username(std::string _username);
        Location* find_location_by_name(std::string name);
        Trip* find_trip_by_id(int _id);

        std::vector<Trip*> get_id_sorted_trips() { return trips; }
        std::vector<Trip*> get_cost_sorted_trips();
        std::vector<Location*> get_locs() { return locations; }
    private:
        std::vector<Location*> locations;
        std::vector<Member*> members;
        std::vector<Trip*> trips;
        Trip* make_trip(TripRequestTokens trip_tokens);
};

#endif /* __DATABASE_H__ */