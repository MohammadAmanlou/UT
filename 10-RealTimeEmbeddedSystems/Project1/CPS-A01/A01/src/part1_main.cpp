#include <CPS4042/Sketchs/Microcontroller.h>
#include <CPS4042/Sketchs/Sensor.h>
#include <CPS4042/Units/Bit.h>
#include <CPS4042/Units/Byte.h>
#include <CPS4042/Wires/Pin.h>
#include <CPS4042/main.h>

std::int32_t
main()
{
    Boards::Esp8266 esp8266;
    Sensors::Vl530x vl530x;

    auto linkRed    = std::make_shared<Link>();
    auto linkBlack  = std::make_shared<Link>();
    auto linkGreen  = std::make_shared<Link>();
    auto linkYellow = std::make_shared<Link>();

    CPS_SET_OBJECT_NAME(esp8266);
    CPS_SET_OBJECT_NAME(vl530x);

    CPS_SET_OBJECT_NAME_PTR(linkRed);
    CPS_SET_OBJECT_NAME_PTR(linkBlack);
    CPS_SET_OBJECT_NAME_PTR(linkGreen);
    CPS_SET_OBJECT_NAME_PTR(linkYellow);

    esp8266.gpio().vdd1.attachLink(linkRed);
    esp8266.gpio().gnd1.attachLink(linkBlack);
    esp8266.gpio().scl.attachLink(linkGreen);
    esp8266.gpio().sda.attachLink(linkYellow);

    vl530x.gpio().vdd.attachLink(linkRed);
    vl530x.gpio().gnd.attachLink(linkBlack);
    vl530x.gpio().scl.attachLink(linkGreen);
    vl530x.gpio().sda.attachLink(linkYellow);

    MicroController micro(&esp8266);
    Sensor          disSen(&vl530x);

    micro.start();
    disSen.start();

    return Application::exec();
}