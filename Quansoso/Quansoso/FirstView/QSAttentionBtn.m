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

//- (void)setImage:(UIImage *)image forState:(UIControlState)state
//{
//    [self setImage:image forState:state];
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake((96/2-40), (96/2-40), 80, 80)];
        self.imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imgView];
    }
    
    return self;
}

- (void)setWithModel:(QSMerchant *)aModel
{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:aModel.picUrl]];
}

- (UIImageView *)countImgView
{
    if (!_countImgView) {
        _countImgView = [[UIImageView alloc] initWithFrame:CGRectMake(96-12, -6, 18, 18)];
        _countImgView.layer.cornerRadius = 9;
        _countImgView.backgroundColor = RGBCOLOR(252, 82, 88);
        [self addSubview:_countImgView];
    }
    return _countImgView;
}

- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.backgroundColor = [UIColor clearColor];
        _countLabel.font = kFont10;
        _countLabel.backgroundColor = [UIColor clearColor];
        _countLabel.textColor = [UIColor whiteColor];
    }
    return _countLabel;
}

- (void)addRedViewWithCount:(int)aCount
{
    [self addSubview:self.countImgView];
    self.countLabel.text = [NSString stringWithFormat:@"%d", aCount];
    [self.countImgView addSubview:self.countLabel];
}

- (void)removeRedView
{
    if (self.countImgView.superview) {
        [self.countLabel removeFromSuperview];
        [self.countImgView removeFromSuperview];
    }
}

@end
