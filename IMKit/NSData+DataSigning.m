//
//  NSData+DataSigning.m
//  IMClone
//
//  Created by Maxthon Chan on 13-2-28.
//  Copyright (c) 2013年 myWorld Creations. All rights reserved.
//

#import "NSData+DataSigning.h"

#if defined(GNUSTEP)

// On Linux, use OpenSSL

#import <openssl/sha.h>
#define IMSHA512DigestLength SHA512_DIGEST_LENGTH
#define IMSHA512Digest SHA512
typedef size_t IMSHA512Size;

#else

// On OS X and iOS, use Common Crypto

#import <CommonCrypto/CommonCrypto.h>
#define IMSHA512DigestLength CC_SHA512_DIGEST_LENGTH
#define IMSHA512Digest CC_SHA512
typedef CC_LONG IMSHA512Size;

#endif

@implementation NSData (DataSigning)

- (NSData *)sha512
{
    unsigned char hash[IMSHA512DigestLength];
    IMSHA512Digest([self bytes], (IMSHA512Size)[self length], hash);
    return [NSData dataWithBytes:hash
                          length:IMSHA512DigestLength];
}

@end
