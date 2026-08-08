#ifndef BYTESTREAM_H
#define BYTESTREAM_H

#include <CPS4042/Units/Byte.h>

template <typename T>
requires std::is_integral_v<T> && std::is_unsigned_v<T>
struct ByteStream
{
    using Value  = boost::remove_cv_ref_t<T>;

    ByteStream() = default;

    inline ByteStream&
    operator<<(Byte b)
    {
        m_value <<= bitWidth<Byte>();
        m_value  += static_cast<UByte>(b);
        m_count++;

        if(m_count > byteWidth<T>())
        {
            std::cerr << "ByteStream::Overflow" << std::endl;
            throw std::runtime_error("ByteStream::Overflow");
        }

        return *this;
    }

    bool
    isReady() const
    {
        return m_count == byteWidth<T>();
    }

    Value
    value() const
    {
        if(!isReady()) return -1;
        return m_value;
    }

    Value
    take()
    {
        auto v = value();
        clear();
        return v;
    }

    void
    clear()
    {
        m_value = 0;
        m_count = 0;
    }

private:
    Value        m_value {};
    std::uint8_t m_count {};
};

#endif    // BYTESTREAM_H
