//
//  QSAttentionBtn.m
//  Quansoso
//
//  Created by Johnny's on 14/11/29.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSAttentionBtn.h"
#import "UIImageView+WebCache.h"

@implementation QSAttentionBtn

- (instancetype)initWithFrame:(CGRect)frame andModel:(QSMerchant *)aModel
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((96/2-40), (96/2-40), 80, 80)];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [imgView sd_setImageWithURL:[NSURL URLWithString:aModel.picUrl] placeholderImage:[UIImage imageNamed:@""]];
        [self addSubview:imgView];
        countImgView = [[UIImageView alloc] initWithFrame:CGRectMake(96-12, -6, 18, 18)];
        countImgView.layer.cornerRadius = 9;
        countImgView.backgroundColor = RGBCOLOR(252, 82, 88);
        [self addSubview:countImgView];
        countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
        countLabel.textAlignment = NSTextAlignmentCenter;
        countLabel.backgroundColor = [UIColor clearColor];
        countLabel.font = kFont10;
        countLabel.text = @"15";
        countLabel.backgroundColor = [UIColor clearColor];
        countLabel.textColor = [UIColor whiteColor];
        [countImgView addSubview:countLabel];
    }
    
    return self;
}

- (void)removeRedView
{
    if (countImgView) {
        [countLabel removeFromSuperview];
        [countImgView removeFromSuperview];
    }
}

@end
