CC = g++
CFLAGS = -std=c++11

all: supplier.out customer.out restaurant.out

supplier.out: supplier.o connection.o utils.o ingredients.o
	$(CC) $(CFLAGS) supplier.o connection.o utils.o ingredients.o -o supplier.out

customer.out: customer.o connection.o utils.o
	$(CC) $(CFLAGS) customer.o connection.o utils.o -o customer.out

restaurant.out: restaurant.o connection.o utils.o ingredients.o
	$(CC) $(CFLAGS) restaurant.o connection.o utils.o ingredients.o -o restaurant.out

supplier.o: supplier.c supplier.h
	$(CC) $(CFLAGS) -c supplier.c
	
connection.o: connection.c connection.h
	$(CC) $(CFLAGS) -c connection.c

utils.o: utils.c utils.h
	$(CC) $(CFLAGS) -c utils.c

ingredients.o: ingredients.c ingredients.h
	$(CC) $(CFLAGS) -c ingredients.c

customer.o: customer.c customer.h
	$(CC) $(CFLAGS) -c customer.c

restaurant.o: restaurant.c restaurant.h
	$(CC) $(CFLAGS) -c restaurant.c

clean:
	rm -f *.o supplier.out customer.out restaurant.out
