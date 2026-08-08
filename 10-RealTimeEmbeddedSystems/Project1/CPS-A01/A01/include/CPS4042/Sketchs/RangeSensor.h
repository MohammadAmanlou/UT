#ifndef RANGE_SENSOR_H
#define RANGE_SENSOR_H

#include <CPS4042/Hardwares/Sensors/VL530X.h>
#include <CPS4042/Sketchs/AbstractSketch.h>
#include <boost/random/mersenne_twister.hpp>
#include <boost/random/uniform_int_distribution.hpp>
#include <algorithm>

class RangeSensor : public AbstractSketch<Sensors::Vl530x>
{
public:
    RangeSensor(Sensors::Vl530x* node,
                Protocols::I2CBusLine* bus,
                std::uint16_t minValue,
                std::uint16_t maxValue,
                std::uint32_t seed,
                const std::string& label) :
        AbstractSketch<Sensors::Vl530x> {node},
        m_bus {bus},
        m_minValue {minValue},
        m_maxValue {maxValue},
        m_rng {seed},
        m_label {label}
    {}

    std::int32_t
    setup(Sensors::Vl530x::Gpio& gpio) override
    {
        node()->i2c().setBus(m_bus);
        node()->i2c().init(Sensors::Vl530x::address);
        std::cout << "[" << m_label << "] setup completed, range "
                  << m_minValue << ".." << m_maxValue << std::endl;
        return 0;
    }

    std::int32_t
    loop(Sensors::Vl530x::Gpio& gpio) override
    {
        if(!node()->i2c().hasDataToSend())
        {
            std::uint16_t sensorValue = generateData();
            Byte byte0 = getByte<0>(sensorValue);
            Byte byte1 = getByte<1>(sensorValue);

            UByte ub0 = static_cast<UByte>(byte0);
            UByte ub1 = static_cast<UByte>(byte1);
            Byte checksum = static_cast<Byte>(std::max(ub0, ub1) - std::min(ub0, ub1));

            node()->i2c().queueData(byte1);
            node()->i2c().queueData(byte0);
            node()->i2c().queueData(checksum);
        }
        return 0;
    }

private:
    std::uint16_t
    generateData()
    {
        boost::random::uniform_int_distribution<> dist(m_minValue, m_maxValue);
        return static_cast<std::uint16_t>(dist(m_rng));
    }

    Protocols::I2CBusLine* m_bus {nullptr};
    std::uint16_t m_minValue {0};
    std::uint16_t m_maxValue {0};
    boost::random::mt19937 m_rng;
    std::string m_label;
};

#endif    // RANGE_SENSOR_H
