//
//  IMMessageCenter.h
//  IMClone
//
//  Created by Maxthon Chan on 13-2-28.
//  Copyright (c) 2013年 myWorld Creations. All rights reserved.
//

#import <IMKit/IMDecls.h>

IMBeginDecls

@class IMMessageCenter, IMMessage;

@protocol IMMessageCenterDelegate <NSObject>

@optional

- (void)messageCenter:(IMMessageCenter *)messageCenter
didRegisterWithServer:(NSURL *)url
         withUserInfo:(NSDictionary *)info;

- (void)messageCenter:(IMMessageCenter *)messageCenter
failedToRegisterWithServer:(NSURL *)url
         withUserInfo:(NSDictionary *)info
                error:(NSError *)error;

- (void)messageCenter:(IMMessageCenter *)messageCenter
didUnregisterFromServer:(NSURL *)url;

@end

@interface IMMessageCenter : NSObject

@property (weak) id<IMMessageCenterDelegate> delegate;

+ (instancetype)messageCenterAtURL:(NSURL *)url;

- (id)initWithURL:(NSURL *)url;

- (void)registerWithIdentifier:(NSString *)identifier
                      userInfo:(NSDictionary *)info;

- (void)unregister;

- (void)sendMessage:(IMMessage *)message;


@end

IMEndDecls
