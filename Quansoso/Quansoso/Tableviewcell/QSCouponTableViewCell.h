//
//  QSCouponTableViewCell.h
//  Quansoso
//
//  Created by Johnny's on 14-9-22.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QSCouponTableViewCell : UITableViewCell

@property(nonatomic, strong) UIImageView *imgCoupon;
@property(nonatomic, strong) UILabel *labelBrandName;
@property(nonatomic, strong) UILabel *labelTime;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
