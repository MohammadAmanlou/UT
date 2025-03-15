#include "member.hpp"

bool Member::is_same_as(std::string new_username)
{
    return (this->username == new_username);
}

bool Member::is_status(bool in_stat)
{
    return (status == in_stat);
}

void Member::start_to_travel()
{
    status = MEMBER_TRAVELING;
} 

void Member::stop_travel()
{
    status = MEMBER_NOT_TRAVELING;
}

