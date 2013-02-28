#
# Makefile
#
#
# Created by Maxthon Chan on 13-2-28.
# Copyright (c) 2013年 myWorld Creations. All rights reserved.
#

# Files

include files.mk

ifeq ($(shell uname), Darwin)

# OS X

CC := xcrun clang
CXX := xcrun clang++
LD := xcrun clang
AR := xcrun ar

CFLAGS := $(CFLAGS) -fblocks -Wall -O2 -c -I. -std=gnu99 -arch x86_64
CXXFLAGS := $(CXXFLAGS)
OBJCFLAGS := $(OBJCFLAGS) -fobjc-arc -Xclang -fobjc-default-synthesize-properties
OBJCXXFLAGS := $(OBJCXXFLAGS)
LDFLAGS := $(LDFLAGS) -framework Foundation -framework IMServer -framework IMKit -arch x86_64

DYLIB_EXT := dylib
DYLIB := lib$(PRODUCT).$(DYLIB_EXT) $(PRODUCT).framework

else

# Linux

#Use GNUstep
include $(GNUSTEP_MAKEFILES)/common.make

CC := clang
CXX := clang++
LD := clang
AR := ar

CFLAGS := $(CFLAGS) -fblocks -Wall -O2 -c -I. -std=gnu99
CXXFLAGS := $(CXXFLAGS)
OBJCFLAGS := $(OBJCFLAGS) `gnustep-config --objc-flags` -fobjc-arc -Xclang -fobjc-default-synthesize-properties -ObjC
OBJCXXFLAGS := $(OBJCXXFLAGS)
LDFLAGS := $(LDFLAGS) `gnustep-config --base-libs` -ldispatch -lIMServer -lIMKit

DYLIB_EXT := so
DYLIB := lib$(PRODUCT).$(DYLIB_EXT)

endif

OBJS := $(CSRCS:.c=.o) $(CXXSRCS:.cc=.o) $(OBJCSRCS:.m=.o) $(OBJCXXSRCS:.mm=.o)
TARGETS := $(PRODUCT)

all: $(TARGETS)

.PHONY: all clean install uninstall

$(PRODUCT): $(OBJS)
	$(LD) -o $@ $(LDFLAGS) $(OBJS)

.c.o:
	$(CC) $(CFLAGS) $< -o $@

.m.o:
	$(CC) $(CFLAGS) $(OBJCFLAGS) $< -o $@

.cc.o:
	$(CXX) $(CFLAGS) $(CXXFLAGS) $< -o $@

.mm.o:
	$(CXX) $(CFLAGS) $(CXXFLAGS) $(OBJCFLAGS) $(OBJCXXFLAGS) $< -o $@

clean:
	-rm $(TARGETS) -r
	-rm $(OBJS)

install: all
	cp $(PRODUCT) /usr/bin -r

uninstall:
	rm /usr/bin/$(PRODUCT)


