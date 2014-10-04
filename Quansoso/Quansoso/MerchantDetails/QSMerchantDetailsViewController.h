//
//  QSMerchantDetailsViewController.h
//  Quansoso
//
//  Created by qf on 14/9/27.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Result.h"
@interface QSMerchantDetailsViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>
- (instancetype)initWithMerchant:(Result *)merchant;
@end
