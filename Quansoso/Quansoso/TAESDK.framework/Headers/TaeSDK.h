//
//  TaeSDK.h
//  taesdk
//
//  Created by 友和(lai.zhoul@alibaba-inc.com) on 14-8-2.
//  Copyright (c) 2014年 com.taobao. All rights reserved.
//

#import "TaeSession.h"
#import "TaeUser.h"
#import "TaeWebViewUISettings.h"
#import "TaeTradeProcessResult.h"
#import "TaeOrderItem.h"
#import "TaeTest.h"

@class TaeOrderItem;
@class TaeTradeProcessResult;
@class TaeSDK;
@class TaeSession;
@class TaeUser;
@class TaeWebViewUISettings;

#pragma -mark SDK 回调定义
/**
 *  初始化结果回调
 */
typedef void (^initSuccessCallback)();
typedef void (^initFailedCallback)(NSError *error);


/**
 *  登录授权结果回调
 */
typedef void (^loginSuccessCallback)(TaeSession *session);
typedef void (^loginFailedCallback)(NSError *error);


/**
 *  会话登入和登出的监听Handler
 *
 *  @param session 返回状态更新后的会话
 */
typedef void (^sessionStateChangedHandler)(TaeSession *session);


/**
 * 交易流程结果回调
 */
typedef void (^tradeProcessSuccessCallback)(TaeTradeProcessResult *tradeProcessResult);
typedef void (^tradeProcessFailedCallback)(NSError *error);

@interface TaeSDK : NSObject

#pragma -mark SDK 基础API
/**
 *
 *  @return 返回单例
 */
+ (TaeSDK *)sharedInstance ;

/**
 *  TaeSDK初始化，异步执行
 */
-(void)asyncInit;

/**
 *  TaeSDK初始化，异步执行
 *
 *  @param sucessCallback 初始化成功回调
 *  @param failedCallback 初始化失败回调
 */
-(void)asyncInit:(initSuccessCallback) sucessCallback
  failedCallback:(initFailedCallback) failedCallback;


/**
 *
 *  @param handler 会话登录状态改变时候的处理handler,可以通过TaeSession isLogin判断当前登录态
 */
-(void) setSessionStateChangedHandler:(sessionStateChangedHandler) handler;

/**
 *  退出登录
 */
-(void) logout;


/**
 *  用于处理其他App的回跳
 *
 *  @param url
 *
 *  @return 是否经过了TaeSDK的处理
 */
-(BOOL)handleOpenURL:(NSURL *) url;




#pragma -mark SDK Show API
/**
 *  请求登录授权，跳转到手机淘宝登录或者本地弹出登录界面
 *
 *  @param parentController app当前的Controller
 *  @param successCallback      登录授权成功的回调，返回TaeSession
 *  @param failedCallback       登录授权失败的回调，返回NSError
 */
-(void) showLogin:(UIViewController *) parentController
  successCallback:(loginSuccessCallback) successCallback
   failedCallback:(loginFailedCallback) failedCallback;



/**
 *  使用TaeSDK的webview打开H5页面，可以自动实现淘宝安全免登
 *
 *  @param parentController  app当前的Controller
 *  @param isNeedPush            是否需要使用parentController的navigatorController进行push
 *  @param pageUrl                  页面的url
 *  @param webViewUISettings        可以自定义的webview配置项
 *  @param tradeProcessSuccessCallback    交易流程成功完成订单支付的回调
 *  @param tradeProcessFailedCallback  交易流程未完成的回调
 */
-(void) showPage:(UIViewController *) parentController
      isNeedPush:(BOOL) isNeedPush
         pageUrl:(NSString *)pageUrl
 webViewUISettings:(TaeWebViewUISettings *)webViewUISettings
tradeProcessSuccessCallback:(tradeProcessSuccessCallback)tradeProcessSuccessCallback
tradeProcessFailedCallback:(tradeProcessFailedCallback)tradeProcessFailedCallback;


/**
 *  打开商品详情页面
 *
 *  @param parentController  app当前的Controller
 *  @param isNeedPush            是否需要使用parentController的navigatorController进行push
 *  @param webViewUISettings        可以自定义的webview配置项
 *  @param itemId                      商品详情页请求参数
 *  @param itemType                      商品类型:1代表淘宝，2代表天猫
 *  @param params                        商品详情页请求附加参数
 *  @param tradeProcessSuccessCallback    交易流程成功完成订单支付的回调
 *  @param tradeProcessFailedCallback  交易流程未完成的回调
 */
-(void)showItemDetail:(UIViewController*)parentController
           isNeedPush:(BOOL) isNeedPush
    webViewUISettings:(TaeWebViewUISettings *)webViewUISettings
               itemId:(NSString *)itemId
             itemType:(NSInteger) itemType
               params:(NSDictionary *)params
tradeProcessSuccessCallback:(tradeProcessSuccessCallback)tradeProcessSuccessCallback
tradeProcessFailedCallback:(tradeProcessFailedCallback)tradeProcessFailedCallback;


/**
 *  打开订单页面
 *
 *  @param parentController  app当前的Controller
 *  @param isNeedPush            是否需要使用parentController的navigatorController进行push
 *  @param webViewUISettings        可以自定义的webview配置项
 *  @param orderItems                      订单请求参数数组，参数类型见 TaeOrderItem
 *  @param tradeProcessSuccessCallback    交易流程成功完成订单支付的回调
 *  @param tradeProcessFailedCallback  交易流程未完成的回调
 */
-(void)showOrder:(UIViewController*)parentController
      isNeedPush:(BOOL) isNeedPush
webViewUISettings:(TaeWebViewUISettings *)webViewUISettings
      orderItems:(NSArray *)orderItems
tradeProcessSuccessCallback:(tradeProcessSuccessCallback)tradeProcessSuccessCallback
tradeProcessFailedCallback:(tradeProcessFailedCallback)tradeProcessFailedCallback;


#pragma -mark SDK 环境定义

typedef enum{
    TaeSDKEnvironmentDaily,  //测试环境
    TaeSDKEnvironmentPreRelease,//预发环境
    TaeSDKEnvironmentRelease//线上环境
} TaeSDKEnvironment;


TaeSDKEnvironment TaeSDKCurrentEnvironment();//当前环境


#pragma -mark SDK 回调Code定义

typedef enum{
    TAE_INIT_FAILED,//SDK初始化失败
    TAE_LOGIN_FAILED,//登录失败
    TAE_TRADE_PROCESS_FAILED //交易链路失败
} TaeSDKCode;




@end



