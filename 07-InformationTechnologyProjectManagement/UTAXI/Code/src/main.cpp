#include "server/server.hpp"
#include "web/interface.hpp"
#include <iostream>
#include <iomanip> 

int main(int argc, char *argv[])
{
    std::cout << std::fixed << std::setprecision(2);
    Interface interface;
    interface.run(argv);

    return 0;
}