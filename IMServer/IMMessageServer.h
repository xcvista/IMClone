//
//  IMMessageServer.h
//  IMClone
//
//  Created by Maxthon Chan on 13-2-28.
//  Copyright (c) 2013年 myWorld Creations. All rights reserved.
//

#import <IMServer/IMServerDecls.h>

IMBeginDecls

@interface IMMessageServer : NSObject

+ (IMInstanceType)messageServer;

- (void)launch IMNoReturn;

@end

IMEndDecls
