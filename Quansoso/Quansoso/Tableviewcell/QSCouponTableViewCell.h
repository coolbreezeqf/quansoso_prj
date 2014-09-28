//
//  QSCouponTableViewCell.h
//  Quansoso
//
//  Created by Johnny's on 14-9-22.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QSCouponTableViewCell : UITableViewCell

@property(nonatomic, strong) UIImageView *imgBackground;
@property(nonatomic, strong) UIImageView *imgCoupon;
@property(nonatomic, strong) UILabel *labelCouponName;
@property(nonatomic, strong) UILabel *labelTime;
@property(nonatomic, strong) UIImageView *imgPrice;
@end
