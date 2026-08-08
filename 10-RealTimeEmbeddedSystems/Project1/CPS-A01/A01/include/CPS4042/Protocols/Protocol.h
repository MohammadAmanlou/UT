#ifndef PROTOCOL_H
#define PROTOCOL_H

#include <CPS4042/Units/Byte.h>
#include <queue>

namespace Protocols
{

template <typename Gpio>
class AbstractProtocol
{
public:
    explicit AbstractProtocol()  = default;
    virtual void run(Gpio& gpio) = 0;

    virtual void write(Byte byte) = 0;
    virtual Byte read()           = 0;

    bool
    isDataAvailable() const
    {
        return static_cast<bool>(AbstractProtocol<Gpio>::m_buffer.size());
    };

protected:
    std::queue<Byte> m_buffer;
};

template <typename BoardType, typename Gpio>
class AbstractI2C : public AbstractProtocol<Gpio>
{
    using BoardPtr = std::remove_pointer_t<boost::remove_cv_ref_t<BoardType>>*;

public:
    explicit AbstractI2C(BoardPtr board) :
        m_board(board)
    {}

    virtual void init(Byte address) = 0;

protected:
    BoardPtr         m_board;
    bool             m_started {false};
};

template <typename BoardType, typename Gpio>
class AbstractUsart : public AbstractProtocol<Gpio>
{
    using BoardPtr = std::remove_pointer_t<boost::remove_cv_ref_t<BoardType>>*;

public:
    explicit AbstractUsart(BoardPtr board) :
        m_board(board)
    {}

protected:
    BoardPtr m_board;
    bool     m_isFlagDetected {false};
    bool     m_isWritingFinished {false};
};

}    // namespace Protocols

#endif    // PROTOCOL_H
