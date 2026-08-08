#ifndef BOARD_H
#define BOARD_H


#include "CPS4042/Hardwares/Processor.h"
#include "CPS4042/Units/BaudRate.h"

#include <CPS4042/Globals/Object.h>
#include <CPS4042/Wires/Link.h>
#include <CPS4042/Wires/Pin.h>

namespace GpioHelper
{
template <typename T>
static constexpr std::size_t field_count_v = boost::pfr::tuple_size<T>::value;
}

class BoardBase : public Object
{
protected:
    void
    setupProcessor(ProcessorBase* p, BaudRate bar, BitRate btr)
    {
        if(!p) return;

        p->setup(bar, btr);
    }
};

template <BaudRate  bar,
          BitRate   btr,
          Frequency workingFrequency,
          typename WorkingVoltageTp,
          template <BaudRate, BitRate, typename V> typename GpioTp>
requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp> &&
         DvfsConsistencyCheckV<workingFrequency, WorkingVoltageTp>
class Board : public BoardBase
{
public:
    using Gpio          = GpioTp<bar, btr, WorkingVoltageTp>;
    using ProcessorType = Processor<workingFrequency, WorkingVoltageTp, Gpio>;
    using Parent        = Board;

    constexpr Board(const std::string& processorName)
    {
        auto processor = std::make_unique<ProcessorType>();
        processor->setName(processorName);
        std::cout << processor->name() << " created." << std::endl;
        installProcessor(std::move(processor));
        connectPinsToProcessor(m_gpio);
    };

    void
    installProcessor(std::unique_ptr<ProcessorType> processor)
    {
        m_processor = std::move(processor);
        setupProcessor(m_processor.get(), bar, btr);
    }

    inline static constexpr BaudRate
    baudRate()
    {
        return bar;
    }

    inline static constexpr BitRate
    bitRate()
    {
        return btr;
    }

    inline static constexpr Frequency
    frequency()
    {
        return workingFrequency;
    }

    inline void
    installSetupCode(ProcessorType::Code&& code)
    {
        m_processor->installSetupCode(std::move(code));
    }

    inline void
    installLoopCode(ProcessorType::Code&& code)
    {
        m_processor->installLoopCode(std::move(code));
    }

    inline void constexpr start()
    {
        if constexpr(frequency() != Frequency::Drived)
            m_processor->exec(m_gpio);
        else
            startModule();
    }

    inline Gpio&
    gpio()
    {
        return m_gpio;
    }

    template <std::uint64_t pinIndex>
    inline constexpr void
    attachPinToCommunicationClock()
    {
        static_assert(frequency() != Frequency::Drived,
                      "failed to attach pin to communication clock,"
                      "you can not call function "
                      "'attachPinToCommunicationClock' on a slave board.");

        static_assert(GpioHelper::field_count_v<Gpio> > pinIndex,
                      "failed to attach pin to communication clock, "
                      "invalid pin index.");

        auto& pin = boost::pfr::get<pinIndex>(m_gpio);

        static_assert(std::is_same_v<Pins::Digital<WorkingVoltageTp>,
                                     std::decay_t<decltype(pin)>>,
                      "failed to attach pin to communication clock, selected "
                      "pin type must be Digital.");

        m_processor->communicationClockChanged.connect(
          [this, &pin](Bit edge) { pin.write(edge); });
    }

protected:
    virtual inline void startModule() = 0;

    void
    connectPinsToProcessor(Gpio& gpio)
    {
        boost::pfr::for_each_field(
          gpio,
          [&gpio, this](const auto& field, std::size_t idx) {
              try
              {
                  field.setProcessor(m_processor.get());
              }
              catch(...)
              {
                  std::cerr << "failed to connect pins to processor. " << idx
                            << " at processor pipeline." << std::endl;
              }
          });
    }

protected:
    Gpio                           m_gpio;
    std::unique_ptr<ProcessorType> m_processor;
};

#endif    // BOARD_H
