#ifndef Transmitter_H
#define Transmitter_H

#include "CPS4042/Globals/Object.h"
#include "CPS4042/Units/BaudRate.h"

#include <CPS4042/Units/Bit.h>
#include <CPS4042/Utils/Queue.h>
#include <CPS4042/Wires/Link.h>
#include <memory>
#include <mutex>

class TransmitterBase : public Object
{};

template <typename WorkingVoltageTp>
requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp>
class Transmitter : public TransmitterBase
{
public:
    using Signal = boost::signals2::signal<void(WorkingVoltageTp)>;

    Transmitter(BaudRate baudRate, BitRate bitRate) :
        m_baudrate(baudRate), m_bitrate(bitRate)
    {}

    virtual ~Transmitter() = default;

    inline std::uint64_t
    baudrate() const
    {
        return m_baudrate;
    }

    inline std::uint64_t
    bitrate() const
    {
        return m_bitrate;
    }

    bool
    attachLink(std::shared_ptr<Link> link)
    {
        if(!link)
        {
            std::cerr << "failed to attach link. link is null." << std::endl;
            return false;
        }

        if(link->isAttached())
        {
            if(baudrate() != BaudRates::NotSpecified &&
               link->baudrate() != baudrate())
            {
                std::cerr << "failed to attach link. inconsistent baudrates "
                          << baudrate() << " != " << link->baudrate()
                          << std::endl;
                return false;
            }

            if(baudrate() != BaudRates::NotSpecified &&
               link->bitrate() != bitrate())
            {
                std::cerr << "failed to attach link. inconsistent bitrates "
                          << bitrate() << " != " << link->bitrate()
                          << std::endl;
                return false;
            }
        }

        if(!link->attachHeader(this))
        {
            return false;
        }

        if(baudrate() != BaudRates::NotSpecified)
        {
            link->setBaudrate(baudrate());
            link->setBitrate(bitrate());
        }

        if(m_async) link->setAsync(true);

        setAttachedLink(link);

        m_attachedLink->currentVoltageLevelChanged.connect([this](float vol) {
            auto level = WorkingVoltageTp(vol);
            linkVoltageLevelChanged(level);
        });

        std::cout << name() << ": " << link->name() << " attached successfully"
                  << std::endl;

        return true;
    }

    inline bool
    async() const
    {
        return m_async;
    }

    inline void
    setAsync(bool newAsync)
    {
        m_async = newAsync;
    }

    inline bool
    canRead() const
    {
        return m_canRead;
    }

    inline void
    setCanRead(bool newCanRead)
    {
        m_canRead = newCanRead;
    }

protected:
    Signal linkVoltageLevelChanged;

    /// this method will call on every cpu cycle!
    virtual void
    onNextPositiveEdgeCallback(bool write, bool read) const
    {
        if(!m_attachedLink) return;

        // Unused!
        (void)(write);

        if(m_sendingBuffer.size())
            writeOnLink();
        else
        {
            if(read && canRead()) readFromLink();
        }
    }

    inline void
    writeOnLink() const
    {
        std::scoped_lock lock(m_writeMutex);

        if(!m_attachedLink) return;

        if(m_sendingBuffer.empty())
        {
            auto vl = Voltage::fromBit<WorkingVoltageTp>(Bit::Z);
            m_attachedLink->setCurrentVoltageLevel(&vl);
            return;
        }

        if(bitrate() == baudrate())
        {
            Bit  bit = m_sendingBuffer.take();
            auto vl  = Voltage::fromBit<WorkingVoltageTp>(bit);
            m_attachedLink->setCurrentVoltageLevel(&vl);
        }
        else
        {
            // we only support sending bytes!
            Byte byte = m_sendingBuffer.takeRest();
            auto vl   = Voltage::fromByte<WorkingVoltageTp>(byte);
            m_attachedLink->setCurrentVoltageLevel(&vl);
        }
    }

    inline void
    readFromLink() const
    {
        std::scoped_lock lock(m_readMutex);

        auto             level =
          WorkingVoltageTp(m_attachedLink->currentVoltageLevel(name()));

        if(bitrate() == baudrate())
        {
            auto bit = Voltage::toBit(level);

            if(bit == Bit::Z) return;
            m_receivingBuffer.push(bit);
        }
        else
        {
            auto byte = Voltage::toByte(level);
            m_receivingBuffer.push(byte);
        }
    }

    inline void
    setAttachedLink(std::shared_ptr<Link> link)
    {
        m_attachedLink = link;
    }

    inline void
    write(const Bit bit)
    {
        std::scoped_lock lock(m_writeMutex);
        m_sendingBuffer.push(bit);
    }

    inline void
    write(const Byte byte)
    {
        std::scoped_lock lock(m_writeMutex);
        m_sendingBuffer.push(byte);
    }

    inline void
    write(const std::vector<Byte>& bytes)
    {
        std::scoped_lock lock(m_writeMutex);
        for(auto& byte : bytes)
        {
            m_sendingBuffer.push(byte);
        }
    }

    inline ByteCount
    hasByteToRead() const
    {
        std::scoped_lock lock(m_readMutex);
        return m_receivingBuffer.hasByte();
    }

    inline BitCount
    hasBitToRead() const
    {
        std::scoped_lock lock(m_readMutex);
        return m_receivingBuffer.size();
    }

    inline ByteCount
    hasByteToWrite() const
    {
        std::scoped_lock lock(m_writeMutex);
        return m_sendingBuffer.hasByte();
    }

    inline BitCount
    hasBitToWrite() const
    {
        std::scoped_lock lock(m_writeMutex);
        return m_sendingBuffer.size();
    }

    inline Byte
    read()
    {
        std::scoped_lock lock(m_readMutex);
        auto             first = m_receivingBuffer.takeRest();
        first                  = reverse(first);
        return first;
    }

    inline Bit
    readBit()
    {
        std::scoped_lock lock(m_readMutex);
        return m_receivingBuffer.take();
    }

    inline std::vector<Byte>
    readAll()
    {
        std::scoped_lock  lock(m_readMutex);
        std::vector<Byte> result;

        while(m_receivingBuffer.hasByte())
        {
            result.push_back(m_receivingBuffer.takeRest());
        }

        return result;
    }

private:
    const std::uint64_t           m_baudrate {0};
    const std::uint64_t           m_bitrate {0};
    mutable std::mutex            m_writeMutex;
    mutable std::mutex            m_readMutex;
    mutable BitQueue              m_sendingBuffer {};
    mutable BitQueue              m_receivingBuffer {};
    mutable std::shared_ptr<Link> m_attachedLink {nullptr};
    bool                          m_async {false};
    bool                          m_canRead {true};

    friend class ProcessorBase;
};


#endif    // Transmitter_H
