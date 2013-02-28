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

DYLIB := libIMKit.so IMKit.framework

else

# Linux

CC := clang
CXX := clang++
LD := clang
AR := ar

CFLAGS := $(CFLAGS) -fblocks -Wall -O2 -c -I. -std=gnu99
CXXFLAGS := $(CXXFLAGS)
OBJCFLAGS := $(OBJCFLAGS) `gnustep-config --objc-flags` -fobjc-arc -Xclang -fobjc-default-synthesize-properties -ObjC
OBJCXXFLAGS := $(OBJCXXFLAGS)
LDFLAGS := $(LDFLAGS) `gnustep-config --base-libs` -ldispatch

DYLIB := libIMKit.so

endif

OBJS := $(CSRCS:.c=.o) $(CXXSRCS:.cc=.o) $(OBJCSRCS:.m=.o) $(OBJCXXSRCS:.mm=.o)
TARGETS := $(DYLIB) libIMKit.a
HEADER_DIR := IMKit

all: $(HEADER_DIR) $(TARGETS)

.PHONY: all clean

libIMKit.so: $(OBJS)
	$(LD) -o $@ $(LDFLAGS) $(OBJS) -shared

IMKit.framework: libIMKit.so Headers IMKit-Info.plist
	mkdir -p IMKit.framework/Versions/A/Resources
	cp libIMKit.so IMKit.framework/Versions/A/IMKit
	cp IMKit-Info.plist IMKit.framework/Versions/A/Resources/Info.plist
	cp -r Headers IMKit.framework/Versions/A/Headers
	cd IMKit.framework/Versions && ln -s A Current
	cd IMKit.framework && ln -s Versions/Current/IMKit IMKit
	cd IMKit.framework && ln -s Versions/Current/Resources Resources
	cd IMKit.framework && ln -s Versions/Current/Headers Headers

libIMKit.a: $(OBJS)
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
	
