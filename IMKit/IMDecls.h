//
//  IMDecls.h
//  IMClone
//
//  Created by Maxthon Chan on 13-2-28.
//  Copyright (c) 2013年 myWorld Creations. All rights reserved.
//

#ifndef IMClone_IMDecls_h
#define IMClone_IMDecls_h

#ifndef __has_builtin         // Optional of course.
#define __has_builtin(x) 0  // Compatibility with non-clang compilers.
#endif
#ifndef __has_feature         // Optional of course.
#define __has_feature(x) 0  // Compatibility with non-clang compilers.
#endif
#ifndef __has_extension
#define __has_extension __has_feature // Compatibility with pre-3.0 compilers.
#endif
#ifndef __has_attribute         // Optional of course.
#define __has_attribute(x) 0  // Compatibility with non-clang compilers.
#endif

#if defined(__cplusplus)
#define IMBeginDecls extern "C" {
#define IMEndDecls }
#define IMExtern extern "C"
#else
#define IMBeginDecls
#define IMEndDecls
#define IMExtern extern
#endif

#if !__has_extension(blocks)
#error This product will not build without blocks. Please build with -fblocks.
#endif

#ifdef __OBJC__

#import <Foundation/Foundation.h>

#if !__has_feature(objc_arc)
#warning This product will leak memory without ARC. Please build with -fobjc-arc.
#endif

#if !__has_feature(objc_array_literals) || !__has_feature(objc_dictionary_literals) || !__has_feature(objc_subscripting)
#error This product will not build without Objective-C object literals and subscripting. Please build with clang 3.2+
#endif

#if !__has_feature(objc_default_synthesize_properties)
#warning This product will not function properly without -fobjc-default-synthesize-properties.
#endif

#if __has_feature(objc_instancetype)
#define IMInstanceType instancetype
#else
#define IMInstanceType id
#endif

#endif // __OBJC__

#if  __has_extension(attribute_deprecated_with_message)
#define IMDeprecated(x) __attribute__((deprecated(x)))
#else
#define IMDeprecated(x)
#endif

#if __has_extension(attribute_unavailable_with_message)
#define IMUnavailable(x) __attribute__((unavailable(x)))
#else
#define IMUnanailable(x)
#endif

#if __has_builtin(__builtin_unreachable)
#define IMUnrechable() __builtin_unreachable()
#define IMNoReturn __attribute__((noreturn))
#else
#define IMUnrechable()
#define IMNoReturn
#endif

#define IMKitVersion "0.1.1-1r1 (git master)"

#endif
