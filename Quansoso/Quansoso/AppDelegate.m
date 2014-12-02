//
//  AppDelegate.m
//  Quansoso
//
//  Created by  striveliu on 14-9-13.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "AppDelegate.h"
#import <TAESDK/TAESDK.h>
#import "QSRootViewController.h"
#import "NetManager.h"
#import "SVProgressHUD.h"
#import "MobClick.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "WeiboSDK.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.rootvc = [[QSRootViewController alloc] initWithNibName:nil bundle:nil];
    
    self.rootNav = [[UINavigationController alloc] initWithRootViewController:self.rootvc];
    self.window.backgroundColor = [UIColor blackColor];
    self.window.rootViewController = self.rootNav;
    [self initTBSDK];
    [self.window makeKeyAndVisible];
    [self umengregister];
    [WeiboSDK registerApp:kAppKey];
    [self performSelector:@selector(registerRemoteToken) withObject:nil afterDelay:5];
    return YES;
}

///注册友盟
- (void)umengregister
{
    NSDictionary *bundleDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [bundleDic objectForKey:@"CFBundleShortVersionString"];
    [MobClick startWithAppkey:kUMENG_APPKEY reportPolicy:SENDWIFIONLY channelId:nil];
    [UMSocialData setAppKey:kUMENG_APPKEY];
    [UMSocialWechatHandler setWXAppId:kShareWEIXINAPPID appSecret:kShareWEIXINAPPSECRET url:@"http://app.hu8hu.com/"];
    [MobClick setAppVersion:appVersion];
}


- (void)initTBSDK
{
    [[TaeSDK sharedInstance] asyncInit:^{
        MLOG(@"TBSDK--初始化成功");
        [[NSNotificationCenter defaultCenter] postNotificationName:kTaeSDKInitSuccessMsg object:nil];
    } failedCallback:^(NSError *error) {
        MLOG(@"TBSDK--初始化失败");
        [SVProgressHUD showErrorWithStatus:@"初始化失败" cover:YES offsetY:kMainScreenHeight/2.0];
    }];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [[TaeSDK sharedInstance] handleOpenURL:url];
    [self.rootvc viewWillAppear:YES];
    return YES;
}

#pragma mark 注册devicetoken
- (void)registerRemoteToken
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    MLOG(@"fasfas");
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    MLOG(@"registertoken_error");
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    if(deviceToken)
    {
        NSString *strToken  = [NSString stringWithFormat:@"%@",deviceToken];
        MLOG(@"device_token = %@",strToken);
        NSString *oldToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceToken"];
        if(![oldToken isEqualToString:strToken])//如果不等就上报
        {
            NSString *struserNick = [[TaeSession sharedInstance] getUser].nick?[[TaeSession sharedInstance] getUser].nick:@"0";
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"upload_token", @"service", strToken,@"token",struserNick,@"tbNick",nil];
            NSString *devurl = @"http://quansoso.uz.taobao.com/d/cr/rest";
            [NetManager requestWith:dict url:devurl method:@"GET" operationKey:[self description] parameEncoding:AFFormURLParameterEncoding succ:^(NSDictionary *successDict) {
                [[NSUserDefaults standardUserDefaults] setObject:strToken forKey:@"DeviceToken"];
                MLOG(@"%@", successDict);
            } failure:^(NSDictionary *failDict, NSError *error) {
                MLOG(@"%@", failDict);
            }];
        }
        
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	
	[[QSDataSevice sharedQSDataSevice] saveData];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
