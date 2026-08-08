#ifndef I2C_H
#define I2C_H

#include <CPS4042/Protocols/Protocol.h>
#include <CPS4042/Units/Bit.h>
#include <CPS4042/Units/Byte.h>
#include <iostream>
#include <mutex>
#include <queue>

namespace Protocols
{

struct I2CBusLine
{
    std::mutex mtx;
    bool       transactionActive {false};
    Byte       addressByte {0};
    bool       readMode {false};
    bool       addressReady {false};
    bool       ackReady {false};
    bool       ackValue {false};
    bool       dataReady {false};
    Byte       dataByte {0};
    bool       dataConsumed {false};
    bool       masterDone {false};
};

inline I2CBusLine&
getI2CBus()
{
    static I2CBusLine bus;
    return bus;
}

enum class MasterState : std::uint8_t
{
    Idle,
    SendAddress,
    WaitAck,
    ReadData,
    WriteData,
    Done
};

enum class SlaveState : std::uint8_t
{
    Idle,
    WaitAddress,
    SendAck,
    SendData,
    RecvData
};

template <typename BoardType, typename Gpio>
class I2CMaster : public AbstractI2C<BoardType, Gpio>
{
    using BoardPtr = std::remove_pointer_t<boost::remove_cv_ref_t<BoardType>>*;
    using Base     = AbstractI2C<BoardType, Gpio>;

public:
    explicit I2CMaster(BoardPtr board) :
        Base {board}
    {}

    void
    setBus(I2CBusLine* bus)
    {
        if(bus) m_bus = bus;
    }

    void
    init(Byte address) override
    {
        m_targetAddress = address;
        Base::m_started = true;
        m_state         = MasterState::Idle;
        std::cout << "[I2C Master] Initialized – target 0x" << std::hex
                  << (int)(UByte)address << std::dec << std::endl;
    }

    void
    requestFrom(Byte address, std::uint8_t numBytes)
    {
        m_targetAddress = address;
        m_readMode      = true;
        m_bytesToRead   = numBytes;
        m_bytesRead     = 0;
        m_state         = MasterState::SendAddress;
        m_addressByte   = static_cast<Byte>((address << 1) | 0x01);
        Base::m_started = true;
    }

    void
    beginTransmission(Byte address)
    {
        m_targetAddress = address;
        m_readMode      = false;
        m_state         = MasterState::SendAddress;
        m_addressByte   = static_cast<Byte>((address << 1) & 0xFE);
        Base::m_started = true;
    }

    void
    endTransmission()
    {
        m_state = MasterState::Done;
    }

    void
    write(Byte byte) override
    {
        m_txQueue.push(byte);
    }

    Byte
    read() override
    {
        if(Base::m_buffer.empty()) return 0;
        Byte val = Base::m_buffer.front();
        Base::m_buffer.pop();
        return val;
    }

    bool
    available() const
    {
        return !Base::m_buffer.empty();
    }

    bool
    hasDataToSend() const
    {
        return !m_txQueue.empty();
    }

