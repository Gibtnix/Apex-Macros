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
INSTALLPREFIX ?= /usr/local/bin

####### Files

SOURCES       = main.c
OBJECTS       = main.o
TARGET        = apex-macros
RULESFILE     = 90-apex.rules

####### Build rules

.PHONY: clean delete install

all: Makefile $(TARGET) $(RULESFILE)

$(TARGET): $(OBJECTS)
	$(LINK) $(LDFLAGS) -o $(TARGET) $(OBJECTS) $(LDLIBS)

clean:
	-$(RM) $(OBJECTS)

delete: clean
	-$(RM) $(TARGET) $(RULESFILE)

install:
	@mv -v $(TARGET) $(INSTALLPREFIX)/$(TARGET)
	@chmod 755 $(INSTALLPREFIX)/$(TARGET)

####### Compile

$(RULESFILE): gen_rules.sh
	./gen_rules.sh

main.o: main.c
	$(CC) -c $(CFLAGS) -o main.o main.c
