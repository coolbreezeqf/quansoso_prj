//
//  QSDailyView.m
//  Quansoso
//
//  Created by Johnny's on 14/10/27.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSDailyView.h"

@implementation QSDailyView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        UIImageView *backImgView = [[UIImageView alloc] initWithFrame:self.bounds];
        [backImgView setImage:[UIImage imageNamed:@"QSDailyBackGround"]];
        [self addSubview:backImgView];
        [self addSubview:self.preferentialLabel];
        [self addSubview:self.preferentialTimeLabel];
        [self addSubview:self.brandNameLabel];
        [self addSubview:self.preferentialDetailLabel];
    }
    return self;
}

- (UILabel *)preferentialLabel
{
    if (!_preferentialLabel) {
        _preferentialLabel = [[UILabel alloc] initWithFrame:CGRectMake(19, 45, 66, 21)];
        [_preferentialLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:25]];
        _preferentialLabel.textAlignment = NSTextAlignmentCenter;
        _preferentialLabel.textColor = RGBCOLOR(75, 171, 14);
        _preferentialLabel.text = @"100";
    }
    return _preferentialLabel;
}

- (UILabel *)preferentialTimeLabel
{
    if (!_preferentialTimeLabel) {
        _preferentialTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 107, 105, 21)];
        _preferentialTimeLabel.textAlignment = NSTextAlignmentCenter;
        _preferentialTimeLabel.font = kFont10;
        _preferentialTimeLabel.textColor = RGBCOLOR(172, 171, 168);
        _preferentialTimeLabel.text = @"截止到2014.10.12";
    }
    return _preferentialTimeLabel;
}

- (UILabel *)brandNameLabel
{
    if (!_brandNameLabel) {
        _brandNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 3, 89, 21)];
        _brandNameLabel.font = kFont14;
        _brandNameLabel.textAlignment = NSTextAlignmentCenter;
        _brandNameLabel.text = @"江南布衣";
    }
    return _brandNameLabel;
}

- (UILabel *)preferentialDetailLabel
{
    if (!_preferentialDetailLabel) {
        _preferentialDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 74, 89, 21)];
        _preferentialDetailLabel.textAlignment = NSTextAlignmentCenter;
        _preferentialDetailLabel.font = kFont14;
        _preferentialDetailLabel.text = @"元优惠券";
        _preferentialDetailLabel.textColor = RGBCOLOR(127, 127, 127);
    }
    return _preferentialDetailLabel;
}

@end
