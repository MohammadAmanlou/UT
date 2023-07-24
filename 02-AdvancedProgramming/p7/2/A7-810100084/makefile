CC := g++ -std=c++11 -g

all:utaxi.out

utaxi.out: objects/main.o objects/person.o objects/utax.o objects/trip.o
	$(CC) objects/main.o objects/person.o objects/utax.o objects/trip.o -o utaxi.out

objects/main.o: person.hpp trip.hpp utax.hpp main.cpp
	$(CC) -c main.cpp -o objects/main.o

objects/person.o: person.cpp
	$(CC) -c person.cpp -o objects/person.o

objects/utax.o: person.hpp trip.hpp utax.cpp
	$(CC) -c utax.cpp -o objects/utax.o

objects/trip.o: person.hpp trip.cpp
	$(CC) -c trip.cpp -o objects/trip.o

.PHONY: clean
clean:
	rm -r objects/*.o