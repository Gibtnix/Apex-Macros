#############################################################################
# Makefile for building Apex-Macros utility
#############################################################################

####### Compiler, tools and options

CC            ?= gcc
CFLAGS        ?= -m64 -pipe -O3 -Wall -W -D_REENTRANT
LINK          ?= gcc
LDFLAGS       ?= -m64 -Wl,-O3
LDLIBS        ?= -lhidapi-libusb
RM            ?= rm -f


####### Files

SOURCES       = main.c
OBJECTS       = main.o
TARGET        = apex-macros
INSTALLPREFIX = /usr/local/bin


####### Build rules

.PHONY: clean delete install

all: Makefile $(TARGET)

$(TARGET): $(OBJECTS)
	$(LINK) $(LDFLAGS) -o $(TARGET) $(OBJECTS) $(LDLIBS)

clean:
	-$(RM) $(OBJECTS)

delete: clean
	-$(RM) $(TARGET)

install:
	@mv -v $(TARGET) $(INSTALLPREFIX)/$(TARGET)
	@chmod 755 $(INSTALLPREFIX)/$(TARGET)

####### Compile

main.o: main.c
	$(CC) -c $(CFLAGS) -o main.o main.c
