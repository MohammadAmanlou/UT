#ifndef __UTAXI_H__
#define __UTAXI_H__

#include <vector>
#include <string>
#include "../data/database.hpp"
#include "../data/data_reader.hpp"
#include "../data/location.hpp"
#include "../user/member.hpp"
#include "../user/driver.hpp"
#include "../user/passenger.hpp"
#include "../data/trip.hpp"

class Utaxi
{
    public:
        Utaxi();
        void gather_loc_data(std::string file_address);
        void save_data();

        void signup(SignupCredentials new_signup);
        void post_trips(TripRequestTokens new_trip_tokens);
        void accept(TripIntractTokens new_accpet_tokens);
        void finish(TripIntractTokens new_finish_tokens);
        void trips_list(TripIntractTokens new_trips_list_tokens);
        void trip_data(TripIntractTokens new_trip_data_tokens);
        void delete_trip(TripIntractTokens new_delete_trip_tokens);

        int get_cost(TripRequestTokens new_cost_tokens);
        int get_trips_count() { return trips_counter; }
        std::vector<Location*> get_locs() { return database.get_locs(); }
        std::vector<Trip*> get_trips() { return target_trips; }
    private:
        Database database;
        std::vector<Trip*> target_trips;
        int trips_counter;

        void check_signup_role(std::string role);
        void check_signup_username(std::string username);
        void check_new_trip_arguments(TripRequestTokens new_trip_tokens);
};

#endif /* __UTAXI_H__ */