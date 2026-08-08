#ifndef SENSOR_H
#define SENSOR_H

#include <CPS4042/Hardwares/Comm/I2C.h>
#include <CPS4042/Hardwares/Sensors/VL530X.h>
#include <CPS4042/Sketchs/AbstractSketch.h>
#include <boost/random/mersenne_twister.hpp>
#include <boost/random/uniform_int_distribution.hpp>

class Sensor : public AbstractSketch<Sensors::Vl530x>
{
public:
    explicit Sensor(Sensors::Vl530x* node) :
        AbstractSketch<Sensors::Vl530x> {node}
    {}

    std::int32_t
    setup(Sensors::Vl530x::Gpio& gpio) override
    {
        node()->i2c().init(Sensors::Vl530x::address);
        std::cout << "vl530x setup completed." << std::endl;
        return 0;
    }

    std::int32_t
    loop(Sensors::Vl530x::Gpio& gpio) override
    {
        if(!node()->i2c().hasDataToSend())
        {
            std::uint16_t sensorValue = generateData();
            Byte byte0 = getByte<0>(sensorValue);  // LSB
            Byte byte1 = getByte<1>(sensorValue);  // MSB

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
        boost::random::uniform_int_distribution<> dist(0, 4000);
        return static_cast<std::uint16_t>(dist(m_rng));
    }

    boost::random::mt19937 m_rng {42};
};

#endif // SENSOR_H
