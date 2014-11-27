//
//  QSBrandBtn.m
//  Quansoso
//
//  Created by Johnny's on 14/11/4.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "QSBrandBtn.h"

@implementation QSBrandBtn


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = RGBCOLOR(228, 222, 214);
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(1, 1, frame.size.width-2, frame.size.height-2)];
        backView.backgroundColor = [UIColor whiteColor];
        backView.layer.cornerRadius = 2;
        backView.userInteractionEnabled = YES;
        [self addSubview:backView];
        
        self.brandLikeView = [[UIImageView alloc] initWithFrame:CGRectMake(backView.right-30, backView.bottom-30, 24, 24)];
        [self.brandLikeView setImage:[UIImage imageNamed:@"QSBrandUnlike"]];
        self.brandLikeView.userInteractionEnabled = YES;
        [backView addSubview:self.brandLikeView];
        
        CGFloat brandWidth = (backView.right-backView.left)-18*2;
        
        self.brandImgView = [[UIImageView alloc] initWithFrame:CGRectMake((backView.right-backView.left-brandWidth)/2, 15, brandWidth, brandWidth)];
        self.brandLikeView.userInteractionEnabled = YES;
        self.brandImgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.brandImgView];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
