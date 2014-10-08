//
//  QSAttentionBrandView.h
//  Quansoso
//
//  Created by Johnny's on 14-10-3.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QSAttentionBrandView : UIView<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) UITableView *showBrandTableView;

- (instancetype)initWithFrame:(CGRect)frame;
@end
