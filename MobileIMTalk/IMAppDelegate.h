//
//  IMAppDelegate.h
//  MobileIMTalk
//
//  Created by Maxthon Chan on 13-3-1.
//  Copyright (c) 2013年 myWorld Creations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileIMKit/IMKit.h>

@interface IMAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property IMMessageCenter *messageCenter;

@end
