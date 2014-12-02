//
//  QSCardDetailsViewController.h
//  Quansoso
//
//  Created by qf on 14/10/11.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSMerchantCommendView.h"
@class QSCards;
@class QSActivity;
@interface QSCardDetailsViewController : BaseViewController<QSMerchantCommendDelegate>
- (instancetype)initWithCard:(QSCards *)card webSite:(NSString*)site andSellerId:(NSString *)sellerid;
- (instancetype)initWithActivity:(QSActivity *)activity andSellerId:(NSString *)sellerid;
- (instancetype)initWithCard:(QSCards *)card shopId:(NSString *)shopid andSellerId:(NSString *)sellerid;
@end
