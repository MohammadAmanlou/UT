#ifndef VL53_X_H
#define VL53_X_H

#include <CPS4042/Hardwares/Comm/I2C.h>
#include <CPS4042/Hardwares/Board.h>
#include <CPS4042/Units/BaudRate.h>
#include <CPS4042/Wires/Pin.h>
#include <boost/pfr.hpp>
#include <iostream>

namespace Sensors
{
using Vl530xVoltage = VoltageLevel3_3v;

template <std::uint64_t bar, std::uint64_t btr, typename WorkingVoltageTp>
requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp>
struct Vl530xGpio
{
public:
    Pins::Vdd<WorkingVoltageTp> vdd {bar, btr, "Vl530x::vdd"};    // Pin 0
    Pins::Gnd<WorkingVoltageTp> gnd {bar, btr, "Vl530x::gnd"};    // Pin 1
    Pins::Sda<WorkingVoltageTp> sda {bar, btr, "Vl530x::sda"};    // Pin 2
    Pins::Scl<WorkingVoltageTp> scl {bar, btr, "Vl530x::scl"};    // Pin 3
};

class Vl530x : public Board<BaudRates::NotSpecified,
                            BitRates::same(BaudRates::NotSpecified),
                            Frequency::Drived, Vl530xVoltage, Vl530xGpio>
{
public:
    inline static constexpr Byte address = 0x29;

    explicit Vl530x() :
        Parent {"Vl530x::processor"}
    {
        m_processor->installProtocol(&m_i2c);

        std::cout << "one instance of Vl530x" << " created." << std::endl;
    }

    mutable Protocols::I2CSlave<Vl530x, Gpio> m_i2c {this};

    inline Protocols::I2CSlave<Vl530x, Gpio>&
    i2c() const
    {
        return m_i2c;
    }

protected:
    inline void
    startModule() override
    {
        m_gpio.scl.onNextEdge([this](Vl530xVoltage level) {
            auto bit = Voltage::toBit(level);

            if(bit == Bit::One)    // positive edge
            {
                m_processor->nextCycle(m_gpio);
            }
        });
    }
};

}    // namespace Sensors

#endif    // VL53_X_H
