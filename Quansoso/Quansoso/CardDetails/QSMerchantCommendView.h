//
//  QSMerchantCommendView.h
//  Quansoso
//
//  Created by qf on 14/11/27.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QSMerchantCommendDelegate <NSObject>

- (void)gotoMoreCard;

@end

@interface QSMerchantCommendView : UIView
@property (nonatomic,strong) NSString *webSiteUrl;
@property (nonatomic,strong) id<QSMerchantCommendDelegate> delegate;
@end