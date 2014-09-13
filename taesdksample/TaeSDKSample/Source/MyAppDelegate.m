//
//  TBAppDelegate.m
//  taesdk
//
//  Created by lai on 14-7-23.
//  Copyright (c) 2014年 com.taobao. All rights reserved.
//

#import "MyAppDelegate.h"

#import "TCViewController.h"        //QX



@implementation MyAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
   
    
    TCViewController *tcViewController = [[TCViewController alloc]init];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:tcViewController];
    
    //QX    MyDemoViewController *demoViewController=[[MyDemoViewController alloc] init];
    //QX    UINavigationController *navController=[[UINavigationController alloc] initWithRootViewController:demoViewController];
    
    
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    //sdk初始化
    [[TaeSDK sharedInstance] asyncInit:^{
        NSLog(@"初始化成功");
    } failedCallback:^(NSError *error) {
         NSLog(@"初始化失败:%@",error);
    }];
    
    //登录状态监听
    [[TaeSDK sharedInstance] setSessionStateChangedHandler:^(TaeSession *session) {
        if([session isLogin]){//未登录变为已登录
            NSLog(@"用户login");
        }else{//已登录变为未登录
            NSLog(@"用户logout");

        }
    }];
    
    return YES;
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    //改URL是否已经被TAE处理过
    BOOL wasHandled=[[TaeSDK sharedInstance] handleOpenURL:url];
    //开发者继续自己处理
    
    return YES;
}



@end
