//
//  QSSettingView.h
//  Quansoso
//
//  Created by  striveliu on 14-9-18.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QSSettingView : UIView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;


- (instancetype)initWithFrame:(CGRect)frame;
@end
