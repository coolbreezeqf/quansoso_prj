//
//  QSCardCell.m
//  Quansoso
//
//  Created by yato_kami on 14/11/10.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSCardCell.h"
#define isTest 1
#define kGrayColor RGBCOLOR(242, 239, 233)
#define kinCellHeight (kCellHeight - 10)
//lf 242 128
//rt 150 128
@interface QSCardCell()
@property (assign, nonatomic) NSInteger type;
@property (strong, nonatomic) UILabel *theTitleLabel;//数量或折扣label
@property (strong, nonatomic) UILabel *largeTitleLabel;//大titile 包邮之类
@property (strong, nonatomic) UILabel *rmbTagLabel;//元字
@property (strong, nonatomic) UILabel *theDetailLabel;//副标题
@property (strong, nonatomic) UIImageView *rightIconImageView;
@property (strong, nonatomic) UILabel *conditionLabel;//限制条件label
@property (strong, nonatomic) UILabel *endTimeLabel; //结束时间label

@property (strong, nonatomic) NSArray *colorArray;

@end;

@implementation QSCardCell

- (NSArray *)colorArray
{
    if (!_colorArray) {
        _colorArray = @[RGBCOLOR(141, 212, 217),RGBCOLOR(145, 182, 16),RGBCOLOR(89, 182, 15),RGBCOLOR(255, 156,3)];
    }
    return _colorArray;
}

- (instancetype)initWithReuseIdentifier:(NSString *)identifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    self.backgroundColor = kGrayColor;
    self.frame = CGRectMake(0, 0, kMainScreenWidth, kCellHeight);
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //left
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kinCellHeight*242/128.0f, kinCellHeight)];
    leftImageView.image = [UIImage imageNamed:@"QSCardLeft"];
    [self addSubview:leftImageView];
    
    UILabel *theTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 55, 24)];
    //theTitleLable.backgroundColor = [UIColor redColor];
    theTitleLable.font = [UIFont boldSystemFontOfSize:24];
    theTitleLable = theTitleLable;
    theTitleLable.textAlignment = NSTextAlignmentRight;
    [leftImageView addSubview:theTitleLable];
    if(isTest == 1) theTitleLable.text = @"100";
    
    UILabel *rmbTagLabel = [[UILabel alloc] initWithFrame:CGRectMake(theTitleLable.right+2, theTitleLable.bottom-14, 30, 14)];
    if(isTest == 1) rmbTagLabel.text = @"元" ;
    _rmbTagLabel = rmbTagLabel;
    rmbTagLabel.textAlignment = NSTextAlignmentLeft;
    rmbTagLabel.font = kFont14;
    [leftImageView addSubview:rmbTagLabel];
    
    UILabel *theDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,theTitleLable.bottom+5 , 90, 13)];
    //theDetailLabel.backgroundColor = [UIColor blueColor];
    theDetailLabel.textAlignment = NSTextAlignmentCenter;
    theDetailLabel.textColor = [UIColor lightGrayColor];
    theDetailLabel.font = kFont12;
    _theDetailLabel = theDetailLabel;
    [leftImageView addSubview:theDetailLabel];
    if(isTest == 1) theDetailLabel.text = @"优惠券";
    
    UILabel *largeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, (kinCellHeight-24)/2.0, 80, 24)];
    largeTitleLabel.font = [UIFont boldSystemFontOfSize:24];
    [leftImageView addSubview:largeTitleLabel];
    _largeTitleLabel = largeTitleLabel;
    largeTitleLabel.textAlignment = NSTextAlignmentCenter;
    //largeTitleLabel.backgroundColor = [UIColor blueColor];
    if (isTest == 2) {
        largeTitleLabel.text = @"包邮";
    }
    
    //right
    UIImageView *rightIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kMainScreenWidth - kinCellHeight*150/128.0f, leftImageView.top, kinCellHeight*150/128.0f, kinCellHeight)];
    _rightIconImageView = rightIconImageView;
    rightIconImageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:rightIconImageView];
    if(isTest > 0) rightIconImageView.image = [UIImage imageNamed:@"cardRightImg3"];
    
    //mid
    UIView *midView = [[UIView alloc] initWithFrame:CGRectMake(leftImageView.right, leftImageView.top, rightIconImageView.left-leftImageView.right, kinCellHeight)];
    midView.backgroundColor = [UIColor whiteColor];
    [self addSubview:midView];
    
    UILabel *conditionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, midView.width, 14)];
    conditionLabel.font = kFont14;
    [midView addSubview:conditionLabel];
    if(isTest) conditionLabel.text = @"满300使用";
    //conditionLabel.backgroundColor = [UIColor greenColor];
    _conditionLabel = conditionLabel;
    
    UILabel *endTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(conditionLabel.left, conditionLabel.bottom+5, conditionLabel.width, 10)];
    //endTimeLabel.backgroundColor = [UIColor blueColor];
    if(isTest) endTimeLabel.text = @"截止2014年11月16日";
    endTimeLabel.font = [UIFont systemFontOfSize:10];
    endTimeLabel.textColor = [UIColor lightGrayColor];
    [midView addSubview:endTimeLabel];
    _endTimeLabel = endTimeLabel;
    
    return self;
}

