//
//  QSBrandBtn.h
//  Quansoso
//
//  Created by Johnny's on 14/11/4.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSMerchant.h"

@interface QSBrandBtn : UIView
@property(nonatomic, strong) UIButton *brandLikeView;
@property(nonatomic, strong) UIButton *brandImgView;
@property(nonatomic, assign) BOOL isLiked;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)setBtnWithModel:(QSMerchant *)aModel;
- (void)showDislike;
- (void)showLike;
- (void)changeLike;
@end
