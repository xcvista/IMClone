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
    [aCoder encodeObject:self.target forKey:@"target"];
    [aCoder encodeObject:self.message forKey:@"message"];
    [aCoder encodeObject:self.userData forKey:@"userData"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.target = [aDecoder decodeObjectForKey:@"target"];
        self.message = [aDecoder decodeObjectForKey:@"message"];
        self.userData = [aDecoder decodeObjectForKey:@"userData"];
    }
    return self;
}


@end
