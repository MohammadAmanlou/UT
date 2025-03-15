#ifndef __PASSENGER_H__
#define __PASSENGER_H__

#include <string>

#include "../user/member.hpp"
#include "../defines.hpp"

class Passenger : public Member
{
    public:
        Passenger() {};
        Passenger(std::string _username);
        virtual bool is_passenger() { return true; }
        virtual bool is_driver() { return false; }
};

#endif /* __PASSENGER_H__ */