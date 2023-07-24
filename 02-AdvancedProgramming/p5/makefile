CC := g++ -std=c++11
CCFLAGS += -l SDL2 -l SDL2_image -l SDL2_ttf -l SDL2_mixer

all: starwars.out

starwars.out: objects/main.o objects/rsdl.o objects/game.o objects/ship.o objects/rifle.o objects/enemy.o
	$(CC) objects/main.o objects/rsdl.o objects/game.o objects/ship.o objects/rifle.o objects/enemy.o $(CCFLAGS) -o starwars.out

objects/main.o: rsdl.hpp game.hpp ship.hpp rifle.hpp enemy.hpp main.cpp
	$(CC) -c main.cpp -o objects/main.o

objects/game.o: rsdl.hpp game.hpp ship.hpp rifle.hpp enemy.hpp game.cpp 
	$(CC) -c game.cpp -o objects/game.o

objects/ship.o: rsdl.hpp ship.hpp rifle.hpp ship.cpp  
	$(CC) -c ship.cpp -o objects/ship.o

objects/rifle.o: rsdl.hpp rifle.hpp rifle.cpp  
	$(CC) -c rifle.cpp -o objects/rifle.o

objects/enemy.o: rsdl.hpp enemy.hpp enemy.cpp  
	$(CC) -c enemy.cpp -o objects/enemy.o

objects/rsdl.o: rsdl.hpp rsdl.cpp
	$(CC) -c rsdl.cpp -o objects/rsdl.o

.PHONY: clean
clean:
	rm -r objects/*.o