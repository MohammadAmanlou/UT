#ifndef BAUDRATE_H
#define BAUDRATE_H

#include "CPS4042/Units/Bit.h"
#include "CPS4042/Units/Byte.h"

#include <cstdint>

using BaudRate = std::uint64_t;
using BitRate  = std::uint64_t;

namespace BaudRates
{
// for performace reasons we scale them 0.1
// baud rates must be less than processor frequency
constexpr auto          scale         = 0.1f;
constexpr BaudRate      B115200       = 115'200 * scale;
constexpr BaudRate      B9600         = 96'000 * scale;
constexpr BaudRate      B6400         = 64'000 * scale;
constexpr BaudRate      B3200         = 32'000 * scale;
constexpr BaudRate      NotSpecified  = 0;

}    // namespace BaudRates

namespace BitRates
{
constexpr inline BitRate
same(BaudRate b)
{
    return BitRate(b);
}

constexpr inline BitRate
scale(BaudRate b, BitCount bitPerEdge)
{
    return BitRate(b) * bitPerEdge;
}

constexpr inline BitRate
bytePerEdge(BaudRate b)
{
    return scale(b, bitWidth<Byte>());
}
}    // namespace BitRates


#endif    // BAUDRATE_H
