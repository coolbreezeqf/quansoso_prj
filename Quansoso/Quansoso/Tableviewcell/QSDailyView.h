//
//  QSDailyView.h
//  Quansoso
//
//  Created by Johnny's on 14/10/27.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSDayRecommends.h"

@interface QSDailyView : UIView

@property(nonatomic, strong) UILabel *brandNameLabel;
@property(nonatomic, strong) UILabel *preferentialLabel;
@property(nonatomic, strong) UILabel *preferentialDetailLabel;
@property(nonatomic, strong) UILabel *preferentialTimeLabel;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)setCardWithModel:(QSDayRecommends *)aDayRecommendModel;
@end
