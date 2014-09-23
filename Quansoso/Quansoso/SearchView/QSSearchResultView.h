//
//  QSSearchResultView.h
//  Quansoso
//
//  Created by qf on 14/9/22.
//  Copyright (c) 2014年 taobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QSSearchResultView : UITableView <UITableViewDataSource,UITableViewDelegate>{
	
}
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@property (nonatomic,strong) NSArray *searchResult;		//of SearchInfo
@end
