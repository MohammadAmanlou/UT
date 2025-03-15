#include "trip.hpp"

Trip::Trip(Member* _passenger, Location* _origin, Location* _destination, int _id)
{
    passenger = _passenger;
    origin = _origin;
    destination = _destination;
    status = TRIP_WAITING;
    trip_id = _id;
}

double Trip::calc_price(bool hurry)
{
    double dist = origin->distance_to(destination);
    int traffic_factor = origin->traffic_to(destination);

    price = (hurry ? HURRY_COEFFICIENT : 1 ) * dist * traffic_factor * PRICE_COEFFICIENT;
    return price;
}

bool Trip::is_same_as(int _id)
{
    return (trip_id == _id);
}

void Trip::start()
{
    status = TRIP_TRAVELING;
}

void Trip::finish()
{
    status = TRIP_FINISHED;
}

void Trip::delete_yourself()
{
    status = TRIP_DELETED;
}

bool Trip::is_status(std::string in_stat)
{
    return (status == in_stat);
}

bool Trip::is_deleted()
{
    return (status == TRIP_DELETED);
}