//
//  QSDailyView.m
//  Quansoso
//
//  Created by Johnny's on 14/10/27.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSDailyView.h"

#define kWidth self.frame.size.width
#define kHeight self.frame.size.height
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
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (UILabel *)preferentialLabel
{
    if (!_preferentialLabel) {
        _preferentialLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, kHeight*1/4, kWidth-16, 30)];
        [_preferentialLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30]];
        _preferentialLabel.backgroundColor = [UIColor clearColor];
        _preferentialLabel.textAlignment = NSTextAlignmentCenter;
//        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"100元"]];
//        [string addAttribute:NSFontAttributeName value:kFont18 range:NSMakeRange(string.length-1, 1)];
//        [string addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(243, 130, 11) range:NSMakeRange(0, string.length)];
//        self.preferentialLabel.attributedText = string;
    }
    return _preferentialLabel;
}

- (UILabel *)preferentialTimeLabel
{
    if (!_preferentialTimeLabel) {
        _preferentialTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, kHeight-30, kWidth-10, 21)];
        _preferentialTimeLabel.textAlignment = NSTextAlignmentCenter;
        _preferentialTimeLabel.backgroundColor = [UIColor clearColor];
        _preferentialTimeLabel.font = kFont10;
        _preferentialTimeLabel.textColor = RGBCOLOR(172, 171, 168);
//        _preferentialTimeLabel.text = @"截止到2014.10.12";
    }
    return _preferentialTimeLabel;
}

- (UILabel *)brandNameLabel
{
    if (!_brandNameLabel) {
        _brandNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 3*kMainScreenWidth/320, self.frame.size.width-16, 21)];
        _brandNameLabel.font = kFont14;
        _brandNameLabel.backgroundColor = [UIColor clearColor];
        _brandNameLabel.textAlignment = NSTextAlignmentCenter;
//        _brandNameLabel.text = @"江南布衣江南布衣";
    }
    return _brandNameLabel;
}

- (UILabel *)preferentialDetailLabel
{
    if (!_preferentialDetailLabel) {
        _preferentialDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, kHeight*3/4-35, kWidth-16, 21)];
        _preferentialDetailLabel.textAlignment = NSTextAlignmentCenter;
        _preferentialDetailLabel.backgroundColor = [UIColor clearColor];
        _preferentialDetailLabel.font = kFont14;
//        _preferentialDetailLabel.text = @"优惠券";
        _preferentialDetailLabel.textColor = RGBCOLOR(127, 127, 127);
    }
    return _preferentialDetailLabel;
}

- (void)setCardWithModel:(QSCards *)aCardModel andName:(NSString *)aName
{
    if ([aCardModel.cardType intValue]==1)//优惠券
    {
        int price = [aCardModel.denomination intValue]/10;
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc]
                                             initWithString:[NSString stringWithFormat:@"%d元", price]];
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
    self.brandNameLabel.text = aName;
}

@end
