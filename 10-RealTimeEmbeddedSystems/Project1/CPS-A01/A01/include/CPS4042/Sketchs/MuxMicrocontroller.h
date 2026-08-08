#ifndef MUX_MICROCONTROLLER_H
#define MUX_MICROCONTROLLER_H

#include <CPS4042/Hardwares/Boards/Esp8266.h>
#include <CPS4042/Hardwares/Comm/I2CMux.h>
#include <CPS4042/Sketchs/AbstractSketch.h>
#include <CPS4042/Utils/ByteStream.h>
#include <algorithm>

class MuxMicroController : public AbstractSketch<Boards::Esp8266>
{
public:
    explicit MuxMicroController(Boards::Esp8266* node) :
        AbstractSketch<Boards::Esp8266> {node}
    {}

    std::int32_t
    setup(Boards::Esp8266::Gpio& gpio) override
    {
        node()->usart().init(gpio);
        std::cout << "MuxMicroController setup completed." << std::endl;
        return 0;
    }

    std::int32_t
    loop(Boards::Esp8266::Gpio& gpio) override
    {
        m_cycleCount++;

        if(!m_waitingForResponse && m_cycleCount % 300 == 0)
        {
            m_activeChannel = m_nextChannel;
            m_nextChannel = (m_nextChannel + 1) % Comm::I2CMuxChannelCount;
            m_bytesReceived = 0;
            m_stream.clear();
            m_waitingForResponse = true;

            node()->usart().write(static_cast<Byte>(m_activeChannel));
            std::cout << "[Microcontroller] USART Write to MUX channel request: "
                      << static_cast<int>(m_activeChannel) << std::endl;
        }

        if(node()->usart().isDataAvailable())
        {
            Byte data = node()->usart().read();
            m_bytesReceived++;

            std::cout << "[Microcontroller] USART Read from MUX: "
                      << static_cast<int>(static_cast<UByte>(data))
                      << " (byte " << static_cast<int>(m_bytesReceived)
                      << "/3 for channel " << static_cast<int>(m_activeChannel)
                      << ")" << std::endl;

            if(m_bytesReceived <= 2)
            {
                m_stream << data;
            }
            else if(m_bytesReceived == 3)
            {
                Byte receivedChecksum = data;

                if(m_stream.isReady())
                {
                    std::uint16_t value = m_stream.take();
                    Byte byte0 = getByte<0>(value);
                    Byte byte1 = getByte<1>(value);
                    UByte ub0 = static_cast<UByte>(byte0);
                    UByte ub1 = static_cast<UByte>(byte1);
                    Byte expectedChecksum = static_cast<Byte>(std::max(ub0, ub1) - std::min(ub0, ub1));

                    if(receivedChecksum == expectedChecksum)
                    {
                        std::cout << "[Microcontroller] channel "
                                  << static_cast<int>(m_activeChannel)
                                  << " sensor value: " << value << std::endl;
                    }
                    else
                    {
                        std::cout << "[Microcontroller] checksum mismatch on channel "
                                  << static_cast<int>(m_activeChannel) << std::endl;
                    }
                }

                m_bytesReceived = 0;
                m_waitingForResponse = false;
            }
        }

        return 0;
    }

private:
    std::uint64_t m_cycleCount {0};
    std::uint8_t m_nextChannel {0};
    std::uint8_t m_activeChannel {0};
    std::uint8_t m_bytesReceived {0};
    bool m_waitingForResponse {false};
    ByteStream<std::uint16_t> m_stream;
};

#endif    // MUX_MICROCONTROLLER_H
