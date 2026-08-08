#ifndef PIN_H
#define PIN_H

#include <CPS4042/Hardwares/Processor.h>
#include <CPS4042/Hardwares/Transmitter.h>
#include <cstdint>
#include <vector>

namespace PinUtils
{
enum class Mode : std::uint8_t
{
    Data  = 0xF0,
    Clock = 0x00,
    Vdd   = 0x01,
    Gnd   = 0b00000011
};

template <Mode m>
constexpr bool
isTwoWay()
{
    auto msByte = static_cast<std::uint8_t>(m) >> 4;
    return msByte == 0x0F;
}

bool
isTwoWay(Mode m)
{
    auto msByte = static_cast<std::uint8_t>(m) >> 4;
    return msByte == 0x0F;
}

enum class Type
{
    Analog,
    Digital
};
}    // namespace PinUtils

class PinBase : public Object
{
public:
    explicit PinBase(const std::string& name) { setName(name); }

    void
    setProcessor(ProcessorBase* p) const
    {
        m_processor = p;
    }

protected:
    mutable ProcessorBase* m_processor;
};

template <PinUtils::Mode m, PinUtils::Type t, typename WorkingVoltageTp>
requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp>
class PinHelper
{
public:
    constexpr PinUtils::Mode
    mode() const
    {
        return m;
    }

    constexpr PinUtils::Type
    type() const
    {
        return t;
    }
};

template <PinUtils::Mode m, PinUtils::Type t, typename WorkingVoltageTp,
          bool async>
requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp>
class Pin;

template <PinUtils::Type t, typename WorkingVoltageTp>
requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp>
class Pin<PinUtils::Mode::Vdd, t, WorkingVoltageTp, false>
    : public PinBase,
      public Transmitter<WorkingVoltageTp>,
      public PinHelper<PinUtils::Mode::Vdd, t, WorkingVoltageTp>

{
public:
    using _Trans = Transmitter<WorkingVoltageTp>;

    constexpr Pin(std::uint64_t baudRate, std::uint64_t bitRate,
                  const std::string& name) :
        PinBase {name},
        Transmitter<WorkingVoltageTp> {baudRate, bitRate},
        PinHelper<PinUtils::Mode::Vdd, t, WorkingVoltageTp> {}
    {
        TransmitterBase::setName(name);
        _Trans::write(Bit::One);
    }

    void
    onNextPositiveEdgeCallback(bool write, bool read) const override
    {
        return;
    }
};

template <PinUtils::Type t, typename WorkingVoltageTp>
requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp>
class Pin<PinUtils::Mode::Gnd, t, WorkingVoltageTp, false>
    : public PinBase,
      public Transmitter<WorkingVoltageTp>,
      public PinHelper<PinUtils::Mode::Gnd, t, WorkingVoltageTp>

{
public:
    using _Trans = Transmitter<WorkingVoltageTp>;

    constexpr Pin(std::uint64_t baudRate, std::uint64_t bitRate,
                  const std::string& name) :
        PinBase {name},
        Transmitter<WorkingVoltageTp> {baudRate, bitRate},
        PinHelper<PinUtils::Mode::Gnd, t, WorkingVoltageTp> {}
    {
        TransmitterBase::setName(name);
        _Trans::write(Bit::Zero);
    }

    void
    onNextPositiveEdgeCallback(bool write, bool read) const override
    {
        return;
    }
};

template <PinUtils::Type t, typename WorkingVoltageTp>
requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp>
class Pin<PinUtils::Mode::Clock, t, WorkingVoltageTp, false>
    : public PinBase,
      public Transmitter<WorkingVoltageTp>,
      public PinHelper<PinUtils::Mode::Clock, t, WorkingVoltageTp>
{
public:
    using _Trans = Transmitter<WorkingVoltageTp>;

    constexpr Pin(std::uint64_t baudRate, std::uint64_t bitRate,
                  const std::string& name) :
        PinBase {name},
        Transmitter<WorkingVoltageTp> {baudRate, bitRate},
        PinHelper<PinUtils::Mode::Clock, t, WorkingVoltageTp> {}
    {
        TransmitterBase::setName(name);
    }

    void
    onNextPositiveEdgeCallback(bool write, bool read) const override
    {
        return;
    }

    void
    nextEdge(Bit bit)
    {
        _Trans::write(bit);
        _Trans::writeOnLink();
    }

    void
    onNextEdge(std::function<void(WorkingVoltageTp)> slot)
    {
        typename _Trans::Signal& sig = _Trans::linkVoltageLevelChanged;
        sig.connect(slot);
    }
};

