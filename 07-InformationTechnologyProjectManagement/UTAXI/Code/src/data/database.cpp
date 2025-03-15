#include "database.hpp"
#include <iostream>

using namespace sqlite_orm;

auto setup() {
    auto storage = make_storage("db.sqlite",
                                  make_table("members",
                                             make_column("username", &MemberItem::username, primary_key()),
                                             make_column("status", &MemberItem::status),
                                             make_column("type", &MemberItem::type)),
                                  make_table("locations",
                                             make_column("name", &LocationItem::name, primary_key()),
                                             make_column("latitude", &LocationItem::latitude),
                                             make_column("longitude", &LocationItem::longitude),
                                             make_column("traffic", &LocationItem::traffic)),
                                  make_table("trips",
                                             make_column("id", &TripItem::id, primary_key()),
                                             make_column("status", &TripItem::status),
                                             make_column("price", &TripItem::price),
                                             make_column("passenger_id", &TripItem::passenger_id),
                                             make_column("driver_id", &TripItem::driver_id),
                                             make_column("origin_name", &TripItem::origin_name),
                                             make_column("destination_name", &TripItem::destination_name)));
    return storage;
}

void Database::save_data() {
    std::cout << "Saving Data" << std::endl;
    auto storage = setup();
    for (const auto l: locations)
        storage.replace(LocationItem(l));
    for (const auto m: members)
        storage.replace(MemberItem(m));
    for (const auto t: trips)
        storage.replace(TripItem(t));
}

void Database::read_data() {
    auto storage = setup();
    auto all_members = storage.get_all<MemberItem>();
    for (const auto &m: all_members)
        members.push_back(m.to_member());

    auto all_locations = storage.get_all<LocationItem>();
    for (const auto &l: all_locations)
        locations.push_back(l.to_location());

    auto all_trips = storage.get_all<TripItem>();
    for (const auto &t: all_trips) {
        auto passenger = find_member_by_username(t.passenger_id);
        auto driver = t.driver_id.has_value() ? find_member_by_username(t.driver_id.value()) : nullptr;
        auto origin = find_location_by_name(t.origin_name);
        auto destination = find_location_by_name(t.destination_name);
        trips.push_back(t.to_trip(passenger, driver, origin, destination));
    }
}

void Database::add_member(SignupCredentials new_mem) {
    if (new_mem.role == DRIVER_ROLE)
        members.push_back(new Driver(new_mem.username));
    if (new_mem.role == PASSENGER_ROLE)
        members.push_back(new Passenger(new_mem.username));
}

void Database::add_location(Location *new_loc) {
    locations.push_back(new_loc);
}

bool cmp_trips(Trip *t1, Trip *t2) {
    return (t2->price < t1->price);
}

void Database::add_trip(TripRequestTokens new_tr) {
    Trip *new_trip = make_trip(new_tr);
    bool hurry = (new_tr.in_hurry == YES_HURRY ? true : false);
    new_trip->calc_price(hurry);
    trips.push_back(new_trip);
}

double Database::calc_trip_cost(TripRequestTokens new_tr) {
    Trip *new_trip = make_trip(new_tr);
    bool hurry = (new_tr.in_hurry == YES_HURRY ? true : false);
    return (new_trip->calc_price(hurry));
}

Trip *Database::make_trip(TripRequestTokens new_tr) {
    Trip *new_trip = new Trip(members[find_member_index(new_tr.username)],
                              locations[find_location_index(new_tr.origin_name)],
                              locations[find_location_index(new_tr.destination_name)],
                              new_tr.id);

    return new_trip;
}

std::vector<Trip *> Database::get_trips(std::string sorted) {
    if (sorted == YES_HURRY)
        return (get_cost_sorted_trips());
    else
        return trips;
}

std::vector<Trip *> Database::get_cost_sorted_trips() {
    std::vector<Trip *> sorted_trips = trips;
    sort(sorted_trips.begin(), sorted_trips.end(), cmp_trips);
    return sorted_trips;
}

void Database::check_passenger_trip_errors(TripRequestTokens new_trip_tokens) {
    check_member_is_available(new_trip_tokens.username);
    check_location_is_available(new_trip_tokens.origin_name);
    check_location_is_available(new_trip_tokens.destination_name);
    check_is_passenger(new_trip_tokens.username);
    check_member_is(MEMBER_TRAVELING, new_trip_tokens.username);
}

