#ifndef I2C_MUX_H
#define I2C_MUX_H

#include <CPS4042/Hardwares/Board.h>
#include <CPS4042/Hardwares/Comm/I2C.h>
#include <CPS4042/Protocols/Usart.h>
#include <CPS4042/Units/BaudRate.h>
#include <CPS4042/Wires/Pin.h>
#include <array>
#include <cstdint>
#include <iostream>

namespace Comm
{

using I2CMuxVoltage = VoltageLevel3_3v;

inline constexpr std::uint8_t I2CMuxChannelCount = 2;

template <typename WorkingVoltageTp>
requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp>
class SelectedSdaPin
{
public:
    using ChannelPin = Pins::Sda<WorkingVoltageTp>;

    constexpr SelectedSdaPin(std::uint64_t, std::uint64_t,
                             const std::string& name) :
        m_name {name}
    {}

    void
    bind(ChannelPin* channel0, ChannelPin* channel1)
    {
        m_channels[0] = channel0;
        m_channels[1] = channel1;
    }

    void
    select(std::uint8_t channel)
    {
        m_selectedChannel = channel % I2CMuxChannelCount;
    }

    void
    setProcessor(ProcessorBase*) const
    {}

    void
    onNextPositiveEdgeCallback(bool, bool) const
    {}

    void
    write(Bit bit)
    {
        if(auto* pin = activePin()) pin->write(bit);
    }

    void
    write(Byte byte)
    {
        if(auto* pin = activePin()) pin->write(byte);
    }

private:
    ChannelPin*
    activePin() const
    {
        return m_channels[m_selectedChannel % I2CMuxChannelCount];
    }

private:
    std::string  m_name;
    ChannelPin*  m_channels[I2CMuxChannelCount] {nullptr, nullptr};
    std::uint8_t m_selectedChannel {0};
};

template <typename WorkingVoltageTp>
requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp>
class SelectedSclPin
{
public:
    using ChannelPin = Pins::Scl<WorkingVoltageTp>;

    constexpr SelectedSclPin(std::uint64_t, std::uint64_t,
                             const std::string& name) :
        m_name {name}
    {}

    void
    bind(ChannelPin* channel0, ChannelPin* channel1)
    {
        m_channels[0] = channel0;
        m_channels[1] = channel1;
    }

    void
    select(std::uint8_t channel)
    {
        m_selectedChannel = channel % I2CMuxChannelCount;
    }

    void
    setProcessor(ProcessorBase*) const
    {}

    void
    onNextPositiveEdgeCallback(bool, bool) const
    {}

    void
    nextEdge(Bit bit)
    {
        if(auto* pin = activePin()) pin->nextEdge(bit);
    }

private:
    ChannelPin*
    activePin() const
    {
        return m_channels[m_selectedChannel % I2CMuxChannelCount];
    }

private:
    std::string  m_name;
    ChannelPin*  m_channels[I2CMuxChannelCount] {nullptr, nullptr};
    std::uint8_t m_selectedChannel {0};
};

template <BaudRate BR, BitRate BTR, typename WorkingVoltageTp>
requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp>
struct I2CMuxGpio
{
public:
    Pins::Vdd<WorkingVoltageTp> vdd {BR, BTR, "I2CMux::vdd"};
    Pins::Gnd<WorkingVoltageTp> gnd {BR, BTR, "I2CMux::gnd"};

    // USART side: ESP8266 TX/RX connects to these pins.
    Pins::Rx<WorkingVoltageTp> rx {BR, BTR, "I2CMux::rx"};
    Pins::Tx<WorkingVoltageTp> tx {BR, BTR, "I2CMux::tx"};

    // Compatibility pins used by the unchanged I2C master protocol.
    // They dispatch writes/clock edges to the currently selected physical C2I channel.
    SelectedSdaPin<WorkingVoltageTp> sda {BR, BTR, "I2CMux::selected::sda"};
    SelectedSclPin<WorkingVoltageTp> scl {BR, BTR, "I2CMux::selected::scl"};

    // C2I channel 0: physically independent SDA/SCL pair.
    Pins::Sda<WorkingVoltageTp> sda0 {BR, BTR, "I2CMux::ch0::sda"};
    Pins::Scl<WorkingVoltageTp> scl0 {BR, BTR, "I2CMux::ch0::scl"};

    // C2I channel 1: physically independent SDA/SCL pair.
    Pins::Sda<WorkingVoltageTp> sda1 {BR, BTR, "I2CMux::ch1::sda"};
    Pins::Scl<WorkingVoltageTp> scl1 {BR, BTR, "I2CMux::ch1::scl"};
};

class I2CMux
    : public Board<BaudRates::NotSpecified,
                   BitRates::same(BaudRates::NotSpecified),
                   Frequency::F320khz,
                   I2CMuxVoltage,
                   I2CMuxGpio>
{
public:
    explicit I2CMux() :
        Parent {"I2CMux::processor"}
    {
        m_gpio.sda.bind(&m_gpio.sda0, &m_gpio.sda1);
        m_gpio.scl.bind(&m_gpio.scl0, &m_gpio.scl1);
        selectChannel(0);

        m_processor->communicationClockChanged.connect(
          [this](Bit edge) { m_gpio.scl.nextEdge(edge); });

        m_i2c0.setBus(&m_buses[0]);
        m_i2c1.setBus(&m_buses[1]);

        m_processor->installProtocol(&m_usart);
        m_processor->installProtocol(&m_i2c0);
        m_processor->installProtocol(&m_i2c1);

        std::cout << "one instance of I2CMux created." << std::endl;
    }

    mutable Protocols::Usart<I2CMux, Gpio>     m_usart {this};
    mutable Protocols::I2CMaster<I2CMux, Gpio> m_i2c0 {this};
    mutable Protocols::I2CMaster<I2CMux, Gpio> m_i2c1 {this};
    mutable std::array<Protocols::I2CBusLine, I2CMuxChannelCount> m_buses {};

    inline Protocols::Usart<I2CMux, Gpio>&
    usart() const
    {
        return m_usart;
    }

    inline Protocols::I2CMaster<I2CMux, Gpio>&
    i2c(std::uint8_t channel) const
    {
        channel %= I2CMuxChannelCount;
        return (channel == 0) ? m_i2c0 : m_i2c1;
    }

    inline Protocols::I2CBusLine*
    bus(std::uint8_t channel) const
    {
        channel %= I2CMuxChannelCount;
        return const_cast<Protocols::I2CBusLine*>(&m_buses[channel]);
    }

    inline void
    selectChannel(std::uint8_t channel) const
    {
        channel %= I2CMuxChannelCount;
        auto& gpio = const_cast<I2CMux*>(this)->m_gpio;
        gpio.sda.select(channel);
        gpio.scl.select(channel);
    }

protected:
    inline void
    startModule() override
    {}
};

}    // namespace Comm

#endif    // I2C_MUX_H
