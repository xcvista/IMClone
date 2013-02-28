//
//  main.h
//  IMClone
//
//  Created by Maxthon Chan on 13-2-28.
//  Copyright (c) 2013年 myWorld Creations. All rights reserved.
//

#ifndef IMClone_main_h
#define IMClone_main_h

#import <IMServer/IMServer.h>

#ifdef __APPLE_CC__
#define CC_TYPE "Apple LLVM Compiler"
#else
#define CC_TYPE "clang"
#endif

#define eprintf(format, ...) fprintf(stderr, format, ##__VA_ARGS__)

#endif
