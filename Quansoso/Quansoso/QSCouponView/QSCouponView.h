//
//  QSCouponView.h
//  Quansoso
//
//  Created by Johnny's on 14-9-27.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSUserCouponListManage.h"

@interface QSCouponView : UIView<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UIView *viewHead;
@property(nonatomic, strong) UIImageView *imgViewUserHead;
@property(nonatomic, strong) UILabel *labelStore;
@property(nonatomic, strong) UITableView *tableViewShow;
@property(nonatomic, strong) UILabel *couponLabel;
@property(nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property(nonatomic, strong) QSUserCouponListManage *userCouponListManage;

- (instancetype)initWithFrame:(CGRect)frame;
@end
