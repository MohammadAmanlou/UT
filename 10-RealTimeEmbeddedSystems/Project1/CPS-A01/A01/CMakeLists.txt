cmake_minimum_required(VERSION 3.19)

project(CPS4042 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 20)

# The template-heavy simulator compiles much faster with O0 on MinGW/GCC.
if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    add_compile_options(-O0)
endif()

set(CPS4042_INCLUDE_DIR
    ${CMAKE_CURRENT_SOURCE_DIR}/include
)

set(BOOST_INCLUDE_DIR
    "D:/golboo/term 10/CPS/projects/boost_1_84_0_4students/boost_1_84_0"
)

set(CPS4042_COMMON_HEADERS
    include/CPS4042/main.h

    include/CPS4042/Protocols/Protocol.h
    include/CPS4042/Wires/Link.h
    include/CPS4042/Wires/Pin.h

    include/CPS4042/Hardwares/Transmitter.h
    include/CPS4042/Hardwares/Board.h
    include/CPS4042/Hardwares/Processor.h
    include/CPS4042/Hardwares/Boards/Esp8266.h
    include/CPS4042/Hardwares/Sensors/VL530X.h
    include/CPS4042/Hardwares/Comm/I2C.h
    include/CPS4042/Hardwares/Comm/I2CMux.h

    include/CPS4042/Units/Bit.h
    include/CPS4042/Units/Byte.h
    include/CPS4042/Units/Voltage.h
    include/CPS4042/Units/Frequency.h
    include/CPS4042/Units/BaudRate.h

    include/CPS4042/Utils/Queue.h
    include/CPS4042/Utils/Wave.h
    include/CPS4042/Utils/ByteStream.h

    include/CPS4042/Globals/Object.h

    include/CPS4042/Sketchs/AbstractSketch.h
    include/CPS4042/Sketchs/Sensor.h
    include/CPS4042/Sketchs/Microcontroller.h
    include/CPS4042/Sketchs/HardDisk.h
    include/CPS4042/Sketchs/I2CMultiplexer.h
    include/CPS4042/Sketchs/MuxMicrocontroller.h
    include/CPS4042/Sketchs/RangeSensor.h
)

add_executable(CPS4042_part1
    src/part1_main.cpp
    ${CPS4042_COMMON_HEADERS}
)

add_executable(CPS4042_part2
    src/part2_main.cpp
    ${CPS4042_COMMON_HEADERS}
)

add_executable(CPS4042_part3
    src/part3_main.cpp
    ${CPS4042_COMMON_HEADERS}
)

foreach(target CPS4042_part1 CPS4042_part2 CPS4042_part3)
    target_include_directories(${target}
        PRIVATE
            ${CPS4042_INCLUDE_DIR}
            ${BOOST_INCLUDE_DIR}
    )

    target_compile_features(${target}
        PRIVATE
            cxx_std_20
    )
endforeach()

include(GNUInstallDirs)

install(TARGETS
    CPS4042_part1
    CPS4042_part2
    CPS4042_part3
    BUNDLE  DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)