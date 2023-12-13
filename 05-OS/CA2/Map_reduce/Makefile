CC = g++
BUILD_DIR = build
INCLUDE_DIR = includes
CFLAGS = -std=c++17 -lstdc++fs

MAIN_EXECUTABLE_FILE = main.out
BUILDING_EXECUTABLE_FILE = buildings.out
RESOURCE_EXECUTABLE_FILE = resources.out
BILLER_EXECUTABLE_FILE = biller.out

MAIN_OBJECTS = \
	$(BUILD_DIR)/main.o

BUILDING_OBJECTS = \
	$(BUILD_DIR)/Building.o

RESOURCE_OBJECTS = \
	$(BUILD_DIR)/resource.o

BILLER_OBJECTS = \
	$(BUILD_DIR)/Biller.o

LOGGER_OBJECTS = \
	$(BUILD_DIR)/Logger.o

MainSensitivityList = \
	main.cpp

BillerSensitivityList = \
	Biller.cpp

BuildingSensitivityList = \
	Building.cpp

ResourceSensitivityList = \
	resource.cpp

all: $(BUILD_DIR) $(MAIN_EXECUTABLE_FILE) $(BUILDING_EXECUTABLE_FILE) $(RESOURCE_EXECUTABLE_FILE) $(BILLER_EXECUTABLE_FILE)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(MAIN_EXECUTABLE_FILE): $(MAIN_OBJECTS) $(LOGGER_OBJECTS)
	$(CC) $(MAIN_OBJECTS) $(LOGGER_OBJECTS) $(CFLAGS) -o $(MAIN_EXECUTABLE_FILE)

$(BUILDING_EXECUTABLE_FILE): $(BUILDING_OBJECTS) $(LOGGER_OBJECTS)
	$(CC) $(BUILDING_OBJECTS) $(LOGGER_OBJECTS) $(CFLAGS) -o $(BUILDING_EXECUTABLE_FILE)

$(RESOURCE_EXECUTABLE_FILE): $(RESOURCE_OBJECTS) $(LOGGER_OBJECTS)
	$(CC) $(RESOURCE_OBJECTS) $(LOGGER_OBJECTS) $(CFLAGS) -o $(RESOURCE_EXECUTABLE_FILE)

$(BILLER_EXECUTABLE_FILE): $(BILLER_OBJECTS) $(LOGGER_OBJECTS)
	$(CC) $(BILLER_OBJECTS) $(LOGGER_OBJECTS) $(CFLAGS) -o $(BILLER_EXECUTABLE_FILE)

$(BUILD_DIR)/main.o: $(MainSensitivityList) $(INCLUDE_DIR)/Logger.hpp
	$(CC) -c main.cpp $(CFLAGS) -o $(BUILD_DIR)/main.o

$(BUILD_DIR)/Biller.o: $(BillerSensitivityList) $(INCLUDE_DIR)/Logger.hpp
	$(CC) -c Biller.cpp $(CFLAGS) -o $(BUILD_DIR)/Biller.o

$(BUILD_DIR)/Building.o: $(BuildingSensitivityList) $(INCLUDE_DIR)/Logger.hpp
	$(CC) -c Building.cpp $(CFLAGS) -o $(BUILD_DIR)/Building.o

$(BUILD_DIR)/resource.o: $(ResourceSensitivityList) $(INCLUDE_DIR)/Logger.hpp
	$(CC) -c resource.cpp $(CFLAGS) -o $(BUILD_DIR)/resource.o

$(BUILD_DIR)/Logger.o: $(INCLUDE_DIR)/Logger.cpp $(INCLUDE_DIR)/Logger.hpp
	$(CC) -c $(INCLUDE_DIR)/Logger.cpp $(CFLAGS) -o $(BUILD_DIR)/Logger.o


.PHONY: clean
clean:
	rm -rf $(BUILD_DIR) *.o *.out
