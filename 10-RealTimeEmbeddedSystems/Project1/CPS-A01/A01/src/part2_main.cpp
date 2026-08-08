#include <CPS4042/Sketchs/HardDisk.h>
#include <CPS4042/Sketchs/UsartMicroController.h>
#include <CPS4042/Units/Bit.h>
#include <CPS4042/Units/Byte.h>
#include <CPS4042/Wires/Pin.h>
#include <CPS4042/main.h>

std::int32_t
main()
{
    Boards::Esp8266 esp8266;
    Sensors::Usb    usb;

    auto linkVdd = std::make_shared<Link>();
    auto linkGnd = std::make_shared<Link>();

    auto linkTxEspRxUsb = std::make_shared<Link>();
    auto linkRxEspTxUsb = std::make_shared<Link>();

    CPS_SET_OBJECT_NAME(esp8266);
    CPS_SET_OBJECT_NAME(usb);

    CPS_SET_OBJECT_NAME_PTR(linkVdd);
    CPS_SET_OBJECT_NAME_PTR(linkGnd);
    CPS_SET_OBJECT_NAME_PTR(linkTxEspRxUsb);
    CPS_SET_OBJECT_NAME_PTR(linkRxEspTxUsb);

    esp8266.gpio().vdd1.attachLink(linkVdd);
    esp8266.gpio().gnd1.attachLink(linkGnd);
    esp8266.gpio().tx.attachLink(linkTxEspRxUsb);
    esp8266.gpio().rx.attachLink(linkRxEspTxUsb);

    usb.gpio().vdd.attachLink(linkVdd);
    usb.gpio().gnd.attachLink(linkGnd);
    usb.gpio().tx.attachLink(linkRxEspTxUsb);
    usb.gpio().rx.attachLink(linkTxEspRxUsb);

    UsartMicroController micro(&esp8266);
    HardDisk             harddisk(&usb);

    micro.start();
    harddisk.start();

    return Application::exec();
}