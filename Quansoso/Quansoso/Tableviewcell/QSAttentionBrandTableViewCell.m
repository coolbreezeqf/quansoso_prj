//
//  QSAttentionBrandTableViewCell.m
//  Quansoso
//
//  Created by Johnny's on 14-10-8.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSAttentionBrandTableViewCell.h"

@implementation QSAttentionBrandTableViewCell

- (instancetype)init
{
    self = [super init];
    CGRect temframe = self.frame;
    temframe.size.width = kMainScreenWidth;
    self.frame = temframe;
    
    UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 4.5, kMainScreenWidth, 0.5)];
    topLineView.backgroundColor = [UIColor blackColor];
    [self addSubview:topLineView];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, kMainScreenWidth, 40)];
    [self addSubview:backView];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBottom(backView), kMainScreenWidth, 0.5)];
    bottomLineView.backgroundColor = [UIColor blackColor];
    [self addSubview:bottomLineView];
    
    self.brandImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
    self.brandImgView.backgroundColor = [UIColor blueColor];
    [backView addSubview:self.brandImgView];
    
    self.cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(kMainScreenWidth-80, 10, 60, 20)];
    self.cancelBtn.titleLabel.font = kFont12;
    [self.cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.cancelBtn setTitle:@"取消关注" forState:UIControlStateNormal];
    [self.cancelBtn.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.cancelBtn.layer setBorderWidth:0.5];
    [self.cancelBtn.layer setCornerRadius:5];
    [self.cancelBtn addTarget:self action:@selector(cancelAttention) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:self.cancelBtn];
    
    self.brandNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 5, 150, 30)];
    self.brandNameLabel.text = @"优衣库官方旗舰店";
    self.brandNameLabel.font = kFont14;
    [backView addSubview:self.brandNameLabel];
    
    
    return self;
}

- (void)cancelAttention
{
    MLOG(@"cancel");
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
