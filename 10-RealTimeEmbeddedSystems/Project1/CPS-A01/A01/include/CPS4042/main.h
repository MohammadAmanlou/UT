#pragma once

#include <csignal>
#include <thread>

#define CPS_SET_OBJECT_NAME(OBJ)     OBJ.setName(#OBJ)
#define CPS_SET_OBJECT_NAME_PTR(OBJ) OBJ->setName(#OBJ)

namespace Application
{

std::int32_t
exec()
{
    constinit static std::atomic<bool> stopFlag(false);
    auto signalHandler = [](int signal) { stopFlag.store(true); };

    std::signal(SIGINT, signalHandler);
    std::signal(SIGTERM, signalHandler);
    // std::signal(SIGHUP, signalHandler);

    std::thread t([]() {
        while(!stopFlag.load())
        {
            using namespace std::chrono_literals;
            std::this_thread::sleep_for(300ms);
        }
    });

    t.join();
    return 0;
}

}    // namespace Application
