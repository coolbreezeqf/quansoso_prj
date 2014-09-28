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
@interface QSSearchViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *searchResult;		//of SearchInfo

@end
