//
//  IMMessage.m
//  IMClone
//
//  Created by Maxthon Chan on 13-2-28.
//  Copyright (c) 2013年 myWorld Creations. All rights reserved.
//

#import "IMMessage.h"
#import "NSData+DataSigning.h"

NSString *const IMServerTarget = @"server@im.maxius.tk";

@implementation IMMessage

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    NSDictionary *sourceDictionary = @{@"target": self.target,
                                       @"message": self.message,
                                       @"data": self.userData};
    
    NSData *sourceData = [NSPropertyListSerialization dataFromPropertyList:sourceDictionary
                                                                    format:NSPropertyListBinaryFormat_v1_0
                                                          errorDescription:nil];
    
    if (!sourceData)
        return;
    
    NSData *hash = [sourceData sha512];
    
    // Generate the signature;
    NSData *signature = [NSData dataWithData:hash];
    
    [aCoder encodeObject:sourceData forKey:@"data"];
    [aCoder encodeObject:signature forKey:@"signature"];
}

@end
