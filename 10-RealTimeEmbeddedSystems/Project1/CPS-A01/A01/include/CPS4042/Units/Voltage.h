#ifndef VOLTAGE_H
#define VOLTAGE_H

#include <CPS4042/Units/Bit.h>
#include <CPS4042/Units/Byte.h>
#include <numeric>    // IWYU pragma: export

enum class WorkingVoltage
{
    V3_3,
    V5
};

template <WorkingVoltage max>
struct VoltageLevel;

class TransmitterBase;

struct AbstractVoltageLevel
{
    using Level = float;
    inline static constexpr Level undefined = -1.0f;

    constexpr AbstractVoltageLevel() {}
    explicit constexpr AbstractVoltageLevel(Level lvl) { m_level = lvl; }

    Level constexpr level() const { return m_level; }

    /// it adds some noises by default!
    virtual Byte toByte() const = 0;
    virtual Bit  toBit() const  = 0;

protected:
    Level m_level = undefined;

    friend class TransmitterBase;
};

template <>
struct VoltageLevel<WorkingVoltage::V3_3> : AbstractVoltageLevel

{
    explicit constexpr VoltageLevel(Byte byte)
    {

        m_level = (byte / std::numeric_limits<Byte>::max()) * 3.3f;
    }

    explicit constexpr VoltageLevel(float raw): AbstractVoltageLevel(raw)
    {}

    explicit constexpr VoltageLevel(Bit bit)
    {
        switch(bit)
        {
            case Bit::One :
                m_level = 3.3f;
                break;

            case Bit::Zero :
                m_level = 0.0f;
                break;

            case Bit::Z :
            case Bit::X :
            default :
                m_level = undefined;
                break;
        }
    }

    Byte
    toByte() const override
    {
        return static_cast<Byte>(
          ((m_level * std::numeric_limits<Byte>::max()) / 3.3f));
    }

    Bit
    toBit() const override
    {
        if(m_level == undefined) return Bit::Z;
        return m_level > 0 ? Bit::One : Bit::Zero;
    }
};

template <>
struct VoltageLevel<WorkingVoltage::V5> : AbstractVoltageLevel
{
    explicit constexpr VoltageLevel(Byte byte)
    {
        m_level = (byte / std::numeric_limits<Byte>::max()) * 5.0f;
    }

    explicit constexpr VoltageLevel(float raw): AbstractVoltageLevel(raw)
    {}

    explicit constexpr VoltageLevel(Bit bit)
    {
        switch(bit)
        {
            case Bit::One :
                m_level = 5.0f;
                break;

            case Bit::Zero :
                m_level = 0.0f;
                break;

            case Bit::Z :
            case Bit::X :
            default :
                m_level = undefined;
                break;
        }
    }

    Byte
    toByte() const override
    {
        return static_cast<Byte>(
          ((m_level * std::numeric_limits<Byte>::max()) / 5.0f));
    }

    Bit
    toBit() const override
    {
        if(m_level == undefined) return Bit::Z;
        return m_level > 0 ? Bit::One : Bit::Zero;
    }
};

using VoltageLevel5v   = VoltageLevel<WorkingVoltage::V5>;
using VoltageLevel3_3v = VoltageLevel<WorkingVoltage::V3_3>;

namespace Voltage
{

template <typename T>
requires std::is_base_of_v<AbstractVoltageLevel, T>
T
fromByte(Byte byte)
{
    return T(byte);
}

template <typename T>
requires std::is_base_of_v<AbstractVoltageLevel, T>
T
fromBit(Bit bit)
{
    return T(bit);
}

template <typename T>
requires std::is_base_of_v<AbstractVoltageLevel, T>
Byte
toByte(const T& lvl)
{
    return lvl.toByte();
}

template <typename T>
requires std::is_base_of_v<AbstractVoltageLevel, T>
Bit
toBit(const T& lvl)
{
    return lvl.toBit();
}
}    // namespace Voltage

#endif    // VOLTAGE_H
