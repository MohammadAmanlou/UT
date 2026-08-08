#ifndef I2C_MULTIPLEXER_H
#define I2C_MULTIPLEXER_H

#include <CPS4042/Hardwares/Comm/I2CMux.h>
#include <CPS4042/Hardwares/Sensors/VL530X.h>
#include <CPS4042/Sketchs/AbstractSketch.h>
#include <CPS4042/Utils/ByteStream.h>
#include <algorithm>

class I2CMultiplexer : public AbstractSketch<Comm::I2CMux>
{
public:
    explicit I2CMultiplexer(Comm::I2CMux* node) :
        AbstractSketch<Comm::I2CMux> {node}
    {}

    std::int32_t
    setup(Comm::I2CMux::Gpio& gpio) override
    {
        node()->usart().init(gpio);
        node()->i2c(0).init(Sensors::Vl530x::address);
        node()->i2c(1).init(Sensors::Vl530x::address);
        std::cout << "I2C MUX setup completed." << std::endl;
        return 0;
    }

    std::int32_t
    loop(Comm::I2CMux::Gpio& gpio) override
    {
        if(!m_waitingForSensor && node()->usart().isDataAvailable())
        {
            Byte command = node()->usart().read();
            std::uint8_t channel = static_cast<UByte>(command) % Comm::I2CMuxChannelCount;

            std::cout << "[I2C MUX] USART Read from Microcontroller channel command: "
                      << static_cast<int>(static_cast<UByte>(command))
                      << " -> selected channel " << static_cast<int>(channel)
                      << std::endl;

            m_activeChannel = channel;
            m_receivedBytes = 0;
            m_waitingForSensor = true;

            node()->selectChannel(m_activeChannel);
            node()->i2c(m_activeChannel).requestFrom(Sensors::Vl530x::address, 3);

            std::cout << "[I2C MUX] selected I2C channel "
                      << static_cast<int>(m_activeChannel) << std::endl;
        }

        if(m_waitingForSensor && node()->i2c(m_activeChannel).available())
        {
            Byte data = node()->i2c(m_activeChannel).read();
            node()->usart().write(data);
            m_receivedBytes++;

            std::cout << "[I2C MUX] USART Write to Microcontroller: "
                      << static_cast<int>(static_cast<UByte>(data))
                      << " from I2C channel " << static_cast<int>(m_activeChannel)
                      << std::endl;

            if(m_receivedBytes >= 3)
            {
                m_receivedBytes = 0;
                m_waitingForSensor = false;
            }
        }

        return 0;
    }

private:
    std::uint8_t m_activeChannel {0};
    std::uint8_t m_receivedBytes {0};
    bool m_waitingForSensor {false};
};

#endif    // I2C_MULTIPLEXER_H
