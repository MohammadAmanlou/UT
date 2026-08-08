#ifndef USART_MICROCONTROLLER_H
#define USART_MICROCONTROLLER_H

#include <CPS4042/Hardwares/Boards/Esp8266.h>
#include <CPS4042/Sketchs/AbstractSketch.h>
#include <CPS4042/Units/Byte.h>
#include <cstdint>
#include <iostream>

class UsartMicroController : public AbstractSketch<Boards::Esp8266>
{
public:
    explicit UsartMicroController(Boards::Esp8266 *node)
        : AbstractSketch<Boards::Esp8266>{node}
    {
    }

    std::int32_t
    setup(Boards::Esp8266::Gpio &gpio) override
    {
        node()->usart().init(gpio);
        std::cout << "UsartMicroController setup completed." << std::endl;
        return 0;
    }

    std::int32_t
    loop(Boards::Esp8266::Gpio &gpio) override
    {
        (void)gpio;

        m_cycleCount++;

        writeAddressToUsb();
        readDataFromUsb();

        return 0;
    }

private:
    void
    writeAddressToUsb()
    {
        if(m_cycleCount % 200 == 0 && m_nextAddress < m_addressLimit)
        {
            Byte address = static_cast<Byte>(m_nextAddress);

            node()->usart().write(address);

            std::cout << "[UsartMicroController] USART Write to USB address: "
                      << static_cast<int>(static_cast<UByte>(address))
                      << std::endl;

            m_nextAddress++;
        }
    }

    void
    readDataFromUsb()
    {
        if(node()->usart().isDataAvailable())
        {
            Byte data = node()->usart().read();

            std::cout << "[UsartMicroController] USART Read from USB data: "
                      << static_cast<int>(static_cast<UByte>(data))
                      << std::endl;
        }
    }

private:
    std::uint64_t m_cycleCount {0};
    std::uint8_t  m_nextAddress {0};
    std::uint8_t  m_addressLimit {10};
};

#endif // USART_MICROCONTROLLER_H