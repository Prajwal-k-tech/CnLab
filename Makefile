# Makefile for SHA-1 implementation (RFC 3174)
CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -O2

# Targets
all: sha1test

sha1test: sha1test.o sha1.o
	$(CC) $(CFLAGS) -o sha1test sha1test.o sha1.o

sha1test.o: sha1test.c sha1.h
	$(CC) $(CFLAGS) -c sha1test.c

sha1.o: sha1.c sha1.h
	$(CC) $(CFLAGS) -c sha1.c

clean:
	rm -f sha1test sha1test.o sha1.o

test: sha1test
	./sha1test

.PHONY: all clean test