#ifndef __MEMBER_H__
#define __MEMBER_H__

#include <string>

#include "../defines.hpp"

class Member
{
    public:
        Member() {};
        bool is_same_as(std::string new_username);
        void start_to_travel();
        void stop_travel();
        bool is_status(bool in_stat);
        virtual bool is_passenger() = 0;
        virtual bool is_driver() = 0;

        std::string get_username() { return username; }
    protected:
        std::string username;
        bool status;
};

#endif /* __MEMBER_H__ */