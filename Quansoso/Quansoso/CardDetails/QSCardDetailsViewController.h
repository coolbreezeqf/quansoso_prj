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

@interface QSCardDetailsViewController : BaseViewController<QSMerchantCommendDelegate>
- (instancetype)initWithCard:(QSCards *)card;
- (instancetype)initWithCard:(QSCards *)card isFromRoot:(BOOL)isRoot;
@end
