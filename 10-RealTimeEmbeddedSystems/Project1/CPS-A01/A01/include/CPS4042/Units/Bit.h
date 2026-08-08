#ifndef BIT_H
#define BIT_H

#include <cstdint>
#include <iostream>
#include <type_traits>

enum class Bit : std::uint8_t
{
    Zero = 0b00000000,
    One  = 0b00000001,
    X    = 0b00001111,
    Z    = 0b11111111
};

template <typename T>
requires std::is_integral_v<T> || std::is_same_v<Bit, T>
inline constexpr std::uint8_t
bitWidth(T value)
{
    if constexpr(std::is_same_v<Bit, T>) return 1;
    return sizeof(T) * 8;
}

template <typename T>
requires std::is_integral_v<T> || std::is_same_v<Bit, T>
inline constexpr std::uint8_t
bitWidth()
{
    if constexpr(std::is_same_v<Bit, T>) return 1;
    return sizeof(T) * 8;
}

template <typename T>
requires std::is_integral_v<T>
inline constexpr Bit
takeNthBit(T value, std::uint8_t n)
{
    if(bitWidth<T>() <= n)
    {
        std::cerr << "n is larger than bit width of provided value " << (int)n
                  << " >= " << (int)bitWidth<T>() << std::endl;

        return Bit::X;
    }

    T mask     = 1;
    mask     <<= n;
    T result   = value & mask;

    if(result)
        return Bit::One;
    else
        return Bit::Zero;
}

template <auto byte, std::uint8_t n>
requires std::is_integral_v<decltype(byte)>
inline constexpr Bit
takeNthBit()
{
    using T = decltype(byte);

    static_assert(bitWidth<T>() >= n,
                  "n is larger than bit width of provided value");

    T mask     = 1;
    mask     <<= n;
    T result   = byte & mask;

    if(result)
        return Bit::One;
    else
        return Bit::Zero;
}

template <typename T>
requires std::is_integral_v<T>
inline constexpr Bit
takeMsb(T value)
{
    return takeNthBit(value, bitWidth<T>() - 1);
}

template <auto value>
requires std::is_integral_v<decltype(value)>
inline constexpr Bit
takeMsb()
{
    return takeNthBit<value, bitWidth<decltype(value)>() - 1>();
}

template <typename T>
requires std::is_integral_v<T>
inline constexpr Bit
takeLsb(T value)
{
    return takeNthBit(value, 0);
}

template <auto value>
requires std::is_integral_v<decltype(value)>
inline constexpr Bit
takeLsb()
{
    return takeNthBit<value, 0>();
}

inline constexpr std::string
toString(Bit bit)
{
    switch(bit)
    {
        case Bit::One :
            return "One";
        case Bit::Zero :
            return "Zero";
        case Bit::X :
            return "X";
        case Bit::Z :
            return "Z";
        default :
            return "X";
    }

    return "X";
}

inline constexpr void
flip(Bit& bit)
{
    if(bit == Bit::One)
        bit = Bit::Zero;
    else
        bit = Bit::One;
}

using BitCount = std::uint8_t;


#endif    // BIT_H
