#ifndef FREQUENCY_H
#define FREQUENCY_H

#include <CPS4042/Units/Bit.h>
#include <CPS4042/Units/Voltage.h>
#include <chrono>
#include <cstdint>

enum class Frequency : std::uint8_t
{
    Drived  = 0b00000000,
    F40khz  = 0b00000001,
    F80khz  = 0b00000010,
    F160khz = 0b00000100,
    F320khz = 0b00001000,
    F500khz = 0b11110001,
    F640khz = 0b11110011,
    F860khz = 0b11110111,
    F1mhz   = 0b11111111,
};

template <Frequency workingFrequency, typename WorkingVoltageTp>
requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp>
struct DvfsConsistencyCheck
{
private:
    static constexpr inline bool
    check()
    {
        if constexpr(workingFrequency == Frequency::Drived)
        {
            return true;
        }

        if constexpr(takeMsb<static_cast<std::uint8_t>(workingFrequency)>() ==
                     Bit::One)
        {
            return std::is_same_v<WorkingVoltageTp, VoltageLevel5v>;
        }

        return std::is_same_v<WorkingVoltageTp, VoltageLevel3_3v>;
    }

public:
    static inline constexpr bool value = DvfsConsistencyCheck::check();
};

template <Frequency workingFrequency, typename WorkingVoltageTp>
requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp>
inline constexpr bool DvfsConsistencyCheckV =
  DvfsConsistencyCheck<workingFrequency, WorkingVoltageTp>::value;

inline constexpr bool
isDvfsConsistence(Frequency f)
{
    auto bit = takeMsb(static_cast<std::uint8_t>(f));
    return bit == Bit::One;
}

std::chrono::nanoseconds
frequencyToPeriod(Frequency f)
{
    using namespace std::chrono_literals;
    switch(f)
    {
        case Frequency::F40khz :
            return 25'000ns;

        case Frequency::F80khz :
            return 12'500ns;

        case Frequency::F160khz :
            return 6'250ns;

        case Frequency::F320khz :
            return 3'125ns;

        case Frequency::F500khz :
            return 2'000ns;

        case Frequency::F640khz :
            return 1'563ns;

        case Frequency::F860khz :
            return 1'163ns;

        case Frequency::F1mhz :
            return 1'000ns;

        case Frequency::Drived :
            return 1ns;
            break;
    }

    return 1'000ns;
}

#endif    // FREQUENCY_H
