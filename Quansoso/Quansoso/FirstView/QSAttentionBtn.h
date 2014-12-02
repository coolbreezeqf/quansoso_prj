//
//  QSAttentionBtn.h
//  Quansoso
//
//  Created by Johnny's on 14/11/29.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSMerchant.h"

@interface QSAttentionBtn : UIImageView

@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UIImageView *countImgView;
@property(nonatomic, strong) UILabel *countLabel;
- (instancetype)initWithFrame:(CGRect)frame;
//- (void)setImage:(UIImage *)image forState:(UIControlState)state;
- (void)removeRedView;
- (void)addRedViewWithCount:(int)aCount;
- (void)setWithModel:(QSMerchant *)aModel;
@end
