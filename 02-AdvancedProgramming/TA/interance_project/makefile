
AP_Pro.out: Tree.o Node.o main.o IO.o
	g++ -std=c++11 Tree.o Node.o main.o IO.o -o AP_Pro.out

Tree.o: Tree.cpp Tree.h
	g++ -std=c++11 -c Tree.cpp
	
Node.o: Node.cpp Node.h
	g++ -std=c++11 -c Node.cpp

main.o: main.cpp
	g++ -std=c++11 -c main.cpp

IO.o: IO.cpp IO.h
	g++ -std=c++11 -c IO.cpp

.PHONY: clean
clean:
	rm *.o
