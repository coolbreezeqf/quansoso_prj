//
//  QSAttentionBrandView.h
//  Quansoso
//
//  Created by Johnny's on 14-10-3.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QSAttentionBrandListManage.h"

@interface QSAttentionBrandView : UIView<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView *showBrandTableView;
@property(nonatomic, strong) QSAttentionBrandListManage *attentionBrandListManage;
@property(nonatomic, strong) void(^cellBolck)(void);
@property(nonatomic, strong) UIAlertView *alertView;
- (instancetype)initWithFrame:(CGRect)frame;
@end
