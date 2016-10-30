#############################################################################
# Makefile for building Apex-Macros utility
#############################################################################

####### Compiler, tools and options

CC            = gcc
FLAGS         = -m64 -pipe -O3 -Wall -W -D_REENTRANT
LINK          = gcc
LFLAGS        = -m64 -Wl,-O3
LIBS          = -lhidapi-libusb
DEL_FILE      = rm -f


####### Files

SOURCES       = main.c
OBJECTS       = main.o
TARGET        = apex-macros
INSTALLPREFIX = /usr/local/bin


####### Build rules

.PHONY: clean delete install

all: Makefile $(TARGET)

$(TARGET): $(OBJECTS)
	$(LINK) $(LFLAGS) -o $(TARGET) $(OBJECTS) $(LIBS)

clean:
	-$(DEL_FILE) $(OBJECTS)

delete: clean
	-$(DEL_FILE) $(TARGET)

install:
	@mv -v $(TARGET) $(INSTALLPREFIX)/$(TARGET)
	@chmod 755 $(INSTALLPREFIX)/$(TARGET)

####### Compile

main.o: main.c
	$(CC) -c $(FLAGS) -o main.o main.c
