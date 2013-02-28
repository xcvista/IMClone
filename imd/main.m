//
//  main.m
//  imd
//
//  Created by Maxthon Chan on 13-2-28.
//  Copyright (c) 2013年 myWorld Creations. All rights reserved.
//

#import "main.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSArray *args = [[NSProcessInfo processInfo] arguments];
        
        if ([args count] > 1)
            args = [args subarrayWithRange:NSMakeRange(1, [args count] - 1)];
        else
            args = @[];
        
        if ([args indexOfObject:@"--version"] != NSNotFound)
        {
            // Show the version info.
            eprintf("IMServer %s\n", IMServerVersion);
            eprintf("IMKit %s\n", IMKitVersion);
            eprintf("\n");
            eprintf("This is FREE SOFTWARE. You can freely use, modify, copy and redistribute this software.\n");
            eprintf("Built with %s %s.\n", CC_TYPE, __clang_version__);
            exit(0);
        }
        
        if ([args indexOfObject:@"--help"] != NSNotFound)
        {
            // Show the help info.
            eprintf("IMServer %s\n", IMServerVersion);
            eprintf("IMKit %s\n", IMKitVersion);
            eprintf("\n");
            eprintf("USAGE:\t%s [--reload] [--stop]\n", [[(NSString *)args[0] lastPathComponent] cStringUsingEncoding:[NSString defaultCStringEncoding]]);
            eprintf("\t--reload: Cause the server to reload its settings.\n");
            eprintf("\t--stop:   Stop the server\n");
            eprintf("\n");
            eprintf("This is FREE SOFTWARE. You can freely use, modify, copy and redistribute this software.\n");
            eprintf("Built with %s %s.\n", CC_TYPE, __clang_version__);
            exit(0);
        }
        
        BOOL launch = YES;
        
        if ([args indexOfObject:@"--reload"] != NSNotFound)
        {
            [[NSDistributedNotificationCenter defaultCenter] postNotificationName:IMMessageServerReloadNotification
                                                                           object:nil];
            launch = NO;
        }
        
        if ([args indexOfObject:@"--stop"] != NSNotFound)
        {
            [[NSDistributedNotificationCenter defaultCenter] postNotificationName:IMMessageServerStopNotification
                                                                           object:nil];
            launch = NO;
        }
        
        if (launch)
            [[IMMessageServer messageServer] launch];
        
    }
    return 0;
}

