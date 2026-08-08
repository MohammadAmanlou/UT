#include <CPS4042/Hardwares/Comm/I2CMux.h>
#include <CPS4042/Sketchs/I2CMultiplexer.h>
#include <CPS4042/Sketchs/MuxMicrocontroller.h>
#include <CPS4042/Sketchs/RangeSensor.h>
#include <CPS4042/Units/Bit.h>
#include <CPS4042/Units/Byte.h>
#include <CPS4042/Wires/Pin.h>
#include <CPS4042/main.h>

std::int32_t
main()
{
    Boards::Esp8266 esp8266;
    Comm::I2CMux    mux;
    Sensors::Vl530x sensor0;
    Sensors::Vl530x sensor1;

    auto linkVdd = std::make_shared<Bus>();
    auto linkGnd = std::make_shared<Bus>();

    auto linkTxEspRxMux = std::make_shared<Link>();
    auto linkRxEspTxMux = std::make_shared<Link>();

    auto linkScl0 = std::make_shared<Bus>();
    auto linkSda0 = std::make_shared<Bus>();

    auto linkScl1 = std::make_shared<Bus>();
    auto linkSda1 = std::make_shared<Bus>();

    CPS_SET_OBJECT_NAME(esp8266);
    CPS_SET_OBJECT_NAME(mux);
    CPS_SET_OBJECT_NAME(sensor0);
    CPS_SET_OBJECT_NAME(sensor1);

    CPS_SET_OBJECT_NAME_PTR(linkVdd);
    CPS_SET_OBJECT_NAME_PTR(linkGnd);
    CPS_SET_OBJECT_NAME_PTR(linkTxEspRxMux);
    CPS_SET_OBJECT_NAME_PTR(linkRxEspTxMux);
    CPS_SET_OBJECT_NAME_PTR(linkScl0);
    CPS_SET_OBJECT_NAME_PTR(linkSda0);
    CPS_SET_OBJECT_NAME_PTR(linkScl1);
    CPS_SET_OBJECT_NAME_PTR(linkSda1);

    esp8266.gpio().vdd1.attachLink(linkVdd);
    esp8266.gpio().gnd1.attachLink(linkGnd);
    esp8266.gpio().tx.attachLink(linkTxEspRxMux);
    esp8266.gpio().rx.attachLink(linkRxEspTxMux);

    mux.gpio().vdd.attachLink(linkVdd);
    mux.gpio().gnd.attachLink(linkGnd);
    mux.gpio().rx.attachLink(linkTxEspRxMux);
    mux.gpio().tx.attachLink(linkRxEspTxMux);

    sensor0.gpio().vdd.attachLink(linkVdd);
    sensor0.gpio().gnd.attachLink(linkGnd);

    sensor1.gpio().vdd.attachLink(linkVdd);
    sensor1.gpio().gnd.attachLink(linkGnd);

    mux.gpio().scl0.attachLink(linkScl0);
    mux.gpio().sda0.attachLink(linkSda0);
    sensor0.gpio().scl.attachLink(linkScl0);
    sensor0.gpio().sda.attachLink(linkSda0);

    mux.gpio().scl1.attachLink(linkScl1);
    mux.gpio().sda1.attachLink(linkSda1);
    sensor1.gpio().scl.attachLink(linkScl1);
    sensor1.gpio().sda.attachLink(linkSda1);

    MuxMicroController micro(&esp8266);
    I2CMultiplexer     i2cMux(&mux);

    RangeSensor range0(&sensor0, mux.bus(0), 0, 20, 101, "Sensor-0");
    RangeSensor range1(&sensor1, mux.bus(1), 50, 100, 202, "Sensor-1");

    micro.start();
    i2cMux.start();
    range0.start();
    range1.start();

    return Application::exec();
}