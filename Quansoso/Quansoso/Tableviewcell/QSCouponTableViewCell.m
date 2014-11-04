//
//  QSCouponTableViewCell.m
//  Quansoso
//
//  Created by Johnny's on 14-9-22.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSCouponTableViewCell.h"

@implementation QSCouponTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    CGRect temframe = self.frame;
    temframe.size.width = kMainScreenWidth;
    self.frame = temframe;
    
    UIImageView *backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(kMainScreenWidth-310, 4, 310, 61)];
    [backgroundImg setImage:[UIImage imageNamed:@"QSCouponImg100"]];
    [self addSubview:backgroundImg];
    
    return self;
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