    void
    run(Gpio& gpio) override
    {
        if(!Base::m_started) return;

        auto& bus = *m_bus;

        switch(m_state)
        {
            case MasterState::Idle:
                break;

            case MasterState::SendAddress:
            {
                std::scoped_lock lk(bus.mtx);
                bus.transactionActive = true;
                bus.addressByte       = m_addressByte;
                bus.readMode          = m_readMode;
                bus.addressReady      = true;
                bus.ackReady          = false;
                bus.dataReady         = false;
                bus.dataConsumed      = false;
                bus.masterDone        = false;

                for(std::uint8_t i = 0; i < 8; i++)
                {
                    Bit bit = takeNthBit(m_addressByte, 7 - i);
                    gpio.sda.write(bit);
                }

                std::cout << "[I2C Master] Address byte 0x" << std::hex
                          << (int)(UByte)m_addressByte << std::dec
                          << (m_readMode ? " (READ)" : " (WRITE)")
                          << " sent on SDA" << std::endl;

                m_state   = MasterState::WaitAck;
                m_waitCnt = 0;
                break;
            }

            case MasterState::WaitAck:
            {
                std::scoped_lock lk(bus.mtx);
                if(bus.ackReady)
                {
                    bool ack     = bus.ackValue;
                    bus.ackReady = false;
                    if(ack)
                    {
                        std::cout << "[I2C Master] ACK received" << std::endl;
                        if(m_readMode)
                            m_state = MasterState::ReadData;
                        else
                        {
                            if(!m_txQueue.empty())
                                m_state = MasterState::WriteData;
                            else
                                m_state = MasterState::Done;
                        }
                    }
                    else
                    {
                        std::cout << "[I2C Master] NACK – address not recognized"
                                  << std::endl;
                        m_state = MasterState::Done;
                    }
                }
                else
                {
                    m_waitCnt++;
                    if(m_waitCnt > 2000)
                    {
                        std::cout << "[I2C Master] ACK timeout" << std::endl;
                        m_state = MasterState::Done;
                    }
                }
                break;
            }

            case MasterState::ReadData:
            {
                std::scoped_lock lk(bus.mtx);
                if(bus.dataReady)
                {
                    Byte val         = bus.dataByte;
                    bus.dataReady    = false;
                    bus.dataConsumed = true;
                    Base::m_buffer.push(val);
                    m_bytesRead++;

                    std::cout << "[I2C Master] Read data byte: "
                              << (int)(UByte)val << std::endl;

                    if(m_bytesRead >= m_bytesToRead)
                    {
                        bus.masterDone = true;
                        m_state        = MasterState::Done;
                    }
                }
                break;
            }

            case MasterState::WriteData:
            {
                std::scoped_lock lk(bus.mtx);
                if(!bus.dataReady)
                {
                    if(!m_txQueue.empty())
                    {
                        Byte val         = m_txQueue.front();
                        m_txQueue.pop();
                        bus.dataByte     = val;
                        bus.dataReady    = true;
                        bus.dataConsumed = false;

                        for(std::uint8_t i = 0; i < 8; i++)
                        {
                            Bit bit = takeNthBit(val, 7 - i);
                            gpio.sda.write(bit);
                        }

                        std::cout << "[I2C Master] Write data byte: "
                                  << (int)(UByte)val << std::endl;
                    }
                    else
                    {
                        bus.masterDone = true;
                        m_state        = MasterState::Done;
                    }
                }
                break;
            }

            case MasterState::Done:
            {
                std::scoped_lock lk(bus.mtx);
                bus.transactionActive = false;
                bus.masterDone        = true;
                m_state               = MasterState::Idle;
                break;
            }
        }
    }

private:
    Byte             m_targetAddress {0};
    Byte             m_addressByte {0};
    bool             m_readMode {false};
    MasterState      m_state {MasterState::Idle};
    std::uint8_t     m_bytesToRead {0};
    std::uint8_t     m_bytesRead {0};
    std::uint32_t    m_waitCnt {0};
    std::queue<Byte> m_txQueue;
    I2CBusLine*      m_bus {&getI2CBus()};
};

template <typename BoardType, typename Gpio>
class I2CSlave : public AbstractI2C<BoardType, Gpio>
{
    using BoardPtr = std::remove_pointer_t<boost::remove_cv_ref_t<BoardType>>*;
    using Base     = AbstractI2C<BoardType, Gpio>;

public:
    explicit I2CSlave(BoardPtr board) :
        Base {board}
    {}

    void
    setBus(I2CBusLine* bus)
    {
        if(bus) m_bus = bus;
    }

    void
    init(Byte address) override
    {
        m_ownAddress    = address;
        Base::m_started = true;
        m_state         = SlaveState::WaitAddress;
        std::cout << "[I2C Slave] Initialized – own address 0x" << std::hex
                  << (int)(UByte)address << std::dec << std::endl;
    }

