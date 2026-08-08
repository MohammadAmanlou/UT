#ifndef BYTE_H
#define BYTE_H

#include "boost/assert.hpp"
#include "boost/type_traits/remove_cv_ref.hpp"

#include <CPS4042/Units/Bit.h>
#include <cstdint>

using Byte      = std::int8_t;
using UByte     = std::uint8_t;
using ByteCount = std::uint8_t;

inline constexpr Byte reverse(Byte b)
{
    Byte res = 0;

    for(std::uint8_t i = 0; i < bitWidth(Byte {}); i++)
    {
        auto bit = takeNthBit(b, i);
        res <<=1;
        res += (std::uint8_t)bit;
    }

    return res;
}

template <typename T>
requires std::is_integral_v<T>
class ByteVector
{

public:
    using BytePtr = Byte*;
    using Value   = boost::remove_cv_ref_t<T>;

    explicit constexpr ByteVector(const Value& value) :
        m_value {value}
    {}

    inline constexpr std::uint16_t
    size()
    {
        return bitWidth<Value>() / bitWidth<Byte>();
    }

    inline constexpr BytePtr
    data()
    {
        return reinterpret_cast<BytePtr>(&m_value);
    }

    inline constexpr Byte
    operator[](std::uint16_t index)
    {
        BOOST_ASSERT_MSG(index < size(), "index out of range");
        return data()[index];
    }

    inline constexpr Value
    value() const
    {
        return m_value;
    }

private:
    Value m_value;
};

template <std::uint16_t index, typename T>
inline constexpr Byte
getByte(ByteVector<T> v)
{
    static_assert(index < v.size(), "index out of range");
    return v.data()[index];
}

template <std::uint16_t index, typename T>
requires std::is_integral_v<T>
inline constexpr Byte
getByte(T& v)
{
    constexpr auto size =
      bitWidth<typename ByteVector<T>::Value>() / bitWidth<Byte>();

    static_assert(index < size, "index out of range");
    auto* ptr = reinterpret_cast<ByteVector<T>::BytePtr>(&v);
    return ptr[index];
}

template <std::uint16_t index, typename T>
requires std::is_integral_v<T>
inline constexpr Byte
getByte(T&& v)
{
    constexpr auto size =
      bitWidth<typename ByteVector<T>::Value>() / bitWidth<Byte>();

    static_assert(index < size, "index out of range");
    auto* ptr = reinterpret_cast<ByteVector<T>::BytePtr>(&v);
    return ptr[index];
}

template <typename T>
requires std::is_integral_v<T> || std::is_same_v<Bit, T>
inline constexpr std::uint8_t
byteWidth(T value)
{
    return sizeof(T);
}

template <typename T>
requires std::is_integral_v<T> || std::is_same_v<Bit, T>
inline constexpr std::uint8_t
byteWidth()
{
    return sizeof(T);
}


#endif    // BYTE_H
