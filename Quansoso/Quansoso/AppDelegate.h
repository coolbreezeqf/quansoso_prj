//
//  AppDelegate.h
//  Quansoso
//
//  Created by  striveliu on 14-9-13.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QSRootViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) QSRootViewController *rootvc;
@property (strong, nonatomic) UINavigationController *rootNav;
@end

