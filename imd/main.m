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
        
        NSUInteger versionIndex = [args indexOfObject:@"--version"];
        NSUInteger helpIndex = [args indexOfObject:@"--help"];
        
        if (versionIndex != NSNotFound && versionIndex > 0)
        {
            // Show the version info.
            eprintf("IMServer %s\n", IMServerVersion);
            eprintf("IMKit %s\n", IMKitVersion);
            eprintf("\n");
            eprintf("This is FREE SOFTWARE. You can freely use, modify, copy and redistribute this software.\n");
            eprintf("Built with %s %s.\n", CC_TYPE, __clang_version__);
            exit(0);
        }
        
        if (helpIndex != NSNotFound && helpIndex > 0)
        {
            // Show the help info.
            eprintf("IMServer %s\n", IMServerVersion);
            eprintf("IMKit %s\n", IMKitVersion);
            eprintf("\n");
            eprintf("USAGE:\t%s [--detach]\n", [[(NSString *)args[0] lastPathComponent] cStringUsingEncoding:[NSString defaultCStringEncoding]]);
            eprintf("\t--detach: Detach after spawn - run as classical UNIX daemon.\n");
            eprintf("\t          Do not use --detach with upstart and launchd.\n");
            eprintf("\n");
            eprintf("This is FREE SOFTWARE. You can freely use, modify, copy and redistribute this software.\n");
            eprintf("Built with %s %s.\n", CC_TYPE, __clang_version__);
            exit(0);
        }
        
        [[IMMessageServer messageServer] launch];
        
    }
    return 0;
}