    void
    write(Byte byte) override
    {
        m_txQueue.push(byte);
    }

    void
    queueData(Byte byte)
    {
        m_txQueue.push(byte);
    }

    Byte
    read() override
    {
        if(Base::m_buffer.empty()) return 0;
        Byte val = Base::m_buffer.front();
        Base::m_buffer.pop();
        return val;
    }

    bool
    available() const
    {
        return !Base::m_buffer.empty();
    }

    bool
    hasDataToSend() const
    {
        return !m_txQueue.empty();
    }

    void
    run(Gpio& gpio) override
    {
        if(!Base::m_started) return;

        auto& bus = *m_bus;

        switch(m_state)
        {
            case SlaveState::Idle:
                break;

            case SlaveState::WaitAddress:
            {
                std::scoped_lock lk(bus.mtx);
                if(bus.addressReady)
                {
                    Byte addr    = (bus.addressByte >> 1) & 0x7F;
                    bool readBit = (bus.addressByte & 0x01) != 0;

                    std::cout << "[I2C Slave] Address 0x" << std::hex
                              << (int)(UByte)addr << std::dec
                              << (readBit ? " R" : " W") << " received"
                              << std::endl;

                    bus.addressReady = false;
                    m_addressMatch   = (addr == m_ownAddress);
                    m_readRequested  = readBit;
                    m_state          = SlaveState::SendAck;
                }
                break;
            }

            case SlaveState::SendAck:
            {
                std::scoped_lock lk(bus.mtx);
                bus.ackValue = m_addressMatch;
                bus.ackReady = true;

                if(m_addressMatch)
                {
                    gpio.sda.write(Bit::Zero);
                    std::cout << "[I2C Slave] ACK sent" << std::endl;

                    if(m_readRequested)
                        m_state = SlaveState::SendData;
                    else
                        m_state = SlaveState::RecvData;
                }
                else
                {
                    gpio.sda.write(Bit::One);
                    std::cout << "[I2C Slave] NACK – address mismatch"
                              << std::endl;
                    m_state = SlaveState::WaitAddress;
                }
                break;
            }

            case SlaveState::SendData:
            {
                std::scoped_lock lk(bus.mtx);
                if(bus.masterDone)
                {
                    m_state = SlaveState::WaitAddress;
                    break;
                }
                if(!bus.dataReady)
                {
                    if(!m_txQueue.empty())
                    {
                        Byte val         = m_txQueue.front();
                        m_txQueue.pop();
                        bus.dataByte     = val;
                        bus.dataReady    = true;
                        bus.dataConsumed = false;

                        for(std::uint8_t i = 0; i < 8; i++)
                        {
                            Bit bit = takeNthBit(val, 7 - i);
                            gpio.sda.write(bit);
                        }

                        std::cout << "[I2C Slave] Data byte "
                                  << (int)(UByte)val << " sent" << std::endl;
                    }
                    else
                    {
                        m_state = SlaveState::WaitAddress;
                    }
                }
                break;
            }

            case SlaveState::RecvData:
            {
                std::scoped_lock lk(bus.mtx);
                if(bus.masterDone)
                {
                    m_state = SlaveState::WaitAddress;
                    break;
                }
                if(bus.dataReady)
                {
                    Byte val         = bus.dataByte;
                    bus.dataReady    = false;
                    bus.dataConsumed = true;
                    Base::m_buffer.push(val);

                    std::cout << "[I2C Slave] Received data byte: "
                              << (int)(UByte)val << std::endl;
                }
                break;
            }
        }
    }

private:
    Byte             m_ownAddress {0};
    bool             m_readRequested {false};
    bool             m_addressMatch {false};
    SlaveState       m_state {SlaveState::Idle};
    std::queue<Byte> m_txQueue;
    I2CBusLine*      m_bus {&getI2CBus()};
};

}    // namespace Protocols

#endif    // I2C_H