- (void)setCellUIwithCardType:(cardType)type denomination:(NSString *)denom Money_condition:(NSString *)money_condition end:(NSString *)endTime discountRate:(NSString *)rate
{
    self.type = type;
    //清除文字
    self.theTitleLabel.text = @"";
    self.theDetailLabel.text = @"";
    self.largeTitleLabel.text = @"";

    //赋值
    self.conditionLabel.text = [NSString stringWithFormat:@"满%@元",money_condition];
    self.endTimeLabel.text = [NSString stringWithFormat:@"截至%@",endTime];

    switch (type) {
#warning 其他类型待定
        case cardType_privilege://优惠券
        {
            self.theTitleLabel.text = denom;
            self.detailTextLabel.text = @"优惠券";
            self.conditionLabel.text = [self.conditionLabel.text stringByAppendingString:@"使用"];
            
            int i = 0;
            if ([denom isEqualToString:@"3"] || [denom isEqualToString:@"5"] || [denom isEqualToString:@"10"]) i = 0;
            else if ([denom isEqualToString:@"20"])i = 1;
            else if([denom isEqualToString:@"50"]) i = 2;
            else if([denom isEqualToString:@"100"]) i = 3;
            
            self.theTitleLabel.textColor = self.colorArray[i];
            self.rightIconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"cardRightImg1_%d",i]];
        }
            break;
        case cardType_mail://包邮
        {
            self.largeTitleLabel.text = @"包邮";
            self.largeTitleLabel.textColor = RGBCOLOR(15, 182, 144);
            self.rightIconImageView.image = [UIImage imageNamed:@"cardRightImg4"];
        }
            break;
        case cardType_count://折扣
        {
            self.largeTitleLabel.text = [rate stringByAppendingString:@"%"];
            self.largeTitleLabel.textColor = RGBCOLOR(255, 107, 107);
            self.rightIconImageView.image = [UIImage imageNamed:@"cardRightImg3"];
        }
            break;
        case cardType_treasure://宝贝-满送
        {
            self.largeTitleLabel.text = @"满送";
            self.largeTitleLabel.textColor = RGBCOLOR(174, 93, 161);
            self.rightIconImageView.image = [UIImage imageNamed:@"cardRightImg5"];
        }
            break;
        case cardType_floor://阶梯卡-满减
        {
            self.theTitleLabel.text = denom;
            self.theDetailLabel.text = @"满减";
            self.theTitleLabel.textColor = RGBCOLOR(230, 183, 60);
            self.conditionLabel.text = [self.conditionLabel.text stringByAppendingString:[NSString stringWithFormat:@"减%@元",denom]];
            self.rightIconImageView.image = [UIImage imageNamed:@"cardRightImg2"];
        }
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
