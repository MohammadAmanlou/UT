#ifndef __DRIVER_H__
#define __DRIVER_H__

#include <string>

#include "../user/member.hpp"

class Driver : public Member
{
    public:
        Driver() {};
        Driver(std::string _username);
        virtual bool is_passenger() { return false; }
        virtual bool is_driver() { return true; }
};

#endif /* __DRIVER_H__ */