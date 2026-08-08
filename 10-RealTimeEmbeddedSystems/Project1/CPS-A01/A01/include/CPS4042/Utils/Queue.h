#ifndef QUEUE_H
#define QUEUE_H

#include <CPS4042/Units/Bit.h>
#include <CPS4042/Units/Byte.h>
#include <cassert>
#include <cmath>
#include <queue>

template <typename T>
class Queue : public std::queue<T>
{
public:
    inline T
    take()
    {
        boost::remove_cv_ref_t<T> res = this->front();
        this->pop();
        return res;
    }

    inline std::vector<T>
    vector(bool move = false)
    {
        std::vector<T> res;

        for(auto& item : this->c)
        {
            res.push_back(item);
        }

        if(move) this->c.clear();

        return res;
    }

    void
    clear()
    {
        this->c.clear();
    }
};

class BitQueue : public Queue<Bit>
{
public:
    inline bool
    hasByte() const
    {
        return size() >= bitWidth<Byte>();
    }

    inline Byte
    takeByte()
    {
        assert(size() < bitWidth<Byte>());
        return takeMany(bitWidth<Byte>());
    }

    inline Byte
    takeRest()
    {
        return takeMany(size());
    }

    inline void
    push(Bit bit)
    {
        Queue::push(bit);
    }

    inline void
    push(Byte byte)
    {
        for(std::uint8_t i = 0; i < bitWidth<Byte>(); i++)
        {
            auto bit = takeNthBit(byte, i);
            push(bit);
        }
    }

    inline ByteCount
    byteCount() const
    {
        return (ByteCount)std::ceil((float)size() / (float)bitWidth<Byte>());
    }

private:
    inline Byte
    takeMany(std::uint8_t n)
    {
        Byte byte = 0b00000000;

        if(n > bitWidth<Byte>()) n = bitWidth<Byte>();

        for(std::uint8_t i = 0; i < n; i++)
        {
            auto bit   = take();
            byte     <<= 1;

            switch(bit)
            {
                case Bit::One :
                    byte += 1;
                    break;

                case Bit::Zero :
                case Bit::X :
                case Bit::Z :
                    byte += 0;
                    break;
            }
        }

        return byte;
    }
};

#endif    // QUEUE_H
