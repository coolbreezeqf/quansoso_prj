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
        _preferentialLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 38, 90, 28)];
        [_preferentialLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30]];
        _preferentialLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _preferentialLabel;
}

- (UILabel *)preferentialTimeLabel
{
    if (!_preferentialTimeLabel) {
        _preferentialTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 107, 100, 21)];
        _preferentialTimeLabel.textAlignment = NSTextAlignmentCenter;
        _preferentialTimeLabel.font = kFont10;
        _preferentialTimeLabel.textColor = RGBCOLOR(172, 171, 168);
//        _preferentialTimeLabel.text = @"截止到2014.10.12";
    }
    return _preferentialTimeLabel;
}

- (UILabel *)brandNameLabel
{
    if (!_brandNameLabel) {
        _brandNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 3, 89, 21)];
        _brandNameLabel.font = kFont14;
        _brandNameLabel.textAlignment = NSTextAlignmentCenter;
//        _brandNameLabel.text = @"江南布衣";
    }
    return _brandNameLabel;
}

- (UILabel *)preferentialDetailLabel
{
    if (!_preferentialDetailLabel) {
        _preferentialDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 74, 89, 21)];
        _preferentialDetailLabel.textAlignment = NSTextAlignmentCenter;
        _preferentialDetailLabel.font = kFont14;
//        _preferentialDetailLabel.text = @"优惠券";
        _preferentialDetailLabel.textColor = RGBCOLOR(127, 127, 127);
    }
    return _preferentialDetailLabel;
}

- (void)setCardWithModel:(QSCards *)aCardModel
{
    if ([aCardModel.cardType intValue]==1)//优惠券
    {
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元", aCardModel.denomination]];
        [string addAttribute:NSFontAttributeName value:kFont18 range:NSMakeRange(string.length-1, 1)];
        [string addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(243, 130, 11) range:NSMakeRange(0, string.length)];
        self.preferentialLabel.attributedText = string;
        self.preferentialDetailLabel.text = @"优惠券";
        self.preferentialTimeLabel.text = [NSString stringWithFormat:@"截止到%@", aCardModel.endProperty];
    }
    if ([aCardModel.cardType intValue]==2)//折扣
    {
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"50%"];
        [string addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(253, 82, 88) range:NSMakeRange(0, string.length)];
        self.preferentialLabel.attributedText = string;
        self.preferentialDetailLabel.text = @"OFF";
    }
    if ([aCardModel.cardType intValue]==3)//包邮
    {
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"包邮"];
        [string addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(26, 167, 124) range:NSMakeRange(0, string.length)];
        self.preferentialLabel.attributedText = string;
        self.preferentialDetailLabel.text = @"满400元";
    }
    self.brandNameLabel.text = aCardModel.merchant;
}

@end
