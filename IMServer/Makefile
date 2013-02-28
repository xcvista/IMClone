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
LDFLAGS := $(LDFLAGS) -framework Foundation -arch x86_64

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
LDFLAGS := $(LDFLAGS) `gnustep-config --base-libs` -ldispatch

DYLIB_EXT := so
DYLIB := lib$(PRODUCT).$(DYLIB_EXT)

endif

OBJS := $(CSRCS:.c=.o) $(CXXSRCS:.cc=.o) $(OBJCSRCS:.m=.o) $(OBJCXXSRCS:.mm=.o)
TARGETS := $(DYLIB) lib$(PRODUCT).a
HEADER_DIR := $(PRODUCT)

all: $(HEADER_DIR) $(TARGETS)

.PHONY: all clean install uninstall

lib$(PRODUCT).$(DYLIB_EXT): $(OBJS)
	$(LD) -o $@ $(LDFLAGS) $(OBJS) -shared

$(PRODUCT).framework: lib$(PRODUCT).$(DYLIB_EXT) Headers $(PRODUCT)-Info.plist
	mkdir -p $(PRODUCT).framework/Versions/A/Resources
	cp lib$(PRODUCT).$(DYLIB_EXT) $(PRODUCT).framework/Versions/A/$(PRODUCT)
	cp $(PRODUCT)-Info.plist $(PRODUCT).framework/Versions/A/Resources/Info.plist
	cp -r Headers $(PRODUCT).framework/Versions/A/Headers
	cd $(PRODUCT).framework/Versions && ln -s A Current
	cd $(PRODUCT).framework && ln -s Versions/Current/$(PRODUCT) $(PRODUCT)
	cd $(PRODUCT).framework && ln -s Versions/Current/Resources Resources
	cd $(PRODUCT).framework && ln -s Versions/Current/Headers Headers

lib$(PRODUCT).a: $(OBJS)
	$(AR) -q $@ $(OBJS)

.c.o:
	$(CC) $(CFLAGS) $< -o $@

.m.o:
	$(CC) $(CFLAGS) $(OBJCFLAGS) $< -o $@

.cc.o:
	$(CXX) $(CFLAGS) $(CXXFLAGS) $< -o $@

.mm.o:
	$(CXX) $(CFLAGS) $(CXXFLAGS) $(OBJCFLAGS) $(OBJCXXFLAGS) $< -o $@

Headers: $(HEADERS)
	mkdir -p Headers
	cp $(HEADERS) Headers

$(HEADER_DIR): Headers
	ln -s Headers $(HEADER_DIR)

clean:
	-rm $(HEADER_DIR)
	-rm Headers -r
	-rm $(TARGETS) -r
	-rm $(OBJS)

ifeq ($(shell uname), Darwin)

# OS X Install

install: all
	cp $(PRODUCT).framework /Library/Frameworks -r
	ln /Library/Frameworks/$(PRODUCT).framework/$(PRODUCT) /usr/lib/lib$(PRODUCT).dylib

uninstall:
	-rm /usr/lib/lib$(PRODUCT).dylib
	rm /Library/Frameworks/$(PRODUCT).framework -r

else

# Linux Install

install: all
	cp lib$(PRODUCT).$(DYLIB_EXT) $(GNUSTEP_LIBRARIES)
	cp Headers $(GNUSTEP_HEADERS)/$(HEADER_DIR)

uninstall:
	rm $(GNUSTEP_LIBRARIES)/lib$(PRODUCT).$(DYLIB_EXT)
	rm -r $(GNUSTEP_HEADERS)/$(HEADER_DIR)

endif

