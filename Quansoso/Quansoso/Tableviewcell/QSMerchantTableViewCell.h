//
//  QSMerchantTableViewCell.h
//  Quansoso
//
//  Created by qf on 14/10/3.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QSMerchantTableViewCell : UITableViewCell
@property (strong, nonatomic)  UIImageView *iconImageView;
@property (strong, nonatomic)  UILabel *titleLb;
+ (CGFloat)cellHeight;
@end
