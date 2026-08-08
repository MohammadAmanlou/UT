#ifndef PROCESSOR_H
#define PROCESSOR_H

#include "CPS4042/Globals/Object.h"

#include <CPS4042/Protocols/Protocol.h>
#include <CPS4042/Units/Frequency.h>
#include <CPS4042/Units/Voltage.h>
#include <boost/assert.hpp>
#include <boost/pfr.hpp>
#include <boost/signals2.hpp>
#include <boost/type_traits.hpp>
#include <functional>
#include <thread>

class ProcessorBase : public Object
{
public:
    inline void
    stop()
    {
        m_isBusy.store(false);
    }

    inline constexpr void
    allocate(BitCount memory) const
    {
        m_usedMemoryCapacity += memory;
    }

    template <typename Gpio>
    inline void
    installProtocol(Protocols::AbstractProtocol<Gpio>* gpio)
    {
        m_protocols.push_back(gpio);
    }

protected:
    void
    setup(std::uint64_t bar, std::uint64_t btr)
    {
        m_baudRate = bar;
        m_bitRate  = btr;
    }

    template <typename Gpio>
    void
    driveGpio(Gpio& gpio, bool write, bool read)
    {
        boost::pfr::for_each_field(
          gpio,
          [&gpio, write, read](const auto& field, std::size_t idx) {
              try
              {
                  field.onNextPositiveEdgeCallback(write, read);
              }
              catch(...)
              {
                  std::cerr << "failed to drive pin " << idx
                            << " at processor pipeline." << std::endl;
              }
          });

        for(auto* protocol : m_protocols)
        {
            reinterpret_cast<Protocols::AbstractProtocol<Gpio>*>(protocol)->run(
              gpio);
        }
    }

protected:
    std::atomic<bool>     m_isBusy {false};
    std::uint64_t         m_baudRate;
    std::uint64_t         m_bitRate;
    std::vector<void*>    m_protocols;
    mutable std::uint64_t m_usedMemoryCapacity {0};

    friend class BoardBase;
};

template <typename Gpio>
class ProcessorInterm : public ProcessorBase
{
public:
    using Code                    = std::function<std::int32_t(Gpio&)>;
    virtual void exec(Gpio& gpio) = 0;

    inline void
    installLoopCode(Code&& code)
    {
        if(m_isBusy.load())
        {
            std::cerr << "installing loop code failed, processor is busy."
                      << std::endl;
            return;
        }

        m_loopCode = std::move(code);
    }

    inline void
    installLoopCode(Code& code)
    {
        if(m_isBusy.load())
        {
            std::cerr << "installing loop code failed, processor is busy."
                      << std::endl;
            return;
        }

        m_loopCode = code;
    }

    inline void
    installSetupCode(Code&& code)
    {
        if(m_isBusy.load())
        {
            std::cerr << "installing setup code failed, processor is busy."
                      << std::endl;
            return;
        }

        m_setupCode = std::move(code);
    }

    inline void
    installSetupCode(Code& code)
    {
        if(m_isBusy.load())
        {
            std::cerr << "installing setup code failed, processor is busy."
                      << std::endl;
            return;
        }

        m_setupCode = code;
    }

protected:
    Code m_loopCode;
    Code m_setupCode;
};

template <Frequency workingFrequency, typename WorkingVoltageTp, typename Gpio>
requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp> &&
         DvfsConsistencyCheckV<workingFrequency, WorkingVoltageTp>
class Processor : public ProcessorInterm<Gpio>
{
public:
    using Core                     = ProcessorInterm<Gpio>;
    constexpr explicit Processor() = default;

    // signals
    boost::signals2::signal<void(const Bit)> communicationClockChanged;

    inline static constexpr Frequency
    frequency()
    {
        return workingFrequency;
    }

    void
    exec(Gpio& gpio) override
    {
        if(ProcessorBase::m_isBusy.load()) return;

        ProcessorBase::m_isBusy.store(true);

        std::thread worker([this, &gpio]() {
            static std::uint64_t cycle = {};
            std::int32_t         exitCode {0};
            exitCode = Core::m_setupCode(gpio);

            while(ProcessorBase::m_isBusy.load())
            {
                nextCycleP(cycle, exitCode, gpio);
                handleClockEdge2(cycle);
                std::this_thread::sleep_for(frequencyToPeriod(frequency()));
            }

            cycle = 0;
        });

        worker.detach();
    }

    void
    nextCycle(Gpio& gpio)
    {
        std::int32_t exitCode {0};

        if(!m_drivenIsInitiated) exitCode = Core::m_setupCode(gpio);

        m_drivenIsInitiated = true;
        nextCycleP(m_drivenCycle, exitCode, gpio);
    }

private:
    inline void
    handleClockEdge(const std::uint64_t& cycle)
    {
        auto          oneSecond      = 1'000'000'000;
        auto          period         = frequencyToPeriod(frequency());
        std::uint64_t cyclePerSecond = (oneSecond / period.count());

        if(ProcessorBase::m_baudRate > cyclePerSecond)
        {
            throw std::runtime_error(
              "baudrate must be less tan or equal to frequency!");
        }

        std::uint64_t rate = cyclePerSecond / ProcessorBase::m_baudRate;

        if((cycle % rate) == 0)
        {
            handleClockEdge2(cycle);
        }
    }

    inline void
    nextCycleP(std::uint64_t& cycle, std::int32_t& exitCode, Gpio& gpio)
    {
        try
        {
            cycle++;

            if(exitCode != 0)
            {
                throw std::runtime_error(std::string("error code (") +
                                         std::to_string(exitCode) + ")");
            }

            if(!ProcessorBase::m_usedMemoryCapacity)
            {
                exitCode = Core::m_loopCode(gpio);
            }

            bool write = static_cast<bool>(ProcessorBase::m_usedMemoryCapacity);
            bool read  = !(cycle == 1 && frequency() != Frequency::Drived);

            auto before = ProcessorBase::m_usedMemoryCapacity;

            ProcessorBase::driveGpio(gpio, write, read);

            if(ProcessorBase::m_usedMemoryCapacity)
            {
                ProcessorBase::m_usedMemoryCapacity--;
            }
        }
        catch(const std::exception& e)
        {
            std::cerr << "an error accured on main loop excecution: "
                      << e.what() << std::endl;
        }
        catch(...)
        {
            std::cerr << "an error accured on main loop excecution: "
                         "unknown error"
                      << std::endl;
        }
    }

    inline void
    handleClockEdge2(const std::uint64_t& cycle)
    {
        if(m_clockEdge.load() == Bit::One)
            m_clockEdge.store(Bit::Zero);
        else
            m_clockEdge.store(Bit::One);

        communicationClockChanged(m_clockEdge.load());

        if(m_clockEdge.load() == Bit::One)
            m_clockEdge.store(Bit::Zero);
        else
            m_clockEdge.store(Bit::One);

        communicationClockChanged(m_clockEdge.load());
    }

    inline Bit
    communicationClock()
    {
        return m_clockEdge.load();
    }

private:
    std::atomic<Bit> m_clockEdge {Bit::Zero};
    bool             m_drivenIsInitiated {false};
    std::uint64_t    m_drivenCycle {};
};

#endif    // PROCESSOR_H
