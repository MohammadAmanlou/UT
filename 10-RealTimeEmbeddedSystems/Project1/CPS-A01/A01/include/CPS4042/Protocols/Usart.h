#ifndef USART_H
#define USART_H

#include <queue>
#include <CPS4042/Protocols/Protocol.h>
#include <CPS4042/Wires/Pin.h>
#include <CPS4042/Units/Bit.h>
#include <CPS4042/Units/Byte.h>

namespace Protocols
{

    enum class ReceiveState
    {
        Idle,
        Data,
        Stop
    };

    enum class TransmitState
    {
        Idle,
        Start,
        Data,
        Stop
    };

    template <typename BoardType, typename Gpio>
    class Usart : public AbstractUsart<BoardType, Gpio>
    {
    public:
        explicit Usart(BoardType *board)
            : AbstractUsart<BoardType, Gpio>(board)
        {
        }

        void init(Gpio &gpio)
        {
            gpio.tx.setCanRead(false);
            gpio.rx.setCanRead(true);

            m_rxState = ReceiveState::Idle;
            m_txState = TransmitState::Idle;

            std::cout << "[USART] Initialized" << std::endl;
        }

        void run(Gpio &gpio) override
        {
            handleReceive(gpio);
            handleTransmit(gpio);
        }

        void write(Byte byte) override
        {
            m_txQueue.push(byte);
        }

        Byte read() override
        {
            if (this->m_buffer.empty())
                return 0;

            Byte data = this->m_buffer.front();
            this->m_buffer.pop();

            return data;
        }

    private:

        /*
        ====================================
        RX
        ====================================
        */

        ReceiveState m_rxState{ReceiveState::Idle};
        Byte m_rxByte{0};
        std::uint8_t m_rxBitIndex{0};

        void handleReceive(Gpio &gpio)
        {
            if (!gpio.rx.hasBitToRead())
                return;

            Bit bit = gpio.rx.readBit();

            switch (m_rxState)
            {
            case ReceiveState::Idle:

                if (bit == Bit::Zero)
                {
                    m_rxByte = 0;
                    m_rxBitIndex = 0;
                    m_rxState = ReceiveState::Data;
                }

                break;

            case ReceiveState::Data:

                m_rxByte |=
                    (static_cast<std::uint8_t>(bit)
                     << m_rxBitIndex);

                m_rxBitIndex++;

                if (m_rxBitIndex >= 8)
                {
                    m_rxState = ReceiveState::Stop;
                }

                break;

            case ReceiveState::Stop:

                if (bit == Bit::One)
                {
                    this->m_buffer.push(m_rxByte);
                }

                m_rxState = ReceiveState::Idle;

                break;
            }
        }


        /*
        ====================================
        TX
        ====================================
        */

        std::queue<Byte> m_txQueue;

        TransmitState m_txState
        {
            TransmitState::Idle
        };

        std::uint8_t m_txBitIndex{0};

        Byte m_txCurrentByte{0};

        void handleTransmit(Gpio &gpio)
        {
            switch (m_txState)
            {
            case TransmitState::Idle:

                // gpio.tx.write(Bit::One);

                if (!m_txQueue.empty())
                {
                    m_txCurrentByte =
                        m_txQueue.front();

                    m_txQueue.pop();

                    m_txBitIndex = 0;

                    m_txState =
                        TransmitState::Start;
                }

                break;


            case TransmitState::Start:

                gpio.tx.write(Bit::Zero);

                m_txState =
                    TransmitState::Data;

                break;


            case TransmitState::Data:

                gpio.tx.write(
                    takeNthBit(
                        m_txCurrentByte,
                        m_txBitIndex));

                m_txBitIndex++;

                if (m_txBitIndex >= 8)
                {
                    m_txState =
                        TransmitState::Stop;
                }

                break;


            case TransmitState::Stop:

                gpio.tx.write(Bit::One);

                m_txState =
                    TransmitState::Idle;

                break;
            }
        }
    };

} // namespace Protocols

#endif // USART_H