void Database::check_accept_errors(TripIntractTokens new_accpet_tokens) {
    check_member_is_available(new_accpet_tokens.username);
    check_trip_is_available(new_accpet_tokens.id);
    check_trip_is(TRIP_TRAVELING, new_accpet_tokens.id);
    check_trip_is(TRIP_FINISHED, new_accpet_tokens.id);
    check_trip_is_deleted(new_accpet_tokens.id);
    check_is_driver(new_accpet_tokens.username);
    check_member_is(MEMBER_TRAVELING, new_accpet_tokens.username);
}

void Database::check_finish_errors(TripIntractTokens new_finish_tokens) {
    check_member_is_available(new_finish_tokens.username);
    check_trip_is_available(new_finish_tokens.id);
    check_trip_is(TRIP_WAITING, new_finish_tokens.id);
    check_is_driver(new_finish_tokens.username);
    check_finish_another_user_trip(new_finish_tokens);
    check_member_is(MEMBER_NOT_TRAVELING, new_finish_tokens.username);
}

void Database::check_delete_trip_errors(TripIntractTokens new_delete_trip_tokens) {
    check_trip_is_available(new_delete_trip_tokens.id);
    check_trip_is_deleted(new_delete_trip_tokens.id);
    check_trip_is(TRIP_TRAVELING, new_delete_trip_tokens.id);
    check_trip_is(TRIP_FINISHED, new_delete_trip_tokens.id);
    check_delete_another_user_trip(new_delete_trip_tokens);
}

void Database::check_member_is_available(std::string _username) {
    if (find_member_index(_username) == -1)
        throw std::runtime_error(NOT_FOUND_ERROR);
}

void Database::check_user_exist(std::string _username) {
    if (find_member_index(_username) != -1)
        throw std::runtime_error(BAD_REQUEST_ERROR);
}

void Database::check_location_is_available(std::string loc_name) {
    if (find_location_index(loc_name) == -1)
        throw std::runtime_error(NOT_FOUND_ERROR);
}

void Database::check_trip_is_available(int _id) {
    if (find_trip_index(_id) == -1)
        throw std::runtime_error(NOT_FOUND_ERROR);
}

void Database::check_trip_is_deleted(int _id) {
    if (trips[find_trip_index(_id)]->is_deleted())
        throw std::runtime_error(NOT_FOUND_ERROR);
}

void Database::check_trip_is(std::string status, int _id) {
    if (trips[find_trip_index(_id)]->is_status(status))
        throw std::runtime_error(BAD_REQUEST_ERROR);
}

void Database::check_delete_another_user_trip(TripIntractTokens new_delete_trip_tokens) {
    if (!find_passenger_by_trip(new_delete_trip_tokens.id)->is_same_as(new_delete_trip_tokens.username))
        throw std::runtime_error(PERMISSION_ERROR);
}

void Database::check_finish_another_user_trip(TripIntractTokens new_finish_tokens) {
    if (!find_driver_by_trip(new_finish_tokens.id)->is_same_as(new_finish_tokens.username))
        throw std::runtime_error(PERMISSION_ERROR);
}

void Database::check_is_passenger(std::string _username) {
    if (!members[find_member_index(_username)]->is_passenger())
        throw std::runtime_error(PERMISSION_ERROR);
}

void Database::check_is_driver(std::string _username) {
    if (!members[find_member_index(_username)]->is_driver())
        throw std::runtime_error(PERMISSION_ERROR);
}

void Database::check_member_is(bool status, std::string _username) {
    if (members[find_member_index(_username)]->is_status(status))
        throw std::runtime_error(BAD_REQUEST_ERROR);
}

int Database::find_member_index(std::string member_name) {
    for (int i = 0; i < members.size(); i++)
        if (members[i]->is_same_as(member_name))
            return i;

    return -1;
}

int Database::find_location_index(std::string location_name) {
    for (int i = 0; i < locations.size(); i++)
        if (locations[i]->is_same_as(location_name))
            return i;

    return -1;
}

int Database::find_trip_index(int _id) {
    for (int i = 0; i < trips.size(); i++)
        if (trips[i]->is_same_as(_id))
            return i;

    return -1;
}

Member *Database::find_passenger_by_trip(int _id) {
    return (trips[find_trip_index(_id)]->get_passenger());
}

Member *Database::find_driver_by_trip(int _id) {
    return (trips[find_trip_index(_id)]->get_driver());
}

Member *Database::find_member_by_username(std::string _username) {
    return (members[find_member_index(_username)]);
}

Location *Database::find_location_by_name(std::string name) {
    for (const auto l: locations)
        if (l->is_same_as(name))
            return l;
    return nullptr;
}


Trip *Database::find_trip_by_id(int _id) {
    return (trips[find_trip_index(_id)]);
}
