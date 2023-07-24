CC := g++ -std=c++11

all:library.out

library.out: objects/main.o objects/person.o objects/library.o objects/documents.o
	$(CC) objects/main.o objects/person.o objects/library.o objects/documents.o -o library.out

objects/main.o: person.hpp library.hpp documents.hpp main.cpp
	$(CC) -c main.cpp -o objects/main.o

objects/person.o: documents.hpp person.cpp
	$(CC) -c person.cpp -o objects/person.o

objects/library.o: person.hpp documents.hpp library.cpp
	$(CC) -c library.cpp -o objects/library.o

objects/documents.o: person.hpp documents.cpp
	$(CC) -c documents.cpp -o objects/documents.o

.PHONY: clean
clean:
	rm -r objects/*.o