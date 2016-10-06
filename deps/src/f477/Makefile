UNAME := $(shell uname)
ifeq ($(UNAME), Darwin)
  F477LIB = libf477.dylib
else
  F477LIB = libf477.so
endif

all: install

install: sharedlib
	mkdir -p ../../usr/lib
	cp $(F477LIB) ../../usr/lib

sharedlib:  f477.o
	$(CC) -Wall -fPIC -shared f477.o -o $(F477LIB)

f477.o: f477.c
	$(CC) -Wall -c -O2 -fPIC f477.c

clean:
	-rm *.o *.so *.dylib
