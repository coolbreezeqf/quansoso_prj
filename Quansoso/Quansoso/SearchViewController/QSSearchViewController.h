//
//  QSSearchViewController.h
//  Quansoso
//
//  Created by qf on 14/9/23.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import "BaseViewController.h"
#import "QSSearchResultView.h"
#import "QSSearchNetManager.h"
#import "QSSearchHistoryView.h"

@interface QSSearchViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,QSSearchHistoryDelegate>

@property (nonatomic,strong) UITableView *tableView;

@end
