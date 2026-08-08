#ifndef USB_H
#define USB_H

#include <CPS4042/Protocols/Usart.h>
#include <CPS4042/Hardwares/Board.h>
#include <CPS4042/Units/BaudRate.h>
#include <CPS4042/Wires/Pin.h>

#include <iostream>

namespace Sensors
{

    using UsbVoltage = VoltageLevel3_3v;

    template <BaudRate BR, BitRate BTR, typename WorkingVoltageTp>
        requires std::is_base_of_v<AbstractVoltageLevel, WorkingVoltageTp>
    struct UsbGpio
    {
    public:
        Pins::Vdd<WorkingVoltageTp> vdd{BR, BTR, "Usb::vdd"};
        Pins::Gnd<WorkingVoltageTp> gnd{BR, BTR, "Usb::gnd"};

        Pins::Rx<WorkingVoltageTp> rx{BR, BTR, "Usb::rx"};
        Pins::Tx<WorkingVoltageTp> tx{BR, BTR, "Usb::tx"};
    };

    class Usb
        : public Board<
              BaudRates::NotSpecified,
              BitRates::same(BaudRates::NotSpecified),
            //   Frequency::Drived,
              Frequency::F320khz,
              UsbVoltage,
              UsbGpio>
    {

    public:
        explicit Usb()
            : Parent{"Usb::processor"}
        {
            m_processor->installProtocol(&m_usart);

            std::cout << "one instance of Usb created." << std::endl;
        }

        mutable Protocols::Usart<Usb, Gpio> m_usart{this};

        inline Protocols::Usart<Usb, Gpio> &
        usart() const
        {
            return m_usart;
        }

        protected:
            inline void startModule() override
            {
            }

    // protected:
    //     inline void startModule() override
    //     {
    //         std::thread([this]()
    //                     {
    //                         bool firstCycle = true;

    //                         while (true)
    //                         {
    //                             if (firstCycle)
    //                             {
    //                                 m_processor->nextCycle(m_gpio);
    //                                 firstCycle = false;
    //                             }

    //                             m_processor->nextCycle(m_gpio);

    //                             std::this_thread::sleep_for(
    //                                 std::chrono::microseconds(5));
    //                         }
    //                     })
    //             .detach();

    //         std::cout << "Usb::startModule started (Drived)." << std::endl;
    //     }
    };

} // namespace Sensors

#endif // USB_H
