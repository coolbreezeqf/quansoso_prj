//
//  QSBrandBtn.h
//  Quansoso
//
//  Created by Johnny's on 14/11/4.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QSBrandBtn : UIButton
@property(nonatomic, strong) UIImageView *brandLikeView;
@property(nonatomic, strong) UIImageView *brandImgView;
@property(nonatomic, assign) BOOL isLiked;

- (instancetype)initWithFrame:(CGRect)frame;
@end
