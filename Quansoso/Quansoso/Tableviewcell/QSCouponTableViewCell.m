//
//  QSCouponTableViewCell.m
//  Quansoso
//
//  Created by Johnny's on 14-9-22.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSCouponTableViewCell.h"

@implementation QSCouponTableViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    CGRect temframe = self.frame;
    frame.size.width = kMainScreenWidth;
    self.frame = temframe;
    
    
    return self;
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
