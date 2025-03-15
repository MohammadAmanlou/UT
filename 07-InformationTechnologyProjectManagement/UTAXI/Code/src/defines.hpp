#ifndef __DEFINES_H__
#define __DEFINES_H__

#include <string>

constexpr double LENGTH_OF_A_DEGREE = 110.5;
constexpr double PRICE_COEFFICIENT = 10000;
constexpr double HURRY_COEFFICIENT = 1.2;

const std::string LOCATION_TOKENS_DELIMITER = ",";
const std::string COMMAND_TOKENS_DELIMITER = " ";
const std::string TRIPS_DATA_DELIMITER = " ";
const std::string EMPTY_ARG = "NULL";
const std::string GET_ = "GET";
const std::string POST_ = "POST";
const std::string DELETE = "DELETE";
const std::string TRIP_WAITING = "waiting";
const std::string TRIP_TRAVELING = "traveling";
const std::string TRIP_FINISHED = "finished";
const std::string TRIP_DELETED = "deleted";

const std::string DRIVER_ROLE = "driver";
const std::string PASSENGER_ROLE = "passenger";

const std::string PERMISSION_ERROR = "Permission Denied";
const std::string NOT_FOUND_ERROR = "Not Found";
const std::string BAD_REQUEST_ERROR = "Bad Request";
const std::string EMPTY_ERROR = "EMPTY";
const std::string DONE_PROMPT = "OK";

const std::string YES_HURRY = "yes";
const std::string NO_HURRY = "no";

const std::string ACCPET_COMMAND = "accept";
const std::string TRIPS_COMMAND = "trips";
const std::string COST_COMMAND = "cost";
const std::string FINISH_COMMAND = "finish";
const std::string SIGNUP_COMMAND = "signup";

const std::string ID_ARG = "id";
const std::string SORT_BY_COST_ARG = "sort_by_cost";
const std::string USERNAME_ARG = "username";
const std::string ROLE_ARG = "role";
const std::string ORIGIN_ARG = "origin";
const std::string DESTINATION_ARG = "destination";
const std::string HURRY_ARG = "in_hurry";


constexpr bool MEMBER_TRAVELING = true;
constexpr bool MEMBER_NOT_TRAVELING = false;

namespace WebCommand
{
    enum Command
    {
        W_NONE,
        GET,
        POST,
        DELETE 
    };
}

namespace POSTCommand
{
    enum Command
    {
        P_NONE,
        SIGNUP,
        REQUEST,
        ACCEPT,
        FINISH
    };
}

namespace GETCommand
{
    enum Command
    {
        G_NONE,
        TRIPS_LIST,
        TRIP_DATA,
        COST
    };
}

namespace DELETECommand
{
    enum Command
    {
        D_NONE,
        TRIPS
    };
}

#endif /* __DEFINES_H__ */