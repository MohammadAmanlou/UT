#ifndef MICROCONTROLLER_H
#define MICROCONTROLLER_H

#include <CPS4042/Hardwares/Comm/I2C.h>
#include <CPS4042/Hardwares/Boards/Esp8266.h>
#include <CPS4042/Sketchs/AbstractSketch.h>
#include <CPS4042/Utils/ByteStream.h>
#include <CPS4042/Utils/Wave.h>
#include <bitset>

class MicroController : public AbstractSketch<Boards::Esp8266>
{
public:
    explicit MicroController(Boards::Esp8266 *node) : AbstractSketch<Boards::Esp8266>{node}
    {
    }

    std::int32_t
    setup(Boards::Esp8266::Gpio &gpio) override
    {
        node()->i2c().init(0x29);
        node()->usart().init(gpio);
        std::cout << "esp8266 setup completed." << std::endl;
        return 0;
    }

    std::int32_t
    loop(Boards::Esp8266::Gpio &gpio) override
    {
        m_cycleCount++;

        handle_i2c();
        handle_usart();

        return 0;
    }

private:
    void handle_i2c()
    {
        if (m_cycleCount % 200 == 0 && m_cycleCount < limit_usart * 200)
        {
            node()->i2c().requestFrom(0x29, 3);
            m_bytesReceived = 0;
            m_distanceStream.clear();
        }

        if (node()->i2c().available())
        {
            Byte data = node()->i2c().read();
            m_bytesReceived++;

            if (m_bytesReceived <= 2)
            {
                m_distanceStream << data;
            }
            else if (m_bytesReceived == 3)
            {
                Byte receivedChecksum = data;

                if (m_distanceStream.isReady())
                {
                    std::uint16_t distance = m_distanceStream.take();

                    Byte byte0 = getByte<0>(distance);
                    Byte byte1 = getByte<1>(distance);
                    UByte ub0 = static_cast<UByte>(byte0);
                    UByte ub1 = static_cast<UByte>(byte1);
                    Byte expectedChecksum = static_cast<Byte>(
                        std::max(ub0, ub1) - std::min(ub0, ub1));

                    if (receivedChecksum == expectedChecksum)
                    {
                        std::cout << "[Microcontroller] new distance: "
                                  << distance << std::endl;
                    }
                    else
                    {
                        std::cout << "[Microcontroller] checksum mismatch, "
                                  << "data discarded" << std::endl;
                    }
                }

                m_bytesReceived = 0;
            }
        }
    }
    void handle_usart()
    {
        if (m_cycleCount % 200 == 0 && addrs < limit_usart)
        {
            node()->usart().write(addrs);
            std::cout << "[Microcontroller] USART Write to USB: "
                      << (int)(UByte)addrs << std::endl;
            addrs++;
        }

        if (node()->usart().isDataAvailable())
        {
            Byte data = node()->usart().read();
            std::cout << "[Microcontroller] USART Read from USB: "
                      << (int)(UByte)data << std::endl;
        }
    }
    std::uint64_t m_cycleCount{0};
    ByteStream<std::uint16_t> m_distanceStream;
    std::uint8_t m_bytesReceived{0};
    std::uint8_t addrs{0};
    std::uint64_t limit_usart{10};
};

#endif // MICROCONTROLLER_H
