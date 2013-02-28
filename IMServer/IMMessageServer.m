//
//  IMMessageServer.m
//  IMClone
//
//  Created by Maxthon Chan on 13-2-28.
//  Copyright (c) 2013年 myWorld Creations. All rights reserved.
//

#import "IMMessageServer.h"
#import "IMMessageRouter.h"

NSString *const IMMessageServerReloadNotification = @"tk.maxius.im.server.reload";
NSString *const IMMessageServerStopNotification = @"tk.maxius.im.server.stop";

IMMessageServer *IMSharedServer = nil;

@interface IMMessageServer ()

@property NSConnection *_connection;
@property NSSocketPort *_port;
@property IMMessageRouter *_router;

- (void)_reload:(id)sender;
- (void)_stop:(id)sender;

@end

@implementation IMMessageServer

+ (IMInstanceType)messageServer
{
    if (!IMSharedServer)
        IMSharedServer = [[IMMessageServer alloc] init];
    return IMSharedServer;
}

- (void)launch
{
    NSArray *args = [[NSProcessInfo processInfo] arguments];
    
    if ([args count] > 1)
        args = [args subarrayWithRange:NSMakeRange(1, [args count] - 1)];
    else
        args = @[];
    
    // Load the configure
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults synchronize];
    
    if (![userDefaults integerForKey:@"port"])
        [userDefaults setInteger:12345 forKey:@"port"];
    if (![[userDefaults objectForKey:@"name"] length])
        [userDefaults setObject:@"IMServer" forKey:@"name"];
    
    // Set up the connection
    self._port = [[NSSocketPort alloc] initWithTCPPort:[userDefaults integerForKey:@"port"]];
    if (![[NSSocketPortNameServer sharedInstance] registerPort:self._port
                                                          name:[userDefaults objectForKey:@"name"]])
    {
        NSLog(@"Server port register failed. Abort.");
        abort();
    }
    
    self._connection = [NSConnection connectionWithReceivePort:self._port
                                                      sendPort:self._port];
    self._router = [[IMMessageRouter alloc] init];
    NSProtocolChecker *protocolChecker = [NSProtocolChecker protocolCheckerWithTarget:self._router protocol:@protocol(IMMessageCenter)];
    [self._connection setRootObject:protocolChecker];
    
    NSLog(@"Server started at <imcl://localhost:%li/%@>", [userDefaults integerForKey:@"port"], [userDefaults objectForKey:@"name"]);
    
    // Set up the notification
    NSDistributedNotificationCenter *notificationCenter = [NSDistributedNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(_reload:)
                               name:IMMessageServerReloadNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(_stop:)
                               name:IMMessageServerStopNotification
                             object:nil];
    
    [[NSRunLoop currentRunLoop] run];
    IMUnrechable();
}

- (void)_reload:(id)sender
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults synchronize];
}

- (void)_stop:(id)sender
{
    [[NSDistributedNotificationCenter defaultCenter] removeObserver:self];
    exit(0);
}

@end
