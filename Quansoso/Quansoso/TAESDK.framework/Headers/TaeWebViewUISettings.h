//
//  TaeWebViewUISettings.h
//  taesdk
//
//  Created by 友和(lai.zhoul@alibaba-inc.com) on 14-8-9.
//  Copyright (c) 2014年 com.taobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaeWebViewUISettings : NSObject

@property(nonatomic, strong) NSString *title ; //顶层 navigatorBar的标题内容
@property(nonatomic, strong) UIFont *titleFont ; //顶层 navigatorBar的标题字体
@property(nonatomic, strong) UIColor *titleColor ; //顶层 navigatorBar的标题字体颜色
@property(nonatomic, strong) UIColor *barTintColor ; //顶层 navigatorBar的背景颜色

@property(nonatomic, strong) UIColor *tintColor ; //顶层 navigatorBar的左右bar的颜色，仅ios7

@end
