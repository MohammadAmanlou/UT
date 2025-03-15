CC := g++ -std=c++20
EXECUTABLE := utaxi.out

BUILD_DIR := build

SQLITE_DATABASE_FILE := db.sqlite

INTERFACE_ADDITIONAL_OBJECTS := ${BUILD_DIR}/database.o ${BUILD_DIR}/myserver.o ${BUILD_DIR}/html_maker.o ${BUILD_DIR}/handlers.o ${BUILD_DIR}/server_lists.o
DATABASE_OBJECTS := ${BUILD_DIR}/general.o ${BUILD_DIR}/datareader.o ${BUILD_DIR}/location.o ${BUILD_DIR}/member.o ${BUILD_DIR}/passenger.o ${BUILD_DIR}/driver.o ${BUILD_DIR}/trip.o ${BUILD_DIR}/database_items.o
APHTTP_OBJECTS := ${BUILD_DIR}/response.o ${BUILD_DIR}/utilities.o ${BUILD_DIR}/route.o ${BUILD_DIR}/request.o ${BUILD_DIR}/server.o ${BUILD_DIR}/template_parser.o
ALL_OBJECTS := ${BUILD_DIR}/interface.o ${BUILD_DIR}/utaxi.o ${BUILD_DIR}/main.o ${INTERFACE_ADDITIONAL_OBJECTS} ${DATABASE_OBJECTS} ${APHTTP_OBJECTS}

#------application------#
MAIN = src/main
DEFINES := src/defines.hpp
SQLITE := src/data/sqlite_orm.h
INTERFACE := src/web/interface
UTAXI := src/web/utaxi

#------backend------#
DATABASE := src/data/database
GENERAL := src/utils/general
DATA_READER := src/data/data_reader
DATABASE_ITEMS := src/data/database_items
LOCATION := src/data/location
MEMBER := src/user/member
PASSENGER := src/user/passenger
DRIVER := src/user/driver
TRIP := src/data/trip

#------frontend to backend------#
HTML_MAKER := src/web/html_maker
HANDLERS := src/web/handlers
SERVER_LISTS := src/web/server_lists
MYSERVER = src/web/myserver

#------aphttp------#
RESPONSE := src/utils/response
UTILITIES := src/utils/utilities
REQUEST := src/utils/request
TEMPLATE_PARSER := src/utils/template_parser
INCLUDE = src/utils/include

SERVER = src/server/server
ROUTE = src/server/route

all: ${BUILD_DIR} ${EXECUTABLE} ${SQLITE_DATABASE_FILE}

${BUILD_DIR}:
	mkdir -p ${BUILD_DIR}

${SQLITE_DATABASE_FILE}:
	sqlite3 ${SQLITE_DATABASE_FILE} < initial_setup.sql

${EXECUTABLE}: ${ALL_OBJECTS}
	${CC} ${ALL_OBJECTS} -o ${EXECUTABLE} -lsqlite3

${BUILD_DIR}/main.o: ${INTERFACE}.hpp ${SERVER}.hpp ${BUILD_DIR}/interface.o ${MAIN}.cpp
	${CC} -c ${MAIN}.cpp -o ${BUILD_DIR}/main.o

${BUILD_DIR}/interface.o: ${INTERFACE}.hpp ${INTERFACE}.cpp ${APHTTP_OBJECTS} ${INTERFACE_ADDITIONAL_OBJECTS} ${DEFINES}
	${CC} -c ${INTERFACE}.cpp -o ${BUILD_DIR}/interface.o

${BUILD_DIR}/myserver.o: ${MYSERVER}.cpp ${MYSERVER}.hpp
	${CC} -c ${MYSERVER}.cpp -o ${BUILD_DIR}/myserver.o

${BUILD_DIR}/html_maker.o: ${HTML_MAKER}.hpp ${HTML_MAKER}.cpp
	${CC} -c ${HTML_MAKER}.cpp -o ${BUILD_DIR}/html_maker.o

${BUILD_DIR}/handlers.o: ${HANDLERS}.cpp ${HANDLERS}.hpp
	${CC} -c ${HANDLERS}.cpp -o ${BUILD_DIR}/handlers.o

${BUILD_DIR}/server_lists.o: ${INTERFACE}.hpp src/web/server_lists.cpp
	${CC} -c src/web/server_lists.cpp -o ${BUILD_DIR}/server_lists.o

