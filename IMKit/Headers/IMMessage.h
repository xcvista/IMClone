//
//  IMMessage.h
//  IMClone
//
//  Created by Maxthon Chan on 13-2-28.
//  Copyright (c) 2013年 myWorld Creations. All rights reserved.
//

#import <IMKit/IMDecls.h>

IMBeginDecls

IMExtern NSString *const IMServerTarget;

@interface IMMessage : NSObject <NSCoding>

@property NSString *target;
@property NSString *message;
@property NSDictionary *userData;

@end

IMEndDecls
