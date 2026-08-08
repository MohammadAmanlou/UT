#ifndef ABSTRACTSKETCH_H
#define ABSTRACTSKETCH_H

#include <CPS4042/Hardwares/Board.h>

template <typename T>
requires std::is_base_of_v<BoardBase, T>
class AbstractSketch : public Object
{
public:
    constexpr explicit AbstractSketch(T* node) :
        Object {}, m_node {node}
    {}

    void start()
    {
        m_node->installSetupCode(
          std::move([this](auto& v) -> std::int32_t { return setup(v); }));

        m_node->installLoopCode(
          std::move([this](auto& v) -> std::int32_t { return loop(v); }));

        m_node->start();
    }

    const boost::remove_cv_ref<T>::type*
    node() const
    {
        return m_node;
    }

protected:
    virtual std::int32_t setup(T::Gpio& gpio) = 0;
    virtual std::int32_t loop(T::Gpio& gpio)  = 0;

private:
    boost::remove_cv_ref<T>::type* m_node {nullptr};
};

#endif // ABSTRACTSKETCH_H