template <PinUtils::Type t, typename WorkingVoltageTp, bool async>
requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp>
class Pin<PinUtils::Mode::Data, t, WorkingVoltageTp, async>
    : public PinBase,
      public Transmitter<WorkingVoltageTp>,
      public PinHelper<PinUtils::Mode::Data, t, WorkingVoltageTp>
{
    using _Trans = Transmitter<WorkingVoltageTp>;

public:
    constexpr Pin(std::uint64_t baudRate, std::uint64_t bitRate,
                  const std::string& name) :
        PinBase {name},
        Transmitter<WorkingVoltageTp> {baudRate, bitRate},
        PinHelper<PinUtils::Mode::Data, t, WorkingVoltageTp> {}
    {
        TransmitterBase::setName(name);
        _Trans::setAsync(async);
    }

    virtual ~Pin() = default;

    inline void
    write(const Bit bit)
    {
        BOOST_ASSERT_MSG(PinBase::m_processor,
                         "please invoke connectPinsToProcessor "
                         "inside board constructor.");

        PinBase::m_processor->allocate(bitWidth<Bit>());
        _Trans::write(bit);
    }

    inline void
    write(const Byte byte)
    {
        BOOST_ASSERT_MSG(PinBase::m_processor,
                         "please invoke connectPinsToProcessor "
                         "inside board constructor.");

        PinBase::m_processor->allocate(bitWidth<Byte>());
        _Trans::write(byte);
    }

    inline void
    write(const std::vector<Byte>& bytes)
    {
        BOOST_ASSERT_MSG(PinBase::m_processor,
                         "please invoke connectPinsToProcessor "
                         "inside board constructor.");

        PinBase::m_processor->allocate(bitWidth<Byte>() * bytes.size());
        _Trans::write(bytes);
    }

    inline ByteCount
    hasByteToRead() const
    {
        return _Trans::hasByteToRead();
    }

    inline BitCount
    hasBitToRead() const
    {
        return _Trans::hasBitToRead();
    }

    inline ByteCount
    hasByteToWrite() const
    {
        return _Trans::hasByteToWrite();
    }

    inline BitCount
    hasBitToWrite() const
    {
        return _Trans::hasBitToWrite();
    }

    inline Byte
    read()
    {
        return _Trans::read();
    }

    inline Bit
    readBit()
    {
        return _Trans::readBit();
    }

    inline std::vector<Byte>
    readAll()
    {
        return _Trans::readAll();
    }
};

// clang-format off
namespace Pins
{

template <typename WorkingVoltageTp, bool async>
requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp>
using Digital__   = Pin<PinUtils::Mode::Data, PinUtils::Type::Digital, WorkingVoltageTp, async>;

template <typename WorkingVoltageTp>
requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp>
using Digital   = Digital__<WorkingVoltageTp, false>;

template <typename WorkingVoltageTp>
requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp>
using Analog    = Pin<PinUtils::Mode::Data, PinUtils::Type::Analog, WorkingVoltageTp, false>;

template <typename WorkingVoltageTp>
requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp>
using Vdd       = Pin<PinUtils::Mode::Vdd, PinUtils::Type::Analog, WorkingVoltageTp, false>;

template <typename WorkingVoltageTp>
requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp>
using Gnd       = Pin<PinUtils::Mode::Gnd, PinUtils::Type::Analog, WorkingVoltageTp, false>;

template <typename WorkingVoltageTp>
requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp>
using Scl       = Pin<PinUtils::Mode::Clock, PinUtils::Type::Digital, WorkingVoltageTp, false>;

template <typename WorkingVoltageTp>
requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp>
using Sda       = Digital__<WorkingVoltageTp, false>;

template <typename WorkingVoltageTp>
requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp>
using Rx       = Digital__<WorkingVoltageTp, true>;

template <typename WorkingVoltageTp>
requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp>
using Tx       = Digital__<WorkingVoltageTp, true>;

}    // namespace Pins::V5

// clang-format on



template <typename... Ts>
struct are_pin_based;

template <typename T, typename... Ts>
struct are_pin_based<T, Ts...>
    : std::integral_constant<bool, std::is_base_of_v<PinBase, T> &&
                                     are_pin_based<Ts...>::value>
{};

template <>
struct are_pin_based<> : std::true_type
{};

#endif    // PIN_H
