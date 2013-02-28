//
//  IMServerDecls.h
//  IMClone
//
//  Created by Maxthon Chan on 13-2-28.
//  Copyright (c) 2013年 myWorld Creations. All rights reserved.
//

#ifndef IMClone_IMServerDecls_h
#define IMClone_IMServerDecls_h

#import <IMKit/IMKit.h>

#if __has_builtin(__builtin_unreachable)
#define IMUnrechable() __builtin_unreachable()
#define IMNoReturn __attribute__((noreturn))
#else
#define IMUnrechable()
#define IMNoReturn
#endif

#define IMServerVersion "0.1.1-1r1 (git master)"

#endif
