#ifndef DATABASE_ITEM_HPP
#define DATABASE_ITEM_HPP

#include <optional>
#include <string>

#include "location.hpp"
#include "trip.hpp"
#include "../user/member.hpp"

struct MemberItem {
    MemberItem() = default;
    explicit MemberItem(Member* m);
    Member* to_member() const;

    std::string username;
    bool status;
    std::string type;
};

struct LocationItem {
    LocationItem() = default;
    explicit LocationItem(Location* l);
    Location* to_location() const;

    std::string name;
    double latitude;
    double longitude;
    int traffic;
};

struct TripItem {
    TripItem() = default;
    explicit TripItem(Trip* t);
    Trip* to_trip(Member* passenger, Member* driver, Location* origin, Location* destination) const;

    int id;
    std::string status;
    double price;
    std::string passenger_id;
    std::optional<std::string> driver_id;
    std::string origin_name;
    std::string destination_name;
};

#endif //DATABASE_ITEM_HPP
