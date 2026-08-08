#ifndef LINK_H
#define LINK_H

#include "CPS4042/Globals/Object.h"
#include "CPS4042/Units/BaudRate.h"
#include "CPS4042/Utils/Queue.h"

#include <CPS4042/Units/Byte.h>
#include <CPS4042/Units/Voltage.h>
#include <algorithm>
#include <atomic>
#include <boost/signals2.hpp>
#include <cstdint>
#include <iostream>
#include <limits>
#include <mutex>
#include <vector>

template <typename WorkingVoltageTp>
requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp>
class Transmitter;

class Link : public Object
{
public:
    using Signal = boost::signals2::signal<void(float)>;

    Link() :
        m_maxHeaders(2)
    {}

    virtual ~Link() = default;

    /// bits per second
    consteval std::uint64_t
    bandwidth() const
    {
        // ideal
        return 1'000'000'000;
    }

    /// nano seconds
    consteval std::uint8_t
    latency() const
    {
        // ideal
        return 1;
    }

    inline std::uint8_t
    maxHeaders() const
    {
        return m_maxHeaders;
    }

    /// related to the first attached transmitter
    inline BaudRate
    baudrate() const
    {
        return m_baudrate;
    }

    /// related to the first attached transmitter
    inline BitRate
    bitrate() const
    {
        return m_bitrate;
    }

    inline std::uint8_t
    headerCount() const
    {
        return m_headers.size();
    }

    inline bool
    isAttached() const
    {
        return m_headers.size();
    }

    Signal currentVoltageLevelChanged;

    inline bool
    async() const
    {
        return m_async;
    }

protected:
    inline float
    currentVoltageLevel(
      const std::string   &caller,
      std::source_location loc = std::source_location::current()) const
    {
        std::scoped_lock lock(m_queueMutex);
        if(!m_async.load()) return m_currentVoltageLevel.load();

        if(m_asyncQueue.size())
        {
            return m_asyncQueue.take();
        }

        return AbstractVoltageLevel::undefined;
    }

    inline void
    applyNoise()
    {
        /// noise must apply on current voltage level
        m_currentVoltageLevel = m_currentVoltageLevel * 1;
    }

    inline bool
    attachHeader(TransmitterBase *header)
    {
        if(!header)
        {
            std::cerr << "failed to add header, header is null" << std::endl;
            return false;
        }

        if(m_headers.size() >= m_maxHeaders)
        {
            std::cerr
              << "failed to add header, link is at the maximum header capacity."
              << "maximum header cpacity of link: " << m_maxHeaders
              << std::endl;

            return false;
        }

        if(std::find(m_headers.begin(), m_headers.end(), header) !=
           m_headers.end())
        {
            std::cout << "failed to add header, header is already attaced!"
                      << std::endl;
            return false;
        }

        std::cout << name() << ": header "
                  << reinterpret_cast<Object *>(header)->name()
                  << " attached to link successfully." << std::endl;

        m_headers.push_back(header);
        return true;
    }

    inline void
    setCurrentVoltageLevel(AbstractVoltageLevel *newCurrentVoltageLevel)
    {
        std::scoped_lock lock(m_queueMutex);
        m_currentVoltageLevel.store(newCurrentVoltageLevel->level());

        if(m_async.load())
        {
            m_asyncQueue.push(m_currentVoltageLevel.load());
        }

        // just for clock
        currentVoltageLevelChanged(m_currentVoltageLevel.load());
    }

    inline void
    setAsync(bool newAsync)
    {
        m_async = newAsync;
    }

    inline void
    setBitrate(std::uint64_t newBitrate)
    {
        m_bitrate = newBitrate;
    }

    inline void
    setBaudrate(std::uint64_t newBaudrate)
    {
        m_baudrate = newBaudrate;
    }

protected:
    std::uint8_t m_maxHeaders;

private:
    std::atomic<AbstractVoltageLevel::Level> m_currentVoltageLevel {0};
    std::uint64_t                            m_baudrate {0};
    std::uint64_t                            m_bitrate {0};
    std::vector<TransmitterBase *>           m_headers;

    std::atomic<bool>                        m_async {false};
    mutable Queue<float>                     m_asyncQueue {};
    mutable std::mutex                       m_queueMutex;

    friend class Transmitter<VoltageLevel5v>;
    friend class Transmitter<VoltageLevel3_3v>;
};

class Bus : public Link
{
public:
    Bus() { m_maxHeaders = std::numeric_limits<std::uint8_t>::max(); }
};



#endif    // LINK_H
