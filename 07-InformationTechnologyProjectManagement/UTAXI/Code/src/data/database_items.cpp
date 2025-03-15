#include "database_items.hpp"

#include "../user/driver.hpp"
#include "../user/passenger.hpp"

MemberItem::MemberItem(Member *m) {
    username = m->get_username();
    status = m->is_status(true);
    type = m->is_driver() ? "Driver" : "Passenger";
}

Member *MemberItem::to_member() const {
    Member *m = type == "Driver"
                    ? static_cast<Member *>(new Driver(username))
                    : static_cast<Member *>(new Passenger(username));
    if (status)
        m->start_to_travel();
    return m;
}

LocationItem::LocationItem(Location *l) {
    name = l->get_name();
    latitude = l->get_latitude();
    longitude = l->get_longitude();
    traffic = l->get_traffic();
}

Location *LocationItem::to_location() const {
    return new Location(name, latitude, longitude, traffic);
}

TripItem::TripItem(Trip *t) {
    id = t->get_id();
    status = t->get_status();
    price = t->get_price();
    passenger_id = t->get_passenger()->get_username();
    driver_id = t->get_driver() ? std::optional(t->get_driver()->get_username()) : std::nullopt;
    origin_name = t->get_origin()->get_name();
    destination_name = t->get_destination()->get_name();
}

Trip *TripItem::to_trip(Member *passenger, Member *driver, Location *origin, Location *destination) const {
    Trip *t = new Trip(passenger, origin, destination, id);
    t->set_status(status);
    t->set_price(price);
    t->set_driver(driver);
    return t;
}
