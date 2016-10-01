F477LIB = libf477.so
all: $(F477LIB)

f477.o: f477.c
	$(CC) -Wall -c -O2 -fPIC f477.c

# linking to primesieve not neccessary unless we want functions from primesieve.
libf477.so:  f477.o
	gcc -Wall -shared -Wl,-soname,libf477.so f477.o -o $(F477LIB) \
           -lc -L../../usr/lib/ -Wl,-rpath,'$(CURDIR)/../../usr/lib'

install: $(F477LIB)
	mkdir -p ../../usr/lib
	cp $(F477LIB) ../../usr/lib

clean:
	-rm *.o *.so
