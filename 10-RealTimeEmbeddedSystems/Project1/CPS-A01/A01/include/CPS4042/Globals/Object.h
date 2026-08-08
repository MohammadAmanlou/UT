#ifndef OBJECT_H
#define OBJECT_H

#include <chrono>
#include <string>
#include <thread>

class Object
{
public:
    std::string name() const;
    void        setName(const std::string &newName);

private:
    std::string m_name;
};

inline std::string
Object::name() const
{
    return m_name;
}

inline void
Object::setName(const std::string &newName)
{
    m_name = newName;
}

static inline void
delay(std::uint64_t millis)
{
    std::this_thread::sleep_for(std::chrono::milliseconds(millis));
}

#endif    // OBJECT_H
