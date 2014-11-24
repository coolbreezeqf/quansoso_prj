//
//  LoadingView.m
//  Quansoso
//
//  Created by Johnny's on 14/11/24.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "LoadingView.h"
#import "UIImage+GIF.h"

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];

        UIImageView *loadingImgView = [[UIImageView alloc]
                        initWithFrame:CGRectMake(frame.size.width/2-8, frame.size.height/2-8, 16, 16)];
        [loadingImgView setImage:[UIImage sd_animatedGIFNamed:@"loading"]];
        [self addSubview:loadingImgView];
    }
    return self;
}

@end