${BUILD_DIR}/utaxi.o: ${UTAXI}.cpp ${UTAXI}.hpp ${DEFINES}
	${CC} -c ${UTAXI}.cpp -o ${BUILD_DIR}/utaxi.o

${BUILD_DIR}/database.o: ${DATABASE}.cpp ${DATABASE}.hpp ${DATABASE_OBJECTS} ${SQLITE}
	${CC} -c ${DATABASE}.cpp -o ${BUILD_DIR}/database.o

${BUILD_DIR}/general.o: ${LOCATION}.hpp ${GENERAL}.cpp ${GENERAL}.hpp ${DEFINES}
	${CC} -c ${GENERAL}.cpp -o ${BUILD_DIR}/general.o

${BUILD_DIR}/database_items.o: ${DATABASE_ITEMS}.hpp ${DATABASE_ITEMS}.cpp ${DEFINES}
	${CC} -c ${DATABASE_ITEMS}.cpp -o ${BUILD_DIR}/database_items.o

${BUILD_DIR}/datareader.o: ${DATA_READER}.cpp ${DATA_READER}.hpp ${DEFINES}
	${CC} -c ${DATA_READER}.cpp -o ${BUILD_DIR}/datareader.o

${BUILD_DIR}/location.o: ${GENERAL}.hpp ${LOCATION}.cpp ${LOCATION}.hpp ${DEFINES}
	${CC} -c ${LOCATION}.cpp -o ${BUILD_DIR}/location.o

${BUILD_DIR}/member.o: ${MEMBER}.cpp ${MEMBER}.hpp ${DEFINES}
	${CC} -c ${MEMBER}.cpp -o ${BUILD_DIR}/member.o

${BUILD_DIR}/passenger.o: ${MEMBER}.hpp ${PASSENGER}.cpp ${PASSENGER}.hpp ${DEFINES}
	${CC} -c ${PASSENGER}.cpp -o ${BUILD_DIR}/passenger.o

${BUILD_DIR}/driver.o: ${MEMBER}.hpp ${DRIVER}.cpp ${DRIVER}.hpp ${DEFINES}
	${CC} -c ${DRIVER}.cpp -o ${BUILD_DIR}/driver.o

${BUILD_DIR}/trip.o: ${TRIP}.cpp ${TRIP}.hpp ${DEFINES}
	${CC} -c ${TRIP}.cpp -o ${BUILD_DIR}/trip.o
#------------------------------------------------------------------------------------------------------------------------------------------------#

${BUILD_DIR}/response.o: ${RESPONSE}.hpp ${RESPONSE}.cpp ${INCLUDE}.hpp
	${CC} -c ${RESPONSE}.cpp -o ${BUILD_DIR}/response.o

${BUILD_DIR}/request.o: ${REQUEST}.cpp ${REQUEST}.hpp ${INCLUDE}.hpp ${UTILITIES}.hpp
	${CC} -c ${REQUEST}.cpp -o ${BUILD_DIR}/request.o

${BUILD_DIR}/utilities.o: ${UTILITIES}.cpp ${UTILITIES}.hpp
	${CC} -c ${UTILITIES}.cpp -o ${BUILD_DIR}/utilities.o

${BUILD_DIR}/server.o: ${SERVER}.cpp ${SERVER}.hpp ${ROUTE}.hpp ${UTILITIES}.hpp ${RESPONSE}.hpp ${REQUEST}.hpp ${INCLUDE}.hpp ${TEMPLATE_PARSER}.hpp ${TEMPLATE_PARSER}.cpp
	${CC} -c ${SERVER}.cpp -o ${BUILD_DIR}/server.o

${BUILD_DIR}/route.o: ${ROUTE}.cpp ${ROUTE}.hpp ${UTILITIES}.hpp ${RESPONSE}.hpp ${REQUEST}.hpp ${INCLUDE}.hpp
	${CC} -c ${ROUTE}.cpp -o ${BUILD_DIR}/route.o

${BUILD_DIR}/template_parser.o: ${TEMPLATE_PARSER}.cpp ${TEMPLATE_PARSER}.hpp ${REQUEST}.cpp ${REQUEST}.hpp ${UTILITIES}.hpp ${UTILITIES}.cpp
	${CC} -c ${TEMPLATE_PARSER}.cpp -o ${BUILD_DIR}/template_parser.o

.PHONY: clean all
clean:
	rm -r ${BUILD_DIR}/*.o
