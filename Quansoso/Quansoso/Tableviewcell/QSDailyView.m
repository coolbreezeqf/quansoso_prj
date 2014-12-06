//
//  QSDailyView.m
//  Quansoso
//
//  Created by Johnny's on 14/10/27.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSDailyView.h"
#import "QSCards.h"
#import "QSActivity.h"

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

- (void)setCardWithModel:(QSDayRecommends *)aDayRecommendModel
{
    int aCouponType = [aDayRecommendModel.couponType intValue];
    if (aCouponType==1)//优惠券
    {
        QSCards *aCardModel = aDayRecommendModel.card;
        int price = [aCardModel.denomination intValue]/100;
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc]
                                             initWithString:[NSString stringWithFormat:@"%d元", price]];
        [string addAttribute:NSFontAttributeName value:kFont18 range:NSMakeRange(string.length-1, 1)];
        [string addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(243, 130, 11) range:NSMakeRange(0, string.length)];

        self.preferentialLabel.attributedText = string;
        self.preferentialDetailLabel.text = @"优惠券";
        self.preferentialTimeLabel.text = [NSString stringWithFormat:@"截止到%@", aCardModel.endProperty];
        self.brandNameLabel.text = [self newString:aDayRecommendModel.name];
    }
    else if(aCouponType==2)//活动
    {
        QSActivity *activityModel = aDayRecommendModel.activity;
        int activityType = [activityModel.type intValue];
        if (activityType==1)//满减
        {
            int price = [activityModel.denomination intValue]/10;
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc]
                                                 initWithString:[NSString stringWithFormat:@"%d元", price]];
            [string addAttribute:NSFontAttributeName value:kFont18 range:NSMakeRange(string.length-1, 1)];
            [string addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(237, 181,68) range:NSMakeRange(0, string.length)];
            self.preferentialLabel.attributedText = string;
            self.preferentialDetailLabel.text = [NSString stringWithFormat:@"满%@减", activityModel.moneyCondition];
        }
        else if(activityType==2)//打折
        {
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d%%", [activityModel.discountRate intValue]/100]];
            [string addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(253, 82, 88) range:NSMakeRange(0, string.length)];
            self.preferentialLabel.attributedText = string;
            self.preferentialDetailLabel.text = @"OFF";
        }
        else if(activityType==3)//包邮
        {
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"包邮"];
            [string addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(26, 167, 124) range:NSMakeRange(0, string.length)];
            self.preferentialLabel.attributedText = string;
            if (activityModel.moneyCondition && activityModel.moneyCondition>0)
            {
                self.preferentialDetailLabel.text = [NSString stringWithFormat:@"满%d元送", [activityModel.moneyCondition intValue]/100];
            }
            else
            {
                self.preferentialDetailLabel.text = [NSString stringWithFormat:@"满%d件送", [activityModel.quantityCondition intValue]/100];
            }
        }
        else if(activityType==4)//满送
        {
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"满送"];
            [string addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(174, 93, 161) range:NSMakeRange(0, string.length)];
            self.preferentialLabel.attributedText = string;
            if (activityModel.moneyCondition && activityModel.moneyCondition>0)
            {
                self.preferentialDetailLabel.text = [NSString stringWithFormat:@"满%d元送", [activityModel.moneyCondition intValue]/100];
            }
            else
            {
                self.preferentialDetailLabel.text = [NSString stringWithFormat:@"满%d件送", [activityModel.quantityCondition intValue]/100];
            }
        }
        self.preferentialTimeLabel.text = [NSString stringWithFormat:@"截止到%@", activityModel.endProperty];
        self.brandNameLabel.text = [self newString:activityModel.merchant];
    }
}

- (NSString *)newString:(NSString *)oldStr
{
    NSString *str2 = oldStr;
    NSRange range = [str2 rangeOfString:@"官方旗舰店"];
    if (range.location != NSNotFound)
    {
        str2 = [str2 stringByReplacingCharactersInRange:range withString:@""];
    }
    range = [str2 rangeOfString:@"旗舰店"];
    if (range.location != NSNotFound)
    {
        str2 = [str2 stringByReplacingCharactersInRange:range withString:@""];
    }
    range = [str2 rangeOfString:@"专营店"];
    if (range.location != NSNotFound)
    {
        str2 = [str2 stringByReplacingCharactersInRange:range withString:@""];
    }
    range = [str2 rangeOfString:@"专卖店"];
    if (range.location != NSNotFound)
    {
        str2 = [str2 stringByReplacingCharactersInRange:range withString:@""];
    }
    return str2;
}

@end
