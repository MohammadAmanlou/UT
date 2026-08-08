#ifndef WAVE_H
#define WAVE_H

#include <CPS4042/Units/Byte.h>

/// a simple wave generator
template <Byte min, Byte max, Byte step>
struct Wave
{
    static_assert(((max - min) > step) && ((max - min) % step == 0),
                  "invalid range or step");

    inline void
    operator()(Byte& data)
    {
        if(data >= max)
        {
            data          = max;
            m_upDirection = false;
        }

        if(data <= min)
        {
            data          = min;
            m_upDirection = true;
        }

        if(m_upDirection)
            data += step;
        else
            data -= step;
    }

private:
    static inline bool m_upDirection = true;
};

#endif    // WAVE_H
